/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:cafe_client/src/protocol/cafe.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointCafe extends _i1.EndpointRef {
  _EndpointCafe(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'cafe';

  _i2.Future<List<_i3.Cafe>> getAllCafe() =>
      caller.callServerEndpoint<List<_i3.Cafe>>(
        'cafe',
        'getAllCafe',
        {},
      );

  _i2.Future<void> updateCafe(_i3.Cafe cafe) => caller.callServerEndpoint<void>(
        'cafe',
        'updateCafe',
        {'cafe': cafe},
      );

  _i2.Future<void> createCafe(_i3.Cafe cafe) => caller.callServerEndpoint<void>(
        'cafe',
        'createCafe',
        {'cafe': cafe},
      );

  _i2.Future<void> deleteCafe(_i3.Cafe cafe) => caller.callServerEndpoint<void>(
        'cafe',
        'deleteCafe',
        {'cafe': cafe},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    cafe = _EndpointCafe(this);
    example = _EndpointExample(this);
  }

  late final _EndpointCafe cafe;

  late final _EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'cafe': cafe,
        'example': example,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
