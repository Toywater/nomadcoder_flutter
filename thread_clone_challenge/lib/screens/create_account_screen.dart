import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/repos/auth_repo.dart';
import 'package:navigation_time_challenge12/utils/utils.dart';
import 'package:navigation_time_challenge12/view_models/user_config_vm.dart';
import 'package:navigation_time_challenge12/widgets/form_button.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  static String routeUrl = "/createAccount";
  static String routeName = "createAccount";

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onCreateAccountTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        {
          // 이메일 계정
          if (formData["email"] == null || formData["email"]!.isEmpty) {
            showErrorSnack(context, "Please write your email.");
            return;
          }

          // 암호 체크
          if (formData["newPassword"] == null || formData["confirmPassword"] == null || formData["newPassword"] != formData["confirmPassword"]) {
            showErrorSnack(context, "Password error");
            return;
          }

          String errorMsg = await ref.read(authRepo).createUser(formData["email"]!, formData["newPassword"]!);
          if (errorMsg.isNotEmpty && mounted) {
            showErrorSnack(context, errorMsg);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.read(userConfigProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: Sizes.size16,
              children: [
                Gaps.v96,
                Container(
                  width: Sizes.size96,
                  height: Sizes.size96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.size24),
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.threads,
                      size: Sizes.size80,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['newPassword'] = newValue;
                    }
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write confirm password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['confirmPassword'] = newValue;
                    }
                  },
                ),
                // 계정 생성 버튼
                GestureDetector(
                  onTap: _onCreateAccountTap,
                  child: const FormButton(displayText: "Create Account", isDisabled: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
