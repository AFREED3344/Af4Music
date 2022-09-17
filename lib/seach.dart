import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/home_screen.dart';
import 'package:musicplayer/nowplayscreen.dart';
import 'package:musicplayer/widgets/getsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ValueNotifier<List<SongModel>> temp = ValueNotifier([]);
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              //search filtering
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 22),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 160, 158, 158)),
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 35,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 144, 141, 141), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (String value) {
                searchFilter(value);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: temp,
              builder: (BuildContext context, List<SongModel> songData,
                  Widget? child) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      final data = songData[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          leading: QueryArtworkWidget(
                              artworkWidth: 60,
                              artworkFit: BoxFit.cover,
                              id: data.id,
                              type: ArtworkType.AUDIO),
                          title: Text(
                            data.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            
                            // final searchindex = creatSearchIndex(data);
                            FocusScope.of(context).unfocus();
                            GetSongs.player.setAudioSource(
                                GetSongs.createSongList(temp.value),
                                initialIndex: index);
                            GetSongs.player.play();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    NowPlay(playerSong: temp.value)));
                          },
                        ),
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: temp.value.length);
              }),
        ));
  }

  // seach fuction
  searchFilter(String value) {
    if (value.isEmpty) {
      temp.value = ScreenHome.songs;
    } else {
      temp.value = ScreenHome.songs
          .where((song) =>
              song.title.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    }
    temp.notifyListeners();
  }
}
