import 'face_landmark.dart';

class FaceMeshModel {
  final List<FaceLandmark> landmarks;

  const FaceMeshModel({
    required this.landmarks,
  });

  factory FaceMeshModel.demo() {
    return FaceMeshModel(
      landmarks: const [
        FaceLandmark(
          x: 0.50,
          y: 0.42,
        ),
      ],
    );
  }
}