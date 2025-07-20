#!/usr/bin/env python3
import json
import requests
from pyquery import PyQuery as pq

location_id = "f0e0d6290703e313e21b7081d55a91301a340511d90252504613352a99a82ab6"
unit = "metric"

material_icons = {
    "sunnyDay": "󰖙", "clearNight": "󰖔", "cloudyFoggyDay": "󰅟", "cloudyFoggyNight": "󰼱",
    "rainyDay": "󰖗", "rainyNight": "󰖗", "snowyIcyDay": "󰖘", "snowyIcyNight": "󰖘",
    "thunderstorm": "󰖓", "default": "󰖐"
}

lang = "en-IN" if unit == "metric" else "en-US"
url = f"https://weather.com/{lang}/weather/today/l/{location_id}"

html = pq(url=url)

temp = html("span[data-testid='TemperatureValue']").eq(0).text()
status = html("div[data-testid='wxPhrase']").text()
status = f"{status[:16]}.." if len(status) > 17 else status

status_class = html("#regionHeader").attr("class")
condition_code = (
    status_class.split(" ")[2].split("-")[2]
    if status_class and "-" in status_class else "default"
)
icon = material_icons.get(condition_code, material_icons["default"])

feels_like = html("span[data-testid='TemperatureValue']").eq(1).text()
feels_like_text = f"Feels like {feels_like}°{'C' if unit == 'metric' else 'F'}"

temp_max = html("div[data-testid='wxData'] span[data-testid='TemperatureValue']").eq(0).text()
temp_min = html("div[data-testid='wxData'] span[data-testid='TemperatureValue']").eq(1).text()
minmax_text = f"󰸄  {temp_min}  󰸅  {temp_max}"

wind = html("span[data-testid='Wind']").text()
wind_text = f"󱭚  {wind}"

humidity = html("span[data-testid='PercentageValue']").text()
humidity_text = f"󰖎  {humidity}"

visibility = html("span[data-testid='VisibilityValue']").text()
visibility_text = f"󰈈  {visibility}"

aqi = html("text[data-testid='DonutChartValue']").text()
aqi_text = f"󰵃  AQI {aqi}" if aqi else ""

# Fetch only first rain percentage (not all)
rain_raw = html("div[data-testid='SegmentPrecipPercentage'] > span")
rain_text = ""
if rain_raw and len(rain_raw) > 0:
    rain_val = rain_raw.eq(0).text()
    if rain_val:
        rain_text = f"󰖖  {rain_val}"

tooltip = (
    f"<span size='xx-large'>{temp}</span>\n"
    f"<big>{icon}</big> {status}\n"
    f"<small>{feels_like_text}</small>\n\n"
    f"{minmax_text}\n"
    f"{wind_text}   {humidity_text}\n"
    f"{visibility_text}   {aqi_text}\n"
    f"{rain_text}"
)

output = {
    "text": f"{icon} {temp}",
    "alt": status,
    "tooltip": tooltip,
    "class": condition_code
}

print(json.dumps(output))
