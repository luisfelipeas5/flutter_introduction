import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension BuildContextExtensions on BuildContext {
  T read<T extends Object>() {
    if (T is StateStreamableSource<Object?>) {
      return BlocProvider.of(this);
    }
    return Modular.get<T>();
  }
}
