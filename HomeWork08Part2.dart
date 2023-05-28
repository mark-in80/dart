import 'dart:math';

void main() {
  Cuboid cuboid = Cuboid(1, 2, 3);
  Cube cube = Cube(2);
  print("Cuboid Surface Area  = ${cuboid.surfaceArea}");
  print("Cuboid Volume = ${cuboid.volume}");
  print("Cube Volume = ${cube.volume}");
  print("Cube Surface Area = ${cube.surfaceArea}");
}

class Cuboid {
  final int length;
  final int width;
  final int height;

  Cuboid(this.width, this.length, this.height);

  int get surfaceArea {
    int surfaceArea = 2 * (length * width + width * height + length * height);
    return surfaceArea;
  }

  int get volume {
    int volumeCuboidCube = length * width * height;
    return volumeCuboidCube;
  }
}

class Cube extends Cuboid {
  Cube(int length) : super(length, length, length);
}
