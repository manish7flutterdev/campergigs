import 'package:flutter/material.dart';


class CustomButtonss{


  static Widget signInButtonWithIcon(double buttonHeight,double buttonWidth,Color buttonColour,
                            double borderRadius, Color shadowColour, double shadowOffsetX,
                             double shadowOffsetY,double blurRadius,IconData icon,Color iconColor, double iconSize , double iconTextWidth,
                             String buttonText, TextStyle textStyle
                             ){
    return Container(
                           height: buttonHeight,
                          width: buttonWidth,
                          decoration: BoxDecoration(
                            color: buttonColour,
                            borderRadius: BorderRadius.circular(borderRadius),
                            boxShadow:  [BoxShadow(
                              color: shadowColour,
                              offset:  Offset(shadowOffsetX, shadowOffsetY),
                              blurRadius: blurRadius,
                    ), ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Icon(icon,
                              color: iconColor,
                              size: iconSize,
                              ),
                              SizedBox(width: iconTextWidth,),
                              Text(buttonText,
                              style: textStyle,
                              )
                            ],
                          ),
                        );
  }


  static Widget signInButtonWithoutIcon(double buttonHeight,double buttonWidth,Color buttonColour,
                            double borderRadius, Color shadowColour, double shadowOffsetX,
                             double shadowOffsetY,double blurRadius,
                             String buttonText, TextStyle textStyle
                             ){
    return Container(
                           height: buttonHeight,
                          width: buttonWidth,
                          decoration: BoxDecoration(
                            color: buttonColour,
                            borderRadius: BorderRadius.circular(borderRadius),
                            boxShadow:  [BoxShadow(
                              color: shadowColour,
                              offset:  Offset(shadowOffsetX, shadowOffsetY),
                              blurRadius: blurRadius,
                    ), ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                             
                              Text(buttonText,
                              style: textStyle,
                              )
                            ],
                          ),
                        );
  }
}