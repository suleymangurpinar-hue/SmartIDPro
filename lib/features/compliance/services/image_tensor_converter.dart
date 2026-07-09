import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageTensorConverter {
  static Float32List imageToTensor(
    img.Image image,
  ) {
    final resized =
        img.copyResize(
      image,
      width: 640,
      height: 640,
    );

    final tensor =
        Float32List(
      1 * 3 * 640 * 640,
    );

    int index = 0;

    for (int y = 0; y < 640; y++) {
      for (int x = 0; x < 640; x++) {
        final pixel =
            resized.getPixel(x, y);

        tensor[index] =
            pixel.r / 255.0;

        tensor[index + 640 * 640] =
            pixel.g / 255.0;

        tensor[index + 2 * 640 * 640] =
            pixel.b / 255.0;

        index++;
      }
    }

    return tensor;
  }
}
