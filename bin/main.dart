import 'dart:io';
import 'package:dart_web_scraper/scraper.dart';
import 'package:dart_web_scraper/models/scraped_data.dart';

void main(List<String> arguments) async {
  var scraper = Scraper();
  var url = getUrl();

  var scrapedData = await scraper.scrapeWebsite(url);
  print('Scraped data: $scrapedData');

  await saveToFile(scrapedData);
}

String getUrl() {
  print("Enter URL: ");
  String geturl = stdin.readLineSync()!;
  return geturl;
}

Future<void> saveToFile(ScrapedData data) async {
  var file = File('scraped_data.txt');
  var sink = file.openWrite();
  
  sink.writeln('URL: ${data.url}');
  sink.writeln('\nParagraphs:');
  for (var p in data.paragraphs) {
    sink.writeln('- $p');
  }
  sink.writeln('\nLinks:');
  for (var l in data.links) {
    sink.writeln('- $l');
  }
  
  await sink.flush();
  await sink.close();
  
  print('Data saved to ${file.path}');
}