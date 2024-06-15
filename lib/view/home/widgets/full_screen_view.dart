import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/api_url.dart';

class FullScreenView extends StatelessWidget {
  final String? image;
  const FullScreenView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // backgroundColor: Colors.black,
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InteractiveViewer(
              maxScale: 5,
              minScale: 0.1,
              constrained: true,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 400,
                imageUrl: image!,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.network(ApiUrl.imageNotFound),
              )),
        ],
      ),
    );
  }
}
