import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_app/login/view/login_screen.dart';
import 'package:user_management_app/login/view_model/login_provider.dart';
import 'package:user_management_app/routes/routes.dart';
import 'package:user_management_app/utilities/view/const.dart';

class LogoutAlertBox extends StatelessWidget {
  const LogoutAlertBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kUwhite,
      content: const Text(
        'Are you sure?',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            context.read<LoginProvider>().logOut(context);
            RoutesProvider.removeScreen(screen: const LoginScreen());
            const snackBar = SnackBar(
              content: Text('Logout Completed'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text('LOGOUT'),
        ),
        TextButton(
          onPressed: () {
            RoutesProvider.backScreen();
          },
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.amber),
          ),
        )
      ],
    );
  }
}
