import 'dart:convert';

import 'package:dartz/dartz.dart' hide Bind;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:go_repo_search/app_module.dart';
import 'package:go_repo_search/modules/search/domain/entities/entities.dart';
import 'package:go_repo_search/modules/search/domain/usecases/usecases.dart';

import 'modules/search/utils/utils.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dio;
  setUp(() {
    dio = DioMock();
    initModule(AppModule(), replaceBinds: [
      Bind.instance<Dio>(dio),
    ]);
  });

  test('Should recover usecase without error', () {
    final usecase = Modular.get<SearchByTextImpl>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Should get a ResultSearch list', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: jsonDecode(gitHubResult),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("giovane");
    expect(result.fold(id, id), isA<List<ResultSearch>>());
  });
}
