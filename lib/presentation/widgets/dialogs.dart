import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../utils/constants/Colors.dart';
import '../../utils/constants/strings.dart';
import 'custo_checkbox_listtile.dart';
import 'custom_edit_text.dart';
import 'custom_elevated_button.dart';

void showWaitingDialog() {
  SmartDialog.show(
      builder: (context) {
        return Container(
          height: 80,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            child: Image.asset(
              "assets/images/wait.gif",
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      clickMaskDismiss: false,
      backDismiss: false);
}

void showNotifyDialog(String msg, String image, Color color) {
  SmartDialog.show(
      builder: (context) {
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  height: 150,
                ),
              ),
              Text(
                msg,
                style: const TextStyle(
                  color: CustomColors.darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: railwayFontFamily,
                ),
              ),
            ],
          ),
        );
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: const Duration(seconds: 5));
}

void hideWaitingDialog() {
  SmartDialog.dismiss();
}

void showEditTaskDialog({
  required GlobalKey<FormState> checkEditTaskKey,
  required Color color,
  required TextEditingController todoController,
  required bool completedValue,
  required VoidCallback onSave,
  required VoidCallback onExit,
  required Function onChangeCompleted,
}) {
  SmartDialog.show(
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * (40 / 100),
            width: MediaQuery.of(context).size.width * (95 / 100),
            alignment: Alignment.center,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Form(
                key: checkEditTaskKey,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30, left: 10),
                      child: Text(
                        "Edit Task",
                        style: TextStyle(
                            fontFamily: railwayFontFamily,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkBlue),
                      ),
                    ),
                    CustomEditText(
                      label: 'To Do',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: todoController,
                      obscureText: false,
                      icon: Icons.drive_file_rename_outline,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    CustomCheckBoxListTile(
                      value: completedValue,
                      label: "Completed",
                      onChange: (newValue) {
                        onChangeCompleted(newValue);
                      },
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.darkBlue,
                        fontFamily: railwayFontFamily,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          text: "Edit",
                          // Login UI Functionality
                          onPressed: () {
                            final isValid = checkEditTaskKey.currentState?.validate();
                            if (!isValid!) {
                              return;
                            }
                            checkEditTaskKey.currentState?.save();

                            onSave();
                          },
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: CustomColors.buttonColor,
                          shadowColor: CustomColors.buttonColor,
                          elevation: 20,
                          textColor: CustomColors.white,
                        ),
                        CustomElevatedButton(
                          text: "Exit",
                          // Login UI Functionality
                          onPressed: onExit,
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: Colors.red,
                          shadowColor: Colors.red,
                          elevation: 20,
                          textColor: CustomColors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: null);
}

void showAddTaskDialog({
  required GlobalKey<FormState> checkAddTaskKey,
  required Color color,
  required TextEditingController todoController,
  required bool completedValue,
  required VoidCallback onAdd,
  required VoidCallback onExit,
  required Function onChangeCompleted,
}) {
  SmartDialog.show(
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * (40 / 100),
            width: MediaQuery.of(context).size.width * (95 / 100),
            alignment: Alignment.center,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Form(
                key: checkAddTaskKey,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30, left: 10),
                      child: Text(
                        "Add New Task",
                        style: TextStyle(
                            fontFamily: railwayFontFamily,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.darkBlue),
                      ),
                    ),
                    CustomEditText(
                      label: 'To Do',
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * (95 / 100),
                      controller: todoController,
                      obscureText: false,
                      icon: Icons.drive_file_rename_outline,
                      textStyle: const TextStyle(
                        color: CustomColors.darkBlue,
                      ),
                      validator: (_) {
                        return null;
                      },
                      defaultBorderSideColor: CustomColors.darkBlue,
                      focusedBorderSideColor: CustomColors.primaryColor,
                    ),
                    CustomCheckBoxListTile(
                      value: completedValue,
                      label: "Completed",
                      onChange: (newValue) {
                        onChangeCompleted(newValue);
                      },
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.darkBlue,
                        fontFamily: railwayFontFamily,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          text: "Add",
                          // Login UI Functionality
                          onPressed: () {
                            final isValid = checkAddTaskKey.currentState?.validate();
                            if (!isValid!) {
                              return;
                            }
                            checkAddTaskKey.currentState?.save();

                            onAdd();
                          },
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: CustomColors.buttonColor,
                          shadowColor: CustomColors.buttonColor,
                          elevation: 20,
                          textColor: CustomColors.white,
                        ),
                        CustomElevatedButton(
                          text: "Exit",
                          // Login UI Functionality
                          onPressed: onExit,
                          width: 100,
                          height: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: railwayFontFamily,
                          fontSize: 14,
                          color: Colors.red,
                          shadowColor: Colors.red,
                          elevation: 20,
                          textColor: CustomColors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: null);
}

void showLogoutDialog({
  required Color color,
  required VoidCallback onOk,
  required VoidCallback onCancel,
}) {
  SmartDialog.show(
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * (30 / 100),
            width: MediaQuery.of(context).size.width * (95 / 100),
            alignment: Alignment.center,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: color,
              body: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30, left: 10),
                    child: Text(
                      "Would you like to log out!!",
                      style: TextStyle(
                          fontFamily: railwayFontFamily,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.darkBlue),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        text: "OK",
                        // Login UI Functionality
                        onPressed: () {
                          onOk();
                        },
                        width: 100,
                        height: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: railwayFontFamily,
                        fontSize: 14,
                        color: CustomColors.buttonColor,
                        shadowColor: CustomColors.buttonColor,
                        elevation: 20,
                        textColor: CustomColors.white,
                      ),
                      CustomElevatedButton(
                        text: "Cancel",
                        // Login UI Functionality
                        onPressed: onCancel,
                        width: 100,
                        height: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: railwayFontFamily,
                        fontSize: 14,
                        color: Colors.red,
                        shadowColor: Colors.red,
                        elevation: 20,
                        textColor: CustomColors.white,
                      )
                    ],
                  )
                ],
              ),
            ));
      },
      clickMaskDismiss: true,
      backDismiss: true,
      displayTime: null);
}
