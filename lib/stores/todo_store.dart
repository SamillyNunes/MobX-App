import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {

  _TodoStore(this.title);

  final String title; //nesse caso n precisa modificar. final pra garantir isso
  
  @observable
  bool done = false;

  @action
  void toggleDone() => done=!done;
  
}