import 'package:bloc/bloc.dart';
import 'package:go_repo_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:go_repo_search/modules/search/presenter/search/states/states.dart';

import '../../../../modules/search/domain/entities/entities.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart()) {
    on<String>((event, emit) async {
      emit(SearchLoading());
      final result = await usecase(event);
      emit(result.fold((l) => SearchError(l), (r) => SearchSuccess(r)));
    });
  }
}
