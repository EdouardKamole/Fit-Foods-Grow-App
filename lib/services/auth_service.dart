import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    _currentUser = UserModel(
      id: '1',
      email: email,
      name: 'Demo User',
      age: 12,
      profileImage: '',
      points: 450,
      level: 3,
      joinDate: DateTime.now(),
      isParentVerified: true,
    );
    
    return true;
  }

  Future<bool> signup(String email, String password, String name, int age) async {
    await Future.delayed(const Duration(seconds: 2));
    
    _currentUser = UserModel(
      id: '1',
      email: email,
      name: name,
      age: age,
      profileImage: '',
      points: 0,
      level: 1,
      joinDate: DateTime.now(),
      isParentVerified: false,
    );
    
    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  Future<bool> verifyParent(String parentEmail) async {
    await Future.delayed(const Duration(seconds: 2));
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(isParentVerified: true);
    }
    return true;
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    _currentUser = updatedUser;
  }
}

extension UserModelExtension on UserModel {
  UserModel copyWith({
    String? name,
    int? age,
    String? profileImage,
    int? points,
    int? level,
    bool? isParentVerified,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      points: points ?? this.points,
      level: level ?? this.level,
      joinDate: joinDate,
      isParentVerified: isParentVerified ?? this.isParentVerified,
    );
  }
}