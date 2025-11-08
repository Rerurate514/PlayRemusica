class GetDownloadDirectoryException implements Exception {
  @override
  String toString(){
    return "GetDownloadDirectoryException: Failed to get download directory";
  }
}
