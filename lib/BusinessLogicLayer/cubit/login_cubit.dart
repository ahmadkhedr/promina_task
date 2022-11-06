import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pro_mina_task/BusinessLogicLayer/Validators.dart';
import 'package:pro_mina_task/DataLayer/Repositories/LoginRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../../DataLayer/Models/OnLineModels/LoginModel.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with Validators {
  LoginCubit() : super(LoginInitial());

  final _mailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _mailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get mailStream =>
      _mailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get activateButton =>
      Rx.combineLatest2(_mailController, _passwordController, (e, p) => true);

  LoginModel? loginModel;
  final loginRepository = LoginRepository();

  startLoginRequest() async {
    emit(LoginLoading());

    loginModel = await loginRepository.userLoginRequest(
        _mailController.value, _passwordController.value);

    loginModel!.user != null
        ? emit(LoginLoaded(loginModel!))
        : emit(LoginFailed());
    //  emit(LoginFailed());
  }
}
