import '../../Entity/Inventory.dart';
import '../../Entity/FoodRecord.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
class InventoryController{

  String url = 'api.spoonacular.com';

  Future<String> fetchImageUrl(Map<String, dynamic> request) async {
    request['apiKey'] = '7df62bdc1ad34570b6ab05269bbef6bd';
    print(request);
    final response = await http.get(
      Uri.https(url, 'food/ingredients/search', request),
    );
    print("Status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var res=json.decode(response.body)['results'];
      print(res);

      String imageUrl="https://spoonacular.com/cdn/ingredients_100x100/"+ res[0]["image"].toString();

      //add code to add the id and url in firebase
      return imageUrl;
    } else {
      //throw Exception('Failed to load recipe info');
      print("Ingredient does not exist in spoonacular");
      return " ";
    }
  }


}