import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/playlist_model.dart';
import 'package:music/song_model.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    Playlist playlist = Get.arguments ?? Playlist.playlists[0];
    // Playlist playlist = Playlist.playlists[0];
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.grey.shade300.withOpacity(0.8),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Playlist'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _PlaylistInformation(playlist: playlist),
                  const SizedBox(
                    height: 30,
                  ),
                  const _PlayOrShuffleSwitch(),
                  _PlaylistSongs(playlist: playlist),
                ],
              ),
            ),
          ),
        ));
  }
}

class _PlaylistSongs extends StatelessWidget {
  const _PlaylistSongs({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;
  get song => null;

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    int  i;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlist.songs.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            i = playlist.songs[index].id;
            Get.toNamed('/song', arguments: Song.songs[i-1]);
          },
          child: ListTile(
            leading: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            title: Text(
              playlist.songs[index].title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text('${playlist.songs[index].description} '),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _PlayOrShuffleSwitch extends StatefulWidget {
  const _PlayOrShuffleSwitch({super.key});

  @override
  State<_PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}
 get song => null;
class _PlayOrShuffleSwitchState extends State<_PlayOrShuffleSwitch> {
  bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
          child: 
          Stack(
            children: [   
               AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: isPlay ? 0 : width * 0.45,
                child: Container(
                  height: 50,
                  width: width * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),                    
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Play",
                        style: TextStyle(
                          color: isPlay ? Colors.white : Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.play_circle,
                      color: isPlay ? Colors.white : Colors.black,
                    ),
                  ],
                  
                ),
              ),
              
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Shuffle",
                        style: TextStyle(
                          color: isPlay ? Colors.black: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.shuffle,
                      color: isPlay ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]
        ),
      ),
    );
  }
}

class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            playlist.imageUrl,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          playlist.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
