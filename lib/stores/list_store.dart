import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store{
  
  //observables sao core state
  @observable
  String newTodoTitle ="";

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  //computeds sao derivaded states
  @computed 
  bool get isFormValid  => newTodoTitle.isNotEmpty;

  //o observable n vai funcionar com listas pq ele procura sempre por um objeto novo, e no caso da lista o obj eh o mesmo,
  //so que adiciona ou remove itens, entao n esta modificando o estado dele
  // @observable
  // List<String> todoList = List();
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();// essa lista eh INTERNAMENTE observavel

  @action
  void addTodo(){ //acao para quando tocar no botao e ele vai pegar o que ja tem no input e adicionar na lista
    todoList.insert(0,new TodoStore(newTodoTitle));
    newTodoTitle=""; //pra que o icone de add suma depois 
  }
}