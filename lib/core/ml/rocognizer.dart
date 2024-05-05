import 'package:tflite_flutter/tflite_flutter.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  static const int WIDTH = 112;
  static const int HEIGHT = 112;

  String get modelName => "assets/mobile_face_recognition.tflite";

  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset(modelName, options: _interpreterOptions);
    } catch (e) {
      print('Failed to load model. Exception: ${e.toString()}');
    }
  }

  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null){
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
  }
}
