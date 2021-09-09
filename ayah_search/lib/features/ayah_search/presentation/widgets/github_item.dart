import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GithubItem extends StatefulWidget {
  const GithubItem({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  _GithubItemState createState() => _GithubItemState(onTap);
}

class _GithubItemState extends State<GithubItem> {
  double quantity = 1;
  final Function() onTap;

  _GithubItemState(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: (_) => setState(() => quantity = 1.5),
      onTapUp: (_) => setState(() => quantity = 1),
      child: AnimatedContainer(
        duration: 300.milliseconds,
        padding: EdgeInsets.symmetric(
          horizontal: 8 * quantity,
          vertical: 6 * quantity,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/github.svg',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'Prantik',
                  style: TextStyle(fontSize: 18),
                  children: [
                    TextSpan(
                      text: '\ngithub.com/coderprantik',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
