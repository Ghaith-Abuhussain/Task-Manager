import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

import '../components/custom_clipper.dart';
import '../widgets/custom_elevated_button.dart';
import '../../config/router/router.dart';
import '../../presentation/views/login_screen.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: CustomColors.background,
            child: Column(
              children: [
                ClipPath(
                  clipper: CurvedBottomClipper(),
                  child: Container(
                    color: CustomColors.mideumBlue,
                    height: MediaQuery.of(context).size.height * (3 / 5),
                    child: ClipRRect(
                      child: Image.asset("assets/images/task_login_signup.png", fit: BoxFit.fill,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Your Best Way To Manage Tasks",
                  style: TextStyle(
                      color: CustomColors.darkBlue,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                  text: "Login",
                  onPressed: () {
                    navigateToRoute(context, LoginScreen.routeName);
                  },
                  width: 240,
                  height: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  color: CustomColors.primaryColor,
                  shadowColor: CustomColors.primaryColor,
                  elevation: 20,
                  textColor: CustomColors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
