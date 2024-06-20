import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_.jpg'),
          ),
          Positioned(
            right: -8,
            bottom: 1,
            child: SizedBox(
              height: 46,
              width: 46,
              child: IconButton(
                color: Color(0xff3E3D3D),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(Icons.camera_alt),
              ),
            ),
          )
        ],
      ),
    );
  }
}
