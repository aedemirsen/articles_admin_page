import 'package:articles_admin_page/admin_page.dart';
import 'package:articles_admin_page/config.dart';
import 'package:articles_admin_page/cubit/controller_cubit.dart';
import 'package:articles_admin_page/service/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ControllerCubit(
          Service(Dio(BaseOptions(baseUrl: AppConfig.baseUrl)))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yazılar Admin Sayfası',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AdminPage(title: 'Yazılar Admin Sayfası'),
      ),
    );
  }
}
