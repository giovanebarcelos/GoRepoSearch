import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../errors/errors.dart';
import '../repositories/repositories.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String? searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}
