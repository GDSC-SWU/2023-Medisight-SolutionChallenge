import 'package:flutter/material.dart';
import 'package:medisight/theme/theme_provider.dart';
import 'package:medisight/widget/grid_button_2.dart';
import 'package:provider/provider.dart';

class TipSubPage2 extends StatefulWidget {
  const TipSubPage2({super.key});

  @override
  State<TipSubPage2> createState() => _TipSubPageState2();
}

class _TipSubPageState2 extends State<TipSubPage2> {
  late ScrollController _scrollController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Provider.of<ThemeProvider>(context, listen: false).themeMode;
    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          backgroundColor: Theme.of(context).canvasColor,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("의약품 복용 상식",
                  style: TextStyle(
                      color: isShrink
                          ? (themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white)
                          : Colors.white,
                      fontWeight: FontWeight.w600)),
              background:
                  Image.asset("assets/images/info_2.jpg", fit: BoxFit.cover)),
        ),
        SliverPadding(
            padding: const EdgeInsets.only(left: 28, right: 28, bottom: 28),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          const Text(
                            "주제를 선택해주세요",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          GridButton2()
                        ],
                      ),
                  childCount: 1),
            )),
      ]),
    );
  }
}
