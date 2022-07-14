import 'package:campergigs/src/components/Buttons/buttons.dart';
import 'package:campergigs/src/network/signup_handler.dart';
import 'package:campergigs/src/ui/signin.dart';
import 'package:campergigs/src/ui/signup.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivateAccount extends StatefulWidget {
  const ActivateAccount({ Key? key }) : super(key: key);

  @override
  _ActivateAccountState createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  bool tick = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _activationCodeController = TextEditingController();
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
            CustomImage(width/1.3, height/1.5, 'assets/images/2.jpg'),
            heading(), 
            Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 30,top: 10),
              child: Text(
                "We sent you an Activation Code in your Email. Please fill in below and activate your account to proceed further",
               style:CustomFonts.medium(16, Colors.black)
              ),
            ),
            textField("Email", false, _emailController),
            textField("Activation Code", false, _activationCodeController),
            activateButton(),
            SizedBox(height: 50,)
          ],
        ),
      ));
  }

  Widget heading(){
    return Padding(
              padding: const EdgeInsets.only(top : 30.0,bottom: 8),
              child: Text(
                "Activate your Account",
                style: CustomFonts.large(30, Colors.black),
              ),
            );
  }


  Widget textField(String text, bool obscure,TextEditingController controller){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: Text(text,style: CustomFonts.large(14,Color.fromRGBO(79, 90, 191, 1)),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10),
              child: Container(
          height: 30,
          width: width/1.2,
          decoration: BoxDecoration(
                color: Color.fromRGBO(238, 244, 254, 1),
                borderRadius: BorderRadius.circular(12)),
          child: TextField(
            obscureText: obscure,
              controller: controller,
              style: CustomFonts.textFieldText,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, bottom: 20, right: 5),
              ),
          ),
        ),
            )
      ],
    );
  }


  Widget activateButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: (){
          if(checkValidation()==true){
           activateFunction();
          }
        },
        child: CustomButtonss.signInButtonWithoutIcon(36, 213, const Color.fromRGBO(79, 90, 191, 1), 15, const Color.fromRGBO(54, 62, 147, 0.40), 16, 27, 25, "Activate", CustomFonts.medium(18, Colors.white))),
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

  activateAlertbox(String text){
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text,style:CustomFonts.contactSubHeading),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                   Get.to(()=>Signin());
                  },
                  child: Text('Go to Signin')),
             
            ],
          );
        });
  }

  activateFunction() async{
    var data = {
    "email":_emailController.text,
    "code":_activationCodeController.text,
    };
    var response = await SignUpHandler.activation(data);
    if(response['success']==true){
      activateAlertbox(response['message']);
    }else{
      alertBox(response['message']);
    }
  }


  checkValidation(){
    if(_emailController.text==''){
      alertBox("Please enter Email");
      return false;
    }else if(_activationCodeController.text==''){
      alertBox("Please enter the Activation Code");
      return false;
    }else{
      return true;
    }
  }
  
}