
class UserDetails {
  late String firstName;
  late String lastName;
  late String country;
  late String city;
  late String email;
  late Map map;

  UserDetails({
    required this.city,
    required this.country,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.map
  });
  Map<String, dynamic> toJson() => {
        'first name': firstName,
        'last name': lastName,
        'country': country,
        'city': city,
        'email': email,
        

      };
  static UserDetails fromJson(Map<String, dynamic> json) => UserDetails(
      email: json['email'],
      firstName: json['first name'],
      lastName: json['last name'],
      city: json['city'],
      country: json['country'],
      map:json['']);
}
