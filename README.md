# MobileRush

A Flutter weather dashboard prototype with weather-dependent backgrounds, a rain chart, and destination suggestions.

## Features

- Weather summary with temperature, feels-like temperature, wind, humidity, and pressure
- Weather-risk messages and rain-chance visualization
- Recommended-place cards with local destination content
- Background imagery for sunny, rainy, and snowy conditions

## Stack

Flutter and Dart, `http` for API requests, `fl_chart` for charts, and `snow_fall_animation` for visual effects. The Dart SDK constraint is `^3.5.3`.

## Project layout

```text
lib/screens/weather.dart       Dashboard and weather request
lib/components/                Charts, risk messages, and place cards
lib/config/services.dart       Local place-data loader
assets/data/places.json        Bundled destination data
assets/images/                 Weather and destination imagery
```

## Local setup

1. Install a Flutter SDK compatible with `pubspec.yaml`.
2. Review the weather endpoint in `lib/screens/weather.dart`. The backend implementation is not included in this repository; use a development endpoint you control if the configured service is unavailable.
3. Run:

```bash
flutter pub get
flutter run
```

The screen expects a JSON response with `location.city` and a `weather` object containing `condition`, `feels_like`, `precipitation_probability`, `wind_speed`, `humidity`, `atm_pressure`, `temperature`, and `risk_factor`.

## Prototype limitations

The screen starts with example weather values and uses fixed fallback values after request failures. Destination suggestions and rain-chart values also include sample content. Do not treat the screen as a verified live forecast, safety warning, or location-aware travel service.

## Development checks

```bash
flutter analyze
flutter test
```

The commands are provided for local verification. API availability, build success, and platform behavior have not been verified as part of this documentation update.
