import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_form.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'provider/users.dart';
import 'views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Users(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.HOME: (_) =>  const UserList(),
            AppRoutes.USER_FORM: (_) =>  const UserForm(),
          },
        )
      );
  }
}
