abstract class UserEvent {}

//Register
class RegisterUserEvent extends UserEvent {
  String name;
  String email;
  String password;
  String mobNo;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.mobNo,
  });
}

//Login
class LoginUserEvent extends UserEvent {
  String email;
  String password;

  LoginUserEvent({required this.email, required this.password});
}

