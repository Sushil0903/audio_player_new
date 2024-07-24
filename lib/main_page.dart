import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/songlist.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    var Audioplay =
        Provider.of<MainProvider>(context, listen: false).assetsAudioPlayer;
    return Scaffold(
      backgroundColor: Color(0xffFFE0EA),
      appBar: AppBar(

        title: Text(
          "Spotify",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              letterSpacing: 2),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CarouselSlider(
                items: List.generate(
                  Audioplay.playlist?.audios.length ?? 0,
                  (index) {
                    var audio = Audioplay.playlist?.audios[index];
                    return Container(
                        height: 300,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          audio?.metas.image?.path ?? "Null",
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ));
                  },
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  // enlargeFactor: 0.5,
                  enlargeCenterPage: true,
                  // aspectRatio: 2,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sidhu.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${sidhu[index].metas.title}"),
                  subtitle: Text("Sidhu Mosewala"),
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage("${sidhu[index].metas.image!.path}"),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "home_page", arguments: index);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

/*
  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  Artist.length,
                  (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 70,
                          width: 70,
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            Artist[index]["Artimg"] ?? "",
                            fit: BoxFit.cover,
                            isAntiAlias: true,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        Text(Artist[index]["Art"]),
                      ],
                    );
                  },
                ),
              ),
            ),
*
*/
