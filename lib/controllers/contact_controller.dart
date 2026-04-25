import 'package:get/get.dart';
import 'package:spjewellery/core/constants/api_route_constants.dart';
import 'package:spjewellery/models/contact_model.dart';
import 'package:spjewellery/services/api_service.dart';

class ContactController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();

  var isLoading = false.obs;
  var contact = Rxn<ContactModel>();
  RxList<String> numberList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContact();
  }

  Future<void> fetchContact() async {
    try {
      isLoading.value = true;

      final Response response = await apiClient.getData(
        RouteConstant.contactDetail,
      );

      if (response.statusCode == 200) {
        final body = response.body;

        if (body != null && body['success'] == true) {
          /// Parse Model
          final data = ContactModel.fromJson(body['data']);
          contact.value = data;

          /// Safely parse phone numbers
          if (data.phone != null && data.phone!.isNotEmpty) {
            numberList.assignAll(
              data.phone!
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList(),
            );
          } else {
            numberList.clear();
          }
        } else {
          print(
            "API success but returned failure message: ${body?['message']}",
          );
        }
      } else {
        print("API error status: ${response.statusCode}");
      }
    } catch (e) {
      print("Contact fetch exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
