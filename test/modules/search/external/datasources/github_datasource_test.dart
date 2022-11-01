import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../lib/modules/search/external/datasources/github_datasource.dart';
import '../../utils/utils.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  final datasource = GitHubDataSource(dio);
  test('Should return a ResultSearchModel list', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonDecode(gitHubResult),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final sut = datasource.getSearch("searchText");

    expect(sut, completes);
  });
}
