import 'package:genius_radio/src/models/YoutubeVideo.dart';
import 'package:mobx/mobx.dart';

// ignore: implementation_imports
import 'package:youtube_plyr_iframe/src/player_value.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'player_store.g.dart';

class PlayerStore = _PlayerStore with _$PlayerStore;

abstract class _PlayerStore with Store {
  _PlayerStore();

  @observable
  bool isLoadingPlaylist = false;

  @observable
  bool isSeeking = false;

  @observable
  double seekValue = 0;

  @observable
  List<YoutubeVideo> playlist = [];

  @observable
  int playlistIndex = 0;

  @observable
  String author = "";

  @observable
  String title = "";

  @observable
  String videoId = "";

  @observable
  PlayerState playerState;

  @observable
  Duration duration = Duration(seconds: 100);

  @observable
  Duration position = Duration(seconds: 0);

  @action
  void setSeeking(bool value) {
    isSeeking = value;
  }

  @action
  void setSeekValue(double value) {
    seekValue = value;
  }

  @action
  void nextSong() {
    if (playlistIndex < playlist.length - 1) {
      playlistIndex += 1;
    }
  }

  @action
  void selectSong(int value) {
    playlistIndex = value;
  }

  @action
  void previousSong() {
    if (playlistIndex > 0) {
      playlistIndex -= 1;
    }
  }

  @action
  Future<void> loadPlaylist(List<String> list) async {
    isLoadingPlaylist = true;
    for (String element in list) {
      playlist.add(await getDetail(element));
    }
    isLoadingPlaylist = false;
  }

  Future<YoutubeVideo> getDetail(String id) async {
    String embedUrl =
        "https://www.youtube.com/oembed?url=http://www.youtube.com/watch?v=$id&format=json";
    var res = await http.get(Uri.parse(embedUrl));
    try {
      if (res.statusCode == 200) {
        //return the json from the response
        var decoded = json.decode(res.body);
        decoded.addAll({"videoId": id});
        return YoutubeVideo.fromJson(decoded);
      } else {
        return null;
      }
    } on FormatException catch (e) {
      print('invalid JSON' + e.toString());
      return null;
    }
  }

  @action
  setValues(YoutubePlayerValue value) {
    position = value.position;
    author = value.metaData.author;
    title = value.metaData.title;
    videoId = value.metaData.videoId;
    duration = value.metaData.duration;
    playerState = value.playerState;
  }
}
