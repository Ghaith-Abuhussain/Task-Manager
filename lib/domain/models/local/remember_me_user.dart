import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';
import '../../../utils/constants/strings.dart';

@Entity(tableName: remembermeUserTableName)
class RememberMeUser extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String password;
  final bool   isLoggedIn;

  RememberMeUser({required this.id, required this.username, required this.password, required this.isLoggedIn});

  @override
  // TODO: implement props
  List<Object?> get props => [id, username, password, isLoggedIn];

}