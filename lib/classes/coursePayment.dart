class Courses {
  Courses(
      {required this.city,
      required this.country,
      required this.coursesPaymentsDate,
      required this.email,
      required this.firstname,
      required this.lastname});

  Courses.fromJson(Map<String, Object?> json)
      : this(
          city: json['city']! as String,
          country: json['country']! as String,
          coursesPaymentsDate: json['coursesPaymentsDate']! as Map,
          email: json['email']! as String,
          firstname: json['firstname']! as String,
          lastname: json['lastname']! as String,
        );

  final String city;
  final String country;
  final Map coursesPaymentsDate;
  final String email;
  final String firstname;
  final String lastname;

  Map<String, Object?> toJson() {
    return {
      'city': city,
      'coursesPaymentsDate': coursesPaymentsDate,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}
