import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

class OptionsScreen extends StatelessWidget {
  final String? title;
  const OptionsScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Utils.scrHeight * .005),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  //SizedBox(height: 110),
                  // Row(
                  //   children: [
                  //     const CircleAvatar(
                  //       radius: 16,
                  //       child: Icon(Icons.person, size: 18),
                  //     ),
                  //     const SizedBox(width: 6),
                  //     const Text('flutter_developer02'),
                  //     const SizedBox(width: 10),
                  //     const Icon(Icons.verified, size: 15),
                  //     const SizedBox(width: 6),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: const Text(
                  //         'Follow',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(width: Utils.scrHeight * .006),
                  SizedBox(
                    width: Utils.scrHeight * .31,
                    child: Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: Utils.scrHeight * .010),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.music_note,
                  //       size: 15,
                  //     ),
                  //     Text(
                  //       'Original Audio - some music track--',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: Utils.scrHeight * .25,
              ),
              // Column(
              //   children: [
              //     const Icon(Icons.favorite_outline),
              //     const Text('601k'),
              //     const SizedBox(height: 20),
              //     const Icon(Icons.comment_rounded),
              //     const Text('1123'),
              //     const SizedBox(height: 20),
              //     Transform(
              //       transform: Matrix4.rotationZ(5.8),
              //       child: const Icon(Icons.send),
              //     ),
              //     const SizedBox(height: 50),
              //     const Icon(Icons.more_vert),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
