import 'package:campergigs/src/components/Buttons/buttons.dart';
import 'package:campergigs/src/ui/signup.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatefulWidget {
  const Contact({ Key? key }) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
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
            CustomImage(width/1.2, height/2.6, 'assets/images/5.jpg'),
            heading(),
            contactText(),  
            mainAddress(),
            address(),
            subHeading(),
            textField("Name", false, _nameController),
            textField("Email Address", false, _emailController),
            textFieldLarge("Your Message", false, _messageController),
            signinButton(),
            
            
          ],
        ),
      ));
  }

  Widget heading(){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical : 30.0),
              child: Text(
                "Contact Us",
                style: CustomFonts.heading,
              ),
            );
  }

  Widget subHeading(){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical : 30.0),
              child: Text(
                "Get in Touch",
                style: CustomFonts.contactSubHeading,
              ),
            );
  }


  Widget contactText(){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical :10.0,horizontal: 50),
              child: Text(
              "Nam ac elit a ante commodo tristique. Duis urna, condiment a vehicula a, hendrerit ac nisi Lorem ipsum",
              style: CustomFonts.contactText,
              textAlign: TextAlign.center,
          ),
            );
  }

  Widget mainAddress(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text("info@campergigs.com",style: CustomFonts.mailId,),
    );
  }


  Widget address(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal :100.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("15876 N Pima Rd",style: CustomFonts.orSigninWith,),
              SizedBox(height: 8,),
              Text(" Scottsdale, AZ",style: CustomFonts.orSigninWith)
            ],
          ),
          Expanded(child: SizedBox()),
          Text("602.846.5449",style: CustomFonts.orSigninWith,),
        ],
      ),
    );
  }


  Widget textField(String text, bool obscure,TextEditingController controller){
    return Column(
      children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:15),
              child: Container(
          height: 37,
          width: width/1.5,
          decoration: BoxDecoration(
                color: Color.fromRGBO(238, 244, 254, 1),
                borderRadius: BorderRadius.circular(12)),
          child: TextField(
            obscureText: obscure,
              controller: controller,
              style: CustomFonts.textFieldText,
              decoration: InputDecoration(
                hintText: text,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10,bottom: 10, right: 5),
              ),
          ),
        ),
            )
      ],
    );
  }


  Widget textFieldLarge(String text, bool obscure,TextEditingController controller){
    return Column(
      children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:15),
              child: Container(
          height: 80,
          width: width/1.5,
          decoration: BoxDecoration(
                color: Color.fromRGBO(238, 244, 254, 1),
                borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            
            obscureText: obscure,
              controller: controller,
              maxLines: null,
              style: CustomFonts.textFieldText,
              decoration: InputDecoration(
                hintText: text,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, bottom: 10, right: 5),
              ),
          ),
        ),
            )
      ],
    );
  }

 

  Widget signinButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: (){
          if(checkValidation()==true){
            alertBox("Api Not Ready Yet");
          }
        },
        child: CustomButtonss.signInButtonWithoutIcon(36, 213, const Color.fromRGBO(79, 90, 191, 1), 15, const Color.fromRGBO(54, 62, 147, 0.40), 16, 27, 25, "Send Message", CustomFonts.signinGoogle)),
    );
  }


  alertBox(String text){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text,style:CustomFonts.contactSubHeading),
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

  checkValidation(){
    if(_nameController.text==''){
      alertBox("Please enter Name");
      return false;
    }else if(_emailController.text==''){
      alertBox("Please enter Email");
      return false;
    }else if(_messageController.text==''){
      alertBox("Please enter your Message");
      return false;    
    }else{
      return true;
    }
  }



  
}