class PatientModel {
  String? patientId;
  String? fullName;
  String? firstName;
  String? phone;
  String? dateOfBirth;
  String? address;
  String? height;
  String? weight;
  String? gender;
  String? slotValue;
  String? status;
  DateTime? scheduledDate;

  PatientModel({
    this.patientId,
    this.fullName,
    this.firstName,
    this.phone,
    this.dateOfBirth,
    this.address,
    this.height,
    this.weight,
    this.gender,
    this.slotValue,
    this.status,
    this.scheduledDate,
  });
  factory PatientModel.fromJson(Map<dynamic, dynamic> json) => PatientModel(
        patientId: json["patient_id"] ?? '',
        fullName: json["full_name"] ?? '',
        firstName: json["first_name"] ?? '',
        phone: json["phone"] ?? '',
        dateOfBirth: json["date_of_birth"] ?? '',
        address: json["address"] ?? '',
        height: json["height"] ?? '',
        weight: json["weight"] ?? '',
        gender: json["gender"] ?? '',
        slotValue: json["slot_value"] ?? '',
        status: json["status"] ?? '',
        scheduledDate: json["scheduled_date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName ?? '',
        "phone": phone ?? '',
        "gender": gender ?? '',
      };
}
