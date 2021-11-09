import 'dart:typed_data';
import 'dart:ui';

import 'package:craft_cuts_mobile/haircut_demo/exceptions/decode_image_failed_exception.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<List<Face>> findFaceCoordinates(Uint8List imageBytes) async {
    final inputImage = _inputImageFromBytes(imageBytes);
    final faceDetectorOptions = FaceDetectorOptions(
      mode: FaceDetectorMode.fast,
      enableTracking: true,
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
    );
    final faceDetector = GoogleMlKit.vision.faceDetector(faceDetectorOptions);
    final faceList = await faceDetector.processImage(inputImage);
    return faceList;
  }

  static InputImage _inputImageFromBytes(Uint8List bytes) {
    final decoder = img.findDecoderForData(bytes);
    final image = decoder?.decodeImage(bytes);

    if (image == null) throw DecodeImageFailedException();

    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    const imageRotation = InputImageRotation.Rotation_0deg;
    const inputImageFormat = InputImageFormat.BGRA8888;
    final planeData = <InputImagePlaneMetadata>[];
    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );
    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    return inputImage;
  }
}
