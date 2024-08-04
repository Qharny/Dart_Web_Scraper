import 'package:test/test.dart';
import 'package:dart_web_scraper/scraper.dart';
import 'package:dart_web_scraper/models/scraped_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('Scraper Tests', () {
    late Scraper scraper;

    setUp(() {
      scraper = Scraper();
    });

    test('scrapeWebsite extracts paragraphs and links correctly', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '''
          <html>
            <body>
              <p>Test paragraph 1</p>
              <p>Test paragraph 2</p>
              <a href="https://example.com">Example link</a>
              <a href="https://test.com">Test link</a>
            </body>
          </html>
          ''',
          200,
          headers: {'content-type': 'text/html'},
        );
      });

      scraper.client = mockClient;

      final result = await scraper.scrapeWebsite('https://test-url.com');

      expect(result, isA<ScrapedData>());
      expect(result.url, equals('https://test-url.com'));
      expect(
          result.paragraphs, equals(['Test paragraph 1', 'Test paragraph 2']));
      expect(result.links, equals(['https://example.com', 'https://test.com']));
    });

    test('scrapeWebsite handles empty response', () async {
      final mockClient = MockClient((request) async {
        return http.Response('', 200);
      });

      scraper.client = mockClient;

      final result = await scraper
          .scrapeWebsite('https://globalwave.vercel.app/Index.html');

      expect(result, isA<ScrapedData>());
      expect(result.url, equals('https://globalwave.vercel.app/Index.html'));
      expect(result.paragraphs, isEmpty);
      expect(result.links, isEmpty);
    });

    test('scrapeWebsite handles network error', () async {
      final mockClient = MockClient((request) async {
        throw Exception('Network error');
      });

      scraper.client = mockClient;

      expect(
          () =>
              scraper.scrapeWebsite('https://globalwave.vercel.app/Index.html'),
          throwsA(isA<Exception>()));
    });
  });
}
