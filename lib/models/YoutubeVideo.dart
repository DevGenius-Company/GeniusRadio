class YoutubeVideo {
  final String title;
  final String author;
  final String thumbnail;
  final String videoId;

  YoutubeVideo({this.title, this.author, this.thumbnail,this.videoId});

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
        title: json['title'],
        author: json['author_name'],
        thumbnail: json['thumbnail_url'],
        videoId: json['videoId']);
  }
}
