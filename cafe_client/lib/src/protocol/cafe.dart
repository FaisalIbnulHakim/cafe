/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Holds a note with a text written by the user.
class Cafe extends _i1.SerializableEntity {
  Cafe({
    this.id,
    required this.url,
    required this.name,
    required this.sub,
    required this.harga,
    required this.jenis,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The contents of the note.
  String url;

  String name;

  String sub;

  String harga;

  String jenis;

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
}
