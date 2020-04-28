import 'package:flutter/material.dart';
import 'package:flutter_bili/pages/home/home_live_page.dart';
import 'package:flutter_bili/pages/home/home_recommend_page.dart';

class ChannelCommonPage extends StatelessWidget {

  final String uri;
  ChannelCommonPage(this.uri);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getCustomWidget(),
    );
  }

  Widget _getCustomWidget() {
    if (this.uri == 'bilibili://live/home') { //直播
      return LivePage();
    } else if (this.uri == 'bilibili://pegasus/promo') {
      return HomeRecommendPage();
    } else {
      return Center(child: Text('$uri not defined'),);
    }
  }
}