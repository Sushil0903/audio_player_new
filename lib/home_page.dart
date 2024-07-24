import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/main_page.dart';
import 'package:audio_player/main_provider.dart';
import 'package:audio_player/songlist.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)?.settings.arguments as int;
    Provider.of<MainProvider>(context, listen: false)
        .assetsAudioPlayer
        .open(Playlist(audios: sidhu), autoStart: false);
    Provider.of<MainProvider>(context, listen: false)
        .assetsAudioPlayer.open(sidhu[index]);
    var Audioplay =
        Provider.of<MainProvider>(context, listen: false).assetsAudioPlayer;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black12,
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.network(
                    sidhu[index].metas.image!.path,
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(sidhu[index].metas.image!.path,
                      fit: BoxFit.cover),
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Song name",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30),
                              ),
                              Text(
                                "Artist",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
                StreamBuilder<Duration>(
                  stream: Audioplay.currentPosition,
                  builder: (context, snapshot) {
                    Duration? currentDuration;
                    if (Audioplay.current.hasValue) {
                      currentDuration = Audioplay.current.value?.audio.duration;
                    }
                    return Column(
                      children: [
                        Slider(
                          value: snapshot.data?.inSeconds.toDouble() ?? 0,
                          onChanged: (value) {
                            Audioplay.seek(Duration(seconds: value.toInt()));
                          },
                          max: currentDuration?.inSeconds
                                  .toDouble()
                                  .toDouble() ??
                              0,
                          min: 0,
                          activeColor: Colors.yellow,
                          inactiveColor: Colors.white24,
                          thumbColor: Colors.white70,
                        ),
                        Transform.translate(
                          offset: Offset(0, -10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "${snapshot.data?.inMinutes ?? 0.0}:",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                  "${(snapshot.data?.inSeconds ?? 0.0) % 60}"
                                      .padLeft(2, '0'),
                                  style: TextStyle(color: Colors.white)),
                              Spacer(),
                              Text("${currentDuration?.inMinutes ?? 0.0}:",
                                  style: TextStyle(color: Colors.white)),
                              Text(
                                  "${(currentDuration?.inSeconds ?? 0.0) % 60}"
                                      .padLeft(2, '0'),
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        Audioplay.previous();
                      },
                      child: Icon(
                        Icons.skip_previous,
                        size: 50,
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                    Spacer(),
                    StreamBuilder<bool>(
                        stream: Audioplay.isPlaying,
                        builder: (context, snapshot) {
                          bool isplay = snapshot.data ?? false;
                          return FloatingActionButton(
                            onPressed: () {
                              Audioplay.playOrPause();
                            },
                            child: Icon(
                              isplay ? Icons.pause : Icons.play_arrow,
                              size: 50,
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                          );
                        }),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        Audioplay.next();
                      },
                      child: Icon(
                        Icons.skip_next,
                        size: 50,
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Audioplay.shuffle;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Shuffle Mood")));
                        },
                        child: Icon(
                          Icons.shuffle_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Audioplay.currentLoopMode;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Loop Mood")));
                        },
                        child: Icon(
                          Icons.loop,
                          color: Colors.white,
                          size: 30,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
