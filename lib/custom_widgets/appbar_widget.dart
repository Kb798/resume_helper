import 'package:flutter/material.dart';
import 'package:resume_helper/utils/app_colors.dart';


 appbarWidget(String title,bool allowBack){
  return AppBar (
    backgroundColor: AppColors.clrMain,
    centerTitle: true,
    title: Text(title,style: const TextStyle( fontWeight: FontWeight.bold,color: AppColors.clrWhite),),

  );
}
void showToast(BuildContext context,String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content:  Text(text),

    ),
  );
}