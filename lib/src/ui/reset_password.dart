import 'package:campergigs/src/components/Buttons/buttons.dart';
import 'package:campergigs/src/network/reset_handler.dart';
import 'package:campergigs/src/ui/signin.dart';
import 'package:campergigs/src/ui/signup.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  bool pressed = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
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
              padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 30),
              child: Text(
                "We sent you a Password Reset Code in your Email",
               style:CustomFonts.medium(16, Colors.black)
              ),
            ),
            (pressed==true)
            ?
            column2()
            :
            column1(),
            reset(),
            SizedBox(height: 30,)
          ],
        ),
      ));
  }

  Widget heading(){
    return Padding(
              padding: const EdgeInsets.only(top : 30.0,bottom: 8),
              child: Text(
                "Reset Your Password",
                style: CustomFonts.large(30, Colors.black),
              ),
            );
  }
  
  Widget column1(){
    return Column(
      children: [
        textField("Email", false, _emailController),
      ],
    );
  }

  Widget column2(){
    return Column(
      children: [
        // textField("Email", false, _emailController),
        textField("Reset Code", false, _resetCodeController),
        textField("New Password", true, _newPasswordController),
        textField("Confirm New Password", true, _confirmNewPasswordController),
      ],
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


  Widget reset(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: (){
          (pressed==true)
          ?
          emailCheck()
          :
          onlyEmailCheck();
        },
        child: CustomButtonss.signInButtonWithoutIcon(36, 213, const Color.fromRGBO(79, 90, 191, 1), 15, const Color.fromRGBO(54, 62, 147, 0.40), 16, 27, 25, (pressed==false)?"Get Reset Code":"Submit", CustomFonts.medium(18, Colors.white))),
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

  
  onlyEmailCheck() async {
    if(checkValidationEmailOnly()==true){
           var data = {
              "email":_emailController.text
            };
            var response = await ResetHandler.resetEmail(data);
            if(response['success']==true){
              alertBox(response['message']);
              setState(() {
                pressed=true;
              });
            }else{
              alertBox(response['message']);
            }
          }
  }


  checkValidationEmailOnly(){
    if(_emailController.text==''){
      alertBox("Please enter Email");
      return false;
    }else{
      return true;
    }
  }

  emailCheck() async{
    if(checkValidationEmail()==true){
            var data = {
              "code": _resetCodeController.text,
              "newPassword":_newPasswordController.text,
              "confirmPassword":_confirmNewPasswordController.text
            };
            var response = await ResetHandler.resetPassword(data);
            if(response['success']==true){
              Get.to(()=>Signin());
              alertBox(response['message']);
            }else{
              alertBox(response['message']);
            }
          }
  }


  checkValidationEmail(){
    if(_resetCodeController.text==''){
      alertBox("Please enter Reset Code");
      return false;
    }else if(_newPasswordController.text==''){
      alertBox("Please enter New Password");
      return false;
    }else if(_confirmNewPasswordController.text==''){
      alertBox("Please enter Confirm New");
      return false;
    }else if(_newPasswordController.text !=_confirmNewPasswordController.text){
      alertBox("New Password and Confirm Password will be same");
      return false;
    }else{
      return true;
    }
  }
  
}