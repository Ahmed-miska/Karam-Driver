class ContactUsRequestModel {
  final String mobile;
  final String subject;
  final String message;

  ContactUsRequestModel({required this.mobile, required this.subject, required this.message});

  Map<String, dynamic> toJson() {
    return {
      "contact_mobile": mobile,
      "contact_subject": subject,
      "contact_message": message,
    };
  }
}
