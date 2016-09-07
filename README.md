# Geojson formatter plugin for Embulk
[![Gem](https://img.shields.io/gem/v/embulk-formatter-geojson.svg)](https://rubygems.org/gems/embulk-formatter-geojson) [![Gem](https://img.shields.io/gem/dv/embulk-formatter-geojson/stable.svg)](https://rubygems.org/gems/embulk-formatter-geojson)

Geojson formatter based on given `.geojson` template file.
This plugin inject properties passed from input to template `.geojson` file.

## Overview

* **Plugin type**: formatter

## Configuration

- **template_file**: template geojson file path (integer, required)
- **encoding**: output file encoding (string, default: `"UTF-8"`)
- **identifier**: which identifies corresponding feature in geojson file (string, default: `id`)

## Example

```yaml
out:
  type: file
  formatter:
    type: geojson
    template_file: /path/to/template.geojson
    identifier: "identifier"
```

## Build

```
$ rake
```
