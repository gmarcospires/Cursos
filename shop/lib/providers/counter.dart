import 'package:flutter/widgets.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old._value != value;
  }
}

class CounterProvider extends InheritedWidget {
  //Valor para este estado
  final CounterState state = CounterState();

  CounterProvider({required super.child, super.key});

//Método para .of(context)
  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

//Notifica quando há mudança de estado
  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
