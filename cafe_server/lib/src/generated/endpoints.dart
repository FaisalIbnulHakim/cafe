/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/cafe_endpoint.dart' as _i2;
import '../endpoints/example_endpoint.dart' as _i3;
import 'package:cafe_server/src/generated/cafe.dart' as _i4;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'cafe': _i2.CafeEndpoint()
        ..initialize(
          server,
          'cafe',
          null,
        ),
      'example': _i3.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
    };
    connectors['cafe'] = _i1.EndpointConnector(
      name: 'cafe',
      endpoint: endpoints['cafe']!,
      methodConnectors: {
        'getAllCafe': _i1.MethodConnector(
          name: 'getAllCafe',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['cafe'] as _i2.CafeEndpoint).getAllCafe(session),
        ),
        'updateCafe': _i1.MethodConnector(
          name: 'updateCafe',
          params: {
            'cafe': _i1.ParameterDescription(
              name: 'cafe',
              type: _i1.getType<_i4.Cafe>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['cafe'] as _i2.CafeEndpoint).updateCafe(
            session,
            params['cafe'],
          ),
        ),
        'createCafe': _i1.MethodConnector(
          name: 'createCafe',
          params: {
            'cafe': _i1.ParameterDescription(
              name: 'cafe',
              type: _i1.getType<_i4.Cafe>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['cafe'] as _i2.CafeEndpoint).createCafe(
            session,
            params['cafe'],
          ),
        ),
        'deleteCafe': _i1.MethodConnector(
          name: 'deleteCafe',
          params: {
            'cafe': _i1.ParameterDescription(
              name: 'cafe',
              type: _i1.getType<_i4.Cafe>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['cafe'] as _i2.CafeEndpoint).deleteCafe(
            session,
            params['cafe'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i3.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
