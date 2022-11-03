import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modules/search/domain/usecases/usecases.dart';
import '../modules/search/external/datasources/datasources.dart';
import '../modules/search/infra/repositories/repositories.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GitHubDataSource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
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
  List<ModularRoute> get routes => const [];
}
