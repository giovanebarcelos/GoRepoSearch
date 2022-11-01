import 'package:dio/dio.dart';

import '../../../../modules/search/infra/datasources/datasources.dart';
import '../../../../modules/search/infra/models/result_search_model.dart';
import '../../../../modules/search/domain/errors/failures.dart';

extension on String {
  normalize() {
    return replaceAll(" ", "+");
  }
}

class GitHubDataSource implements SearchDataSource {
  final Dio dio;

  GitHubDataSource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get("https://api.github.com/search/users?q=${searchText.normalize()}");

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap({
                'title': e['login'],
                'content': e['id'].toString(),
                'img': e['avatar_url']
              }))
          .toList();

      return list;
    } else {
      throw DataSourceError();
    }

    return <ResultSearchModel>[];
  }
}
