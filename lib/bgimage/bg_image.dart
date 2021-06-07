import 'package:flutter/material.dart';

class BgImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://images.unsplash.com/photo-1585909694668-0a6e0ddbfe8b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2hhcmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}
