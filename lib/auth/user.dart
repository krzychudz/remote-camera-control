import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.email, this.firstName);

  final String email;
  final String firstName;

  @override
  List<Object> get props => [email];

  static const empty = User("", "");
}
