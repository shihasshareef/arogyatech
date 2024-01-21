import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:arogya/widgets/primary_button.dart';
import 'package:page_transition/page_transition.dart';
import '../common/colors.dart';
import '../common/theme.dart';
import 'package:arogya/screens/appointment_screen.dart';

class ModalPopUp {
  final String? date;
  final String? time;
  final String? doctor;
  final String? patient;
  final Color backgroundColor;
  final double modalWidth;
  final double modalHeight;
  final bool barrierDismissable;
  final Color barrierColor;
  ModalPopUp({
    this.date,
    this.time,
    this.doctor,
    this.patient,
    this.backgroundColor = ArogyaColors.lightWhite,
    this.modalWidth = 360,
    this.modalHeight = 360,
    this.barrierDismissable = true,
    this.barrierColor = Colors.white,
  });

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          contentPadding: EdgeInsets.all(0.0.sp),
          insetPadding: EdgeInsets.all(0.0.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4.0.sp,
            ),
          ),
          content: IntrinsicHeight(
            child: SizedBox(
              width: modalWidth,
              height: modalHeight,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const Image(
                    image: AssetImage(
                      'assets/images/tick.png',
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Appointment has been added successfully\non $date, $time',
                    style: arogyaTextTheme()
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Doctor Name: $doctor',
                    style: arogyaTextTheme()
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    'Patient Name: $patient',
                    style: arogyaTextTheme()
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  PrimaryButton(
                      width: 92.w,
                      height: 40.h,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(PageTransition(
                          child: const AppointmentScreen(title: 'Clinic'),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                        ));
                      },
                      text: 'OK'),
                ],
              ),
            ),
          ),
        );
      },
      barrierDismissible: barrierDismissable,
      barrierColor: barrierColor,
    );
  }
}
