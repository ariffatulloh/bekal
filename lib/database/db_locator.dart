import 'package:bekal/database/db.dart';
import 'package:get_it/get_it.dart';

GetIt dbInstance = GetIt.instance;

Future setupLocator() async {
  dbInstance.registerSingleton(AppDB());
}
