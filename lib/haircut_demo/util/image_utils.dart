import 'dart:typed_data';
import 'dart:ui';

import 'package:craft_cuts_mobile/haircut_demo/exceptions/decode_image_failed_exception.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<List<Face>> findFaceCoordinates(XFile imageFile) async {
    final faceDetectorOptions = FaceDetectorOptions(
      mode: FaceDetectorMode.fast,
      enableTracking: true,
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
    );
    final image = InputImage.fromFilePath(imageFile.path);
    final faceDetector = GoogleMlKit.vision.faceDetector(faceDetectorOptions);
    final faceList = await faceDetector.processImage(image);
    return faceList;
  }

  static Future<img.Image> imageFromXFile(XFile xFile) async {
    final photoBytes = await xFile.readAsBytes();
    return imageFromBytes(photoBytes);
  }

  static img.Image putPictureOverPicture(
    img.Image dst,
    img.Image src,
    Rect rectangle,
  ) {
    return img.drawImage(
      dst,
      src,
      dstX: rectangle.topLeft.dx.toInt(),
      dstY: rectangle.topRight.dy.toInt(),
      dstW: rectangle.width.toInt(),
      dstH: rectangle.height.toInt(),
    );
  }

  static img.Image imageFromBytes(Uint8List bytes) {
    final decoder = img.findDecoderForData(bytes);

    if (decoder == null) {
      throw DecodeImageFailedException();
    }

    final image = decoder.decodeImage(bytes);

    if (image == null) {
      throw DecodeImageFailedException();
    }

    return image;
  }
}
