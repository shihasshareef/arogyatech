import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_service.dart';
import 'package:arogya/models/patient_model.dart';
import 'package:arogya/models/appointment_model.dart';

class DoctorServiceApi {
  static DoctorServiceApi shared = DoctorServiceApi._internal();

  DoctorServiceApi._internal();

  List<PatientModel?> patientList = [];
  Future<List<PatientModel?>> getAppointment(
      BuildContext context, String date, String doctorId) async {
    try {
      var dio = await DioClient.getClient();
      if (dio != null) {
        var response = await dio.get(
          'test?scheduled_date=2024-01-20&doctor_id=135',
        );
        for (var element in response.data) {
          patientList.add(PatientModel.fromJson(element));
        }
        return patientList;
      }
      return [];
    } catch (error) {
      if (error is DioException) {
        throw Exception('Languages loading failed');
      }
      if (error.toString().contains("401")) {
        // return login.fromJson({'Network error': 401});
      }
      return [];
    }
  }

  Future<String?> postPatientData(PatientModel patientData) async {
    try {
      var dio = await DioClient.getClient();
      if (dio != null) {
        var response = await dio.post(
          'test/create-patient',
          data: jsonEncode(patientData.toJson()),
        );

        return response.data['patient_id'];
      }
      return null;
    } catch (error) {
      if (error is DioException) {
        throw Exception('Post feed failed');
      }
      if (error.toString().contains("401")) {}
      return null;
    }
  }

  Future<int?> postAppointment(AppointmentModel appointmentData) async {
    try {
      var dio = await DioClient.getClient();
      if (dio != null) {
        var response = await dio.post(
          'test',
          data: jsonEncode(appointmentData.toJson()),
        );

        return response.data['id'];
      }
      return null;
    } catch (error) {
      if (error is DioException) {
        throw Exception('Post feed failed');
      }
      if (error.toString().contains("401")) {}
      return null;
    }
  }
}
