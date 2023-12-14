import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:singfy/audio_file.dart';
// ignore: library_prefixes
import 'app_colors.dart' as AppColors;


class DetailAudioPage extends StatefulWidget{
  // ignore: prefer_typing_uninitialized_variables
  final booksData;
  final int index;
  // ignore: use_key_in_widget_constructors
  const DetailAudioPage({this.booksData, required this.index});


  @override
  // ignore: library_private_types_in_public_api
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer advancedPlayer = AudioPlayer();
  String audioPath = "";

  @override
  void initState(){
  super.initState();
  advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioGreyBackground,
      body: Stack(  //para la parte superior de la pantalla detail
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight/3,
            child: Container(
              color: AppColors.audioBlueBackground,
          
          ),),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon:const Icon(Icons.arrow_back_ios),
                onPressed: (){
                  advancedPlayer.stop();
                  Navigator.of(context).pop(); //navegación a la inversa
                },
              ),
              actions: [
                IconButton(
                  icon:const Icon(Icons.search),
                  onPressed: (){} ,
              ),
              ],
               backgroundColor: Colors.transparent,
               elevation: 0.0,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight*0.2,
            height: screenHeight*0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  Text(widget.booksData[widget.index]["title"],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Avenir",
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Text(widget.booksData[widget.index]["text"], style: TextStyle( 
                    fontSize: 20,
                  ),),
                  AudioFile(advancedPlayer:advancedPlayer, audioPath: widget.booksData[widget.index]["audio"]),
                ],
              ),
            ),
          ),
          Positioned( //no me llega a funcionar
            top: screenHeight*0.12,
            left: (screenHeight-150)/2, 
            right: (screenHeight-150)/2, 
            height: screenHeight*0.16,  //altura de 160
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                color: AppColors.audioGreyBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    image: DecorationImage(
                      image:AssetImage(widget.booksData[widget.index]["img"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}