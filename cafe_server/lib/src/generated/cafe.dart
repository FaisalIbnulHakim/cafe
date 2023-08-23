/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// Holds a note with a text written by the user.
class Cafe extends _i1.TableRow {
  Cafe({
    int? id,
    required this.url,
    required this.name,
    required this.sub,
    required this.harga,
    required this.jenis,
  }) : super(id);

  factory Cafe.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Cafe(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      url: serializationManager.deserialize<String>(jsonSerialization['url']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      sub: serializationManager.deserialize<String>(jsonSerialization['sub']),
      harga:
          serializationManager.deserialize<String>(jsonSerialization['harga']),
      jenis:
          serializationManager.deserialize<String>(jsonSerialization['jenis']),
    );
  }

  static final t = CafeTable();

  /// The contents of the note.
  String url;

  String name;

  String sub;

  String harga;

  String jenis;

  @override
  String get tableName => 'cafe';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'sub': sub,
      'harga': harga,
      'jenis': jenis,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'sub': sub,
      'harga': harga,
      'jenis': jenis,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'sub': sub,
      'harga': harga,
      'jenis': jenis,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'url':
        url = value;
        return;
      case 'name':
        name = value;
        return;
      case 'sub':
        sub = value;
        return;
      case 'harga':
        harga = value;
        return;
      case 'jenis':
        jenis = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Cafe>> find(
    _i1.Session session, {
    CafeExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Cafe>(
      where: where != null ? where(Cafe.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Cafe?> findSingleRow(
    _i1.Session session, {
    CafeExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Cafe>(
      where: where != null ? where(Cafe.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Cafe?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Cafe>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required CafeExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Cafe>(
      where: where(Cafe.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Cafe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Cafe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Cafe row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    CafeExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Cafe>(
      where: where != null ? where(Cafe.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef CafeExpressionBuilder = _i1.Expression Function(CafeTable);

class CafeTable extends _i1.Table {
  CafeTable() : super(tableName: 'cafe');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  /// The contents of the note.
  final url = _i1.ColumnString('url');

  final name = _i1.ColumnString('name');

  final sub = _i1.ColumnString('sub');

  final harga = _i1.ColumnString('harga');

  final jenis = _i1.ColumnString('jenis');

  @override
  List<_i1.Column> get columns => [
        id,
        url,
        name,
        sub,
        harga,
        jenis,
      ];
}

@Deprecated('Use CafeTable.t instead.')
CafeTable tCafe = CafeTable();
