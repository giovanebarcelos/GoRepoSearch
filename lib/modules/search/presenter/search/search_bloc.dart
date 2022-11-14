import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:go_repo_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:go_repo_search/modules/search/presenter/search/states/states.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../modules/search/domain/entities/entities.dart';
import '../../domain/errors/errors.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchBloc(this.usecase) : super(SearchStart()) {
    on<String>((event, emit) async {
      emit(SearchLoading());
      Either<FailureSearch, List<ResultSearch>> result = event.isNotEmpty
          ? await usecase(event)
          : const Right(<ResultSearch>[]);
      emit(result.fold((l) => SearchError(l), (r) => SearchSuccess(r)));
    }, transformer: debounce(const Duration(milliseconds: 800)));
  }
}
