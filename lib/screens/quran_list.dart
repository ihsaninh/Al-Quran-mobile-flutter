import 'package:alquranMobile/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquranMobile/constants/Dictionary.dart';
import 'package:alquranMobile/repositories/QuranListRepository.dart';
import 'package:alquranMobile/blocs/quranlist/cubit/quranlist_cubit.dart';

class QuranListPage extends StatefulWidget {
  @override
  _QuranListPageState createState() => _QuranListPageState();
}

class _QuranListPageState extends State<QuranListPage> {

  final List<String> actionList = [Dictionary.settings, Dictionary.about];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranlistCubit(
        repository: QuranListRepository()
      ),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              color: ColorBase.iron,
              height: 1.0,
            ),
          preferredSize: Size.fromHeight(1.0)
          ),
          elevation: 0,
          title: Text(
            Dictionary.appName,
            style: TextStyle(
              color: ColorBase.black
            ),
          ),
          backgroundColor: ColorBase.white,
          actions: [
            PopupMenuButton(
            icon: Icon(Icons.more_vert, color: ColorBase.black),
            tooltip: 'More options',
            elevation: 20,
            itemBuilder: (context) => actionList
                .map((menu) => PopupMenuItem(child: Text(menu)))
                .toList(),
          )
          ],
        ),
        body: BlocBuilder<QuranlistCubit, QuranlistState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedState) {
              final quranList = state.quranList;
              return ListView.builder(
                itemCount: quranList.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorBase.separator, width: 2.0),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Text(
                        quranList[index].id.toString()
                      )),
                    ),
                    title: Text(quranList[index].suratName),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}