import 'package:google_ml_kit/google_ml_kit.dart';
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
}
