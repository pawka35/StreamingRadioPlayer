// Размеры макета верстки.
import 'package:flutter/cupertino.dart';

const int kMaketWidth = 414;
const int kMaketHeight = 896;

enum Direction {
  height,
  width,
}

// Возвращает соотношения размеров макета и истиного размера экрана.
({double h, double w}) getRatioOfSizes(BuildContext context) {
  return (
    h: MediaQuery.of(context).size.height / kMaketHeight,
    w: MediaQuery.of(context).size.width / kMaketWidth,
  );
}
