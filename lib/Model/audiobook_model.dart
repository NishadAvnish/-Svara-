class AudioBookModel {
  final String imageUrl;
  final String audioUrl;
  final String title;

  AudioBookModel({this.title, this.imageUrl, this.audioUrl});

  Map<String, dynamic> tomap() {
    var map = <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };

    return map;
  }
}
