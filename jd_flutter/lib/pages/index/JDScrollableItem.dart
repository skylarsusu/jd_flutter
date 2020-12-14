import 'package:flutter/material.dart';


final List<String> titleList = [
 '自营图书',
 '玩具乐器',
 '时令生鲜',
 '京东图书',
 '生活服务',
 '冬季暖心行',
 '家居百货',
 '大牌鞋靴',
];

class JDScrollableModel {
  final String title;
  final String  titleColor;
  final Widget img;
  final Widget bgImg;
  JDScrollableModel({
    this.title,
    this.titleColor,
    this.img,
    this.bgImg,
 });
}

class JDScrollableItem extends StatelessWidget {
  final JDScrollableModel model;
  JDScrollableItem({
    this.model,
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  // this.model.bgImg,
                  Positioned(
                    left: 0,
                      right: 0,
                      bottom: 0,
                      // height: 100.0,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          '1234',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }
}


class JdScrollableView extends StatelessWidget {
  final List<JDScrollableModel> modelList;
  JdScrollableView({
    this.modelList,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 120.0,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(

                        color: Colors.white,
                        alignment: Alignment.center,
                        // width: MediaQuery.of(context).size.width,
                        height: 100,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: [

                            Stack(
                              fit: StackFit.passthrough,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(15),
                                //   child: modelList[index].img,
                                // ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: modelList[index].img,
                                  ),
                                ),
                                // modelList[index].img,
                                // modelList[index].bgImg,
                                Positioned(
                                   height: 100.0,
                                    child: modelList[index].bgImg,
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    // height: 100.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        modelList[index].title,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),childCount: 8,
              ),
              itemExtent: 100,
          ),
        ],
      ),
    );
  }
}
