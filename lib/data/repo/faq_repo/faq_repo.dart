import 'package:viser_bank/core/utils/url.dart';
import 'package:viser_bank/data/services/api_service.dart';

import '../../../core/utils/method.dart';

class FaqRepo{

  ApiClient apiClient;
  FaqRepo({required this.apiClient});

  Future<dynamic>loadFaq()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.faqEndPoint}';
    final response=await apiClient.request(url,Method.getMethod,null);
    return response;
  }

}