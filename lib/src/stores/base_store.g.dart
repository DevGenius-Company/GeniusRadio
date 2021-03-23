// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaseStore on _BaseStore, Store {
  final _$blueAtom = Atom(name: '_BaseStore.blue');

  @override
  bool get blue {
    _$blueAtom.reportRead();
    return super.blue;
  }

  @override
  set blue(bool value) {
    _$blueAtom.reportWrite(value, super.blue, () {
      super.blue = value;
    });
  }

  final _$_BaseStoreActionController = ActionController(name: '_BaseStore');

  @override
  void toggleBlue() {
    final _$actionInfo =
        _$_BaseStoreActionController.startAction(name: '_BaseStore.toggleBlue');
    try {
      return super.toggleBlue();
    } finally {
      _$_BaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
blue: ${blue}
    ''';
  }
}
