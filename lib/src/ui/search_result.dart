import 'dart:convert';

import 'package:campergigs/src/controller/maincontroller.dart';
import 'package:campergigs/src/dummy_data/discover.dart';
import 'package:campergigs/src/network/search_project.dart';
import 'package:campergigs/src/ui/destination_detail_logged_in.dart';
import 'package:flutter/cupertino.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({ Key? key }) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  MainController _mainController = Get.put(MainController());
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  double lat = 0.0;
  double long = 0.0;
  TextEditingController _searchController = TextEditingController();
  Set<Marker> marker = {};

  searchProject() async{
    var response = await SearchProjectApi.searchProject(_mainController.accessToken.value);
    _mainController.projects.value = response['projects'];
     lat = double.parse(_mainController.projects[_mainController.projects.length-1]['latitude']);
     long = double.parse(_mainController.projects[_mainController.projects.length-1]['longitude']);
    print(lat);
    print(long);
    marker.add(Marker(
        infoWindow: InfoWindow(title: "Origin"),
        markerId: MarkerId("origin"),
        position: LatLng(lat,long)));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    searchProject();
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: statusBar,),
            Navbar(width),
            mapSearch(),
            SizedBox(height: 30,),
            heading(),
            SizedBox(height: 20,),
            searchList(),
            SizedBox(height: 10,),
          ],
        ),
      ));
  }


  Widget mapSearch(){
    return Container(
              width: width,
              height: 500,
              color: Colors.grey,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height:500,
                    child: GoogleMap(
                markers: marker,
                initialCameraPosition:
                    CameraPosition(zoom: 15, target: LatLng(lat,long)),
              ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: searchTab())
                ],
              ),
    );
  }

  Widget searchBox(){
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
                height: 50,
                width: width/1.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                              color: Color.fromRGBO(54, 62, 147, 0.5),
                              offset:  Offset(9, 16),
                              blurRadius: 25,
                    ), ]
                ),
                child: TextField(
                  onChanged: (value){

                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Search",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, right: 5),
              ),
                ),
              ),
    );
  }

  Widget searchTab(){
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        onTap: (){
          customSearchBox1();
        },
        child: Container(
                  height: 50,
                  width: width/1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                                color: Color.fromRGBO(54, 62, 147, 0.5),
                                offset:  Offset(9, 16),
                                blurRadius: 25,
                      ), ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,top: 15),
                    child: Text("Search",style:TextStyle(color:Colors.grey)),
                  )
                ),
      ),
    );
  }


   Widget heading(){
     return Column(
              children: [
                Text("Search Result by ",style: CustomFonts.large(30, Colors.black),),
                SizedBox(height: 8,),
                Text("National Park",style: CustomFonts.large(30, Color.fromRGBO(79, 90, 191, 1)),),
              ],
            );
   }

   Widget searchList(){
     return Container(
              width: width,
              height: 500,
              child: ListView.builder(
                itemCount: _mainController.projects.length,
                itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: InkWell(
                    onTap:(){
                      Get.to(()=>DestinationDetailLoggedIn(_mainController.projects[index]['id']));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          (_mainController.projects[index]['image']==null || _mainController.projects[index]['image'].length == 0 || _mainController.projects[index]['image'][0].length > 40)
                          ?
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                          color:Colors.grey[300],
                                          borderRadius: BorderRadius.circular(20),
                                          ),
                            child: Center(child:Text("Image not Found"))
                            
                          )
                          :
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage("https://campergigs-api.azurewebsites.net//${_mainController.projects[index]['image'][0]}"),
                                           ),
                                          ),
                          ),
                          SizedBox(width: 15,),
                           Container(
                             width: 150,
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_mainController.projects[index]['title'],style: CustomFonts.large(16, Colors.black),),
                                SizedBox(height:5),
                                Text(_mainController.projects[index]['subTitle'] ?? "subtitle",style: CustomFonts.large(13, Color.fromRGBO(0,0,0,0.4)),),
                              ],
                          ),
                           ),
                           
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:[
                                Icon(Icons.location_pin,size: 20,color: Colors.grey[400],),
                                SizedBox(width: 5,),
                                Text(_mainController.projects[index]['city'] ?? "location",
                                overflow: TextOverflow.visible,
                                style: CustomFonts.medium(14, Colors.grey[400]!)),
                              
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
   }

  
 
   customSearchBox1(){
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context,setState){
              return AlertDialog(
                content: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              children: [
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                  width: width/1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                                color: Color.fromRGBO(54, 62, 147, 0.5),
                                offset:  Offset(9, 16),
                                blurRadius: 25,
                      ), ]
                     ),
                     child: TextField(
                  onChanged: (value){
                    _mainController.searchProject(value);
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Search",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15, right: 5),
              ),
                ),
                    ),
                    SizedBox(height: 20,),
                    Obx(()=>Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: _mainController.searchResult.length,
                          itemBuilder: (context,index){
                          return ListTile(
                            onTap:(){
                              _searchController.text = '';
                              Navigator.pop(context);
                              Get.to(()=>DestinationDetailLoggedIn(_mainController.searchResult[index]['id']));     
                            },
                            title: Text(_mainController.searchResult[index]['title'].toString()),
                            subtitle: Text(_mainController.searchResult[index]['description'].toString()),
                          );
                        }),
                    )))
              ],
            )
            
          )
              );
            });
        });
  }

}