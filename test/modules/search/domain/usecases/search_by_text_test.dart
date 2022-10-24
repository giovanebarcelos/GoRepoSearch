// ignore_for_file: avoid_relative_lib_imports

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/modules/search/domain/usecases/usecases.dart';
import '../../../../../lib/modules/search/domain/errors/errors.dart';
import '../../../../../lib/modules/search/domain/entities/entities.dart';
import '../../../../../lib/modules/search/domain/repositories/repositories.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  final repository = MockSearchRepository();
  late SearchByTextImpl sut;

  setUp(() {
    sut = SearchByTextImpl(repository);
  });

  test('should return a ResultSearch list', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    """
    #or 
    when(() => repository.search(any()))
        .thenAnswer((_) => Future.value(const Right(<ResultSearch>[])));
    """;

    final result = await sut("giovane");

    expect(result, isA<Right<FailureSearch, List<ResultSearch>>>());
  });

  test('should return an exception if text is invalid', () async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    """
    #or 
    when(() => repository.search(any()))
        .thenAnswer((_) => Future.value(const Right(<ResultSearch>[])));
    """;

    var result = await sut(null);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await sut("");
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
