import 'dart:typed_data';

class RGBA32Header {
  static const int pixelLength = 4;
  static const int initialHeaderSize = 122;

  final int _width;
  final int _height;

  late Uint8List headedImage;
  late int fileLength;
  final int contentSize;

  RGBA32Header(this._width, this._height)
      : assert(_width & 3 == 0),
        contentSize = _width * _height * pixelLength {
    fileLength = contentSize + initialHeaderSize;
    headedImage = Uint8List(fileLength);
    ByteData bd = headedImage.buffer.asByteData();

    bd.setUint8(0x0, 0x42);
    bd.setUint8(0x1, 0x4d);
    bd.setInt32(0x2, fileLength, Endian.little);
    bd.setInt32(0xa, initialHeaderSize, Endian.little);
    bd.setUint32(0xe, 108, Endian.little);
    bd.setUint32(0x12, _width, Endian.little);
    bd.setUint32(0x16, -_height, Endian.little);
    bd.setUint16(0x1a, 1, Endian.little);
    bd.setUint32(0x1c, 32, Endian.little); // pixel size
    bd.setUint32(0x1e, 3, Endian.little); //BI_BITFIELDS
    bd.setUint32(0x22, contentSize, Endian.little);
    bd.setUint32(0x36, 0x000000ff, Endian.little);
    bd.setUint32(0x3a, 0x0000ff00, Endian.little);
    bd.setUint32(0x3e, 0x00ff0000, Endian.little);
    bd.setUint32(0x42, 0xff000000, Endian.little);
  }

  void appendContent(Uint8List contentIntList) {
    headedImage.setRange(
      initialHeaderSize,
      fileLength,
      contentIntList,
    );
  }
}
