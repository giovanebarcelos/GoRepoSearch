import 'package:dartz/dartz.dart';

import '../../domain/entities/entities.dart';
import '../../domain/errors/failures.dart';
import '../../domain/repositories/search_repository.dart';

import '../../infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await dataSource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    }
    catch (e) {
      return Left(DataSourceError());
    }
  }
}
