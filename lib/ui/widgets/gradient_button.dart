import 'package:flutter/material.dart';
import 'package:marrat/styles/app_colors.dart';
import 'package:marrat/styles/decoration_styles.dart';

/// A button that shows a busy indicator in place of title
class GradientButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;

  const GradientButton(
      {@required this.title,
      this.busy = false,
      @required this.onPressed,
      this.enabled = true});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: InkWell(
          child: AnimatedContainer(
            height: widget.busy ? 40 : null,
            width: widget.busy ? 40 : null,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: widget.busy ? 10 : 15,
                vertical: widget.busy ? 10 : 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightGreenShade, darkGreenShade]),
              borderRadius: BorderRadius.circular(5),
            ),
            child: !widget.busy
                ? Text(
                    widget.title,
                    style: buttonTitleTextStyle,
                  )
                : CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
        ),
      ),
    );
  }
}
