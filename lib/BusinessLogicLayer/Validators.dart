import 'dart:async';

mixin Validators {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, sink) {
    if (email.contains("@") &&
        email.length > 0 &&
        (email.endsWith(".com") || email.endsWith(".net"))) {
      sink.add(email);
    } else {
      sink.addError("Please Enter a valid Mail!!");
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 0) {
      sink.add(password);
    } else {
      sink.addError("Short Password !");
    }
  });
  final nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 0) {
      sink.add(name);
    } else {
      sink.addError("Enter a Valid Name!");
    }
  });
}
