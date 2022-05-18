import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:http/http.dart' as http;
import 'package:tarana_app_live/auth_configFile/authconfig.dart';
import 'notifier/PlayButtonNotifier.dart';
import 'notifier/ProgressNotifier.dart';
import 'notifier/repeat_button_notifier.dart';
import 'notifier/service_locator.dart';

class PageManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final currentSongSingerNotifier = ValueNotifier<String>('');
  final currentSongAlbumNotifier = ValueNotifier<String>('');
  final currentSongAlbumIdNotifier=ValueNotifier<String>('');
  final currentSongAudiVideoTypeNotifier=ValueNotifier<String>('');
  final currentSongV_id_Notifier=ValueNotifier<String>('');
  final currentSongV_titleNotifier=ValueNotifier<String>('');
  final currentSongV_locationNotifier=ValueNotifier<String>('');
  final currentSongCreator_name_Notifier = ValueNotifier<String>('');
  final currentSongfloowing_statusNotifier=ValueNotifier<String>('');
  final currentSongcreator_imageNotifier = ValueNotifier<String>('');
  final currentSongcreator_followerssNotifier = ValueNotifier<String>('');
  final currentSongcreated_by_idNotifier = ValueNotifier<String>('');
  final currentSongbgColor=ValueNotifier('');
  final currentSongIdNotifier=ValueNotifier('');
/*  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);*/
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final currentSongImageNotifier = ValueNotifier<String>('');
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final _audioHandler = getIt<AudioHandler>();
  // Events: Calls coming from the UI
  Future <void> init(current_album_id,creator_names,creator_image,creator_followerss,created_by_id,floowing_status) async {
    await _loadPlaylist(current_album_id,creator_names,creator_image,creator_followerss,created_by_id,floowing_status);
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    _listenToChangesInSinger();
    _listenToChangesInImage();
    _listenToChangessongColor();
    _current_play_song();
  }

  Future <void> _loadPlaylist(current_album_id,creator_names,creator_image,creator_followerss,created_by_id,floowing_status) async {
    var jsonResponse = null;
    var jsonResponse1 = null;
    Map datas = {
      'movie_id':current_album_id,
    };
    var response = await http.post(
        Uri.parse('https://www.itexpress4u.tech/taranaApi/MasterValue_Api/songsList'),
        body: datas);
    jsonResponse = json.decode(response.body);
    var streetsFromJson = jsonResponse['songs_list'];
    //TestClass b = TestClass();
    //  print("creator_imagea");
    //  final songRepository = getIt<TestClass>();
   // var playlist = await songRepository.Test_details(current_album_id);
   // final playlist = await TestClass().Test_details();

    final playlists = streetsFromJson;
   // var valueMap =jsonResponse1[playlist];
   // print(playlist);
    final mediaItems = streetsFromJson
        .map<MediaItem>((song) => MediaItem(
      id: song['id'] ?? '',
      album: song['movie_name'] ?? '',
      title: song['title'] ?? '',
      artist: song['singer_name'] ?? '',
      artUri: Uri.parse(Base_url().image_url+song['image']),
      extras: {'url': "https://www.itexpress4u.tech/taranaApi/assets/songs/"+song['file_name'],'colour': song['colour'],'image': Base_url().image_url+song['image'],'release_year': song['release_year'],'language': song['language'],'creator_names':creator_names,'creator_image':creator_image,'creator_followerss':creator_followerss,'created_by_id':created_by_id,'current_album_id':current_album_id,'audio_video_type':song['audio_video_type'],'v_id':song['v_id'],'v_location':song['v_location'],'v_title':song['v_title']},
    ))
        .toList();

    print(mediaItems);
  //  remove();
  /*  await _audioHandler.removeQueueItem(mediaItems);
    _audioHandler*/
  //  for (int i = 0; i < playlists.length; i++) {
     await remove();
     /* for (var x in mediaItems){
        print("sdsfsdfsd");
        print(x);
      }*/
  //  }
    _audioHandler.addQueueItems(mediaItems);
    for (var x in _audioHandler.queue.value){
      print("sdsfsdfsd");
      print(x);
    }

  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlists) {
      if (playlists.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlists.map((item) => item.title).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
    /*_audioHandler.queue.listen((playlists) {
      if (playlists.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
       // final newList = playlist.map((item) => item.title).toList();
          playlistNotifier.value = playlists;
      }
      _updateSkipButtons();
    });*/
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }
  void skipToQueueItem(int index, String name) {
    _audioHandler.skipToQueueItem(index);
     print(name);
    print("name_123456");
    _audioHandler.play();

  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }
/*creator_names,creator_image,creator_followerss,created_by_id*/
  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      currentSongAlbumNotifier.value = mediaItem?.album ?? '';

      currentSongAudiVideoTypeNotifier.value=mediaItem?.extras!['audio_video_type'] ?? '';
      currentSongV_id_Notifier.value=mediaItem?.extras!['v_id'] ?? '';
      currentSongV_titleNotifier.value =mediaItem?.extras!['v_title'] ?? '';
      currentSongV_locationNotifier.value =mediaItem?.extras!['v_location'] ?? '';

      currentSongAlbumIdNotifier.value =mediaItem?.extras!['current_album_id'] ?? '';
      currentSongCreator_name_Notifier.value = mediaItem?.extras!['creator_names'] ?? '';
      currentSongcreator_imageNotifier.value = mediaItem?.extras!['creator_image'] ?? '';
      currentSongcreator_followerssNotifier.value =mediaItem?.extras!['creator_followerss'] ?? '';
      currentSongcreated_by_idNotifier.value =mediaItem?.extras!['created_by_id'] ?? '';
      currentSongfloowing_statusNotifier.value =mediaItem?.extras!['floowing_status'] ?? '';
      _updateSkipButtons();
    });
  }

  void _listenToChangessongColor() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongbgColor.value = mediaItem?.extras!['url'];
      _updateSkipButtons();
    });
  }

  void _listenToChangesInSinger() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongSingerNotifier.value = mediaItem?.artist ?? '';
      currentSongIdNotifier.value = mediaItem?.id ?? '';
      currentSongIdNotifier.value = mediaItem?.id ?? '';
      _updateSkipButtons();
    });
  }
  void _listenToChangesInImage() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongImageNotifier.value =mediaItem?.extras!['image'];
      _updateSkipButtons();
    });
  }

  void _current_play_song() {
    _audioHandler.mediaItem.listen((mediaItem) {
      print("dsfdsfdssds");
      print(mediaItem);
    //  currentSongImageNotifier.value =mediaItem?.extras!['image'];
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

   Future<void>  remove() async {
    final lastIndex = _audioHandler.queue.value.length - 1;
   /* if (lastIndex < 0) return;*/
     for (int i = 0; i < _audioHandler.queue.value.length; i++) {
      await _audioHandler.removeQueueItemAt(lastIndex);
    }

  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
