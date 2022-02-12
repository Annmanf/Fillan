import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;

  User? getUsers() {
    return _user;
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  dynamic nested = false;

  bool isAnmald() {
    _firestore.collection('users').doc(uid).get().then((value) {
      try {
        nested = value.get(FieldPath(['anmäld']));

        return nested;
      } on StateError catch (e) {
        print('No nested field exists!');
        return false;
      }
    });
    return nested;
    //return false;
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  String? get email {
    return _firebaseAuth.currentUser!.email;
  }

  User get usr {
    return User(
        uid: _firebaseAuth.currentUser!.uid,
        email: _firebaseAuth.currentUser!.email);
  }

  String? get uid {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<void> getData() async {
    CollectionReference seatsfromfire = _firestore.collection('users');
    try {
      seatsfromfire.snapshots().forEach((element) async {
        DocumentSnapshot snapshot = await seatsfromfire
            .doc(uid)
            .get()
            .catchError((onError) => print('failed'));

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          User usr = User.fromJson(data);

          if (usr.uid == _firebaseAuth.currentUser!.uid) {
            _user = usr;
          }
        } else {
          print('nopoe');
        }
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<User?> login(
    String email,
    String password,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credentials.user);
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<User?> signUp(
    String firstname,
    String lastname,
    String email,
    String birthdate,
    String adress,
    String phonenumber,
    String password,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credentials.user!.uid;

      _firestore.collection('users').doc(uid).set({
        'Förnamn': firstname,
        'Efternamn': lastname,
        'email': email,
        'Födelsedatum': birthdate,
        'adress': adress,
        'phonenumber': phonenumber,
        'password': password,
        'uid': uid
      });

      //addUser(firstname, lastname, email, birthdate, adress, phonenumber,
      //password, uid, (e) {});
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> addUser(
    String firstname,
    String lastname,
    String email,
    String birthdate,
    String adress,
    String phonenumber,
    String password,
    String uid,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    bool overeighteen = false;
    //String uid = _firebaseAuth.currentUser!.uid.toString();

    return users
        .add({
          'Förnamn': firstname,
          'Efternamn': lastname,
          'email': email,
          'Födelsedatum': birthdate,
          'adress': adress,
          'phonenumber': phonenumber,
          'password': password,
          'uid': uid
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<User?> signUpWithContacts(
    String firstname,
    String lastname,
    String email,
    String birthdate,
    String adress,
    String phonenumber,
    String contactfirstname,
    String contactlastname,
    String contactphone,
    String contactemail,
    String password,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credentials.user!.uid;
      addUserWithContacts(
          firstname,
          lastname,
          email,
          birthdate,
          adress,
          phonenumber,
          contactfirstname,
          contactlastname,
          contactphone,
          contactemail,
          password,
          uid,
          (e) {});
      return _userFromFirebase(credentials.user);
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> addUserWithContacts(
    String firstname,
    String lastname,
    String email,
    String birthdate,
    String adress,
    String phonenumber,
    String contactfirstname,
    String contactlastname,
    String contactphone,
    String contactemail,
    String password,
    String uid,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //String uid = _firebaseAuth.currentUser!.uid.toString();

    return await users
        .add({
          'Förnamn': firstname,
          'Efternamn': lastname,
          'email': email,
          'Födelsedatum': birthdate,
          'adress': adress,
          'phonenumber': phonenumber,
          'contactfirstname': contactfirstname,
          'contactlastname': contactlastname,
          'contactphone': contactphone,
          'contactemail': contactemail,
          'rules': 'regler',
          'kamera': 'kamera',
          'password': password,
          'uid': uid
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> verifyEmail(
    String email,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await _firebaseAuth.fetchSignInMethodsForEmail(email);
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists(String? docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = _firestore.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteaccount() async {
    try {
      bool docExists = await checkIfDocExists(uid);
      print("Document exists in Firestore? " + docExists.toString());

      if (docExists) {
        _firestore
            .collection('users')
            .doc(uid)
            .delete()
            .then((value) => print("User Deleted"))
            .catchError((error) => print("Failed to delete user: $error"));
      } else {
        print('failed');
      }
      await _firebaseAuth.currentUser!.delete();
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  bool? get status {
    _firestore.collection('users').doc(uid).get().then((value) {
      try {
        value.get(FieldPath(['status']));
        print('statusfromfire $nested');
        return value.get(FieldPath(['status']));
      } on StateError catch (e) {
        print('No nested field exists!');
        return false;
      }
    });
    return false;
    //return false;
  }

  Future<void> setStatus(bool hh) async {
    try {
      _firestore
          .collection('users')
          .doc(uid)
          .update(
            {
              'status': hh,
            },
          )
          .then((value) => print('status updated'))
          .catchError((error) => print("Failed to update status: $error"));
    } on auth.FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> addAnmalan(
    String spel,
    String mat,
    String turneringar,
    String sovplats,
    String fritext,
    String gdpr,
    String regler,
    String sittplats,
  ) async {
    try {
      bool docExists = await checkIfDocExists(uid);
      print("Document exists in Firestore? " + docExists.toString());

      if (docExists) {
        _firestore
            .collection('users')
            .doc(uid)
            .update(
              {
                'spel': spel,
                'mat': mat,
                'turneringar': turneringar,
                'sovplats': sovplats,
                'fritext': fritext,
                'gdpr': gdpr,
                'regler': regler,
                'sittplats': sittplats,
                'anmäld': true,
              },
            )
            .then((value) => print('added'))
            .catchError((error) => print("Failed to add to user: $error"));
      } else {
        print('failed');
      }
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}
