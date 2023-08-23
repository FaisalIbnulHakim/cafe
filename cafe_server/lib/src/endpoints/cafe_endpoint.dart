import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class CafeEndpoint extends Endpoint {
  Future<List<Cafe>> getAllCafe(Session session) async {
    // By ordering by the id column, we always get the notes in the same order
    // and not in the order they were updated.
    return await Cafe.find(
      session,
      orderBy: Cafe.t.id,
    );
  }

  Future<void> updateCafe(Session session, Cafe cafe) async {
    await Cafe.update(session, cafe);
  }

  Future<void> createCafe(Session session, Cafe cafe) async {
    await Cafe.insert(session, cafe);
  }

  Future<void> deleteCafe(Session session, Cafe cafe) async {
    await Cafe.deleteRow(session, cafe);
  }
}
