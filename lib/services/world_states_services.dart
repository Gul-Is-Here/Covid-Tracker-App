import 'dart:convert';

import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

// ----------------> World States Detailed Api Method   <---------------------//
class WolrdStatesServies {
  Future<WolrdStatesModel> fetchWorldStates() async {
    var response = await http.get(Uri.parse(AppUrls.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WolrdStatesModel.fromJson(data);
    } else {
      return throw Exception("Error");
    }
  }
}

//----------------> Countries States Api's Method  <--------------------------//

class CountriesStatesServies {
  Future<List<dynamic>> fetchCountriesStates() async {
    var data;
    var response = await http.get(Uri.parse(AppUrls.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      return data;
    }
  }
  // Future<List<WolrdStatesModel>> fetchCountriesStates() async {
  //   List<WolrdStatesModel> dataList = [];
  //   var response = await http.get(Uri.parse(AppUrls.countriesList));
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     for (Map i in data) {
  //       dataList.add(WolrdStatesModel.fromJson(i));
  //     }
  //     return dataList;
  //   } else {
  //     return dataList;
  //   }
  // }
}
