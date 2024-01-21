import 'package:flutter/material.dart';

import '../models/patient_model.dart';
import 'package:arogya/models/appointment_model.dart';
import 'package:arogya/services/doctor_service.dart';

class AppointmentProvider extends ChangeNotifier {
  Map<String?, List<String?>> appointmentTimeSlots = {};
  String? appointmentDate;
  String? appointmentTime;
  String? appointmentTimeSlot;
  String? doctorName;

  void setAppointmentTimeSlots(String? date, String? timeSlot) {
    if (appointmentTimeSlots[date] == null) {
      appointmentTimeSlots[date] = [];
    }
    appointmentTimeSlots[date]?.add(timeSlot);
    notifyListeners();
  }

  List<String?>? getAppointmentTimeSlots(String? date) {
    return appointmentTimeSlots[date];
  }

  set setAppointmentDate(String date) {
    appointmentDate = date;
    notifyListeners();
  }

  get getAppointmentDate {
    return appointmentDate;
  }

  set setAppointmentTime(String date) {
    appointmentTime = date;
    notifyListeners();
  }

  get getAppointmentTime {
    return appointmentTime;
  }

  set setAppointmentTimeSlot(String slot) {
    appointmentTimeSlot = slot;
    notifyListeners();
  }

  get getAppointmentTimeSlot {
    return appointmentTimeSlot;
  }

  set setDoctorName(String date) {
    doctorName = date;
    notifyListeners();
  }

  get getDoctorName {
    return doctorName;
  }

  Future<String?> postPatientData(PatientModel patientData) async {
    String? id = await DoctorServiceApi.shared.postPatientData(patientData);
    return id;
  }

  Future<int?> postAppointmentData(AppointmentModel appointmentData) async {
    int? id = await DoctorServiceApi.shared.postAppointment(appointmentData);
    return id;
  }
}
