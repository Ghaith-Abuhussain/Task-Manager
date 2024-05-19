import 'package:task_managing/data/datasources/remote/api/task_manager_api_service.dart';

import '../../../domain/models/remote/requests/login/login_request.dart';
import '../../../domain/models/remote/responses/login/login_response.dart';
import '../../../domain/repositories/remote/login_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../../base/base_api_repository.dart';

class LoginRepositoryImpl extends BaseApiRepository implements LoginRepository {
  final TaskManagerApiService _taskManagerApiService;

  LoginRepositoryImpl(this._taskManagerApiService);
  @override
  Future<DataState<LoginResponse>> login({required LoginRequest request}) {

    return getStateOf<LoginResponse>(
      request: () => _taskManagerApiService.login(
        body: request,
      ),
    );

  }

}