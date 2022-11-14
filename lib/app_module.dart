import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modules/search/domain/usecases/usecases.dart';
import '../modules/search/external/datasources/datasources.dart';
import '../modules/search/infra/repositories/repositories.dart';
import '../modules/search/presenter/search/search.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GitHubDataSource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchBloc(i())),
      ];

  /*
  List<Bind> get binds => [
        Bind.lazySingleton<Dio>((i) => Dio()),
        Bind.lazySingleton<GitHubDataSource>(
            (i) => GitHubDataSource(i.get<Dio>())),
        Bind.lazySingleton<SearchRepositoryImpl>(
            (i) => SearchRepositoryImpl(i.get<GitHubDataSource>())),
        Bind.lazySingleton<SearchByTextImpl>(
            (i) => SearchByTextImpl(i.get<SearchRepositoryImpl>())),
      ];
  */

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SearchPage()),
      ];
}
