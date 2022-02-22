import 'package:moor/moor.dart';

class CartEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  IntColumn get productId => integer()();
  IntColumn get productPrice => integer()();
  IntColumn get quantity => integer()();
  TextColumn get productName => text()();
  TextColumn get thumbnail => text()();
}
