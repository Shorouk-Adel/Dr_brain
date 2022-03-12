class PatientModel {
  int id;
  String full_name;
  String email;
  String phone;
  String location;
  String avatar;
  PatientModel(
      this.id,
      this.full_name,
      this.email,
      this.phone,
      this.location,
      this.avatar,
      );

  late PatientModel _patientModel ;
}
