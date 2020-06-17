import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/model/brew.dart';
import 'package:flutter_firebase/model/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.document(uid).setData({
    'sugars': sugars,
    'name': name,
    'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewlistfromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? 'adi',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
       );
      }).toList();
  }

  //userdata from snapshot
  UserData _userDatafromSnapshot (DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewlistfromSnapshot);
  }
  //stream to collect data
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDatafromSnapshot);
  }
}