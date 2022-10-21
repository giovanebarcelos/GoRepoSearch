import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../errors/errors.dart';

abstract class SearchByText {
  Either<FailureSearch, Future<List<ResultSearch>>> call(String searchText);
}
