class AudioBookModel {
  final String imageUrl;
  final String audioUrl;
  final String title;
  bool favourite=false;

  AudioBookModel({this.title, this.imageUrl, this.audioUrl,this.favourite});

  Map<String, dynamic> tomap() {
    var map = <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };

    return map;
  }
}
