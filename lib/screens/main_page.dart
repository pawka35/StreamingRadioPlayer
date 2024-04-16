import 'package:final_project/generated/l10n.dart';
import 'package:final_project/screens/auth/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('MainPage'),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogOutEvent());
              },
              child: Text(S.of(context).logout),
            ),
          ],
        ),
      ),
    );
  }
}
