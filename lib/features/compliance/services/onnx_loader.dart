import 'dart:io';

import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';
import 'package:path_provider/path_provider.dart';

class OnnxLoader {
  static OrtSession? _session;

  static Future<OrtSession> session() async {
    if (_session != null) {
      return _session!;
    }

    OrtEnv.instance.init();

    final modelBytes = await rootBundle.load('assets/models/det_500m.onnx');

    final appDir = await getApplicationSupportDirectory();

    final modelFile = File('${appDir.path}/det_500m.onnx');

    await modelFile.writeAsBytes(modelBytes.buffer.asUint8List(), flush: true);

    final options = OrtSessionOptions();

    _session = OrtSession.fromFile(modelFile, options);

    return _session!;
  }
}
