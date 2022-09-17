import 'package:flutter/material.dart';
import 'package:musicplayer/nowplayscreen.dart';
import 'package:musicplayer/widgets/getsongs.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayerPage extends StatefulWidget {
  const MiniPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniPlayerPage> createState() => _MiniPlayerPageState();
}

class _MiniPlayerPageState extends State<MiniPlayerPage> {
  @override
  void initState() {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: const Color.fromARGB(255, 27, 27, 27),
        width: deviceSize.width,
        height: 70,
        child: ListTile(
          onTap: () {
            // GetSongs.player.setAudioSource(
            //     GetSongs.createSongList(GetSongs.songCopy),
            //     initialIndex: GetSongs.player.currentIndex);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => NowPlay(
                      playerSong: GetSongs.playingSongs,
                    )));
          },
          iconColor: Colors.white,
          textColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  artworkWidth: 100,
                  artworkHeight: 400,
                  id: GetSongs.playingSongs[GetSongs.player.currentIndex!].id,
                  type: ArtworkType.AUDIO,
                )),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              GetSongs
                  .playingSongs[GetSongs.player.currentIndex!].displayNameWOExt,
              style: const TextStyle(
                  fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${GetSongs.playingSongs[GetSongs.player.currentIndex!].artist}",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: const Color.fromARGB(255, 27, 27, 27),
                onPrimary: Colors.white),
            onPressed: () async {
              if (GetSongs.player.playing) {
                await GetSongs.player.pause();
                setState(() {});
              } else {
                if (GetSongs.player.currentIndex != null) {
                  await GetSongs.player.play();
                }
                setState(() {});
              }
            },
            child: StreamBuilder<bool>(
                stream: GetSongs.player.playingStream,
                builder: (context, snapshot) {
                  bool? playingState = snapshot.data;
                  if (playingState != null && playingState) {
                    return const Icon(
                      Icons.pause,
                      size: 35,
                    );
                  } else {
                    return const Icon(
                      Icons.play_arrow,
                      size: 35,
                    );
                  }
                }),
          ),
        ));
  }
}