import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResolutionService {
  static final ResolutionService _instance = new ResolutionService._internal();

  factory ResolutionService() {
    return _instance;
  }
  ResolutionService._internal({
    this.allowFontScaling: false ,
  });

  // todo: 돌렸을때  GPad는 533x853, 600x960 등, 패드는 여기에 해당안됨  (대응 안하는 쪽으로.... 어차피 쓰는사람도없음)
  static const int TYPICAL_7INCH_TABLET_SIZE = 600;
  static const int TYPICAL_7INCH_TABLET_LARGE_SIZE = 1024;

  int _width;
  int _height;

  final bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;
  static double _shortestSide;
  bool isTablet = false;

  void init(BuildContext context, {int width: 720, int height: 1280}) {
    //isTablet = _isTablet(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _shortestSide = mediaQuery.size.shortestSide;

    this._width = width;
    this._height = height;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double get textScaleFactor => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidthDp => _screenWidth;

  static double get screenHeightDp => _screenHeight;

  static double get screenWidth => _screenWidth * _pixelRatio;

  static double get screenHeight => _screenHeight * _pixelRatio;

  static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  static double get statusBarHeightDP => _statusBarHeight;

  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  static bool get isTabletScreen => _shortestSide > TYPICAL_7INCH_TABLET_SIZE;

  get scaleWidth => _screenWidth / _instance._width;

  get scaleHeight => _screenHeight / _instance._height;

  getSize(size) => size * scaleWidth / (isTablet ? 2 : 1);

  getWidth(width) => width * scaleWidth;

  getHeight(height) => height * scaleHeight;

  getIconSize(size) => size * scaleHeight;

  getSp(fontSize) => allowFontScaling ? getSize(fontSize) : getSize(fontSize) / _textScaleFactor;

  isLargeScreenByContext(BuildContext context) => MediaQuery.of(context).size.width >= TYPICAL_7INCH_TABLET_LARGE_SIZE;
}