import 'package:mobx/mobx.dart';

// Include generated file
part 'base_store.g.dart';

// This is the class used by rest of your codebase
class BaseStore = _BaseStore with _$BaseStore;

// The store-class
abstract class _BaseStore with Store {
  @observable
  bool blue = true;

  @action
  void toggleBlue() {
    blue = !blue;
  }
}

// flutter packages pub run build_runner build <- generate <name>.g.dart
// flutter packages pub run build_runner watch <- keep watching
