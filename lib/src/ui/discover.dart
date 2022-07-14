import 'package:campergigs/src/components/Buttons/buttons.dart';
import 'package:campergigs/src/dummy_data/discover.dart';
import 'package:flutter/cupertino.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Discover extends StatefulWidget {
  const Discover({ Key? key }) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  final TextEditingController _searchController = TextEditingController();
  List<Map> tabs = [
    {
      'title': 'Destination',
      'state':true
    },
    {
      'title': 'Gig Type',
      'state':false
    },
    {
      'title': 'Activities',
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
            headingStack(),
            SizedBox(height: 20,),
            searchBox(),
            SizedBox(height: 20,),
            Text("Top Key search", style: CustomFonts.medium(15, Colors.black),),
            SizedBox(height: 20,),
            keywordRow(),
            SizedBox(height: 30,),
            Text(
              "Discover",
              style: CustomFonts.large(36, Colors.black),
            ),
            SizedBox(height: 30,),
            tabController(),
            SizedBox(height: 40,),
            bigTab(),
            SizedBox(height: 40,),
            Text(
              "Explore More",
              style: CustomFonts.large(20, Colors.black),
            ),
            SizedBox(height: 40,),
            exploreMore(),
            SizedBox(height: 40,),
          ],
        ),
      ));
  }


  Widget headingStack(){
    return Stack(
              children: [
                Container(
                    width: width,
                    height: 500,
                    child: PageView.builder(
                      itemCount: DiscoverDummy.headingImage.length,
                      itemBuilder: (context,index){
                      return Image.network(DiscoverDummy.headingImage[index]['url']!,
                      fit: BoxFit.fill,
                      );
                    }),
                  ),
                Positioned(
                  top:250,
                  left: 13,
                  child: Container(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FEATURED",style: CustomFonts.medium(15, Colors.white),),
                        SizedBox(height: 12,),
                        Text("Discover Greek",
                          style :CustomFonts.large(35, Colors.white)
                          ),
                          SizedBox(height: 12,),
                        Text("Class aptent taciti sociosqu ad litora torquent conubia nostra inceptos."
                        ,style: CustomFonts.medium(15, Colors.white),),
                        SizedBox(height: 25,),
                        Container(
                          height: 80,
                          width: width/1.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: DiscoverDummy.headingImage.map((e) =>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Container(
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
                                  ),).toList()
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
  }

  Widget searchBox(){
    return Container(
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
                  hintText: "Search any thing",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 10, right: 5),
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
     return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: Text(e['title'],
                  style: CustomFonts.medium(17, 
                  (e['state']==true)
                  ?
                  Color.fromRGBO(79, 90, 191, 1)
                  :
                  Color.fromRGBO(162, 166, 187, 1)),
                  ),
                )
                ).toList()
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
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Column(
                                      children: [
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
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:12.0,top:120),
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      children: [
                                                        Text(e['name']!,
                                                        style: CustomFonts.large(18, Colors.white),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text(e['subtitle']!,
                                                        style: CustomFonts.medium(16, Colors.white),
                                                        )

                                                      ],
                                                    ),
                                                  )
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