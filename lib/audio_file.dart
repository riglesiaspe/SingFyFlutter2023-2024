


import 'package:audioplayers/audioplayers.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AudioFile extends StatefulWidget{
  final AudioPlayer advancedPlayer;
  final String audioPath;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  AudioFile({required this.advancedPlayer, required this.audioPath});


  @override
  // ignore: library_private_types_in_public_api
  _AudioFileState createState() => _AudioFileState();
}

/* por si diera error al cargar un archivo
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
  */

class _AudioFileState extends State<AudioFile> {
  // ignore: unused_field
  late Duration _duration =  const Duration();
  // ignore: unused_field
  late Duration _position =  const Duration();
  bool isPlaying =  false;
  bool isPaused = false;
  bool isRepeat=false;
  double playbackRate= 0.5;
  Color color = Colors.black;
  // ignore: unused_field
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState(){
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {
      _duration=d;
    }); });
    widget.advancedPlayer.onPositionChanged.listen((p) {setState(() {
      _position = p;  //guarda el valor de posicion del audio
    }); });

    //widget.advancedPlayer.setSourceUrl(widget.audioPath); //archivo en url en Source
    widget.advancedPlayer.setSource(AssetSource(widget.audioPath)); //archivo local en Source

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying=true;
        }else{
          isPlaying=false;
          isRepeat=false;
        }
        
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon:isPlaying==false?Icon(_icons[0], size:50, color:Colors.blue):Icon(_icons[1],size:50,color:Colors.blue),
      onPressed: () async{
        if(isPlaying == false){
        await widget.advancedPlayer.play(AssetSource(widget.audioPath));  //me pide un recurso y no url por actualizacion de flutter
        setState(() {
          isPlaying = true;
        });
        }else if(isPlaying==true){
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
      }, 
      
    );
  }

  Widget btnFast(){
    return
      IconButton(
        // ignore: prefer_const_constructors
        icon: ImageIcon(
          const AssetImage('img/ForwardIcon.png'),
          size:35,
          color: Colors.black,
          ),
        onPressed: (){
          widget.advancedPlayer.setPlaybackRate(playbackRate = 1.5);
        }, 
        );
  }

  Widget btnSlow(){
    return
      IconButton(
        // ignore: prefer_const_constructors
        icon: ImageIcon(
          const AssetImage('img/BackwardIcon.png'),
          size:35,
          color: Colors.black,
          ),
        onPressed: (){
          widget.advancedPlayer.setPlaybackRate(playbackRate = 0.5);
        }, 
        );
  }

  Widget btnLoop(){
    // ignore: prefer_const_constructors
    return IconButton(
      // ignore: prefer_const_constructors
      icon: ImageIcon(
        const AssetImage('img/ShuffleIcon.png'),
        size: 25,
        color: Colors.black,), 
        onPressed: () { 

         },
      );
  }

  Widget btnRepeat(){
    // ignore: prefer_const_constructors
    return IconButton(
      // ignore: prefer_const_constructors
      icon: ImageIcon(
        const AssetImage('img/RepeatIcon.png'),
        size: 25,
        color:color,
        ),
        onPressed: () {
          if(isRepeat==false){
            widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
            setState(() {
              isRepeat=true;
              color=Colors.blue;
            });
          }else if(isRepeat==true){
              widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
              setState(() {
                isRepeat=false;
                color=Colors.black;
              });
          }
        },
      );
  }



  Widget slider(){
    return Slider(
      activeColor: Colors.red,
      inactiveColor:  Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      });
  }

  void changeToSecond(int second ){
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAssets() {
    return 
    // ignore: avoid_unnecessary_containers
    Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              // ignore: prefer_const_literals_to_create_immutables
              children: [
               Text(_position.toString().split(".")[0], style: const TextStyle(fontSize: 16),),
               Text(_duration.toString().split(".")[0], style: const TextStyle(fontSize: 16),),
              ],
            ),
          ),

          slider(),
          loadAssets(),
          

        ],
      ),
    );
  }
}