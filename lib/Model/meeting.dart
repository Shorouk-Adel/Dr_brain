class MeetingModel {
  int? id;
  String? meetingId;
  String? meetingName;
  String? meetingDescription;
  String? meetingDate;
  String? meetingTime;
  String? meetingDateTime;
  String? meetingLink;
  String? doctorEmail;
  String? patientEmail;
  String? doctorId;
  String? patientId;


  MeetingModel(
      {this.id,
      this.meetingId,
      this.meetingName,
      this.meetingDescription,
      this.meetingDate,
      this.meetingTime,
      this.meetingDateTime,
      this.meetingLink,
      this.doctorEmail,
      this.patientEmail,
      this.doctorId,
      this.patientId,
});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    meetingName = json['meeting_name'];
    meetingDescription = json['meeting_description'];
    meetingDate = json['meeting_date'];
    meetingTime = json['meeting_time'];
    meetingDateTime = json['meeting_date_time'];
    meetingLink = json['meeting_link'];
    doctorEmail = json['doctor_email'];
    patientEmail = json['patient_email'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meeting_id'] = this.meetingId;
    data['meeting_name'] = this.meetingName;
    data['meeting_description'] = this.meetingDescription;
    data['meeting_date'] = this.meetingDate;
    data['meeting_time'] = this.meetingTime;
    data['meeting_date_time'] = this.meetingDateTime;
    data['meeting_link'] = this.meetingLink;
    data['doctor_email'] = this.doctorEmail;
    data['patient_email'] = this.patientEmail;
    data['doctor_id'] = this.doctorId;
    data['patient_id'] = this.patientId;
    return data;
  }
}
