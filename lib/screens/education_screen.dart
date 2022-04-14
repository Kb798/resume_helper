import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_helper/custom_widgets/appbar_widget.dart';
import 'package:resume_helper/custom_widgets/custom_button.dart';
import 'package:resume_helper/custom_widgets/textfield_widget.dart';
import 'package:resume_helper/utils/app_strings.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController instituteController=TextEditingController();
  TextEditingController degreeController=TextEditingController();
  TextEditingController graduationDateController=TextEditingController();
  DateTime? selectedDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget('Education Information', true),
    body: Form(
    key: _formKey,
    child:ListView(
      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: CustomField(
            validator: (String? val) {
              if (val == "") {
                return Constants.strInstituteError;
              } else {
                return null;
              }
            },
            fieldName: Constants.strInstitute,
            fieldInputType: TextInputType.name,
            fieldController: instituteController,
            hint: Constants.strInstituteHint,
            onTap: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: CustomField(
            validator: (String? val) {
              if (val == "") {
                return Constants.strDegreeError;
              } else {
                return null;
              }
            },
            fieldName: Constants.strDegree,
            fieldInputType: TextInputType.name,
            fieldController: degreeController,
            hint: Constants.strDegreeHint,
            onTap: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: CustomField(
            validator: (String? val) {
              if (val == "") {
                return Constants.strDateError;
              } else {
                return null;
              }
            },
            fieldName: Constants.strDate,
            fieldInputType: TextInputType.name,

            readOnly: true,
            fieldController: graduationDateController,
            hint: Constants.strDateHint,
            onTap: () {
              _selectDate(context);
            },
          ),
        ),
        CustomButton(
          title: 'Next',
          onPressed: () {

          },
        )
      ],

    ))
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 100)),
      lastDate:  DateTime.now().add(Duration(days: 1000)), initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      graduationDateController.text =DateFormat.MMMEd().format(selectedDate!) ;

    }

  }
}
