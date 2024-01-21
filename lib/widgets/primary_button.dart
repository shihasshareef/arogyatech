import 'package:flutter/material.dart';

import '../common/theme.dart';
import 'circular_progress_bar.dart';
import 'package:arogya/common/colors.dart';

class PrimaryButton extends StatefulWidget {
  final Function onPressed;
  final bool disabled;
  final String text;
  final double width;
  final double height;
  final double borderRadius;
  final BoxBorder? border;
  final Color color;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    required this.text,
    this.width = 212.0,
    this.height = 40.0,
    this.borderRadius = 100.0,
    this.border,
    this.color = ArogyaColors.paleBlue,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      width: widget.width,
      height: widget.height,
      child: widget.isLoading
          ? TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  widget.color,
                ),
                elevation: MaterialStateProperty.all(0),
              ),
              child: const Center(
                child: CircularProgressBar(),
              ),
            )
          : MouseRegion(
              onHover: (s) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (s) {
                setState(() {
                  isHovered = false;
                });
              },
              child: TextButton(
                onPressed: () {
                  if (!widget.disabled) widget.onPressed();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    widget.disabled ? ArogyaColors.disabled : widget.color,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  widget.text,
                  style: arogyaTextTheme().labelLarge?.copyWith(
                        height: 0.1,
                        color: widget.disabled
                            ? Colors.white
                            : ArogyaColors.textColor,
                      ),
                  // strutStyle:
                  //     StrutStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  // textScaleFactor: 3.sp,
                ),
              ),
            ),
    );
  }
}
