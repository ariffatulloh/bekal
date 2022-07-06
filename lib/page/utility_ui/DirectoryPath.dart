import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DirectoryPath {
  DirectoryPath();
  // String parentPath = "storage/emulated/0/BEKALKU";

  String documentPath = "storage/emulated/0/BEKALKU/documents";
  Future<String> saveDoc({required List<int> documents}) async {
    String parentPath = "";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk_mm_ss').format(now);
    String fileName = 'reporting_$formattedDate.xlsx';
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
        final Directory directory =
            await path_provider.getApplicationSupportDirectory();
        parentPath = directory.path;
        final File file = File('$parentPath/$fileName');
        return file.writeAsBytes(documents, flush: true).then((value) {
          return value.path;
        });

        // Uint8List data = Uint8List.fromList(documents);
        // MimeType type = MimeType.MICROSOFTEXCEL;
        // String path =
        //     await FileSaver.instance.saveAs(fileName, data, "custome123", type);
        // print(path);
        // return path;
      }
    }
    return "";
    // if (Platform.isAndroid) {
    //   var parentPath = await getParentPath();
    //   var documentPath = await getDocumentPath();
    //   if (parentPath.existsSync()) {
    //     print("parent Directory hasbeen created");
    //   }
    //   if (documentPath.existsSync()) {
    //     print("Document Directory hasbeen created");
    //     DateTime now = DateTime.now();
    //     String formattedDate = DateFormat('yyyy-MM-dd kk_mm_ss').format(now);
    //     String fileName = '${documentPath.path}/reporting_$formattedDate.xlsx';
    //     await File(fileName)
    //       ..createSync(recursive: true)
    //       ..writeAsBytes(documents);
    //     return fileName;
    //
    //     // var file = await createFile;
    //     // file.exists()
    //     // print(await file.exists());
    //     // await file.create(recursive: true);
    //     // if (!file.existsSync()) {
    //     //   print("fileName hasbeen created");
    //     // }
    //     // await file.create().then((value) => print(value)).catchError((onError) {
    //     //   print(onError);
    //     // });
    //   }
    //   return "";
    // } else {
    //   var documentPath = await getApplicationSupportDirectory();
    //   if (documentPath.existsSync()) {
    //     print("Document Directory hasbeen created");
    //     DateTime now = DateTime.now();
    //     String formattedDate = DateFormat('yyyy-MM-dd kk_mm_ss').format(now);
    //     String fileName = '${documentPath.path}/reporting_$formattedDate.xlsx';
    //     await File(fileName)
    //       ..createSync(recursive: true)
    //       ..writeAsBytes(documents);
    //     return fileName;
    //   } else {
    //     print('failed Exist');
    //     return "";
    //   }
    // }
  }

  Future<Directory> getDocumentPath() async {
    final dirDocument = Directory("$documentPath");
    if (!(await dirDocument.exists())) {
      // TODO:
      // print("exist");
      await dirDocument.create(recursive: true);
    }
    return dirDocument;
  }

//   Future<Directory> getParentPath() async {
//     // Directory? path = await getExternalStorageDirectory();
// // path?.parent;
//     // await getExternalStorageDirectory().then((value) {
//     //   path = value!;
//     // }).catchError((onError) {});
//     // var newDir = Directory('${path?.parent.parent.parent.parent.+"/"}/bekal');
//     // print(newDir);
//     // String newPath = "";
//     // // print(newDir.existsSync());
//     // if ((await newDir.exists())) {
//     //   // TODO:
//     //   // print("exist");
//     //
//     // } else {
//     //   // TODO:
//     //   // print("not exist");
//     //   await newDir.create().then((value) => print(value)).catchError((onError) {
//     //     print(onError);
//     //   });
//     // }
//     // await getExternalStorageDirectories(
//     //     type: StorageDirectory.documents)
//     //     .then((value) => print(value));
//     // var path = (await getApplicationDocumentsDirectory()).path;
//     // print(await path.exists());
//     // String fileName = '$path/out.xlsx';
//     // var file = File(fileName);
//     // // var file = await createFile;
//     // // file.exists()
//     // // print(await file.exists());
//     // await file
//     //     .create()
//     //     .then((value) => print(value))
//     //     .catchError((onError) {
//     //   print(onError);
//     // });
//     // var x = await file
//     //   ..create(recursive: true)
//     //   ..writeAsBytes(ex);
//
//     // final pathParent = Directory("$parentPath");
//     // if (!(await pathParent.exists())) {
//     //   // TODO:
//     //   // print("exist");
//     //   await pathParent.create(recursive: true);
//     // }
//     // return pathParent;
//     // return Directory('../$path');
//     // ;
//   }

  // => '${await getExternalStorageDirectory()
  // })!.path}';
  // static String get getPathDocuments => '$getParentPath/documents';
  // static String get getPathGalery => '$getParentPath/gallerys';
}
