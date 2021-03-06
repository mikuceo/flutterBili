import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili/model/home_bangumi_model.dart';
import 'package:flutter_bili/widget/home/bangumi/bangumi_like_buttton.dart';
import 'package:flutter_bili/widget/home/bangumi/bangumi_top_header_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BangumiCardWidget extends StatelessWidget {
  BangumiModules modules;
  BangumiCardWidget(this.modules);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(375),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BangumiTopHeaderTitleWidget(title: modules.title,hideRight: false,),
          _gridView(),
          _bottomWidget()
        ],
      ),
    );
  }

  //内容列表
  Widget _gridView() {
    return Container(
      width: ScreenUtil().setWidth(375),
//      height: ScreenUtil().setHeight(350),
      padding: EdgeInsets.only(left: 10,right: 10),
      child: GridView.count(
          crossAxisCount: 2,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: modules.items.map((val) {
          return _singleCell(val);
        }).toList(),
      ),
    );
  }
  //cell
  Widget _singleCell(BangumiModuleItem item) {
    return Container(
//      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _coverImage(item),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(item.title,style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Color(0xff444444)),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(item.desc ?? '',style: TextStyle(color: Color(0xff888888),fontSize: ScreenUtil().setSp(12)),maxLines: 1,overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
  //封面图570x353
  Widget _coverImage(BangumiModuleItem item) {
    return Container(
      width: ScreenUtil().setWidth(190),
      height: ScreenUtil().setHeight(115),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,right: 0,bottom: 0,top: 0,
            child: Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: item.cover,
                  fit: BoxFit.cover,
                  width: ScreenUtil().setWidth(190),
                  height: ScreenUtil().setHeight(115),
                  placeholder: (context, url) => Container(
                      width: ScreenUtil().setWidth(190),
                      height: ScreenUtil().setHeight(115),
                      color: Color(0xffe7e7e7),
                      child: Center(
                        child: Image.asset('images/image_tv.png',width: 90,),
                      )
                  ),
                ),
              ),
            ),
          ),
          item.stat == null ? Container() :
          Positioned(
            left: 0,bottom: 0,right: 0,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent,Color.fromRGBO(0, 0, 0, 0.5)]
                  ),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
              ),
              child: Text(item.stat.followView ?? '',style: TextStyle(color: Colors.white,fontSize: 13),),
            ),
          ),
          item.badgeInfo == null ? Container() :
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                  decoration: BoxDecoration(
                      color: Colors.pink[300],
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(item.badgeInfo.text,style: TextStyle(color: Colors.white,fontSize: 11),),
                ),
              ),
          Positioned(
            left: 0,top: 0,
            child: BangumiLikeButtonWidget(item.oid),
          )
        ],
      ),
    );
  }

  //bottom 换一换
  Widget _bottomWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(0xe60a, fontFamily: "appIconFonts",),color: Colors.pink[300],size: 15,),
          SizedBox(width: 5,),
          Text('换一换',style: TextStyle(color: Colors.pink[300],fontSize: ScreenUtil().setSp(13)),),
        ],
      ),
    );
  }
}
