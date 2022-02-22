// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CartEntityData extends DataClass implements Insertable<CartEntityData> {
  final int id;
  final int userId;
  final int productId;
  final int productPrice;
  final int quantity;
  final String productName;
  final String thumbnail;
  CartEntityData(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.productPrice,
      required this.quantity,
      required this.productName,
      required this.thumbnail});
  factory CartEntityData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CartEntityData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      productPrice: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_price'])!,
      quantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity'])!,
      productName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_name'])!,
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['product_id'] = Variable<int>(productId);
    map['product_price'] = Variable<int>(productPrice);
    map['quantity'] = Variable<int>(quantity);
    map['product_name'] = Variable<String>(productName);
    map['thumbnail'] = Variable<String>(thumbnail);
    return map;
  }

  CartEntityCompanion toCompanion(bool nullToAbsent) {
    return CartEntityCompanion(
      id: Value(id),
      userId: Value(userId),
      productId: Value(productId),
      productPrice: Value(productPrice),
      quantity: Value(quantity),
      productName: Value(productName),
      thumbnail: Value(thumbnail),
    );
  }

  factory CartEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CartEntityData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      productId: serializer.fromJson<int>(json['productId']),
      productPrice: serializer.fromJson<int>(json['productPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      productName: serializer.fromJson<String>(json['productName']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'productId': serializer.toJson<int>(productId),
      'productPrice': serializer.toJson<int>(productPrice),
      'quantity': serializer.toJson<int>(quantity),
      'productName': serializer.toJson<String>(productName),
      'thumbnail': serializer.toJson<String>(thumbnail),
    };
  }

  CartEntityData copyWith(
          {int? id,
          int? userId,
          int? productId,
          int? productPrice,
          int? quantity,
          String? productName,
          String? thumbnail}) =>
      CartEntityData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        productPrice: productPrice ?? this.productPrice,
        quantity: quantity ?? this.quantity,
        productName: productName ?? this.productName,
        thumbnail: thumbnail ?? this.thumbnail,
      );
  @override
  String toString() {
    return (StringBuffer('CartEntityData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('productPrice: $productPrice, ')
          ..write('quantity: $quantity, ')
          ..write('productName: $productName, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, productId, productPrice, quantity, productName, thumbnail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartEntityData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.productId == this.productId &&
          other.productPrice == this.productPrice &&
          other.quantity == this.quantity &&
          other.productName == this.productName &&
          other.thumbnail == this.thumbnail);
}

class CartEntityCompanion extends UpdateCompanion<CartEntityData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> productId;
  final Value<int> productPrice;
  final Value<int> quantity;
  final Value<String> productName;
  final Value<String> thumbnail;
  const CartEntityCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.productName = const Value.absent(),
    this.thumbnail = const Value.absent(),
  });
  CartEntityCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int productId,
    required int productPrice,
    required int quantity,
    required String productName,
    required String thumbnail,
  })  : userId = Value(userId),
        productId = Value(productId),
        productPrice = Value(productPrice),
        quantity = Value(quantity),
        productName = Value(productName),
        thumbnail = Value(thumbnail);
  static Insertable<CartEntityData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? productId,
    Expression<int>? productPrice,
    Expression<int>? quantity,
    Expression<String>? productName,
    Expression<String>? thumbnail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (productId != null) 'product_id': productId,
      if (productPrice != null) 'product_price': productPrice,
      if (quantity != null) 'quantity': quantity,
      if (productName != null) 'product_name': productName,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });
  }

  CartEntityCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int>? productId,
      Value<int>? productPrice,
      Value<int>? quantity,
      Value<String>? productName,
      Value<String>? thumbnail}) {
    return CartEntityCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productPrice.present) {
      map['product_price'] = Variable<int>(productPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartEntityCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('productId: $productId, ')
          ..write('productPrice: $productPrice, ')
          ..write('quantity: $quantity, ')
          ..write('productName: $productName, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }
}

class $CartEntityTable extends CartEntity
    with TableInfo<$CartEntityTable, CartEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartEntityTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'product_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _productPriceMeta =
      const VerificationMeta('productPrice');
  @override
  late final GeneratedColumn<int?> productPrice = GeneratedColumn<int?>(
      'product_price', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int?> quantity = GeneratedColumn<int?>(
      'quantity', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String?> productName = GeneratedColumn<String?>(
      'product_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String?> thumbnail = GeneratedColumn<String?>(
      'thumbnail', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, productId, productPrice, quantity, productName, thumbnail];
  @override
  String get aliasedName => _alias ?? 'cart_entity';
  @override
  String get actualTableName => 'cart_entity';
  @override
  VerificationContext validateIntegrity(Insertable<CartEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_price')) {
      context.handle(
          _productPriceMeta,
          productPrice.isAcceptableOrUnknown(
              data['product_price']!, _productPriceMeta));
    } else if (isInserting) {
      context.missing(_productPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CartEntityData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CartEntityTable createAlias(String alias) {
    return $CartEntityTable(attachedDatabase, alias);
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CartEntityTable cartEntity = $CartEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartEntity];
}
