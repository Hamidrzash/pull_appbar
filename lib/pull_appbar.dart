library pull_appbar;

import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TitleItem {
  final Widget widget;
  final int index;
  TitleItem({required this.widget, required this.index});
}

class PullAppBar extends StatefulWidget {
  final List<Widget> titles;
  final List<Widget> children;
  final List<TitleItem> titleItems;
  final double viewportFraction;
  final int initialPage;
  final bool keepPage;
  final bool allowHorizontalSwipe;
  final ValueChanged<int>? onTitleChanged;
  final ValueChanged<int>? onPageChanged;

  PullAppBar({
    super.key,
    required this.titles,
    required this.children,
    this.viewportFraction = 1 / 2,
    this.initialPage = 0,
    this.onPageChanged,
    this.keepPage = true,
    this.onTitleChanged,
    this.allowHorizontalSwipe = true,
  }) : titleItems = titles.mapIndexed((index, widget) => TitleItem(widget: widget, index: index)).toList();

  @override
  State<PullAppBar> createState() => _PullAppBarState();
}

class _PullAppBarState extends State<PullAppBar> {
  late final _appBarController = PageController(
    viewportFraction: widget.viewportFraction,
    initialPage: widget.initialPage,
    keepPage: widget.keepPage,
  );
  late final ValueNotifier<int> selectedTitleIndex = ValueNotifier(widget.initialPage);
  late final ValueNotifier<int> pageIndex = ValueNotifier(widget.initialPage);
  final ValueNotifier<int> overScrollPixels = ValueNotifier(0);
  final ValueNotifier<bool> showLoading = ValueNotifier(false);
  bool isChangingPage = false;
  bool isChangingTitle = false;

  @override
  void initState() {
    pageIndex.addListener(() {
      if (widget.onPageChanged != null) {
        widget.onPageChanged!(pageIndex.value);
      }
    });
    if (widget.allowHorizontalSwipe) {
      _appBarController.addListener(() {
        if (selectedTitleIndex.value != (_appBarController.page ?? 0).round() && !isChangingTitle) {
          selectedTitleIndex.value = (_appBarController.page ?? 0).round();
          _appBarController.animateToPage(selectedTitleIndex.value,
              duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
          pageIndex.value = selectedTitleIndex.value;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification &&
            notification.metrics.axis == Axis.vertical &&
            notification.dragDetails != null) {
          final pixels = notification.metrics.pixels.abs();
          overScrollPixels.value = pixels.toInt();
          isChangingPage = false;
          if (pixels > 0 && pixels < 60 && !isChangingTitle) {
            isChangingTitle = true;
            selectedTitleIndex.value = 0;
            _appBarController
                .animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut)
                .then((value) => isChangingTitle = false);
          }
          if (pixels > 60 && pixels < 120 && !isChangingTitle) {
            isChangingTitle = true;
            selectedTitleIndex.value = 1;
            _appBarController
                .animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut)
                .then((value) => isChangingTitle = false);
          }
          if (pixels > 120 && pixels < 180 && !isChangingTitle) {
            isChangingTitle = true;
            selectedTitleIndex.value = 2;
            _appBarController
                .animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut)
                .then((value) => isChangingTitle = false);
          }
          if (pixels > 180 && !isChangingTitle) {
            isChangingTitle = true;
            selectedTitleIndex.value = 3;
            _appBarController
                .animateToPage(3, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut)
                .then((value) => isChangingTitle = false);
          }
        }
        if (notification is ScrollUpdateNotification &&
            notification.metrics.axis == Axis.vertical &&
            notification.dragDetails == null) {
          final pixels = notification.metrics.pixels.abs();
          overScrollPixels.value = pixels.toInt();
          showLoading.value = false;
          pageIndex.value = widget.titleItems[selectedTitleIndex.value].index;
          if (pixels == 0 && !isChangingPage) {
            isChangingPage = true;
            final item = widget.titleItems[selectedTitleIndex.value];
            widget.titleItems.removeAt(selectedTitleIndex.value);
            widget.titleItems.sort((a, b) => a.index.compareTo(b.index));
            widget.titleItems.insert(0, item);

            if (_appBarController.hasClients) {
              selectedTitleIndex.value = 0;
              _appBarController.jumpToPage(0);
            }
            Future.delayed(const Duration(milliseconds: 200)).then((value) => showLoading.value = false);
          }
        }

        return true;
      },
      child: CustomScrollView(
        physics: const CustomBouncingScrollPhysics(),
        scrollBehavior: MyCustomScrollBehavior(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            titleSpacing: 0,
            title: SizedBox(
              height: 75,
              child: ValueListenableBuilder(
                valueListenable: selectedTitleIndex,
                builder: (context, value, child) {
                  return IgnorePointer(
                    ignoring: !widget.allowHorizontalSwipe,
                    child: PageView(
                      key: Key('pageIndex${selectedTitleIndex.value < 10 && isChangingPage ? 0 : 1}'),
                      onPageChanged: (value) {
                        if (widget.onTitleChanged != null) {
                          widget.onTitleChanged!(value);
                        }
                      },
                      controller: _appBarController,
                      children: widget.titleItems
                          .mapIndexed(
                            (i, e) => ValueListenableBuilder(
                              valueListenable: overScrollPixels,
                              builder: (context, pixels, child) => Center(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  opacity: selectedTitleIndex.value == i
                                      ? 1
                                      : pixels < 10
                                          ? 0
                                          : 0.5,
                                  child: e.widget,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            stretch: true,
            pinned: true,
          ),
          NotificationListener(
            onNotification: (notification) => true,
            child: ValueListenableBuilder(
              valueListenable: showLoading,
              builder: (context, isLoading, child) => SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: true,
                child: ValueListenableBuilder(
                  valueListenable: pageIndex,
                  builder: (context, index, child) {
                    return widget.children[index];
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBouncingScrollPhysics extends BouncingScrollPhysics {
  const CustomBouncingScrollPhysics({super.parent});

  @override
  CustomBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value > 0) {
      return value;
    }

    return 0;
  }

  @override
  double frictionFactor(double overscrollFraction) {
    return 0.7 * (1 - overscrollFraction);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
