import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/repos/auth_repo.dart';
import 'package:navigation_time_challenge12/screens/create_account_screen.dart';
import 'package:navigation_time_challenge12/utils/utils.dart';
import 'package:navigation_time_challenge12/view_models/user_config_vm.dart';
import 'package:navigation_time_challenge12/widgets/form_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static String routeUrl = "/login";
  static String routeName = "login";

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  // 로그인 수행
  void _onLoginTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        var loginError = await ref.read(authRepo).login(formData["email"]!, formData["password"]!);

        // 로그인 에러인 경우
        if (loginError.isNotEmpty) {
          if (mounted) {
            showErrorSnack(context, loginError);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.read(userConfigProvider).isDarkMode;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
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
                    hintText: 'Password',
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
                      formData['password'] = newValue;
                    }
                  },
                ),
                // 로그인 버튼
                GestureDetector(
                  onTap: _onLoginTap,
                  child: const FormButton(displayText: "Log in", isDisabled: false),
                ),
                Expanded(
                  child: Text("Forgot password?"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size5),
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // 계정 생성 화면으로 전환
                            context.pushNamed(CreateAccountScreen.routeName);
                          },
                          child: Text(
                            "Create new account",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
