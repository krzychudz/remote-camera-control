import 'package:flutter/material.dart';

getThemeData(BuildContext context) => Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      primaryColor: Colors.black,
    );
