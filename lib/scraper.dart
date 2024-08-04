import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'models/scraped_data.dart';

class Scraper {
  http.Client client = http.Client();

  Future<ScrapedData> scrapeWebsite(String url) async {
    try {
      var response = await client.get(Uri.parse(url));
      var document = parse(response.body);
      
      var paragraphs = document.querySelectorAll('p').map((element) => element.text).toList();
      var links = document.querySelectorAll('a').map((element) => element.attributes['href']).toList();
      
      return ScrapedData(
        url: url,
        paragraphs: paragraphs,
        links: links,
      );
    } catch (e) {
      throw Exception('Failed to scrape website: $e');
    }
  }
}