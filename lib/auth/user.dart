import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.email, this.firstName, this.lastName);

  final String email;
  final String firstName;
  final String lastName;

  @override
  List<Object> get props => [email];

  static const empty = User("", "", "");
}
