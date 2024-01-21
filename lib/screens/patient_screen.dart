import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:arogya/common/theme.dart';
import 'package:arogya/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../common/colors.dart';
import '../providers/appointment_provider.dart';
import '../widgets/modal_popup.dart';
import 'package:arogya/models/appointment_model.dart';
import 'package:arogya/models/patient_model.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key, required this.title});
  final String title;

  @override
  State<PatientScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PatientScreen> {
  late AppointmentProvider appointmentProvider;
  final TextEditingController nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  List gender = ["Male", "Female", "Others"];
  String? selectedGender;
  @override
  void initState() {
    selectedGender = gender[0];
    appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: arogyaTextTheme().bodyMedium!.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Patient Profile',
                  style: arogyaTextTheme()
                      .titleLarge!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Container(
                width: 78.w,
                height: 78.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Image(
                  image: AssetImage(
                    'assets/images/profile.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 64.h,
            ),
            SizedBox(
              width: 328.w,
              height: 56.h,
              child: TextFormField(
                focusNode: nameFocusNode,
                controller: nameController,
                keyboardType: TextInputType.name,
                style: arogyaTextTheme().titleLarge?.copyWith(height: 1.27),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  contentPadding: EdgeInsets.all(12.0.sp),
                  hintText: 'Name',
                  hintStyle: arogyaTextTheme().bodyLarge?.copyWith(
                        color: ArogyaColors.hintColor,
                      ),
                  alignLabelWithHint: false,
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            SizedBox(
              width: 328.w,
              height: 56.h,
              child: TextFormField(
                focusNode: phoneFocusNode,
                controller: phoneController,
                keyboardType: TextInputType.number,
                style: arogyaTextTheme().titleLarge?.copyWith(height: 1.27),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  hintText: 'Phone number',
                  contentPadding: EdgeInsets.all(12.0.sp),
                  hintStyle: arogyaTextTheme().bodyLarge?.copyWith(
                        color: ArogyaColors.hintColor,
                      ),
                  alignLabelWithHint: false,
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Gender',
              style: arogyaTextTheme().bodyLarge!.copyWith(color: Colors.black),
            ),
            SizedBox(
              width: 360.w,
              height: 84.h,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: gender.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: Colors.green,
                        value: gender[index],
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      Text(gender[index]),
                    ],
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
              height: 32.h,
            ),
            Text(
              'Appointment Details:',
              style: arogyaTextTheme()
                  .bodyMedium!
                  .copyWith(color: ArogyaColors.brown),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '${appointmentProvider.getDoctorName}  ${appointmentProvider.getAppointmentDate}, ${appointmentProvider.getAppointmentTimeSlot}',
              style: arogyaTextTheme()
                  .bodyMedium!
                  .copyWith(color: ArogyaColors.blue),
            ),
            SizedBox(
              height: 68.h,
            ),
            PrimaryButton(
                width: 348.w,
                height: 40.h,
                color: ArogyaColors.red,
                onPressed: () async {
                  String? patientId = await appointmentProvider.postPatientData(
                    PatientModel(
                      fullName: nameController.text,
                      phone: phoneController.text,
                      gender: selectedGender,
                    ),
                  );
                  int? id = await appointmentProvider.postAppointmentData(
                    AppointmentModel(
                        createdBy: '1106',
                        createdOn: "",
                        doctorId: "135",
                        patientId: patientId,
                        scheduledDate: appointmentProvider.getAppointmentDate,
                        slotValue: "95",
                        status: "scheduled"),
                  );
                  if (id != null) {
                    appointmentProvider.setAppointmentTimeSlots(
                        appointmentProvider.getAppointmentDate,
                        appointmentProvider.getAppointmentTimeSlot);
                    ModalPopUp(
                      date: appointmentProvider.getAppointmentDate,
                      time: appointmentProvider.getAppointmentTimeSlot,
                      doctor: appointmentProvider.getDoctorName,
                      patient: nameController.text,
                      modalWidth: 348.w,
                      modalHeight: 329.h,
                      barrierDismissable: true,
                    ).showPopup(context);
                  }
                },
                text: 'Create & Book Appointment'),
          ],
        ),
      ),
    );
  }
}
