import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_name_trimer.g.dart';

@riverpod
FileNameTrimer fileNameTrimer(Ref ref) {
  return FileNameTrimer();
}

class FileNameTrimer{
  Future<List<String>> convertFileNameToNameString(List listArg) async {
    List<String> strList = convertFileNameToString(listArg);
    List<String> result = [];

    for(var i = 0; i < strList.length; i++){
      result.add(
        strList[i]
          .replaceAll("File: '/storage/emulated/0/Download/", "")
          .replaceAll("Directory: '/storage/emulated/0/Download/", "")
          .replaceAll("'", "")
          .replaceAll("\\", "/")
      );
    }
    
    return result;
  }

  List<String> convertFileNameToString(List listArg){
    List<String> result = [];

    for(var i = 0; i < listArg.length; i++){
      if(listArg[i].toString().contains(".trashed-") || listArg[i].toString().contains("Nearby Share")) continue;
      result.add(listArg[i].toString());
    }

    return result;
  }

  List<String> convertFileNameToPathString(List listArg){
    List<String> strList = convertFileNameToString(listArg);
    List<String> result = [];

    for(var i = 0; i < strList.length; i++){
      result.add(
        strList[i]
          .replaceAll("File: '", "")
          .replaceAll("Directory: '", "")
          .replaceAll("'", "")
      );
    }

    return result;
  }
}
