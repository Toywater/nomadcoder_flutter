import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/models/create_user_model.dart';
import 'package:challenge_assign11/screens/experience_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  bool _emailValid = false; // 이메일이 올바른지 판단

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreateUserModel _userInfo = CreateUserModel();

  String? _isEmailValidation() {
    if (regExp.hasMatch(_userInfo.email)) {
      _emailValid = true;
      return null;
    }

    _emailValid = false;
    return "Invalid email";
  }

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _userInfo.email = _emailController.text;
      });
    });

    _nameController.addListener(() {
      setState(() => _userInfo.name = _nameController.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _birthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue, size: Sizes.size36),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Text(
                "Create your account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
              ),
              Gaps.v32,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    suffixIcon: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size24,
                    ),
                    suffixIconColor: _userInfo.name.length < 3 ? Colors.transparent : Colors.green),
                onSaved: (newValue) {
                  if (newValue != null && newValue.length >= 3) {
                    _userInfo.name = newValue;
                  } else {
                    _userInfo.name = "";
                  }
                },
              ),
              Gaps.v28,
              TextFormField(
                controller: _emailController,
                onSaved: (newValue) {
                  if (newValue != null && _emailValid) {
                    _userInfo.email = newValue;
                  } else {
                    _userInfo.email = "";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _isEmailValidation(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    suffixIcon: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size24,
                    ),
                    suffixIconColor: _emailValid ? Colors.green : Colors.transparent),
              ),
              Gaps.v28,
              TextFormField(
                controller: _birthController,
                onSaved: (newValue) {
                  if (newValue != null) {
                    DateFormat dtForm = DateFormat("yyyy / MM / dd");
                    _userInfo.birth = dtForm.parse(newValue);
                  } else {
                    _userInfo.birth = null;
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                    hintText: "Date of birth",
                    suffixIcon: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size24,
                    ),
                    suffixIconColor: Colors.green),
              ),
              Gaps.v28,
              FractionallySizedBox(
                widthFactor: 1,
                child: CupertinoButton.filled(
                  child: Text("Next", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _formKey.currentState?.save();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExperienceScreen(
                              userInfo: _userInfo,
                            )));
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 200,
        color: Colors.transparent,
        child: CupertinoDatePicker(
          onDateTimeChanged: (value) {
            DateFormat dtForm = DateFormat("yyyy / MM / dd");

            _userInfo.birth = value;
            _birthController.text = dtForm.format(_userInfo.birth!);
          },
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _userInfo.birth,
        ),
      ),
    );
  }
}
