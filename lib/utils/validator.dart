import 'dart:async';

import 'package:flutter/material.dart';

class Validator {
  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.contains('@')) {
      sink.add(value);
    } else {
      sink.addError("This is not valid email");
    }
  });

  final customerrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
  );

  final validateName =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.contains(' ')) {
      sink.add(value);
    } else {
      sink.addError("Name must be two words");
    }
  });

  final validateTitle =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (!value.contains(' ') && value.isNotEmpty) {
      sink.add(value);
    } else {
      sink.addError("title must be one word");
    }
  });

  final validatePassword =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length > 4) {
      sink.add(value);
    } else {
      sink.addError("password must be more than 5");
    }
  });
}