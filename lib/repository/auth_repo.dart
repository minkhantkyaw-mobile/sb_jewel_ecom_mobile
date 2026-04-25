import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../core/constants/api_route_constants.dart';
import '../models/login_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  AuthRepo({required this.apiClient, required this.prefService});

  Future<Response> loginUser(body) async {
    return await apiClient.postData(RouteConstant.login, body);
  }
  Future<Response> getPusher() async {
    return await apiClient.getData(RouteConstant.pusher);
  }
  Future<Response> logoutUser() async {
    return await apiClient.getData(RouteConstant.logout);
  }

  Future<Response> registerUser(body) async {
    return await apiClient.postFormData(RouteConstant.register, body);
  }

  Future<Response> getUser() async {
    return await apiClient.getData(RouteConstant.customer);
  }

  Future<Response> forgotpassword({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.forgotpassword, formData);
  }

  Future<Response> verify_forgotpassword({required FormData formData}) async {
    return apiClient.postFormData(
      RouteConstant.verify_forgotpassword,
      formData,
    );
  }

  Future<Response> update_password({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.update_password, formData);
  }

  Future<Response> updateProfile({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.update_profile, formData);
  }

  Future<Response> changePassword({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.change_password, formData);
  }
  /*









  Future<Response> deleteAccoutn() async {
    return await apiClient.deleteData(RouteConstant.deleteUser);
  }*/

  updateHeader(String token) {
    apiClient.updateHeader(token);
  }

  saveAppToken({required String token}) =>
      prefService.saveAppToken(token: token);

  saveUserData({required UserData userData}) =>
      prefService.saveAppUser(user: userData);

  /*savePassword({required String password}) =>
      prefService.savePassword(password: password);*/
  saveAppLanguage({required int val}) => prefService.saveAppLanguage(val: val);

  // Future<String> getPassword() async => await prefService.getPassword();
  Future<String> getAppToken() async => await prefService.getAppToken();
  Future<dynamic> getUserData() async => await prefService.getUserData();

  Future<int> getAppLanguage() async => await prefService.getAppLanguage();
  Future<String> getFcmToken() async => await prefService.getFcmToken();

  // Delete Account
  Future<Response> deleteAccount() async {
    return await apiClient.deleteData(RouteConstant.deleteAccount);
  }
}
