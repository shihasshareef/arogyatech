import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:arogya/screens/patient_screen.dart';
import 'package:arogya/common/theme.dart';
import 'package:arogya/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../common/colors.dart';
import '../providers/appointment_provider.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key, required this.title});
  final String title;

  @override
  State<AppointmentScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppointmentScreen> {
  late AppointmentProvider appointmentProvider;
  final TextEditingController dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final dateFormat = DateFormat("yyyy-MM-dd");
  List<String> doctorsList = ['Dr Alpha', 'Dr Beta', 'Dr Gamma'];
  List<String> timeFrameList = ['AM', 'PM'];
  List<String> morningTimeList = ['8', '9', '10', '11'];
  List<String> eveningTimeList = ['5', '6', '7', '8'];
  List<String> durationList = ['00', '15', '30', '45'];
  String? selectedDoctor;
  String? selectedDate;
  String? selectedTimeFrame;
  String? selectedTime;
  String? selectedSlot;

  @override
  void initState() {
    appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    selectedDate = dateFormat.format(DateTime.now());
    selectedDoctor = doctorsList[0];
    selectedTimeFrame = timeFrameList[0];
    selectedTime = morningTimeList[0];
    selectedSlot =
        '$selectedTime:${durationList[0]}-$selectedTime:${durationList[1]}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Number of slots${appointmentProvider.getAppointmentTimeSlots(selectedDate)}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20.sp,
        ),
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Appointments',
          style: arogyaTextTheme().bodyMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Pick a Date',
                  style: arogyaTextTheme()
                      .titleLarge!
                      .copyWith(color: ArogyaColors.blue),
                ),
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            DatePicker(
              DateTime.now(),
              daysCount: 30,
              height: 108.h,
              width: 68.w,
              initialSelectedDate: DateTime.now(),
              selectionColor: ArogyaColors.paleWhite,
              selectedTextColor: Colors.black,
              deactivatedColor: Colors.red,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  selectedDate = dateFormat.format(date);
                });
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 32.h,
                  width: 105.w,
                  decoration: BoxDecoration(
                    color: ArogyaColors.paleWhite,
                    border: Border.all(
                      color: ArogyaColors.grey,
                      width: 1.sp,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.sp),
                    ),
                  ),
                  child: Center(
                    child: DropdownButton(
                      alignment: AlignmentDirectional.center,
                      underline: const SizedBox.shrink(),
                      value: selectedDoctor,
                      focusColor: Colors.white,
                      items: doctorsList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDoctor = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 140.w,
                  height: 42.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: timeFrameList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedTimeFrame = timeFrameList[index];
                          });
                        },
                        child: Chip(
                          backgroundColor:
                              selectedTimeFrame == timeFrameList[index]
                                  ? ArogyaColors.blue10
                                  : ArogyaColors.white10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                          ),
                          label: Text(timeFrameList[index]),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 14.w,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              width: 360.w,
              height: 84.h,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: selectedTimeFrame == timeFrameList[0]
                    ? morningTimeList.length
                    : eveningTimeList.length,
                itemBuilder: (context, index) {
                  int count = 0;
                  (appointmentProvider
                      .getAppointmentTimeSlots(selectedDate)
                      ?.forEach((element) {
                    if (element?.substring(0, 1) ==
                        (selectedTimeFrame == timeFrameList[0]
                            ? morningTimeList[index]
                            : eveningTimeList[index])) {
                      count++;
                    }
                  }));
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = (selectedTimeFrame == timeFrameList[0]
                            ? morningTimeList[index]
                            : eveningTimeList[index]);
                      });
                    },
                    child: Container(
                      height: 84.h,
                      width: 72.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedTime ==
                                (selectedTimeFrame == timeFrameList[0]
                                    ? morningTimeList[index]
                                    : eveningTimeList[index])
                            ? ArogyaColors.blue10
                            : ArogyaColors.white10,
                        border: Border.all(
                          color: ArogyaColors.lightGreen,
                          width: 1.sp,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x26000000),
                            blurRadius: 2.r,
                            offset: Offset(0.sp, 1.sp),
                            spreadRadius: 0.r,
                          ),
                          BoxShadow(
                            color: const Color(0x4C000000),
                            blurRadius: 3.r,
                            offset: Offset(0.sp, 1.sp),
                            spreadRadius: 1.r,
                          )
                        ],
                      ),
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 32.r,
                          lineWidth: 6.sp,
                          percent: count * 0.25,
                          center: Text(
                            selectedTimeFrame == timeFrameList[0]
                                ? morningTimeList[index]
                                : eveningTimeList[index],
                          ),
                          backgroundColor: Colors.transparent,
                          progressColor: ArogyaColors.lightRed,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 360.w,
              height: 72.h,
              padding: EdgeInsets.all(10.sp),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  bool preBooked = (appointmentProvider
                          .getAppointmentTimeSlots(selectedDate)
                          ?.contains(
                              '$selectedTime:${durationList[index]}-${index == 3 ? (int.parse(selectedTime!) + 1).toString() : selectedTime}:${durationList[(index + 1) % 4]}') ??
                      false);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (!preBooked) {
                          selectedSlot =
                              '$selectedTime:${durationList[index]}-${index == 3 ? (int.parse(selectedTime!) + 1).toString() : selectedTime}:${durationList[(index + 1) % 4]}';
                        }
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedSlot ==
                              '$selectedTime:${durationList[index]}-${index == 3 ? (int.parse(selectedTime!) + 1).toString() : selectedTime}:${durationList[(index + 1) % 4]}'
                          ? ArogyaColors.blue10
                          : ArogyaColors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.sp),
                        ),
                        side: BorderSide(
                            color:
                                preBooked ? ArogyaColors.faded : Colors.black),
                      ),
                      label: Text(
                        '$selectedTime:${durationList[index]}-${index == 3 ? (int.parse(selectedTime!) + 1).toString() : selectedTime}:${durationList[(index + 1) % 4]}',
                        style: arogyaTextTheme().labelSmall?.copyWith(
                              color:
                                  preBooked ? ArogyaColors.faded : Colors.black,
                            ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            PrimaryButton(
                color: ArogyaColors.paleBlue,
                onPressed: () {
                  appointmentProvider.setAppointmentDate = dateFormat
                      .format(DateTime.parse(selectedDate.toString()));
                  appointmentProvider.setAppointmentTime =
                      '${selectedTime!} ${selectedTimeFrame!}';
                  appointmentProvider.setAppointmentTimeSlot = selectedSlot!;
                  appointmentProvider.setDoctorName = selectedDoctor!;
                  Navigator.of(context).push(PageTransition(
                    child: const PatientScreen(title: 'Clinic'),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 500),
                  ));
                },
                text: 'Schedule an Appointment'),
          ],
        ),
      ),
    );
  }
}
