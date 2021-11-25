// import 'dart:async';
// import 'dart:isolate';
// import 'dart:typed_data';
//
// import 'package:craft_cuts_mobile/haircut_demo/data/models/model_photo_model.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
//
// import 'image_utils.dart';
//
// class HaircutTryOnWorker {
//   final XFile modelFile;
//   final Uint8List? haircutBytes;
//
//   bool _isStarted = false;
//   Isolate? _isolate;
//   Completer<ModelPhotoModel?> _result = Completer();
//   late ReceivePort _resultReceivePort;
//   late ReceivePort _errorReceivePort;
//
//   HaircutTryOnWorker(this.modelFile, this.haircutBytes);
//
//   Future<ModelPhotoModel?> run() async {
//     if (_isStarted) return _result.future;
//
//     _isStarted = true;
//     _initializePorts();
//     _isolate = await Isolate.spawn(
//       _isolateEntryPoint,
//       _WorkerMessageData(modelFile, haircutBytes, _resultReceivePort.sendPort),
//       onError: _errorReceivePort.sendPort,
//       debugName: '${hashCode}@isolate',
//     );
//     return _result.future;
//   }
//
//   void _initializePorts() {
//     _resultReceivePort = ReceivePort('${hashCode}@resultPort');
//     _errorReceivePort = ReceivePort('${hashCode}@errorPort');
//
//     _resultReceivePort.listen(_resultPortListener);
//     _errorReceivePort.listen(_errorPortListener);
//   }
//
//   void _resultPortListener(dynamic message) {
//     if (message is ModelPhotoModel?) {
//       _result.complete(message);
//     }
//     _dispose();
//   }
//
//   void _errorPortListener(dynamic message) {
//     _dispose();
//     _result.completeError(message);
//   }
//
//   void kill() {
//     _dispose();
//     _result.complete(null);
//   }
//
//   void _dispose() {
//     _resultReceivePort.close();
//     _errorReceivePort.close();
//     _isolate?.kill();
//   }
//
//   @override
//   int get hashCode => [modelFile, haircutBytes].hashCode;
//
//   static Future<void> _isolateEntryPoint(_WorkerMessageData message) async {
//     final faceCoordinates =
//         await ImageUtils.findFaceCoordinates(message.modelFile);
//     img.Image modelImage = await ImageUtils.imageFromXFile(message.modelFile);
//
//     if (message.haircutBytes == null) {
//       message.sendPort.send(ModelPhotoModel(
//           image: modelImage, faceCount: faceCoordinates.length));
//       return;
//     }
//
//     final haircutImage = ImageUtils.imageFromBytes(message.haircutBytes!);
//
//     for (final face in faceCoordinates) {
//       modelImage = ImageUtils.putPictureOverPicture(
//           modelImage, haircutImage, face.boundingBox);
//     }
//     message.sendPort.send(
//         ModelPhotoModel(image: modelImage, faceCount: faceCoordinates.length));
//   }
// }
//
// class _WorkerMessageData {
//   final XFile modelFile;
//   final Uint8List? haircutBytes;
//   final SendPort sendPort;
//
//   _WorkerMessageData(this.modelFile, this.haircutBytes, this.sendPort);
// }
