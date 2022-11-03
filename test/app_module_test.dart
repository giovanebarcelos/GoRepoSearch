import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_repo_search/app_module.dart';
import 'package:go_repo_search/modules/search/domain/usecases/usecases.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  initModule(AppModule());

  test('Should recover usecase without error', () {
    final usecase = Modular.get<SearchByTextImpl>();
    expect(usecase, isA<SearchByTextImpl>());
  });
}
