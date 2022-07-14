import 'package:campergigs/src/controller/maincontroller.dart';
import 'package:campergigs/src/dummy_data/discover.dart';
import 'package:campergigs/src/network/destination_detail.dart';
import 'package:flutter/cupertino.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DestinationDetailLoggedIn extends StatefulWidget {
  final id;
  DestinationDetailLoggedIn(this.id);

  @override
  _DestinationDetailLoggedInState createState() => _DestinationDetailLoggedInState();
}

class _DestinationDetailLoggedInState extends State<DestinationDetailLoggedIn> {
  MainController _mainController = Get.put(MainController());
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;

  dynamic data;
    Set<Marker> marker = {
    Marker(
        infoWindow: InfoWindow(title: DiscoverDummy.headingImage[0]['name']),
        markerId: MarkerId("origin"),
        position: LatLng(26.1695, 91.7382),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
  };

  fetchProject() async{
    var response = await DestinationDetailApi.searchProject(_mainController.accessToken.value,widget.id);
    data = response['project'];
       print(data);
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: (data==null)
      ?
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:CircularProgressIndicator()
            ),
          ],
        )
        :
        SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: statusBar,),
            Navbar(width),
            map(),
            image(),
            headingColumn(),
            projectTypeAndDate(),
            description(),
            types(data['gigTypes'],"Gig Types"),
            types(data['accomodationTypes'], "Accomodation Types"),
            types(data['activityTypes'], "Activity Types"),
            types(data['restrictionTypes'], "Restriction Types"),
          ],
        ),
      ));
  }


  Widget map(){
    return Container(
                    width: width,
                    height:500,
                    child: GoogleMap(
                markers: marker,
                initialCameraPosition:
                    CameraPosition(zoom: 15, target: LatLng(26.1695, 91.7382)),
              ),
                  );
  }


  Widget image(){
    if(data['image']==null || data['image'].length == 0 || data['image'][0].length > 40){
      return Container(
        height: 400,
        width:width,
        color: Colors.grey[300],
        child: Center(child: Text("Image Not Found",style: CustomFonts.medium(20, Colors.grey[700]!)))
      );
    }
    else{
    return Container(
              height: 400,
              width:width,
              child: Image.network(
               "https://campergigs-api.azurewebsites.net//${data['image'][0]}",
                 fit: BoxFit.fill,
              ),
            );
    }
  }

  Widget headingColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
            Padding(
              padding: const EdgeInsets.only(left :20.0, top :30,bottom: 10 ),
              child: Row(
                children: [
                  Text(data['title'].toString(),style: CustomFonts.large(30, Colors.black),),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(
                  Icons.location_on_outlined,
                  size: 30,
                  color: Color.fromRGBO(162, 166, 187, 1),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                        data['city'] ?? "location",
                        style: CustomFonts.large(16, Color.fromRGBO(162, 166, 187, 1)),
                      ),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              children: [
                SizedBox(width: 20,),
                Icon(
                  Icons.favorite,
                  size: 30,
                  color: Color.fromRGBO(79, 90, 191, 1),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                   (data['favCount']==null)?"0":data['favCount'].toString(),
                  style: CustomFonts.large(16, Color.fromRGBO(79, 90, 191, 1)),
                ),
              ],
            ),
            SizedBox(height:6),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: rayting(data['avgRating'] ?? 0),
            ),
            SizedBox(height: 15,)
      ]
    );
  }

Widget rayting(int rating) {
    if (rating == 1 || rating < 2) {
      return Row(
        children: [
          starIcon(true),
          starIcon(false),
          starIcon(false),
          starIcon(false),
          starIcon(false),
          SizedBox(width: 5,),
          Text(
            "($rating)",
            style:CustomFonts.medium(15,Color.fromRGBO(162, 166, 187, 0.7) ),
          )
        ],
      );
    } else if (rating == 2 || rating < 3) {
      return Row(
        children: [
          starIcon(true),
          starIcon(true),
          starIcon(false),
          starIcon(false),
          starIcon(false),
          SizedBox(width: 5,),
          Text(
            "($rating)",
            style: CustomFonts.medium(15,Color.fromRGBO(162, 166, 187, 0.7) ),
          )
        ],
      );
    } else if (rating == 3 || rating < 4) {
      return Row(
        children: [
          starIcon(true),
          starIcon(true),
          starIcon(true),
          starIcon(false),
          starIcon(false),
          SizedBox(width: 5,),
          Text(
            "($rating)",
            style:CustomFonts.medium(15,Color.fromRGBO(162, 166, 187, 0.7) ),
          )
        ],
      );
    } else if (rating == 4 || rating < 5) {
      return Row(
        children: [
          starIcon(true),
          starIcon(true),
          starIcon(true),
          starIcon(true),
          starIcon(false),

SizedBox(width: 5,),          Text(
            "($rating)",
            style:CustomFonts.medium(15,Color.fromRGBO(162, 166, 187, 0.7) ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          starIcon(true),
          starIcon(true),
          starIcon(true),
          starIcon(true),
          starIcon(true),
          SizedBox(width: 5,),
          Text(
            "($rating)",
            style: CustomFonts.medium(15,Color.fromRGBO(162, 166, 187, 0.7) ),
          )
        ],
      );
    }
  }

  
  Widget starIcon(bool blue) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 20,
          color: (blue == true)
              ? Color.fromRGBO(79, 90, 191, 1)
              : Color.fromRGBO(162, 166, 187, 1),
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }


  Widget desElements(String text, String image, String subtitleText) {
    return (subtitleText == "none")
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: CustomFonts.large(10, Colors.black),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: CustomFonts.large(10, Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitleText,
                    style: CustomFonts.medium(10, Color.fromRGBO(162, 166, 187, 0.7)),
                  ),
                ],
              )
            ],
          );
  }

  Widget projectTypeAndDate(){
    return Padding(
              padding: const EdgeInsets.symmetric( vertical:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Type",
                      style: CustomFonts.large(16, Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    desElements(
                            data['projectType'] ?? "Project Type",
                            "assets/icons/2.jpg",
                            data['subTitle'] ?? "Short Description",
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dates/Duration",
                      style: CustomFonts.large(16, Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    desElements(
                            "20-02-2021 - 21-02-2021",
                            "assets/icons/1.jpg",
                            'Just Dates',
                          )
                  ],
                ),
              ],
          ),
          );
  }

  Widget description(){
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0 , vertical: 25),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    "Description",
                    style: CustomFonts.large(16, Colors.black),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: width/1.2,
                    child: Text(
                            data['description'] ?? "Description",
                            maxLines: 50,
                            overflow: TextOverflow.ellipsis,
                            style: CustomFonts.medium(12, Color.fromRGBO(162, 166, 187, 0.7)),
                          ),
                  ),
                    ],
                  ),
                ],
              ),
            );
  }


  Widget types(List<dynamic> list, String heading){
    return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left : 20.0),
                  child: Text(heading,style: CustomFonts.large(16, Colors.black),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3,
                          crossAxisSpacing: 0.2,
                          mainAxisSpacing: 0.2),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context,index){
                                  return desElements(list[index],"assets/icons/2.jpg", '');
                                }),
                )
              ],
            );
  }
}