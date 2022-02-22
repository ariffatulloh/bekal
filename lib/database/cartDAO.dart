import 'package:bekal/database/cart.dart';
import 'package:bekal/database/db.dart';
import 'package:moor/moor.dart';

part 'cartDAO.g.dart';

@UseDao(tables: [CartEntity])
class CartDAO extends DatabaseAccessor<AppDB>
    with _$CartDAOMixin
    implements ICart {
  CartDAO(AppDB db) : super(db);

  @override
  Future<int> insertData(CartEntityData data) {
    return into(cartEntity).insert(data);
  }

  @override
  Future<void> deleteData(CartEntityData data) async {
    return await deleteDataById(data.id);
  }

  @override
  Future<bool> updateData(CartEntityData data) async {
    return await update(cartEntity).replace(data);
  }

  @override
  Future<void> deleteDataById(int id) {
    return (delete(cartEntity)..where((data) => data.id.equals(id))).go();
  }

  @override
  SingleSelectable<CartEntityData> getDataById(int id) {
    return select(cartEntity)..where((data) => data.id.equals(id));
  }

  @override
  Stream<List<CartEntityData>> getData() {
    return select(cartEntity).watch();
  }
}

abstract class ICart {
  SingleSelectable<CartEntityData> getDataById(int id);
  Future<int> insertData(CartEntityData cartEntity);
  Future<bool> updateData(CartEntityData cartEntity);
  Future<void> deleteData(CartEntityData cartEntity);
  Future<void> deleteDataById(int id);
  Stream<List<CartEntityData>> getData();
}
