import '../../infra/models/models.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}
