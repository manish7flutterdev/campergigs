import 'package:campergigs/src/dummy_data/discover.dart';
import 'package:flutter/cupertino.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Activities extends StatefulWidget {
  const Activities({ Key? key }) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  TextEditingController _searchController = TextEditingController();
    Set<Marker> marker = {
    Marker(
        infoWindow: InfoWindow(title: DiscoverDummy.headingImage[0]['name']),
        markerId: MarkerId("origin"),
        position: LatLng(26.1695, 91.7382),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
  };

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
            Text("All Activities",style: CustomFonts.large(30, Colors.black),),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Text(
                "Nam ac elit a ante commodo tristique. Duis urna, condiment a vehicula a, hendrerit ac nisi Lorem ipsum",
                textAlign: TextAlign.center,
                style: CustomFonts.medium(15, Color.fromRGBO(0,0,0,0.4)),
              ),
            ),
            SizedBox(height: 30,),
            activityIcons(),
            SizedBox(height: 30,),
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


  activityIcons(){
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