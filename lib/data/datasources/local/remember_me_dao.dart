import 'package:floor/floor.dart';
import '../../../utils/constants/strings.dart';
import '../../../domain/models/local/remember_me_user.dart';

@dao
abstract class RemembermeDao {
  @Query("SELECT * FROM $remembermeUserTableName")
  Future<List<RememberMeUser>> getAllRememberedUsers();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRememberedUser(RememberMeUser user);

  @delete
  Future<void> deleteRememberedUser(RememberMeUser user);

  @Query("SELECT * FROM $remembermeUserTableName WHERE id = 1")
  Future<RememberMeUser?> getRememberedUser();
}