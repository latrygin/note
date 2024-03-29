import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterTheme {
  ///Palette of light themes
  static const supportSeparatorLight = Color(0x33000000);
  static const supportOverlayLight = Color(0x0F000000);

  static const labelPrimaryLight = Color(0xFF000000);
  static const labelSecondaryLight = Color(0x99000000);
  static const labelTertiaryLight = Color(0x4D000000);
  static const labelDisableLight = Color(0x26000000);

  static const colorRedLight = Color(0xFFFF3B30);
  static const colorGreenLight = Color(0xFF34C759);
  static const colorPurpleLight = Color(0xFF673AB7);
  static const colorGrayLight = Color(0xFF8E8E93);

  static const backPrimaryLight = Color(0xFFF7F6F2);
  static const backSecondaryLight = Color(0xFFFFFFFF);
  static const backElevatedLight = Color(0xFFFFFFFF);

  ///Light themes
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backPrimaryLight,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      dividerColor: supportSeparatorLight,
      primaryColor: Colors.deepPurple,
      appBarTheme: AppBarTheme(
        surfaceTintColor: backPrimaryLight,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: const TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryLight,
          fontSize: 24.0,
          height: 38.0 / 32.0,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: backPrimaryLight,
        toolbarTextStyle: const TextStyle(
          fontStyle: FontStyle.normal,
          color: labelTertiaryLight,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          height: 20.0 / 16.0,
        ),
        actionsIconTheme: const IconThemeData(
          size: 24,
          color: colorPurpleLight,
        ),
        iconTheme: const IconThemeData(
          size: 24,
          color: labelPrimaryLight,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6.0,
        ),
        titleTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryLight,
          fontSize: 14.0,
          height: 20.0 / 16.0,
          fontWeight: FontWeight.w400,
        ),
        subtitleTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: colorPurpleLight,
          fontSize: 14.0,
          height: 20.0 / 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardTheme(
        color: backSecondaryLight,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        outline: colorPurpleLight,
        outlineVariant: supportSeparatorLight,
      ),
      textTheme: const TextTheme(
        labelLarge: TextStyle(
          color: labelPrimaryLight,
          fontWeight: FontWeight.w500,
          fontSize: 24.0,
        ),
        labelSmall: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryLight,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          height: 1.25,
        ),
        bodyLarge: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryLight,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(12.0),
        hintStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelTertiaryLight,
          fontSize: 16.0,
          height: 20.0 / 16.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: labelTertiaryLight,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        elevation: 1,
        color: backElevatedLight,
        textStyle: TextStyle(
          color: labelPrimaryLight,
          fontSize: 16,
        ),
      ),
    );
  }

  ///Palette of dark themes
  static const supportSeparatorDark = Color(0x33FFFFFF);
  static const supportOverlayDark = Color(0x52000000);

  static const labelPrimaryDark = Color(0xFFFFFFFF);
  static const labelSecondaryDark = Color(0x99FFFFFF);
  static const labelTertiaryDark = Color(0x66FFFFFF);
  static const labelDisableDark = Color(0x26FFFFFF);

  static const colorRedDark = Color(0xFFFF453A);
  static const colorGreenDark = Color(0xFF32D748);
  static const colorPurpleDark = Color(0xFF9575CD);
  static const colorGrayDark = Color(0xFF8E8E93);

  static const backPrimaryDark = Color(0xFF161618);
  static const backSecondaryDark = Color(0xFF252528);
  static const backElevatedDark = Color(0xFF3C3C3F);

  ///Dark themes
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backPrimaryDark,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: Colors.deepPurple.shade50,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      dividerColor: supportSeparatorDark,
      primaryColor: Colors.deepPurple,
      appBarTheme: AppBarTheme(
        surfaceTintColor: backPrimaryDark,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness:
              Platform.isIOS ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.dark : Brightness.light,
          statusBarBrightness:
              Platform.isIOS ? Brightness.dark : Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: const TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryDark,
          fontSize: 24.0,
          height: 38.0 / 32.0,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: backPrimaryDark,
        toolbarTextStyle: const TextStyle(
          fontStyle: FontStyle.normal,
          color: labelTertiaryDark,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          height: 20.0 / 16.0,
        ),
        actionsIconTheme: const IconThemeData(
          size: 24,
          color: colorPurpleDark,
        ),
        iconTheme: const IconThemeData(
          size: 24,
          color: labelPrimaryDark,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 6.0,
        ),
        titleTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryDark,
          fontSize: 14.0,
          height: 20.0 / 16.0,
          fontWeight: FontWeight.w400,
        ),
        subtitleTextStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: colorPurpleDark,
          fontSize: 14.0,
          height: 20.0 / 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardTheme(
        color: backSecondaryDark,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        //color: backSecondaryDark,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        outline: colorPurpleDark,
        outlineVariant: supportSeparatorDark,
      ),
      textTheme: const TextTheme(
        labelLarge: TextStyle(
          color: labelPrimaryDark,
          fontWeight: FontWeight.w500,
          fontSize: 24.0,
        ),
        labelSmall: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryDark,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          height: 1.25,
        ),
        bodyLarge: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelPrimaryDark,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(12.0),
        hintStyle: TextStyle(
          fontStyle: FontStyle.normal,
          color: labelTertiaryDark,
          fontSize: 16.0,
          height: 20.0 / 16.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: labelTertiaryDark,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        elevation: 1,
        color: backElevatedDark,
        textStyle: TextStyle(
          color: labelPrimaryDark,
          fontSize: 16,
        ),
      ),
    );
  }
}
