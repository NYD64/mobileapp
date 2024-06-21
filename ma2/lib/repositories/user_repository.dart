import '../helpers/database_helper.dart';
import '../models/user.dart';
import '../models/calculation.dart';

class UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<User?> getUserByUsername(String username) async {
    return await _databaseHelper.getUser(username);
  }

  Future<void> addUser(User user) async {
    await _databaseHelper.insertUser(user);
  }

  Future<bool> authenticate(String username, String password) async {
    final user = await getUserByUsername(username);
    return user != null && user.password == password;
  }

  Future<void> addCalculation(Calculation calculation) async {
    await _databaseHelper.insertCalculation(calculation);
  }

  Future<List<Calculation>> getUserCalculations(String username) async {
    return await _databaseHelper.getUserCalculations(username);
  }

  Future<bool> updateUserPasswordByEmail(
      String email, String newPassword) async {
    final db = await _databaseHelper.database;
    final result = await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
    return result > 0;
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }
}

final UserRepository userRepository = UserRepository();
