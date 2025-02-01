import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groovroads/domain/entities/song/song.dart';

class SongModel {
  String? artist;
  num? duration;
  Timestamp? releasedate;
  String? title;
  bool ? isFavorited;
  String ? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releasedate,
    required this.isFavorited,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
  title = json['title']?.toString();
  artist = json['artist']?.toString();
  duration = json['duration'] ?? 0;
  releasedate = json['releasedate'] is Timestamp
      ? json['releasedate']
      : Timestamp.fromDate(DateTime.parse(json['releasedate']));
}
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releasedate: releasedate!.toDate(), // Convert Timestamp to DateTime
      isFavorited: isFavorited!,
      songId: songId!,
    );
  }
}