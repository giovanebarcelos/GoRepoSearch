import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_repo_search/modules/search/presenter/search/search.dart';
import 'package:go_repo_search/modules/search/presenter/search/states/state.dart';

import '../../domain/errors/errors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Search"),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
            top: 8.0,
          ),
          child: TextField(
            onChanged: bloc.add,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search ...",
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return const Center(child: Text('Type a text!'));
                } else if (state is SearchError) {
                  return const Center(child: Text('There was an error!'));
                } else if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final list = (state as SearchSuccess).list;

                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: item.img.isEmpty
                            ? Container()
                            : CircleAvatar(
                                backgroundImage: NetworkImage(item.img),
                              ),
                        title: Text(item.title),
                      );
                    });
              }),
        ),
      ]),
    );
  }
}
