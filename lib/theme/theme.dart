import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

getThemeData(BuildContext context) => Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        color: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      primaryColor: Colors.black,
    );
