class FileRenameException implements Exception {
  final String oldFileName;
  final String newFileName;

  FileRenameException(this.oldFileName, this.newFileName);

  @override
  String toString(){
    return "FileRenameException: Failed to rename $newFileName from $oldFileName";
  }
}
