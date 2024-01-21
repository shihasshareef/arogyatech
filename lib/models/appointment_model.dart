class AppointmentModel {
  String? doctorId;
  String? patientId;
  String? slotValue;
  String? status;
  String? createdOn;
  String? scheduledDate;
  String? createdBy;

  AppointmentModel({
    this.doctorId,
    this.patientId,
    this.slotValue,
    this.status,
    this.createdOn,
    this.scheduledDate,
    this.createdBy,
  });
  factory AppointmentModel.fromJson(Map<dynamic, dynamic> json) =>
      AppointmentModel(
        doctorId: json["doctor_id"] ?? '',
        patientId: json["patient_id"] ?? '',
        slotValue: json["slot_value"] ?? '',
        status: json["status"] ?? '',
        createdOn: json["created_on"] ?? '',
        scheduledDate: json["scheduled_date"] ?? '',
        createdBy: json["created_by"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "patient_id": patientId,
        "slot_value": slotValue,
        "status": status,
        "created_on": createdOn,
        "scheduled_date": scheduledDate,
        "created_by": createdBy,
      };
}
