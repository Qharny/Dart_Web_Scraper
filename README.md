# Dart Web Scraper

A versatile command-line web scraper built with Dart. This tool allows you to scrape web pages and save the extracted data in various formats.

## Features

- Scrape paragraphs and links from any web page
- Save scraped data in TXT, CSV, or JSON format
- Command-line interface with interactive prompts
- Flexible output options (specify format and filename)
- Error handling for network issues and invalid inputs

## Prerequisites

To run this project, you need to have Dart SDK installed on your system. If you haven't installed Dart yet, follow the [official Dart installation guide](https://dart.dev/get-dart).

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/Qharny/Dart_Web_Scraper.git
   cd Dart_Web_Scraper
   ```

2. Install dependencies:
   ```
   dart pub get
   ```

## Usage

You can run the web scraper using the following command:

```
dart run bin/main.dart [options]
```

## Test
You can run the test using the following command:
```
dart run test
```

### Options:

- `--url` or `-u`: Specify the URL to scrape
- `--format` or `-f`: Specify the output format (txt, csv, or json)
- `--output` or `-o`: Specify the output filename

If you don't provide these options, the script will prompt you to enter them interactively.

### Examples:

1. Scrape a website and save as TXT (with interactive prompts):
   ```
   dart run bin/main.dart
   ```

2. Scrape a specific URL and save as CSV:
   ```
   dart run bin/main.dart --url https://example.com --format csv
   ```

3. Scrape a website, save as JSON with a custom filename:
   ```
   dart run bin/main.dart --url https://example.com --format json --output my_data.json
   ```

## Project Structure

- `bin/main.dart`: The main entry point of the application
- `lib/scraper.dart`: Contains the core scraping logic
- `lib/models/scraped_data.dart`: Defines the data model for scraped content

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License


## Acknowledgements

- [http](https://pub.dev/packages/http) package for making HTTP requests
- [html](https://pub.dev/packages/html) package for parsing HTML
- [args](https://pub.dev/packages/args) package for parsing command-line arguments
- [csv](https://pub.dev/packages/csv) package for CSV file handling