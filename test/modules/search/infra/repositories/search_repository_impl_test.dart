// ignore_for_file: avoid_relative_lib_imports

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../lib/modules/search/infra/repositories/repositories.dart';
import '../../../../../lib/modules/search/infra/datasources/datasources.dart';
import '../../../../../lib/modules/search/infra/models/models.dart';
import '../../../../../lib/modules/search/domain/errors/errors.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  final dataSource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(dataSource);

  test('Should return a ResultSearch list', () async {
    when(() => dataSource.getSearch(any()))
        .thenAnswer((_) async => await Future.value(<ResultSearchModel>[]));

    final sut = await repository.search("giovane");

    expect(sut.fold(id, id), isA<List<ResultSearchModel>>());

    /*
    sut.fold(
        (l) => null,
        (resultR) => const Right([])
            .fold((l) => null, (matcherR) => expect(resultR, matcherR)));
    */
  });

  test('Should return an DataSourceError when a DataSource fail', () async {
    when(() => dataSource.getSearch(any())).thenThrow(Exception());

    final sut = await repository.search("giovane");

    expect(sut.fold(id, id), isA<DataSourceError>());
  });
}
