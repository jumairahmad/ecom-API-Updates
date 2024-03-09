// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/Home/models/DealsModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SingleDealScreen/controller/SingleDealController.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:e_commerce/screens/Home/helpers/CatSkeleton.dart';
import 'package:e_commerce/screens/Home/helpers/DealSkeleton.dart';
import 'package:e_commerce/screens/Home/helpers/SpecialsSkeleton.dart';

import 'package:shimmer/shimmer.dart';
import 'models/ProductModel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:marquee/marquee.dart';

class HomeScreen extends StatelessWidget {
  final userController = Get.put(SignInController());
  final homeController = Get.put(HomeController());
  final orderController = Get.put(OrderController());
  final refreshController = RefreshController(initialRefresh: false);
  final btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      void onRefresh() {
        (Permission.location.status.then((value) => print(value)));

        controller.onRefresh();
        refreshController.refreshCompleted();
      }

      homeController.editingController.clear();
      return Scaffold(
        //backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: 100.w < 500 ? 8.h : 7.h,
          width: 100.w < 500 ? 14.w : 10.w,
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {},

            child: ShoppingCartBadge(), //icon inside button
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: CustomBottomNav(),
        appBar:
            getAppBar(context, getInitials(userController.user.userfullName)),
        body: SmartRefresher(
          physics: ScrollPhysics(),
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(),
          controller: refreshController,
          onRefresh: onRefresh,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
                child: controller.isDeviceConnected
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // // // // // // //HORIZONTAL SPACE// // // // // // // // //
                          SizedBox(
                            height: 2.h,
                          ),
                          // // // // // // //SEARCH PANEL// // // // // // // // //
                          Padding(
                            padding: EdgeInsets.only(right: 4.w, left: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 6.2.h,
                                  width: 75.w,
                                  child: Card(
                                    elevation: 5,
                                    color: kTxtLightColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(borderRaius),
                                    ),
                                    child: TextField(
                                      onChanged: (value) {},
                                      controller: controller.editingController,
                                      decoration: searchStyle,
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.fontSize),
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        //controller.editingController.clear();
                                        controller.onSearchSubmit(
                                            value, context, route.searchPage);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.5.h,
                                  width: 14.w,
                                  child: Card(
                                      elevation: 5,
                                      color: kTxtLightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100.h < 300 ? 8 : borderRaius),
                                      ),
                                      child: ShoppingCartBadge()),
                                ),
                              ],
                            ),
                          ),
                          // // // // // // //HORIZONTAL SPACE// // // // // // // // //
                          SizedBox(
                            height: 2.h,
                          ),
                          // // // // // // //CATEGORY GRID// // // // // // // // //
                          Visibility(
                            visible: !controller.isCatLoaded,
                            child: Shimmer.fromColors(
                              baseColor: kTxtColor,
                              highlightColor: kTxtColor.withOpacity(0.5),
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.fromLTRB(1, 10, 15, 1),
                                  primary: false,
                                  childAspectRatio: 0.8,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 1.h,
                                  mainAxisSpacing: 0.2.h,
                                  crossAxisCount: 3,
                                  children: List.generate(
                                      6, (index) => CatSkeletonCard()),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.isCatLoaded,
                            child: SizedBox(
                              height: 39.h,
                              width: 100.w,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 100.w < 500 ? 4.w : 3.w,
                                    right: 100.w < 500 ? 0.w : 2.w),
                                child: PageView.builder(
                                    controller: controller.pageController,
                                    itemCount: controller.pageCount,
                                    onPageChanged: (index) {
                                      controller.updateIndex(index);
                                    },
                                    itemBuilder: (_, pageIndex) {
                                      return GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        primary: false,
                                        crossAxisCount: 100.w < 500 ? 3 : 4,
                                        childAspectRatio: 100.w < 500 ? 0.8 : 1,
                                        padding: 100.w < 500
                                            ? const EdgeInsets.fromLTRB(
                                                1, 10, 15, 1)
                                            : EdgeInsets.all(4.0),
                                        mainAxisSpacing:
                                            100.w < 480 ? 0.2.h : 4,
                                        crossAxisSpacing: 100.w < 500 ? 0 : 4,
                                        shrinkWrap: true,
                                        children: List.generate(
                                            (controller.pageCount - 1) !=
                                                    pageIndex
                                                ? (100.w < 500
                                                    ? controller.perPageItem
                                                    : controller.perPageItem +
                                                        2)
                                                : controller.lastPageItemLength,
                                            (index) {
                                          return CategoryWidget(
                                              controller
                                                  .catList[index +
                                                      (pageIndex *
                                                          controller
                                                              .perPageItem)]
                                                  .categoryname!,
                                              controller
                                                  .catList[index +
                                                      (pageIndex *
                                                          controller
                                                              .perPageItem)]
                                                  .image!, () {
                                            print('object');
                                            homeController.btnGrid_onClick(
                                                controller
                                                    .catList[index +
                                                        (pageIndex *
                                                            controller
                                                                .perPageItem)]
                                                    .categoryname!,
                                                context,
                                                route.searchPage);
                                          });
                                        }),
                                      );
                                    }),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 2.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.pageCount,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: kPrimaryColor.withOpacity(
                                            controller.selectedIndex == index
                                                ? 1
                                                : 0.5)),
                                    margin: EdgeInsets.all(5),
                                    width: 4.w,
                                  ),
                                );
                              },
                            ),
                          ),

                          // // // // // // //DEALS  LIST// // // // // // // // //
                          Visibility(
                              visible: !controller.isDealLoaded,
                              child: SizedBox(
                                height: 15.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          // padding: EdgeInsets.all(0.2.h),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          // physics: NeverScrollableScrollPhysics(),
                                          itemCount: 2,
                                          itemBuilder: (_, __) =>
                                              DealSkeletonCard()),
                                    ),

                                    //DealSkeletonCard(),
                                  ],
                                ),
                              )),
                          Visibility(
                            visible: controller.isDealLoaded,
                            child: SizedBox(
                              height: 15.5.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.dealsList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: DealsCardHome(
                                          controller.dealsList[index]));
                                },
                              ),
                            ),
                          ),
                          // // // // // // //PROMOTIONS // // // // // // // // //
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 100.w < 500 ? 18.sp : 11.sp,
                                      color: kPrimaryColor,
                                      fontFamily: GoogleFonts.dancingScript()
                                          .fontFamily,
                                      fontWeight: FontWeight.bold),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      TyperAnimatedText('Specials',
                                          speed: Duration(milliseconds: 80)),
                                    ],
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                ),
                                // Text(
                                //   "Specials",
                                //   style: Theme.of(context).textTheme.titleLarge,
                                // ),
                                RoundedLoadingButton(
                                  child: Text('See All',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge),
                                  controller: RoundedLoadingButtonController(),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    homeController.btnSeeAll_onClick(
                                        context, route.searchPage);
                                  },
                                  height: 4.h,
                                  width: 30.w,
                                  animateOnTap: true,
                                  resetDuration: Duration(seconds: 2),
                                  resetAfterDuration: true,
                                  errorColor: kPrimaryColor,
                                  successColor: kTextColor,
                                ),
                              ],
                            ),
                          ),
                          // // // // // // //ITEMS GRID// // // // // // // // //
                          Visibility(
                            visible: !controller.isItemsLoaded,
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) =>
                                    SpecialsSkeletonCard()),
                          ),
                          Visibility(
                            visible: controller.isItemsLoaded,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: controller.itemList.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) =>
                                  ProductCard(item: controller.itemList[index]),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          )
                        ],
                      )
                    : NoInternetWiget(
                        btnController, controller.btnReload_onClick)),
          ),
        ),
      );
    });
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class CategoryWidget extends StatelessWidget {
  String? title;
  String? image;
  VoidCallback btnGrid_onClick;
  CategoryWidget(this.title, this.image, this.btnGrid_onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        btnGrid_onClick();
      },
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.only(right: 1.w, left: 1.w),
            elevation: 5,
            color: kTxtLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRaius),
            ),
            child: Image.network(
              image!,
              fit: BoxFit.contain,
              height: 12.h,
              width: 50.w,
            ),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Text(
            title!.capitalizeFirst!,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class DealsCardHome extends StatelessWidget {
  DealsModel? dealsModel;
  DealsCardHome(this.dealsModel);
  final dealController = Get.put(SingleDealController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dealController.isItemsLoaded = false;
        dealController.dealsModel = dealsModel!;
        dealController.getDealDetails(
          dealsModel!.dealid!,
        );

        Get.toNamed(route.singleDetailPage);
      },
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRaius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 1.5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                    width: 100.w < 500 ? 55.w : 35.w,
                    child: Marquee(
                      text: dealsModel!.dealname!.capitalizeFirst!,
                      style: Theme.of(context).textTheme.headlineLarge,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 10.0,
                      velocity: 50.0,
                      pauseAfterRound: Duration(seconds: 1),
                      startPadding: 0.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 100.w < 500 ? 40.w : 30.w,
                      child: Text(
                        getDealRules(dealsModel!),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 100.w < 500 ? 9.sp : 6.sp),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: RoundedLoadingButton(
                      borderRadius: 4,
                      child: Text('learn more'.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium),
                      controller: RoundedLoadingButtonController(),
                      color: kTxtLightColor,
                      onPressed: () {
                        dealController.isItemsLoaded = false;
                        dealController.dealsModel = dealsModel!;
                        dealController.getDealDetails(
                          dealsModel!.dealid!,
                        );

                        Get.toNamed(route.singleDetailPage);
                      },
                      height: 4.h,
                      width: 30.w,
                      animateOnTap: true,
                      resetDuration: Duration(seconds: 2),
                      resetAfterDuration: true,
                      errorColor: kPrimaryColor,
                      successColor: kTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'deal_' + dealsModel!.dealid!,
              transitionOnUserGestures: true,
              child: Image.network(
                dealsModel!.image!,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDealRules(DealsModel dealsModel) {
    String dealRule = '';
    if (dealsModel.discounttype == "price") {
      dealRule = "Buy " +
          dealsModel.dealrules!.first.qty! +
          " for " +
          (double.parse(dealsModel.dealrules!.first.priceeach!) *
                  double.parse(dealsModel.dealrules!.first.qty!))
              .toStringAsFixed(2);
    } else if (dealsModel.discounttype == "percent") {
      dealRule = "Buy " +
          dealsModel.dealrules!.first.qty! +
          " and get " +
          (double.parse(dealsModel.dealrules!.first.priceeach!))
              .toStringAsFixed(0) +
          "% discount";
    }
    return dealRule;
  }
}

class ProductCard extends StatelessWidget {
  final singleItemController = Get.put(SingleItemController());
  ItemModel? item;
  ProductCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void btnAdd_onPressed() {
      singleItemController.itemModel = item!;
      singleItemController.ingrList = [];

      singleItemController.getData();
      singleItemController.update();
      Get.toNamed(route.singleItemPage);
    }

    return GestureDetector(
      onTap: () {
        btnAdd_onPressed();
      },
      child: Card(
        elevation: 5,
        shadowColor: kTxtLightColor,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRaius),
        ),
        child: Column(
          children: [
            Expanded(
              flex: item!.onspecial == "true" ? 3 : 3,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Visibility(
                  visible: item!.onspecial == "true" ? true : false,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/specialOffer_1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 7,
              child: Hero(
                tag: 'item_${item!.id!}',
                transitionOnUserGestures: true,
                child: Image.network(
                  item!.image!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              item!.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: item!.onspecial! == "true" ? 3 : 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: item!.onspecial! == "true" ? true : false,
                          child: Text(
                            "\$" +
                                double.parse(item!.specialprice!)
                                    .toStringAsFixed(2),
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 100.w < 500 ? 10.sp : 7.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "\$" +
                              double.parse(item!.regularprice!)
                                  .toStringAsFixed(2),
                          style: TextStyle(
                            decoration: item!.onspecial! == "true"
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Colors.grey,
                            fontSize: item!.onspecial! == "true"
                                ? 100.w < 500
                                    ? 8.5.sp
                                    : 6.5.sp
                                : Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: AddButton(btnAdd_onPressed),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDiscountValue(String originalPrice, String specialPrice) {
    double discountVal =
        (double.parse(originalPrice) - double.parse(specialPrice)) /
            (double.parse(originalPrice));

    return "-" + (discountVal * 100).round().toString() + "%";
  }
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData? iconData;
  String? text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(items!.length == 2 || items!.length == 4);
  }
  final List<FABBottomAppBarItem>? items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color? color =
        _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item!.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text!,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
