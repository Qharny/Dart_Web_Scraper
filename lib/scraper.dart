import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'models/scraped_data.dart';

class Scraper {
  Future<ScrapedData> scrapeWebsite(String url) async {
    var response = await http.get(Uri.parse(url));
    var document = parse(response.body);
    
    // Example: scraping all paragraph texts
    var paragraphs = document.querySelectorAll('p').map((element) => element.text).toList();
    
    // Example: scraping all link URLs
    var links = document.querySelectorAll('a').map((element) => element.attributes['href']).toList();
    
    return ScrapedData(
      url: url,
      paragraphs: paragraphs,
      links: links,
    );
  }
}