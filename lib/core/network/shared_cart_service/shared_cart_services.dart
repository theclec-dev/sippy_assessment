import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sippy_assessment/features/cart/domain/entities/cart_item.dart';

class SharedCartServices {
  // Singleton pattern
  static final SharedCartServices _instance = SharedCartServices._internal();
  factory SharedCartServices() => _instance;
  SharedCartServices._internal();

  // Firestore instance
  final _db = FirebaseFirestore.instance;

  Future<String> createSession(String uid, String name) async {
    final sessionRef = _db.collection('sessions').doc();
    await sessionRef.set({
      'creatorId': uid,
      'creatorName': name,
      'participantNames': [name],
      'participantUids': [uid],
      'participants': [
        {'uid': uid, 'name': name}
      ],
      'createdAt': Timestamp.now(),
    });
    return sessionRef.id; // Return the session ID
  }

  Future<String> joinSession(String sessionId, String uid, String name) async {
    final sessionDoc = _db.doc('sessions/$sessionId');
    // final sessionRef = _db.collection('sessions').doc(sessionId);
    await sessionDoc.update({
      'participants': FieldValue.arrayUnion([
        {'uid': uid, 'name': name},
      ]),
      'participantNames': FieldValue.arrayUnion([name]),
      'participantUids': FieldValue.arrayUnion([uid]),
    });
    final creator =
        await sessionDoc.get().then((doc) => doc['creatorName']) as String;
    return creator;
  }

  Stream<List<CartItem>> getCartItems(String sessionId) {
    return _db
        .collection('sessions/$sessionId/items')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CartItem.fromSnapshot(doc)).toList());
  }

  Future<void> checkout(String sessionId, String userName, String uid) async {
    final sessionDoc = _db.doc('sessions/$sessionId');
    await sessionDoc.update({
      'participants': FieldValue.arrayRemove([
        {'uid': uid, 'name': userName}
      ]),
      'participantNames': FieldValue.arrayRemove([userName]),
      'participantUids': FieldValue.arrayRemove([uid]),
    });
  }

  Future<void> addItem(
      {required String sessionId,
      required String itemName,
      required int quantity,
      required String userId,
      required String userName,
      required int inStock,
      required int itemId,
      required num itemPrice,
      required String itemImageUrl,
      required String description}) async {
    await _db.collection('sessions/$sessionId/items').add({
      'name': itemName,
      'quantity': quantity,
      'addedBy': userId,
      'addedByName': userName,
      'lastModifiedBy': userId,
      'timestamp': Timestamp.now(),
      'inStock': inStock,
      'itemId': itemId,
      'price': itemPrice,
      'imageUrl': itemImageUrl,
      'description': description,
    });
  }

  Future<void> deleteItem(String sessionId, String itemId) async {
    await _db.doc('sessions/$sessionId/items/$itemId').delete();
  }

  Future<void> updateQuantity(
      {required String sessionId,
      required String itemId,
      required int quantity,
      required String userId}) async {
    final docRef = _db.doc('sessions/$sessionId/items/$itemId');

    await docRef.update({
      'quantity': quantity, // +1 or -1
      'lastModifiedBy': userId,
    });
  }
}
