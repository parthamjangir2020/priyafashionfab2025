import 'package:active_ecommerce_cms_demo_app/custom/lang_text.dart';
import 'package:active_ecommerce_cms_demo_app/custom/useful_elements.dart';
import 'package:active_ecommerce_cms_demo_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_cms_demo_app/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
import 'package:active_ecommerce_cms_demo_app/ui_elements/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../repositories/auction_products_repository.dart';

class AuctionProducts extends StatefulWidget {
  AuctionProducts({
    Key? key,
  }) : super(key: key);

  @override
  _AuctionProductsState createState() => _AuctionProductsState();
}

class _AuctionProductsState extends State<AuctionProducts> {
  ScrollController _mainScrollController = ScrollController();
  ScrollController _xcrollController = ScrollController();

  //init
  bool _dataFetch = false;
  List<dynamic> _auctionProductItems = [];
  int _page = 1;
  int? _totalData = 0;

  bool _showLoadingContainer = false;

  @override
  void initState() {
    super.initState();
    fetchData();

    _xcrollController.addListener(() {
      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
          _showLoadingContainer = true;
        });
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    _xcrollController.dispose();
    super.dispose();
  }

  reset() {
    _dataFetch = false;
    _auctionProductItems.clear();
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  fetchData() async {
    var auctionProductResponse =
        await AuctionProductsRepository().getAuctionProducts(page: _page);
    _auctionProductItems.addAll(auctionProductResponse.products!);
    _totalData = auctionProductResponse.meta!.total;
    _dataFetch = true;
    _showLoadingContainer = false;

    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: MyTheme.mainColor,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            body(),
            Align(
                alignment: Alignment.bottomCenter,
                child: buildLoadingContainer())
          ],
        ),
      ),
    );
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _auctionProductItems.length
            ? AppLocalizations.of(context)!.no_more_products_ucf
            : AppLocalizations.of(context)!.loading_more_products_ucf),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: MyTheme.mainColor,
      centerTitle: false,
      leading: UsefulElements.backButton(context),
      title: Padding(
        padding: const EdgeInsets.only(right: 37),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.auction_product_screen_title,
              style: TextStyle(
                  fontSize: 16,
                  color: MyTheme.dark_font_grey,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/search.png',
                height: 20,
              ),
            ),
          ],
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget body() {
    if (!_dataFetch) {
      return ShimmerHelper()
          .buildProductGridShimmer(scontroller: _mainScrollController);
    }

    if (_auctionProductItems.length == 0) {
      return Center(
        child: Text(LangText(context).local.no_data_is_available),
      );
    }
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _onPageRefresh,
      child: SingleChildScrollView(
        controller: _xcrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          itemCount: _auctionProductItems.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 0.0, bottom: 10, left: 18, right: 18),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // 3
            return ProductCard(
                identifier: 'auction',
                id: _auctionProductItems[index].id,
                slug: _auctionProductItems[index].slug,
                image: _auctionProductItems[index].thumbnail_image,
                name: _auctionProductItems[index].name,
                main_price: _auctionProductItems[index].main_price,
                stroked_price: _auctionProductItems[index].stroked_price,
                is_wholesale: false,
                // discount: _auctionlProductItems[index].discount,
                has_discount: false);
          },
        ),
      ),
    );
  }
}
