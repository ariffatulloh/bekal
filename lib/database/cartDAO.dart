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
  SingleSelectable<CartEntityData> getDataProductId(int id) {
    return select(cartEntity)..where((data) => data.productId.equals(id));
  }

  @override
  Future<CartEntityData?> getDataByProductName(String name) {
    return (select(cartEntity)..where((data) => data.productName.equals(name)))
        .getSingleOrNull();
  }

  @override
  Future<List<CartEntityData>> getData() {
    return select(cartEntity).get();
  }

  @override
  Stream<List<CartEntityData>> watchData() {
    return select(cartEntity).watch();
  }
}

abstract class ICart {
  Future<CartEntityData?> getDataByProductName(String name);
  SingleSelectable<CartEntityData> getDataById(int id);
  SingleSelectable<CartEntityData> getDataProductId(int id);
  Future<int> insertData(CartEntityData cartEntity);
  Future<bool> updateData(CartEntityData cartEntity);
  Future<void> deleteData(CartEntityData cartEntity);
  Future<void> deleteDataById(int id);
  Future<List<CartEntityData>> getData();
  Stream<List<CartEntityData>> watchData();
}
