import 'package:flutter/material.dart';
import 'package:musicplayer/database/model.dart';
import 'package:musicplayer/database/playlistfuntion.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({Key? key, required this.playlist}) : super(key: key);

  final MusicModel playlist;
  @override
  State<SongListPage> createState() => _SongListPageState();
}

final OnAudioQuery audioQuery = OnAudioQuery();

class _SongListPageState extends State<SongListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                      child: Text(
                        'Add Songs ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<List<SongModel>>(
                    future: audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'NO Songs Found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () {},
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: QueryArtworkWidget(
                                  id: item.data![index].id,
                                  type: ArtworkType.AUDIO),
                              title: Text(item.data![index].displayNameWOExt),
                              subtitle: Text("${item.data![index].artist}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                    playlistCheck(item.data![index]);
                                    musicListNotifier.notifyListeners();
                                  },
                                  icon: widget.playlist
                                          .isValueIn(item.data![index].id)
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  color: widget.playlist
                                          .isValueIn(item.data![index].id)
                                      ? Colors.white
                                      : Colors.red[300]
                                  // icon: const Icon(Icons.add
                                  // )
                                  ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const Divider();
                          },
                          itemCount: item.data!.length);
                    })
              ]),
            ),
          ),
        ));
  }

  // song adding to playlist data.
  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueIn(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Added to Playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      widget.playlist.deleteData(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Removed from playlist',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
