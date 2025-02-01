class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final DateTime releasedate;
  final bool isFavorited;
  final String songId;

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releasedate,
    required this.isFavorited,
    required this.songId,
  });
}