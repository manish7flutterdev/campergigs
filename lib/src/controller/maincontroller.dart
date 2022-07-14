import 'package:get/get.dart';

class MainController extends GetxController{
  var signedIn = false.obs;
  var accessToken = ''.obs;
  var projects = [].obs;
  var searchResult = [].obs;

  searchProject(String query){
    searchResult.value = [];
    for(int i=0;i<projects.length;i++){
      if(projects[i]['title'].contains(query) || projects[i]['title'].toLowerCase().contains(query)){
        searchResult.add({"title": projects[i]['title'],
         "description":projects[i]['description'],
         "id":projects[i]['id']});
      }
    }
    print(searchResult);
  }
}