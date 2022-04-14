import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:resume_helper/custom_widgets/appbar_widget.dart';
import 'package:resume_helper/utils/app_colors.dart';
import 'package:resume_helper/utils/app_images.dart';


class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  File? myimage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget('Personal Information', false),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            Center(
              child: Stack(
                children: [
                  myimage == null
                      ? const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage(AppImages.imgProfileImage),
                          backgroundColor: Colors.transparent)
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage: FileImage(myimage!),
                        ),
                  Positioned(
                    top: 85,
                    left: 82,
                    child: InkWell(
                      radius: 18,
                      onTap: () {
                        _getFromGallery();
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.clrWhite,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.clrMain,
                          child: Icon(Icons.edit_rounded, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        myimage = File(pickedFile.path);
        print(myimage);
      });
    }
  }


  bool validateEmail(String value) {
    String pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern1);
    return (!regex.hasMatch(value)) ? false : true;
  }

}
