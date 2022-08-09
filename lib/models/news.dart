class News{
  late final String title;
  late final String author;
  late final String link;
  late final String published_date;
  late final String summary;
  late final String media;

  News({
    required this.author,
    required this.title,
    required this.link,
    required this.media,
    required this.published_date,
    required this.summary
});

  factory News.fromJson(Map<String , dynamic>json){
    return News(
        title: json['title'] ?? '',
        author: json['author'] ?? '',
        link: json['link'] ?? '',
        media: json['media'] ?? '',
        published_date: json['published_date'] ?? '',
        summary: json['summary'] ?? ''
    );
  }


}