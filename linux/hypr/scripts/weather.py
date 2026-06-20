#!/usr/bin/env python3

import json
import sys

import requests

# ---------------------------------------------------------------------------
# location
# ---------------------------------------------------------------------------
# Set this to your coordinates. Defaults to Brussels - change as needed.
# Easiest way to find yours: https://www.latlong.net/
LATITUDE = 50.8503
LONGITUDE = 4.3517
TIMEZONE = "auto"  # Open-Meteo will infer the local timezone from lat/lon

FORECAST_URL = "https://api.open-meteo.com/v1/forecast"
AIR_QUALITY_URL = "https://air-quality-api.open-meteo.com/v1/air-quality"

# ---------------------------------------------------------------------------
# weather icons
# ---------------------------------------------------------------------------
weather_icons = {
    "sunnyDay": "󰖨",
    "clearNight": "󰖔",
    "cloudyFoggyDay": "󰖐",
    "cloudyFoggyNight": "󰖐",
    "rainyDay": "󰖗",
    "rainyNight": "󰖗",
    "snowyIcyDay": "󰼶",
    "snowyIcyNight": "󰼶",
    "severe": "󰖓",
    "default": "󰖕",
}

# Open-Meteo uses WMO weather codes. Map each code to a human-readable phrase
# and a category used to pick an icon above.
# https://open-meteo.com/en/docs (see "WMO Weather interpretation codes")
WMO_CODES = {
    0: ("Clear sky", "sunny"),
    1: ("Mainly clear", "sunny"),
    2: ("Partly cloudy", "cloudyFoggy"),
    3: ("Overcast", "cloudyFoggy"),
    45: ("Fog", "cloudyFoggy"),
    48: ("Freezing fog", "cloudyFoggy"),
    51: ("Light drizzle", "rainy"),
    53: ("Drizzle", "rainy"),
    55: ("Dense drizzle", "rainy"),
    56: ("Freezing drizzle", "snowyIcy"),
    57: ("Dense freezing drizzle", "snowyIcy"),
    61: ("Slight rain", "rainy"),
    63: ("Rain", "rainy"),
    65: ("Heavy rain", "rainy"),
    66: ("Freezing rain", "snowyIcy"),
    67: ("Heavy freezing rain", "snowyIcy"),
    71: ("Slight snow fall", "snowyIcy"),
    73: ("Snow fall", "snowyIcy"),
    75: ("Heavy snow fall", "snowyIcy"),
    77: ("Snow grains", "snowyIcy"),
    80: ("Slight rain showers", "rainy"),
    81: ("Rain showers", "rainy"),
    82: ("Violent rain showers", "rainy"),
    85: ("Slight snow showers", "snowyIcy"),
    86: ("Heavy snow showers", "snowyIcy"),
    95: ("Thunderstorm", "severe"),
    96: ("Thunderstorm, slight hail", "severe"),
    99: ("Thunderstorm, heavy hail", "severe"),
}


def fallback_output(message="weather unavailable"):
    """Always emit valid JSON for waybar, even on failure, so the module
    never just disappears or breaks waybar's parsing."""
    print(
        json.dumps(
            {
                "text": f"{weather_icons['default']}  N/A",
                "alt": "error",
                "tooltip": message,
                "class": "error",
            }
        )
    )
    sys.exit(0)


def describe(code, is_day):
    phrase, base_category = WMO_CODES.get(code, ("Unknown", "default"))
    if base_category == "severe" or base_category == "default":
        category = base_category
    else:
        category = f"{base_category}Day" if is_day else f"{base_category}Night"
        if base_category == "sunny" and not is_day:
            category = "clearNight"
    return phrase, category


try:
    forecast_resp = requests.get(
        FORECAST_URL,
        params={
            "latitude": LATITUDE,
            "longitude": LONGITUDE,
            "timezone": TIMEZONE,
            "current": (
                "temperature_2m,relative_humidity_2m,apparent_temperature,"
                "weather_code,wind_speed_10m,is_day"
            ),
            "hourly": "visibility,precipitation_probability",
            "daily": "temperature_2m_max,temperature_2m_min",
            "forecast_days": 1,
        },
        timeout=10,
    )
    forecast_resp.raise_for_status()
    data = forecast_resp.json()
except Exception as exc:
    fallback_output(f"Failed to fetch forecast: {exc}")

try:
    current = data["current"]
    hourly = data["hourly"]
    daily = data["daily"]

    temp = round(current["temperature_2m"])
    is_day = bool(current["is_day"])
    status, status_code = describe(current["weather_code"], is_day)

    icon = weather_icons.get(status_code, weather_icons["default"])

    temp_feel_text = f"Feels like {round(current['apparent_temperature'])}c"

    temp_min = round(daily["temperature_2m_min"][0])
    temp_max = round(daily["temperature_2m_max"][0])
    temp_min_max = f"  {temp_min}\t\t  {temp_max}"

    wind_text = f"煮  {round(current['wind_speed_10m'])} km/h"

    humidity_text = f"  {current['relative_humidity_2m']}%"

    # Match the current hour's visibility/precip-probability from the hourly
    # arrays (Open-Meteo doesn't include visibility in "current").
    now_index = 0
    try:
        now_index = hourly["time"].index(data["current"]["time"][:13] + ":00")
    except (ValueError, KeyError):
        pass
    visibility_m = hourly["visibility"][now_index]
    visibility_text = f"  {round(visibility_m / 1000, 1)} km"

    # next few hours' rain chance
    upcoming = hourly["precipitation_probability"][now_index : now_index + 6]
    prediction = ", ".join(f"{p}%" for p in upcoming if p is not None)
    prediction = f"\n\n    (hourly) {prediction}" if prediction else ""

    # air quality index (separate API, best-effort - don't fail the whole
    # module if this one call doesn't succeed)
    air_quality_index = "N/A"
    try:
        aq_resp = requests.get(
            AIR_QUALITY_URL,
            params={
                "latitude": LATITUDE,
                "longitude": LONGITUDE,
                "current": "us_aqi",
                "timezone": TIMEZONE,
            },
            timeout=5,
        )
        aq_resp.raise_for_status()
        air_quality_index = str(round(aq_resp.json()["current"]["us_aqi"]))
    except Exception:
        pass

    tooltip_text = str.format(
        "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
        f'<span size="xx-large">{temp}°</span>',
        f"<big>{icon}</big>",
        f"<big>{status}</big>",
        f"<small>{temp_feel_text}</small>",
        f"<big>{temp_min_max}</big>",
        f"{wind_text}\t{humidity_text}",
        f"{visibility_text}\tAQI {air_quality_index}",
        f"<i>{prediction}</i>",
    )

    out_data = {
        "text": f"{icon}  {temp}°",
        "alt": status,
        "tooltip": tooltip_text,
        "class": status_code,
    }
    print(json.dumps(out_data))

except Exception as exc:
    fallback_output(f"Failed to parse forecast data: {exc}")

