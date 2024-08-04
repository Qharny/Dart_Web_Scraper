import 'dart:io';
import 'package:dart_web_scraper/scraper.dart';
import 'package:dart_web_scraper/models/scraped_data.dart';
import 'package:args/args.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('url', abbr: 'u', help: 'URL to scrape')
    ..addOption('format', abbr: 'f', help: 'Output format (txt, csv, json)')
    ..addOption('output', abbr: 'o', help: 'Output file name');

  ArgResults argResults;
  try {
    argResults = parser.parse(arguments);
  } catch (e) {
    print('Error parsing arguments: $e');
    print(
        'Usage: dart run bin/main.dart --url <URL> [--format <format>] [--output <filename>]');
    exit(1);
  }

  var url = argResults['url'] as String? ?? getUrl();
  var format = argResults['format'] as String? ?? getFormat();
  var outputFile =
      argResults['output'] as String? ?? getDefaultFileName(format);

  var scraper = Scraper();

  try {
    var scrapedData = await scraper.scrapeWebsite(url);
    print('Scraped data: $scrapedData');

    await saveToFile(scrapedData, format, outputFile);
  } catch (e) {
    print('An error occurred: $e');
    exit(1);
  }
}

String getUrl() {
  print("Enter URL: ");
  String? geturl = stdin.readLineSync();
  if (geturl == null || geturl.isEmpty) {
    print('Invalid URL');
    exit(1);
  }
  return geturl;
}

String getFormat() {
  print("Select output format:");
  print("1. txt");
  print("2. csv");
  print("3. json");
  print("\n ※※※※※※※※※※※ \n");

  String? choice = stdin.readLineSync();
  switch (choice) {
    case '1':
      return 'txt';
    case '2':
      return 'csv';
    case '3':
      return 'json';
    default:
      print('Invalid choice. Defaulting to txt format.');
      return 'txt';
  }
}

String getDefaultFileName(String format) {
  var timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
  return 'scraped_data_$timestamp.$format';
}

Future<void> saveToFile(
    ScrapedData data, String format, String fileName) async {
  var file = File(fileName);
  var sink = file.openWrite();

  switch (format) {
    case 'txt':
      writeTxtFormat(sink, data);
      break;
    case 'csv':
      writeCsvFormat(sink, data);
      break;
    case 'json':
      writeJsonFormat(sink, data);
      break;
    default:
      throw ArgumentError('Unsupported format: $format');
  }

  await sink.flush();
  await sink.close();

  print('Data saved to ${file.absolute.path}');
}

void writeTxtFormat(IOSink sink, ScrapedData data) {
  sink.writeln('URL: ${data.url}');
  sink.writeln('\nParagraphs:');
  for (var p in data.paragraphs) {
    sink.writeln('- $p');
  }
  sink.writeln('\nLinks:');
  for (var l in data.links) {
    sink.writeln('- $l');
  }
}

void writeCsvFormat(IOSink sink, ScrapedData data) {
  var csvData = [
    ['URL', data.url],
    ['Type', 'Content'],
    ...data.paragraphs.map((p) => ['Paragraph', p]),
    ...data.links.map((l) => ['Link', l]),
  ];
  sink.writeAll(ListToCsvConverter().convert(csvData) as Iterable);
}

void writeJsonFormat(IOSink sink, ScrapedData data) {
  var jsonData = {
    'url': data.url,
    'paragraphs': data.paragraphs,
    'links': data.links,
  };
  sink.write(jsonEncode(jsonData));
}
