import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get _loggedInUser => _auth.currentUser;
  bool get isLoggedIn => _loggedInUser != null;

  // 스트림
  Stream<User?> userStreamChanges() => _auth.authStateChanges();

  // 계정 추가
  Future<String> createUser(String email, String password) async {
    String retStr = "";
    var state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async => await _auth.createUserWithEmailAndPassword(email: email, password: password));

    if (state.hasError) {
      retStr = (state.error! as FirebaseAuthException).message!;
    }

    return retStr;
  }

  // 로그인
  Future<String> login(String email, String password) async {
    String retStr = "";

    var state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _auth.signInWithEmailAndPassword(email: email, password: password),
    );

    if (state.hasError) {
      retStr = (state.error as FirebaseAuthException).message!;
    }

    return retStr;
  }

  // 로그아웃
  Future<void> logout() async {
    const AsyncValue.loading();
    await AsyncValue.guard(() async => await _auth.signOut());
  }
}

final authRepo = Provider((ref) => AuthRepo());
final authStreamRepo = StreamProvider((ref) => ref.read(authRepo).userStreamChanges());
