import 'dart:async';
import 'package:login_bloc/src/bloc/validators.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

class Bloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPass = _passwordController.value;
    print('Email $validEmail');
    print('Password $validPass');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
