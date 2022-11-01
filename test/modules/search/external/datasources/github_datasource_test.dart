// ignore_for_file: avoid_relative_lib_imports

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../lib/modules/search/external/datasources/github_datasource.dart';
import '../../../../../lib/modules/search/domain/errors/errors.dart';
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

  test('Should return a DataSourceError if code is not 200', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final sut = datasource.getSearch("searchText");

    expect(sut, throwsA(isA<DataSourceError>()));
  });
}
