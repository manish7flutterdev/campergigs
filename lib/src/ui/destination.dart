import 'package:campergigs/src/components/Buttons/buttons.dart';
import 'package:campergigs/src/dummy_data/discover.dart';
import 'package:flutter/cupertino.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Destination extends StatefulWidget {
  const Destination({ Key? key }) : super(key: key);

  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  final TextEditingController _searchController = TextEditingController();
  Set<Marker> marker = {
    Marker(
        infoWindow: InfoWindow(title: DiscoverDummy.headingImage[0]['name']),
        markerId: MarkerId("origin"),
        position: LatLng(26.1695, 91.7382),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
  };
  List<Map> tabs = [
    {
      'title': 'Place1',
      'state':true
    },
    {
      'title': 'Place2',
      'state':false
    },
    {
      'title': 'Place3',
      'state':false
    },
    {
      'title': 'Place4',
      'state':false
    },
    {
      'title': 'Place5',
      'state':false
    },
  ];


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
            Text(
              "Top Places in New Jersy",
              style: CustomFonts.large(23, Colors.black),
            ),
            SizedBox(height: 30,),
            tabController(),
            SizedBox(height: 40,),
            bigTab(),
            Text(
              "How do you Gig?",
              style: CustomFonts.large(20, Colors.black),
            ),
            SizedBox(height: 40,),
            exploreMore(),
            SizedBox(height: 40,),
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
                    CameraPosition(zoom: 15, target: LatLng(26.1695, 91.7382)),
              ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: searchBox()),
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

  

  Widget keywordRow(){
    return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: DiscoverDummy.headingImage.map((e) =>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                     image: NetworkImage(e['url']!),
                                                          ),
                                                  ),
                                                ),
                                        SizedBox(height: 10,),
                                        Text(e['name']!,style: CustomFonts.medium(10, Colors.black),)
                                      ],
                                    ),
                                  ),).toList()
                                ),
                              );
  }

  Widget tabController(){
     return SingleChildScrollView(
       scrollDirection: Axis.horizontal,
       child: Row(
                children: 
                  tabs.map((e) => 
                  InkWell(
                    onTap: (){
                      for(int i=0;i<tabs.length;i++){
                        if(e['title']==tabs[i]['title']){
                          tabs[i]['state']=true;
                        }
                        else{
                          tabs[i]['state']=false;
                        }
                      }
                      setState(() {
                        
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Text(e['title'],
                      style: CustomFonts.medium(17, 
                      (e['state']==true)
                      ?
                      Color.fromRGBO(79, 90, 191, 1)
                      :
                      Color.fromRGBO(162, 166, 187, 1)),
                      ),
                    ),
                  )
                  ).toList()
              ),
     );
  }
  
  bigTab(){
    return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: DiscoverDummy.headingImage.map((e) =>
                                  Padding(
                                    padding: const EdgeInsets.only(left:15.0,right: 15.0,bottom: 30),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 300,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                            color: Color.fromRGBO(54, 62, 147, 0.5),
                                            offset:  Offset(9, 9),
                                            blurRadius: 20,
                                            ), ]
                                          ),
                                        ),
                                        Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                     image: NetworkImage(e['url']!),
                                                          ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top:220,
                                                  left: 20,
                                                  child: Column(
                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                        children: [
                                                          Text(e['name']!,
                                                          style: CustomFonts.large(14, Colors.black),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text(e['subtitle']!,
                                                          style: CustomFonts.medium(12, Colors.grey[400]!),
                                                          )
                                                        ],
                                                      ),
                                                ),
                                      ],
                                    ),
                                  ),).toList()
                                ),
                              );
  }

  exploreMore(){
    return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: DiscoverDummy.iconPack.map((e) =>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                     image: AssetImage(e['image']!),
                                                          ),
                                                  ),
                                                ),
                                        SizedBox(height: 10,),
                                        Text(e['title']!,style: CustomFonts.medium(10, Colors.black),)
                                      ],
                                    ),
                                  ),).toList()
                                ),
    );
  }
  
}