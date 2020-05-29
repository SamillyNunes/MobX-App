import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  _LoginStore(){
    autorun( //eh um tipo de reacao que eh chamada sempre que algum observable tem um dado lido ou modificado dentro dela
      (_){
        // print("Email: "+email); //ja vai printar o primeiro valor que observar, q no caso eh o vazio
        // print(password);

        print(isFormValid);
      }
    );
  }

  @observable
  String email="";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  //usado para combinar alguns observables. AO utiliza-lo, sempre tem que declarar um getter
  //eh basicamente uma operacao com observables e retornando um novo valor
  // @computed 
  // bool get isFormValid => email.length>6 && password.length>6;

  @computed
  bool get isEmailValid => 
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  @computed
  bool get isPasswordValid => password.length>=6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;
}
