import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spjewellery/core/extension/text_theme_ext.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../constants/dimesions.dart';

class AppRefresherWidget extends StatelessWidget {
  final RefreshController refreshController;
  final bool? enablePullup;
  final bool canLoadMore;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final Widget child;

  const AppRefresherWidget({
    super.key,
    required this.refreshController,
    this.enablePullup,
    required this.canLoadMore,
    this.onRefresh,
    this.onLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: enablePullup ?? true,
      footer: footer(canLoadMore: canLoadMore),
      header: const WaterDropHeader(),
      physics: const BouncingScrollPhysics(),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }

  Widget footer({required bool canLoadMore}) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator(color: Colors.black);
        } else if (mode == LoadStatus.failed) {
          body = Text(
            "Load Failed!Click retry!".tr,
            style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            "release to load more".tr,
            style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
          );
        } else if (canLoadMore == false) {
          body = Text(
            "No more Data".tr,
            style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
          );
        } else {
          body = Text(
            "",
            style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
          );
        }
        return Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(bottom: Dimesion.height40 * 2),
          height: Dimesion.height40 * 1.2,
          child: body,
        );
      },
    );
  }
}
