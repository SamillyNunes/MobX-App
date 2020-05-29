import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  _LoginStore(){
    autorun( //eh um tipo de reacao que eh chamada sempre que algum observable tem um dado lido ou modificado dentro dela
      (_){
        print("Email: "+email); //ja vai printar o primeiro valor que observar, q no caso eh o vazio
        print(password);
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
}
