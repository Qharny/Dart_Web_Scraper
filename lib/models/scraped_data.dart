class ScrapedData {
  final String url;
  final List<String> paragraphs;
  final List<String?> links;

  ScrapedData({required this.url, required this.paragraphs, required this.links});

  @override
  String toString() {
    return 'ScrapedData(url: $url, paragraphs: $paragraphs, links: $links)';
  }
}