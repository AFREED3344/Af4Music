import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/database/model.dart';
import 'package:musicplayer/database/playlistfuntion.dart';
import 'package:musicplayer/nowplayscreen.dart';
import 'package:musicplayer/songadding.dart';
import 'package:musicplayer/widgets/getsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistData extends StatefulWidget {
  const PlaylistData(
      {Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final MusicModel playlist;
  final int folderindex;
  @override
  State<PlaylistData> createState() => _PlaylistDataState();
}

class _PlaylistDataState extends State<PlaylistData> {
  late List<SongModel> playlistsong;
  @override
  Widget build(BuildContext context) {
    getAllDetails();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Text(widget.playlist.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SongListPage(
                              playlist: widget.playlist,
                            )));
                  },
                  child: const Text('Add Songs')),
              ValueListenableBuilder(
                valueListenable: Hive.box<MusicModel>('playlist').listenable(),
                builder: (BuildContext context, Box<MusicModel> value,
                    Widget? child) {
                  playlistsong = listPlaylist(
                      value.values.toList()[widget.folderindex].songData);

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                            onTap: () {
                              List<SongModel> newlist = [...playlistsong];
                              GetSongs.player.setAudioSource(
                                  GetSongs.createSongList(newlist),
                                  initialIndex: index);
                              GetSongs.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      NowPlay(playerSong: newlist)));
                            },
                            //showinh songs
                            leading: QueryArtworkWidget(
                              id: playlistsong[index].id,
                              type: ArtworkType.AUDIO,
                              errorBuilder: (context, excepion, gdb) {
                                setState(() {});
                                return Image.asset('');
                              },
                            ),
                            title: Text(
                              playlistsong[index].title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            subtitle: Text(
                              playlistsong[index].artist!,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(25.0),
                                                  topRight:
                                                      Radius.circular(25.0))),
                                          child: SizedBox(
                                            height: 350,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors
                                                              .transparent),
                                                  child: QueryArtworkWidget(
                                                      artworkBorder:
                                                          BorderRadius.circular(
                                                              1),
                                                      artworkWidth: 100,
                                                      artworkHeight: 400,
                                                      id: playlistsong[index]
                                                          .id,
                                                      type: ArtworkType.AUDIO),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    playlistsong[index].title,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Colors
                                                                      .transparent),
                                                          onPressed: () {
                                                            widget.playlist
                                                                .deleteData(
                                                                    playlistsong[
                                                                            index]
                                                                        .id);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .delete_outline_outlined,
                                                            size: 25,
                                                          ),
                                                          label: const Text(
                                                            'Remove Song',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.more_vert_sharp,
                                  color: Colors.white,
                                )));
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: playlistsong.length);
                },
              ),
            ],
          )),
        ),
      ),
    );
  }

  // showing song funtion
  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetSongs.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetSongs.songscopy[i].id == data[j]) {
          plsongs.add(GetSongs.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
