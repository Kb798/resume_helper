import 'package:flutter/material.dart';
import 'package:resume_helper/custom_widgets/appbar_widget.dart';
import 'package:resume_helper/custom_widgets/custom_button.dart';
import 'package:resume_helper/custom_widgets/textfield_widget.dart';
import 'package:resume_helper/model/user_resume_model.dart';
import 'package:resume_helper/utils/app_colors.dart';
import 'package:resume_helper/utils/app_strings.dart';

import '../main.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({Key? key}) : super(key: key);

  @override
  _SkillScreenState createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController skillController = TextEditingController();
  List<String> skillLevel = ['Beginner', 'Skillful', 'Experienced', 'Expert'];
  String? selectedLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedLevel = skillLevel[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget('Skill Information', false),
        body: Form(
            key: _formKey,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      fieldController: skillController,
                      hint: Constants.strSkillHint,
                      onTap: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(Constants.strSkillLevel),
                  ),
                  _buildDropDown(),
                  CustomButton(
                    title: 'Next',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userResumeModel.skill = Skill(
                            level: selectedLevel, skill: skillController.text);
                        print("USerResumeModel---->" +
                            userResumeModel.listEducation!.toJson().toString());
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SkillScreen(),));

                      }
                    },
                  )
                ])));
  }

  _buildDropDown() {
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
          // dropdownColor: AppConstants.clrBlack26,
          // focusColor: Colors.white,
          value: selectedLevel,
          //elevation: 5,

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
              selectedLevel = val;
            });
          }),
    );
  }
}
