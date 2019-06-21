import 'package:flutter/material.dart';
import 'package:opencoolapk/data/model/card/icon_link_grid_card.dart';
import 'package:opencoolapk/data/model/feed/inlist_feed.dart';
import 'package:opencoolapk/data/model/card/image_carousel_card_1.dart';
import 'package:opencoolapk/data/model/feed/indexV8_list.dart';
import 'package:opencoolapk/ui/pages/item/carouselcard.dart';
import 'package:opencoolapk/ui/pages/item/feedfeed.dart';
import 'package:opencoolapk/ui/pages/item/iconlink_gridcard.dart';
import 'package:opencoolapk/ui/pages/item/refreshcard.dart';
import 'package:opencoolapk/ui/pages/item/textlink_listcard.dart';

class FeedItem extends StatelessWidget {
  final Data entity;
  final xs = 0.03;

  FeedItem(this.entity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width > 900
              ? ((MediaQuery.of(context).size.width - 900) / 2)
              : 0,
          0,
          MediaQuery.of(context).size.width > 900
              ? ((MediaQuery.of(context).size.width - 900) / 2)
              : 0,
          0),
      child: FeedItemLoader.fromSingleData(context, entity),
    );
  }
}

class FeedItemLoader {
  static Widget fromSingleData(BuildContext ctx, Data entity) {
    switch (entity.entityType) {
      case "card":
        switch (entity.entityTemplate) {
          case "textTitleScrollCard":
            return const SizedBox(); // 多半是广告
            break;
          case "textLinkListCard":
            return TextLinkListCardItem(entity.source);
            break;
          case "imageCarouselCard_1":
            return _buildCarouselCard(
                ctx, ImageCarouselCard.fromJson(entity.source));
            break;
          case "refreshCard":
            return _buildRefreshCard(ctx, entity);
            break;
          case "iconLinkGridCard":
            switch (entity.source['title']) {
              case "":
                return IconLinkGridCardItem(
                    IconLinkGridCard.fromJson(entity.source));
                break;
              case "原创看看号":
                return DyhIconLinkGridCardItem(
                    IconLinkGridCard.fromJson(entity.source));
                break;
            }
            break;
        }
        break;
      case "feed":
        switch (entity.entityTemplate) {
          case "feed":
            return _buildFeedFeedItem(ctx, Feed.fromJson(entity.source));
            break;
          case "feedCover":
            return _buildFeedFeedItem(ctx, Feed.fromJson(entity.source));
            break;
        }
        break;
      case "apk": //不支持
        return const SizedBox(); // 多半也是广告
        break;
    }
    return Card(
      elevation: 0,
      shape: Border.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("未实现的"),
          Text(entity.title),
          Text(entity.entityType),
          Text(entity.entityTemplate)
        ],
      ),
    );
  }

  static Widget _buildFeedFeedItem(BuildContext ctx, Feed entity) {
    return FeedFeedItem(entity);
  }

  static Widget _buildCarouselCard(BuildContext ctx, ImageCarouselCard entity) {
    return CarouselCardItem(entity);
  }

  static Widget _buildRefreshCard(BuildContext ctx, Data entity) {
    return RefreshCardItem(entity);
  }
}
