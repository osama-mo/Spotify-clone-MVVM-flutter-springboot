import 'dart:convert';


class Song {
  final String title;
  final String artist;
  final String hexCode;
  final String uploadedBy;
  final String thumbnail_url;
  final String song_url;

  Song({
      required this.title,
      required this.artist,
      required this.hexCode,
      required this.uploadedBy,
      required this.thumbnail_url,
      required this.song_url,
    });


  Song copyWith({
    String? title,
    String? artist,
    String? hexCode,
    String? uploadedBy,
    String? thumbnail_url,
    String? song_url,
  }) {
    return Song(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      hexCode: hexCode ?? this.hexCode,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'artist': artist,
      'hexCode': hexCode,
      'uploadedBy': uploadedBy,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      title: map['title'] as String,
      artist: map['artist'] as String,
      hexCode: map['hexCode'] as String,
      uploadedBy: map['uploadedBy'] as String,
      thumbnail_url: map['thumbnail_url'] as String,
      song_url: map['song_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Song(title: $title, artist: $artist, hexCode: $hexCode, uploadedBy: $uploadedBy, thumbnail_url: $thumbnail_url, song_url: $song_url)';
  }

  @override
  bool operator ==(covariant Song other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.artist == artist &&
      other.hexCode == hexCode &&
      other.uploadedBy == uploadedBy &&
      other.thumbnail_url == thumbnail_url &&
      other.song_url == song_url;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      artist.hashCode ^
      hexCode.hashCode ^
      uploadedBy.hashCode ^
      thumbnail_url.hashCode ^
      song_url.hashCode;
  }
}
