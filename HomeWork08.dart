void main() {
  Cuboid cuboid = Cuboid(3, 2, 4);
}

class Cuboid {
  final int length;
  final int width;
  final int height;

  Cuboid(this.length, this.width, this.height);

  int get surfaceArea {
    return 2 * (length * width + width * height + length * height);
  }

  int get volume {
    return length * width * height;
  }
}
