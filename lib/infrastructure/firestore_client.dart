import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_shortener/models/short_link.dart';

class FirestoreClient {
  Future<void> addLink(ShortLink link) async {
    final document = Firestore.instance.collection('links').document(link.ending);

    await document.setData({
      'ending': link.ending,
      'url': link.redirectUrl,
      'totalClicks': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String> getRedirectUrl(String ending) async {
    final link = await Firestore.instance.document('links/$ending').get();

    return link != null
      ? link.data['url']
      : null;
  }

  Stream<DocumentSnapshot> getLinkSnapshot(String ending) {
    return Firestore.instance.collection('links').document(ending).snapshots();
  }

  Future<void> addLinkClick(String ending) async {
    final linkRef = Firestore.instance.document('links/$ending');
    final clickRef = linkRef.collection('clicks').document();

    await Firestore.instance.runTransaction((transaction) async {
      final linkSnapshot = await transaction.get(linkRef);
      await transaction.update(linkRef, {'totalClicks': linkSnapshot.data['totalClicks'] + 1});

      await transaction.set(clickRef, {
        'date': FieldValue.serverTimestamp(),
      });
    });
  }
  
  Stream<QuerySnapshot> getLinkClicks(String ending) {
    return Firestore.instance.collection('links').document(ending).collection('clicks').snapshots();
  }
}
