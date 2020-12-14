import 'package:flutter/material.dart';


class AppCenterSwiper extends StatelessWidget {
  final List<AppCenterItemModel> modelList;
  AppCenterSwiper({
    this.modelList,
 });
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 5,
       padding: EdgeInsets.symmetric(vertical: 0),
      children: modelList.map((e) => AppCenterItem(model: e)).toList(),
    );
  }
}


class AppCenterItem extends StatelessWidget {

  final AppCenterItemModel model;
  AppCenterItem({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(244, 245, 245, 1.0),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: [
          Expanded(child: this.model.icon),
          Text(
            this.model.title,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class AppCenterItemModel {

  final Widget icon;//图标
  final String title;
  // final VoidCallback onPressed;

  const AppCenterItemModel({
    this.icon,
    this.title,
  });
}