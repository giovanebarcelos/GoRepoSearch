import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_repo_search/modules/search/domain/entities/entities.dart';
import 'package:go_repo_search/modules/search/domain/errors/errors.dart';
import 'package:go_repo_search/modules/search/domain/usecases/usecases.dart';
import 'package:go_repo_search/modules/search/presenter/search/search_bloc.dart';
import 'package:go_repo_search/modules/search/presenter/search/states/state.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test('should return states on correct order', () {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    expectLater(
      bloc.stream,
      emitsInOrder(
        [
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ],
      ),
    );

    bloc.add("giovane");
  });

  test('should return error', () {
    when(() => usecase.call(any()))
        .thenAnswer((_) async => Left(InvalidTextError()));

    expectLater(
      bloc.stream,
      emitsInOrder(
        [
          isA<SearchLoading>(),
          isA<SearchError>(),
        ],
      ),
    );

    bloc.add("giovane");
  });
}
