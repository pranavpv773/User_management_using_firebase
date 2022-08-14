import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_app/sign_up/view_model/sign_up_provider.dart';

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({
    Key? key,
    required this.primary,
    required this.text,
    this.function,
  }) : super(key: key);
  final Color primary;
  final String text;
  final Function? function;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 150,
          vertical: 15,
        ),
        primary: primary,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
      onPressed: () {
        context.read<SignUpProvider>().onTabGoogleFunction(context);
      },
      child: Text(
        text,
      ),
    );
  }
}
