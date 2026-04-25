class ContactModel {
  final String? phone;
  final String? email;
  final String? address;
  final String? telegramUrl;
  final String? viberUrl;
  final String? facebookUrl;
  final String? createdAt;
  final String? updatedAt;

  ContactModel({
    this.phone,
    this.email,
    this.address,
    this.telegramUrl,
    this.viberUrl,
    this.facebookUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      telegramUrl: json['telegram'] as String?,
      viberUrl: json['viber'] as String?,
      facebookUrl: json['facebook'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'address': address,
      'telegram': telegramUrl,
      'viber': viberUrl,
      'facebook': facebookUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
