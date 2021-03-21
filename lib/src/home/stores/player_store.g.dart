// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlayerStore on _PlayerStore, Store {
  final _$isLoadingPlaylistAtom = Atom(name: '_PlayerStore.isLoadingPlaylist');

  @override
  bool get isLoadingPlaylist {
    _$isLoadingPlaylistAtom.reportRead();
    return super.isLoadingPlaylist;
  }

  @override
  set isLoadingPlaylist(bool value) {
    _$isLoadingPlaylistAtom.reportWrite(value, super.isLoadingPlaylist, () {
      super.isLoadingPlaylist = value;
    });
  }

  final _$isSeekingAtom = Atom(name: '_PlayerStore.isSeeking');

  @override
  bool get isSeeking {
    _$isSeekingAtom.reportRead();
    return super.isSeeking;
  }

  @override
  set isSeeking(bool value) {
    _$isSeekingAtom.reportWrite(value, super.isSeeking, () {
      super.isSeeking = value;
    });
  }

  final _$seekValueAtom = Atom(name: '_PlayerStore.seekValue');

  @override
  double get seekValue {
    _$seekValueAtom.reportRead();
    return super.seekValue;
  }

  @override
  set seekValue(double value) {
    _$seekValueAtom.reportWrite(value, super.seekValue, () {
      super.seekValue = value;
    });
  }

  final _$playlistAtom = Atom(name: '_PlayerStore.playlist');

  @override
  List<YoutubeVideo> get playlist {
    _$playlistAtom.reportRead();
    return super.playlist;
  }

  @override
  set playlist(List<YoutubeVideo> value) {
    _$playlistAtom.reportWrite(value, super.playlist, () {
      super.playlist = value;
    });
  }

  final _$playlistIndexAtom = Atom(name: '_PlayerStore.playlistIndex');

  @override
  int get playlistIndex {
    _$playlistIndexAtom.reportRead();
    return super.playlistIndex;
  }

  @override
  set playlistIndex(int value) {
    _$playlistIndexAtom.reportWrite(value, super.playlistIndex, () {
      super.playlistIndex = value;
    });
  }

  final _$authorAtom = Atom(name: '_PlayerStore.author');

  @override
  String get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(String value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  final _$titleAtom = Atom(name: '_PlayerStore.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$videoIdAtom = Atom(name: '_PlayerStore.videoId');

  @override
  String get videoId {
    _$videoIdAtom.reportRead();
    return super.videoId;
  }

  @override
  set videoId(String value) {
    _$videoIdAtom.reportWrite(value, super.videoId, () {
      super.videoId = value;
    });
  }

  final _$playerStateAtom = Atom(name: '_PlayerStore.playerState');

  @override
  PlayerState get playerState {
    _$playerStateAtom.reportRead();
    return super.playerState;
  }

  @override
  set playerState(PlayerState value) {
    _$playerStateAtom.reportWrite(value, super.playerState, () {
      super.playerState = value;
    });
  }

  final _$durationAtom = Atom(name: '_PlayerStore.duration');

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  final _$positionAtom = Atom(name: '_PlayerStore.position');

  @override
  Duration get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Duration value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  final _$loadPlaylistAsyncAction = AsyncAction('_PlayerStore.loadPlaylist');

  @override
  Future<void> loadPlaylist(List<String> list) {
    return _$loadPlaylistAsyncAction.run(() => super.loadPlaylist(list));
  }

  final _$_PlayerStoreActionController = ActionController(name: '_PlayerStore');

  @override
  void setSeeking(bool value) {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.setSeeking');
    try {
      return super.setSeeking(value);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSeekValue(double value) {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.setSeekValue');
    try {
      return super.setSeekValue(value);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextSong() {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.nextSong');
    try {
      return super.nextSong();
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectSong(int value) {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.selectSong');
    try {
      return super.selectSong(value);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousSong() {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.previousSong');
    try {
      return super.previousSong();
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValues(YoutubePlayerValue value) {
    final _$actionInfo = _$_PlayerStoreActionController.startAction(
        name: '_PlayerStore.setValues');
    try {
      return super.setValues(value);
    } finally {
      _$_PlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingPlaylist: ${isLoadingPlaylist},
isSeeking: ${isSeeking},
seekValue: ${seekValue},
playlist: ${playlist},
playlistIndex: ${playlistIndex},
author: ${author},
title: ${title},
videoId: ${videoId},
playerState: ${playerState},
duration: ${duration},
position: ${position}
    ''';
  }
}
