import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:formula_app/TabBarUI.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => TabSelectorUI()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) {
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
