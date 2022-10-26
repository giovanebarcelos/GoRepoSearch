import 'package:dartz/dartz.dart';

import '../../domain/entities/entities.dart';
import '../../domain/errors/failures.dart';
import '../../domain/repositories/search_repository.dart';

import '../../infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText) {
    throw UnimplementedError();
  }
}
