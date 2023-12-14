

// ignore: unnecessary_import
import 'dart:ui';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:flutter/material.dart';
import 'package:singfy/detail_audio_page.dart';
import 'package:singfy/my_tabs.dart';
// ignore: library_prefixes
import 'app_colors.dart' as AppColors;


class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key key}) : super(key : key);
  const MyHomePage ({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{ //para obtener los libros de mi json y el single para el scroll de debajo del slider(tab controller y scroll controller)

  List popularBooks = [];
  List books = [];

  ScrollController _scrollController = ScrollController();
  late TabController _tabController ; 

// ignore: non_constant_identifier_names
  ReadData() async{
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);  
      });
    });
    // ignore: use_build_context_synchronously
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books = json.decode(s);  
      });
    });
  }

  @override
  void initState(){
    super.initState();
    // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      color: AppColors.loveColor,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(  //creamos contenedor para hacerle un padding a los tres iconos de arriba
                  margin: const EdgeInsets.only(left:20, right:20),
                  child: Row(  
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,  //separacion iconos menú
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(FontAwesomeIcons.alignJustify,size: 20, color:Colors.black),
                      Row(
                        children: const [
                          Icon(Icons.search),
                          SizedBox(width: 15,), //separacion entre lupa y notificacion
                          Icon(Icons.notifications),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,
                ),
                Row(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text("Libros populares", style: TextStyle(fontSize: 27),
                      ),
                    ),
                  ],
                ),
                // ignore: avoid_unnecessary_containers
                const SizedBox(height: 10),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: -20,
                        right: 0,
                        // ignore: sized_box_for_whitespace
                        child: Container( //contenedor del slider
                            height: 160,
                            child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            // ignore: unnecessary_null_comparison
                            itemCount: popularBooks==null?0:popularBooks.length, //veces que se repite el loop
                            itemBuilder: (_, i){
                              return Container( 
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right:10),
                                decoration: BoxDecoration( 
                                  borderRadius: BorderRadius.circular(12),
                                  image:DecorationImage(
                                      image:AssetImage(popularBooks[i]["img"]),
                                      fit:BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                Expanded(child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll){
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor:AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(10),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 5, left: 5),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:Colors.red.withOpacity(0.4),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0), //para no picar fuera del contenedor
                                  ),
                                ],
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              tabs: [ //los guardo en my_tabs para no duplicar codigo
                                const AppTabs(color: AppColors.menu1Color, text: "Home"),
                                const AppTabs(color: AppColors.menu2Color, text: "Popular"),
                                const AppTabs(color: AppColors.menu3Color, text: "Trendin"),
                              ],
                            ),
                          ), 
                        ),
                      ),
                    ];
                  // ignore: prefer_const_constructors
                  }, body: TabBarView(
                       controller: _tabController,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ListView.builder(
                          // ignore: unnecessary_null_comparison
                          itemCount: books==null?0:books.length, //si books no esta vacio coge su longitus para ver cuantas imagenes poner
                          itemBuilder:(_,i){ //el primer valor esta vacio y el segundo es un indice para controlar cada libro
                          return 
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context)=> DetailAudioPage(booksData:books, index:i)),
                              );
                            },
                            child:Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: const Offset(0,0),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[i]["img"]), //selecciona la imagen de el número de libros que haya, el i que le toca y posiciona su img
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, //para conseguir que la estrella se posicione a la izquierda
                                        children: [
                                          Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Icon(Icons.star, size:20, color: AppColors.starColor),
                                              const SizedBox(width: 5,),
                                              // ignore: prefer_const_constructors
                                              Text(books[i]["rating"], style: TextStyle(
                                                color:AppColors.menu2Color
                                              ),),
                                            ],
                                          ),
                                          Text(books[i]["title"], style: const TextStyle(fontSize: 10, fontFamily: "Avenir", fontWeight: FontWeight.bold),),
                                          Text(books[i]["text"], style: const TextStyle(fontSize: 10, fontFamily: "Avenir", color:AppColors.subTitleText),),
                                          Container(
                                            width: 60,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            // ignore: sort_child_properties_last
                                            child: const Text(
                                              "Love", 
                                              style: TextStyle(
                                                fontSize: 7, 
                                                fontFamily: "Avenir", 
                                                color:Colors.white,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                        }),
                      
                        const Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                        const Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text("Content"),
                          ),
                        ),
                      ],
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}