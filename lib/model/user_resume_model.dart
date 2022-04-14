class UserResumeModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? zipCode;
  String? image;
  Education? listEducation;
  Skill? skill;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "address": address,
        "city": city,
        "zipCode": zipCode,
        "image": image,
        "education": listEducation,
        "skill": skill,
      };

  UserResumeModel(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.address,
      this.city,
      this.zipCode,
      this.image,
      this.listEducation,
      this.skill});
}

class Education {
  Education({this.institute, this.date, this.degree});

  String? institute;
  DateTime? date;
  String? degree;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        institute: json["institute"],
        date: json["date"],
        degree: json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "institute": institute,
        "date": date,
        "degree": degree,
      };
}

class Skill {
  Skill({
    this.skill,
    this.level,
  });

  String? skill;

  String? level;

  factory Skill.fromJson(Map<String, dynamic> json) =>
      Skill(skill: json["skill"], level: json["level"]);

  Map<String, dynamic> toJson() => {"skill": skill, "level": level};
}
