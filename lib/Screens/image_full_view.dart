import 'package:flutter/material.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: mWidth,
      height: mHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(image),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
