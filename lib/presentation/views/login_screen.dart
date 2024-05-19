import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing/presentation/views/home_screen.dart';
import '../../utils/constants/colors.dart';
import '../components/custom_clipper.dart';
import '../widgets/custom_edit_text.dart';
import '../widgets/custo_checkbox_listtile.dart';
import '../widgets/custom_elevated_button.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../../config/router/router.dart';
import '../widgets/custom_back_button.dart';
import '../../utils/constants/strings.dart';

// Screens
import '../widgets/dialogs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const routeName = '/login';

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool remembermeValue = false;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();



  bool _chechValidation() {
    final isValid = _loginFormKey.currentState?.validate();
    if (!isValid!) {
      return false;
    }
    _loginFormKey.currentState?.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var loginBlocProvider = BlocProvider.of<LoginBloc>(context);
    loginBlocProvider.add(LoginGetRememberedUser());
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginStateGetRemembered) {
                  _usernameController.text = state.username;
                  _passwordController.text = state.password;
                  if (state.username.isNotEmpty) {
                    remembermeValue = true;
                  }
                  loginBlocProvider.add(LoginEmitInitial());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: CurvedBottomClipper(),
                      child: Stack(
                        children: [
                          Container(
                            color: CustomColors.mideumBlue,
                            height:
                                MediaQuery.of(context).size.height * (2 / 5),
                            child: ClipRRect(
                              child: Image.asset(
                                "assets/images/task_login.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          CustomBackButton(
                            icon: Icons.arrow_back_sharp,
                            onPressed: () {
                              navigateToPrevious(context);
                            },
                            color: Colors.transparent,
                            iconSize: 24,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            padding: const EdgeInsets.all(16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Welcome Task Manager",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: railwayFontFamily,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.darkBlue,

                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Login to your account",
                      style: TextStyle(
                        fontFamily: railwayFontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: CustomColors.darkBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          CustomEditText(
                            label: 'username',
                            controller: _usernameController,
                            obscureText: false,
                            icon: Icons.account_circle,
                            textStyle: const TextStyle(
                              color: CustomColors.darkBlue,
                            ),
                            validator: (_) {
                              if (_usernameController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }

                              return null;
                            },
                            defaultBorderSideColor: CustomColors.darkBlue,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomEditText(
                            label: 'password',
                            controller: _passwordController,
                            obscureText: true,
                            showSuffixIcon: true,
                            icon: Icons.lock,
                            textStyle: const TextStyle(
                              color: CustomColors.darkBlue,
                            ),
                            validator: (_) {
                              if (_passwordController.text.trim().isEmpty) {
                                return 'Must Enter Value Here !!!';
                              }
                              return null;
                            },
                            defaultBorderSideColor: CustomColors.darkBlue,
                            focusedBorderSideColor:
                                CustomColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCheckBoxListTile(
                            value: remembermeValue,
                            label: "Remember me",
                            onChange: (newValue) {
                              remembermeValue = newValue;
                            },
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.darkBlue,
                              fontFamily: railwayFontFamily,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: CustomColors.buttonColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      text: "Login",
                      // Login UI Functionality
                      onPressed: () {
                        if (!_chechValidation()) {
                          return;
                        }
                        loginBlocProvider.add(LoginEventLogin(
                            username: _usernameController.text,
                            password: _passwordController.text,
                            remembermeValue: remembermeValue));
                      },
                      width: 240,
                      height: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: railwayFontFamily,
                      fontSize: 20,
                      color: CustomColors.primaryColor,
                      shadowColor: CustomColors.primaryColor,
                      elevation: 20,
                      textColor: CustomColors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is LoginStateAttemptLogin) {
                  showWaitingDialog();
                } else if (state is LoginStateLoginSuccess) {
                  hideWaitingDialog();
                  navigateToRouteReplacement(context, HomeScreen.routeName);
                } else if (state is LoginStateLoginFailure) {
                  hideWaitingDialog();
                  showNotifyDialog('Login Failed', "assets/images/error2.gif", CustomColors.lightOrange);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
