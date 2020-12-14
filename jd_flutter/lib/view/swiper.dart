import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';


class SwiperView extends StatefulWidget {
  final List bannerImgList;
  final SwiperOnTap onTap;
  final bool autoPay;
  SwiperView(this.bannerImgList, this.onTap, this.autoPay);
  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  List<Widget> imageList;
  SwiperOnTap onTap;
  bool autoPlay;
  @override
  void initState() {
    super.initState();
    imageList = widget.bannerImgList;//bannerList传值
    onTap = widget.onTap;
    autoPlay = widget.autoPay;
  }

  Widget firstSwiperView() {
    return Container(
      // color: Color.fromRGBO(244, 245, 245, 1.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Swiper(
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return imageList[index];
        },
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey[200],
            size: 4,
            activeColor: Colors.red[200],
          ),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: autoPlay,
        autoplayDelay: 5000,
        // onTap: (index) {
        //   print('点击了第$index张图片');
        //
        // },
        onTap: onTap,
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [firstSwiperView()],);
  }
}

