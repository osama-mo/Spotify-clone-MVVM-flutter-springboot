// ignore_for_file: non_constant_identifier_names

import 'dart:convert';


class Song {
  final String id;
  final String title;
  final String artist;
  final String hexCode;
  final String uploadedBy;
  final String thumbnail_url;
  final String song_url;

  Song({
      required this.id,
      required this.title,
      required this.artist,
      required this.hexCode,
      required this.uploadedBy,
      required this.thumbnail_url,
      required this.song_url,
    });


  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? hexCode,
    String? uploadedBy,
    String? thumbnail_url,
    String? song_url,
  }) {
    return Song(
      id: id ?? this.id,
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
      'id': id,
      'title': title,
      'artist': artist,
      'hexCode': hexCode,
      'uploadedBy': uploadedBy,
      'coverArtPath': thumbnail_url,
      'songFilePath': song_url,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as String,
      title: map['title'] as String,
      artist: map['artist'] as String,
      hexCode: map['hexCode'] as String,
      uploadedBy: map['uploadedBy'] as String,
      thumbnail_url: map['coverArtPath'] as String,
      song_url: map['songFilePath'] as String,
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


  static List<Song> fromJsonList(String jsonList) {
    List<Song> songs = [];
    List<dynamic> list = json.decode(jsonList);
    list.forEach((element) {
      songs.add(Song.fromMap(element));
    });
    return songs;
  
  }
}
