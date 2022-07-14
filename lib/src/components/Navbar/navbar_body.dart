import 'package:campergigs/src/controller/maincontroller.dart';
import 'package:campergigs/src/fonts/custom_fonts.dart';

import '/src/components/Navbar/navbar_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends StatefulWidget {
  final width;
  Navbar(this.width);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: widget.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                    height: 30,
                    width: widget.width / 1.1,
                    child: Row(
                      children: [
                        logo(),
                        Expanded(child: SizedBox()),
                        menuButton()
                      ],
                    )),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          navElements()
        ],
      ),
    );
  }

  Widget logo() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 30,
        width: 135,
        child: Image.asset(
          "assets/images/logo1.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget navElements() {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 20,
          ),
          navElementText("Home"),
          navElementText("Find a Gig"),
          navElementText("Post a Gig"),
          navElementText("Join"),
          navElementText("How it works"),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget menuButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(238, 244, 254, 1),
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(54, 62, 147, 0.14),
                    offset: const Offset(8, 14),
                    blurRadius: 24),
              ]),
        ),
      ),
    );
  }

  Widget navElementText(String text) {
    return InkWell(
      onTap: () {
      if(_mainController.signedIn==false){
        alertBox();
      }
      },
      child: Text(
        text,
        style: NavBarMiniStyle.navElements,
      ),
    );
  }

  alertBox(){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please Login First',style:CustomFonts.contactSubHeading),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                   Navigator.pop(context);
                  },
                  child: Text('Close')),
             
            ],
          );
        });
  }
}
