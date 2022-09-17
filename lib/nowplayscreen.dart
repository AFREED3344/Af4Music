import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/database/favouritedb.dart';
import 'package:musicplayer/widgets/getsongs.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

import 'database/favouritebutton.dart';

class NowPlay extends StatefulWidget {
  NowPlay({Key? key, required this.playerSong}) : super(key: key);
  final List<SongModel> playerSong;

  @override
  State<NowPlay> createState() => _NowPlayState();
}

class _NowPlayState extends State<NowPlay> {
  bool _isshuffle = false;
  int currentIndex = 0;
  bool _isPlaying = true;

  @override
  void initState() {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
        GetSongs.currentIndes = index;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 18, 18, 18),
          Color.fromARGB(255, 44, 42, 42)
        ], stops: [
          0.5,
          1
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
                FavoriteDB.favoriteSongs.notifyListeners();
              }),
              icon: const Icon(Icons.arrow_drop_down_circle_outlined)),
          title: const Text('Playing Now'),
          centerTitle: true,
          actions: const [
            Icon(
              Icons.abc,
              color: Colors.black,
            )
          ],
        ),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.8),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 500,
                          width: 300,
                          child: QueryArtworkWidget(
                            keepOldArtwork: true,
                            id: widget.playerSong[currentIndex].id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(20),
                            nullArtworkWidget: const Icon(
                              Icons.music_note_outlined,
                              color: Colors.white,
                              size: 200,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      widget.playerSong[currentIndex]
                                          .displayNameWOExt,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.playerSong[currentIndex].artist
                                                .toString() ==
                                            "<unknown>"
                                        ? "Unknown Artist"
                                        : widget.playerSong[currentIndex].artist
                                            .toString(),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              child: FavoriteBut(
                                  song: widget.playerSong[currentIndex]),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<DurationState>(
                            stream: _durationStateStream,
                            builder: (context, snapshot) {
                              final durationState = snapshot.data;
                              final progress =
                                  durationState?.position ?? Duration.zero;
                              final total =
                                  durationState?.total ?? Duration.zero;
                              return ProgressBar(
                                  timeLabelTextStyle:
                                      TextStyle(color: Colors.white),
                                  progress: progress,
                                  total: total,
                                  barHeight: 3.0,
                                  thumbRadius: 5,
                                  progressBarColor: Colors.white,
                                  thumbGlowColor: Colors.white,
                                  thumbColor: Colors.white,
                                  baseBarColor: Colors.grey,
                                  bufferedBarColor: Colors.grey,
                                  buffered: const Duration(milliseconds: 2000),
                                  onSeek: (duration) {
                                    GetSongs.player.seek(duration);
                                  });
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.all(15),
                                  primary: Colors.transparent,
                                  onPrimary: Colors.black),
                              onPressed: () {
                                _isshuffle == false
                                    ? GetSongs.player
                                        .setShuffleModeEnabled(true)
                                    : GetSongs.player
                                        .setShuffleModeEnabled(false);
                                // setState(() {
                                //   _isshuffle = !_isshuffle;
                                // });
                                const ScaffoldMessenger(
                                    child: SnackBar(
                                        content: Text('Shuffle Enabled')));
                              },
                              //shuffle stream
                              child: StreamBuilder<bool>(
                                  stream:
                                      GetSongs.player.shuffleModeEnabledStream,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    _isshuffle = snapshot.data;
                                    if (_isshuffle) {
                                      return Icon(
                                        Icons.shuffle,
                                        color: Colors.red[800],
                                        size: 25,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.shuffle,
                                        size: 25,
                                        color: Colors.white,
                                      );
                                    }
                                  }),
                            ),
                            //backbutton
                            IconButton(
                                onPressed: () async {
                                  if (GetSongs.player.hasPrevious) {
                                    await GetSongs.player.seekToPrevious();
                                    await GetSongs.player.play();
                                  } else {
                                    await GetSongs.player.play();
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            //pause button
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isPlaying) {
                                      GetSongs.player.pause();
                                    } else {
                                      GetSongs.player.play();
                                    }
                                    _isPlaying = !_isPlaying;
                                  });
                                },
                                icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            //next buttons
                            IconButton(
                                highlightColor: Colors.white,
                                onPressed: (() async {
                                  if (GetSongs.player.hasNext) {
                                    await GetSongs.player.seekToNext();
                                    await GetSongs.player.play();
                                  } else {
                                    await GetSongs.player.play();
                                  }
                                }),
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.transparent,
                                    onPrimary: Colors.black),
                                onPressed: () {
                                  GetSongs.player.loopMode == LoopMode.one
                                      ? GetSongs.player
                                          .setLoopMode(LoopMode.all)
                                      : GetSongs.player
                                          .setLoopMode(LoopMode.one);
                                },
                                //loop stream
                                child: StreamBuilder<LoopMode>(
                                  stream: GetSongs.player.loopModeStream,
                                  builder: (context, snapshot) {
                                    final loopMode = snapshot.data;
                                    if (LoopMode.one == loopMode) {
                                      return Icon(
                                        Icons.repeat_one,
                                        color: Colors.red[800],
                                        size: 25,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.repeat,
                                        color: Colors.white,
                                        size: 25,
                                      );
                                    }
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
    // });
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          GetSongs.player.positionStream,
          GetSongs.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
