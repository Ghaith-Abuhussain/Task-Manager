import '../../../utils/resources/data_state.dart';
import '../../models/remote/requests/login/login_request.dart';
import '../../models/remote/responses/login/login_response.dart';

abstract class LoginRepository {
  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  });
}