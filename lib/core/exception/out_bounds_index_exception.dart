class OutBoundsIndexException implements Exception {
  final int index;
  final int listLen;

  OutBoundsIndexException(this.index, this.listLen);

  @override
  String toString() {
    return "OutBoundsIndexException: Faied to set $index, settable value is 0 < index < $listLen";
  }
}
