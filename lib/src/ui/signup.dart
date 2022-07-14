import 'package:campergigs/src/controller/maincontroller.dart';
import 'package:campergigs/src/network/signin_handler.dart';
import 'package:campergigs/src/network/signup_handler.dart';
import 'package:campergigs/src/ui/activte_account.dart';
import 'package:campergigs/src/ui/search_result.dart';
import '/src/components/Buttons/buttons.dart';
import '/src/ui/signin.dart';
import '/src/components/Image/image_widget.dart';
import '/src/components/Navbar/navbar_body.dart';
import '/src/fonts/custom_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class Signup extends StatefulWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  bool tick = false;
  bool pressed = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  MainController _mainController = Get.put(MainController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: (pressed==true)
      ?
      Center(
        child:CircularProgressIndicator()
      )
      :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: statusBar,),
            Navbar(width),
            CustomImage(width/1.2, height/2.6, 'assets/images/4.jpg'),
            heading(),
            socialButton(),
            orSignInWith(),  
            textField("First Name", false, _firstNameController),
            textField("Last Name", false, _lastNameController),
            textField("Email", false, _emailController),
            textField("Password", true, _passwordController),
            aggrement(),
            signupButton(),
            login()
          ],
        ),
      ));
  }

  Widget heading(){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical : 30.0),
              child: Text(
                "Sign up to Camper Gigs",
                style: CustomFonts.heading,
              ),
            );
  }


  Widget socialButton(){
    return Column(
      children: [
        InkWell(
          onTap:(){
            googleSignup();
            setState(() {
              pressed = true;
            });
          },
          child: CustomButtonss.signInButtonWithIcon(
                            36.5,
                            213,
                            const Color.fromRGBO(79, 90, 191, 1),
                            15,
                            const Color.fromRGBO(54, 62, 147, 0.40),
                            16,
                            27,
                            25,
                            Icons.facebook,
                            Colors.white,
                            15,
                            8,
                            "Signin with Google",
                            CustomFonts.signinGoogle),
        ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              setState(() {
                 pressed = true;
                });
              facebookSignup();
              
            },
            child: CustomButtonss.signInButtonWithIcon(
                            36.5,
                            213,
                            Colors.white,
                            15,
                            const Color.fromRGBO(54, 62, 147, 0.40),
                            10,
                            16,
                            25,
                            Icons.facebook,
                            Colors.blue[800]!,
                            15,
                            8,
                            "with Facebook",
                            CustomFonts.signinFacebook),
          ),
      ],
    ) ;
  }

  Widget orSignInWith(){
    return Padding(
              padding: const EdgeInsets.symmetric(vertical :30.0),
              child: Text(
              "Or sign up with your email address ",
              style: CustomFonts.orSigninWith,
          ),
            );
  }


  Widget textField(String text, bool obscure,TextEditingController controller){
    return Column(
      children: [
        Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: Text(text,style: CustomFonts.emailPass,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10),
              child: Container(
          height: 30,
          width: width/1.5,
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

 Widget aggrement(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
        onTap: () {
          setState(() {
            (tick == true) ? tick = false : tick = true;
          });
        },
        child: Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              color: (tick == false)
                  ? Colors.white
                  : Color.fromRGBO(79, 90, 191, 1),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.blue)),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      const Text(
        "Creating an account means you're okay with our",
        style: CustomFonts.rememberMe,
      ),
      const SizedBox(
        width: 4,
      ),
      InkWell(
        onTap: () {},
        child: const Text(
          "terms and Services",
          style: CustomFonts.forgotPassword,
        ),
      ),
            ],
          ),
          SizedBox(height: 10,),
      Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
        onTap: () {},
        child: const Text(
          "Privacy Policy",
          style: CustomFonts.forgotPassword,
        ),
      ),
      SizedBox(width: 4,),
      const Text(
        "and our default",
        style: CustomFonts.rememberMe,
      ),
      const SizedBox(
        width: 22,
      ),
      InkWell(
        onTap: () {},
        child: const Text(
          "Notification Settings",
          style: CustomFonts.forgotPassword,
        ),
      ),
        ],
      )
        ]
      ),
    );
  }

  Widget signupButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: (){
          if(checkValidation()==true){
            signupFunction();
          }
        },
        child: CustomButtonss.signInButtonWithoutIcon(36, 213, const Color.fromRGBO(79, 90, 191, 1), 15, const Color.fromRGBO(54, 62, 147, 0.40), 16, 27, 25, "Sign Up", CustomFonts.signinGoogle)),
    );
  }


  Widget login(){
    return Padding(
      padding: const EdgeInsets.only(top:20.0,bottom: 25),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: CustomFonts.newUser,
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(()=>Signin());
                  },
                  child: Text(
                    "Log In",
                    style: CustomFonts.createAccount,
                  ),
                ),
              ],
            ),
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
                   Get.to(()=>ActivateAccount());
                  },
                  child: Text('Activate Account')),
             
            ],
          );
        });
  }

  signupFunction() async{
    var data = {
    "email":_emailController.text,
    "password":_passwordController.text,
    "confirmPassword":_passwordController.text,
    "firstName":_firstNameController.text,
    "lastName":_lastNameController.text,
    "userKindOf":"user"
    };
    var response = await SignUpHandler.signup(data);
    if(response['success']==true){
      activateAlertbox("Signed up Successful, Please Activate your Account from the code in your Email");
    }else{
      alertBox(response['message']);
      _passwordController.text = '';
    }
  }


  checkValidation(){
    if(_firstNameController.text==''){
      alertBox("Please enter Name");
      return false;
    }else if(_lastNameController.text==''){
      alertBox("Please enter Username");
      return false;
    }else if(_emailController.text==''){
      alertBox("Please enter Email");
    }else if(_passwordController.text==''){
      alertBox("Please enter Password");
    }else if(tick==false){
      alertBox("Please Agree with our Terms and Conditions");
    }else{
       return true;
    }
  }





  socialSignup(String firstName,String lastName,String email,String password) async{
    var data = {
    "email":email,
    "password":password,
    "firstName":firstName,
    "lastName":lastName,
    "userKindOf":"user"
    };
    print(data);
    var response = await SignUpHandler.signupSSO(data);
    if(response['message']=="Registration Success"){
      setState(() {
        pressed = false;
      });
      activateAlertbox("Signed up Successful, Please Activate your Account from the code in your Email");
    }else if(response['message']=='Email is already in use'){
      signinFunction(email);
    }else{
      alertBox(response['message']);
      setState(() {
        pressed = false;
      });
    }
  }

  signinFunction(String email) async{
    var data = {
      "email": email
    };
    var response = await SigninHandler.signinSSO(data);
    if(response['message']=="User logged in successfully"){
      setState(() {
        pressed = false;
      });
    print(response['accessToken']);
    _mainController.accessToken.value = response['accessToken'];
    Get.to(()=>SearchResult());
    }else if(response['message']=='You must verify your email to activate your account'){
      setState(() {
        pressed= false;
      });
      activateAlertbox("Please Activate your Account from the code in your Email");
    }else{
      setState(() {
        pressed = false;
      });
      alertBox(response['message']);
    }
  }


  facebookSignup(){
    FacebookAuth.instance.login(
                  permissions: ["public_profile","email"]
                ).then((value){
                  FacebookAuth.instance.getUserData().then((userData){
                    // alertBox("${userData['name']} successfully Signed Up");
                    String fullName = userData['name'];
                    var names = fullName.split(' ');
                    String firstName = names[0];
                    String lastName = names[1];
                    socialSignup(firstName, lastName, userData['email'], userData['id']);
                    print(userData);
                  });
                });
  }

    googleSignup(){
    _googleSignIn.signIn().then((userData) {
                            print(userData);
                            _userObj = userData;
                           // alertBox("${userData?.displayName??''} logged in Successfully");
                           String fullName = userData?.displayName??'';
                           String firstName = '';
                           String lastName = '';
                           if(fullName.split(' ').length == 1 ){
                              firstName = fullName;
                           }else{
                            var name = fullName.split(' ');
                            firstName = name[0];
                            lastName = name[1];
                           }
                           socialSignup(firstName, lastName, userData?.email??'', userData?.id??'');
                        }).catchError((e) {
                          print(e);
                        });
  }
}