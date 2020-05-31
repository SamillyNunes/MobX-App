import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginStore loginStore = LoginStore(); 

  ReactionDisposer disposer; //usado pra finalizar quando n tiver rodando mais, pra q n fique rodando infinitamente sse monitoramento

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // autorun(
    //   (_){
    //     if(loginStore.loggedIn){
    //       Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (_)=>ListScreen())
    //       );
    //     }
    //   }
    // );

    // na reaction tem-se q informar 2 funcoes: a primeira q sera utilziada pra monitorar algum valor, a 2a o efeito
    // que ela causa, e ela recebe o valor q foi modificado/monitorado
    // Uma de suas DIFERENCAS PARA O AUTORUN eh que ela nao vai executar uma 1a vez automaticamente, ela vai esperar que haja
    // uma troca
    disposer = reaction(
      (_) => loginStore.loggedIn ,
      (loggedIn){
        if(loggedIn){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_)=>ListScreen())
          );
        }
      }
    );
  }

  @override
  void dispose() {
    disposer(); //pra que n fique mais rodando a reacao e n consuma recursos de forma desnecessaria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(
                      builder: (_){
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                          enabled: loginStore.loading ? false : true, //bloquear o campo enquanto estiver processando o login
                        );
                      }
                    ),
                    const SizedBox(height: 16,),
                    Observer(
                      builder: (_){
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: loginStore.showPass ? false : true,
                          onChanged: loginStore.setPassword,
                          enabled: loginStore.loading ? false : true, //bloquear o campo enquanto estiver processando o login
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: loginStore.showPass ? Icons.visibility_off : Icons.visibility,
                            onTap: loginStore.setShowPass,
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 16,),
                    Observer( //para ficar observando por mudandas no computed dentro e assim refazer o botao
                      builder: (_){
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: loginStore.loading ? 
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white ),
                                ) : Text('Login'),
                            color: Theme.of(context).primaryColor,
                            disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            onPressed: loginStore.loginPressed,//retorna nulo para on pressed pq ai desativara o botao (ele ficara clarinho)
                          ),
                        );
                      }
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
