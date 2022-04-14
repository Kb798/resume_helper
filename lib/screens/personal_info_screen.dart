import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:resume_helper/custom_widgets/appbar_widget.dart';
import 'package:resume_helper/custom_widgets/custom_button.dart';
import 'package:resume_helper/custom_widgets/textfield_widget.dart';
import 'package:resume_helper/model/user_resume_model.dart';
import 'package:resume_helper/utils/app_colors.dart';
import 'package:resume_helper/utils/app_images.dart';
import 'package:resume_helper/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'education_screen.dart';

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
  List<TextEditingController> listSkillController = [];
  List<String> listExperienceLevel = [];
  List<String> skillLevel = ['Beginner', 'Skillful', 'Experienced', 'Expert'];
  File? myimage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listSkillController.add(TextEditingController());
    listExperienceLevel.add(skillLevel[0]);
    getSkills();
  }

  getSkills() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonSkillList = pref.getString('SkillList');
    print("SkillList ------->" + jsonSkillList.toString());
    if (jsonSkillList != null && jsonSkillList.isNotEmpty) {
      List<Skill> getListSkills = List<Skill>.from(
          json.decode(jsonSkillList).map((x) => Skill.fromJson(x)));
      for (int a = 0; a < getListSkills.length; a++) {
        if (getListSkills.length > listSkillController.length) {
          listSkillController.add(TextEditingController());
          listExperienceLevel.add(skillLevel[0]);
        }
        setState(() {
          listSkillController[a].text = getListSkills[a].skill.toString();
          listExperienceLevel.add(getListSkills[a].level.toString());
        });
      }
    }
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomField(
                      validator: (String? val) {
                        if (val == "") {
                          return Constants.strFNameError;
                        } else {
                          return null;
                        }
                      },
                      fieldName: Constants.strFName,
                      fieldInputType: TextInputType.name,
                      fieldController: firstNameController,
                      hint: Constants.strFNameHint,
                      onTap: () {},
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 5,
                    child: CustomField(
                      validator: (String? val) {
                        if (val == "") {
                          return Constants.strLNameError;
                        } else {
                          return null;
                        }
                      },
                      fieldName: Constants.strLName,
                      fieldController: lastNameController,
                      fieldInputType: TextInputType.name,
                      hint: Constants.strLNameHint,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomField(
                validator: (String? val) {
                  if (val == "") {
                    return Constants.strPhoneError;
                  } else if (val!.length < 10) {
                    return "Enter valid phone";
                  } else {
                    return null;
                  }
                },
                fieldName: Constants.strPhoneNo,
                fieldController: phoneNumberController,
                fieldInputType: TextInputType.phone,
                maxLength: 10,
                hint: Constants.strPhoneNo,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomField(
                validator: (String? val) {
                  if (val == "") {
                    return Constants.strEmailError;
                  } else if (validateEmail(val.toString()) == false) {
                    return "Enter valid email";
                  } else {
                    return null;
                  }
                },
                fieldName: Constants.strEmail,
                fieldController: emailController,
                fieldInputType: TextInputType.emailAddress,
                hint: Constants.strEmailHint,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomField(
                validator: (String? val) {
                  if (val == "") {
                    return Constants.strAddressError;
                  } else {
                    return null;
                  }
                },
                fieldName: Constants.strAddress,
                fieldController: addressController,
                fieldInputType: TextInputType.streetAddress,
                hint: Constants.strAddressHint,
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomField(
                      validator: (String? val) {
                        if (val == "") {
                          return Constants.strCityError;
                        } else {
                          return null;
                        }
                      },
                      fieldName: Constants.strCity,
                      fieldController: cityController,
                      fieldInputType: TextInputType.name,
                      hint: Constants.strCityHint,
                      onTap: () {},
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 5,
                    child: CustomField(
                      validator: (String? val) {
                        if (val == "") {
                          return Constants.strZipCodeError;
                        } else if (val!.length < 6) {
                          return "Enter valid zipCode";
                        } else {
                          return null;
                        }
                      },
                      fieldName: Constants.strZipCode,
                      fieldController: zipcodeController,
                      maxLength: 6,
                      fieldInputType: TextInputType.number,
                      hint: Constants.strZipCodeHint,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              separatorBuilder: (context, index) => Container(
                height: 10,
              ),
              itemCount: listSkillController.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomField(
                        validator: (String? val) {
                          if (val == "") {
                            return Constants.strSkillError;
                          } else {
                            return null;
                          }
                        },
                        fieldName: Constants.strSkill,
                        fieldController: listSkillController[index],
                        hint: Constants.strSkillHint,
                        onTap: () {},
                      ),
                    ),
                    _buildDropDown(index),
                  ],
                ),
              ),
            ),
            CustomButton(
              title: 'Next',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (myimage != null) {
                    userResumeModel.firstName =
                        firstNameController.text.toString();
                    userResumeModel.lastName =
                        lastNameController.text.toString();
                    userResumeModel.phone =
                        phoneNumberController.text.toString();
                    userResumeModel.email = emailController.text.toString();
                    userResumeModel.address = addressController.text.toString();
                    userResumeModel.city = cityController.text.toString();
                    userResumeModel.zipCode = zipcodeController.text.toString();
                    userResumeModel.image = myimage!.path.toString();
                    print("USerResumeModel---->" +
                        userResumeModel.toJson().toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EducationScreen(),
                        ));
                  } else {
                    showToast(context, "Please select Image");
                  }
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.clrWhite,
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          List<Skill> listSkills = [];
          setState(() {
            listSkillController.add(TextEditingController());
            listExperienceLevel.add(skillLevel[0]);
            for (int a = 0; a < listSkillController.length; a++) {
              listSkills.add(Skill(
                  skill: listSkillController[a].text,
                  level: listExperienceLevel[a]));
            }
            pref.setString('SkillList',
                json.encode(List<Skill>.from(listSkills.map((e) => e))));
            String? jsonSkillList = pref.getString('SkillList');
            print("SkillList ------->" + jsonSkillList.toString());
            if (jsonSkillList != null && jsonSkillList.isNotEmpty) {
              List<Skill> getListSkills = List<Skill>.from(
                  json.decode(jsonSkillList).map((x) => Skill.fromJson(x)));
              getListSkills.forEach((element) {
                print("Skills--->" + element.toJson().toString());
              });
            }
          });
        },
        child: Icon(
          Icons.add,
          size: 45,
          color: AppColors.clrMain,
        ),
      ),
    );
  }

  _buildDropDown(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.clrMain)),
      margin: EdgeInsets.only(bottom: 20),
      child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          underline: const SizedBox(),
          icon: const SizedBox(),
          value: listExperienceLevel[index],
          items: skillLevel.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  value,
                  // style: TextStyle(
                  //     color: AppConstants.clrWhite),
                ),
              ),
            );
          }).toList(),
          onTap: () {},
          onChanged: (val) {
            setState(() {
              listExperienceLevel[index] = val.toString();
            });
          }),
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
