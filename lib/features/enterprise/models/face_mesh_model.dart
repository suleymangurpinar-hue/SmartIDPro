import 'face_landmark.dart';

class FaceMeshModel {
  final List<FaceLandmark> landmarks;

  const FaceMeshModel({required this.landmarks});

  factory FaceMeshModel.demo() {
    return FaceMeshModel(
      landmarks: List.generate(180, (i) {
        final row = i ~/ 15;
        final col = i % 15;

        return FaceLandmark(x: 0.35 + (col * 0.02), y: 0.20 + (row * 0.03));
      }),
    );
  }
}
