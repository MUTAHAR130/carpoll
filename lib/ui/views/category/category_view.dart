import 'package:rideshare/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import '../../common/uihelper/button_helper.dart';
import '../../common/uihelper/text_helper.dart';
import 'category_viewmodel.dart';

class CategoryView extends StackedView<CategoryViewModel> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CategoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                verticalSpaceMedium,
                text_helper(
                    data: "Welcome",
                    bold: true,
                    font: poppins,
                    color: kcDarkGreyColor,
                    size: 20),
                text_helper(
                    data: "Select a Category To Continue",
                    bold: true,
                    font: poppins,
                    color: kcDarkGreyColor,
                    size: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    button_helper(
                            onpress: () => viewModel.rest(),
                            color: white,
                            width: screenWidthCustom(context, 0.4),
                            padding: const EdgeInsetsDirectional.all(10),
                            border: Border.all(width: 1, color: kcDarkGreyColor),
                            boxshadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  color: viewModel.cat == 'rider'
                                      ? kcPrimaryColor
                                      : white)
                            ],
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/bike.png',
                                  height: screenWidthCustom(context, 0.5),
                                  width: screenWidthCustom(context, 0.5),
                                ).animate(delay: 900.milliseconds).fade(),
                                verticalSpaceSmall,
                                text_helper(
                                  data: "Rider",
                                  font: montserrat,
                                  color: kcDarkGreyColor,
                                  size: fontSize14,
                                  bold: true,
                                ).animate(delay: 900.milliseconds).fade()
                              ],
                            ))
                        .animate(delay: 900.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0),
                    button_helper(
                            onpress: () => viewModel.simple(),
                            color: white,
                            width: screenWidthCustom(context, 0.4),
                            padding: const EdgeInsetsDirectional.all(10),
                            border: Border.all(width: 1, color: kcDarkGreyColor),
                            boxshadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  color: viewModel.cat == 'user'
                                      ? kcPrimaryColor
                                      : white)
                            ],
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/passenger.png',
                                  height: screenWidthCustom(context, 0.5),
                                  width: screenWidthCustom(context, 0.5),
                                ).animate(delay: 1100.milliseconds).fade(),
                                verticalSpaceSmall,
                                text_helper(
                                  data: "Passenger",
                                  font: montserrat,
                                  color: kcDarkGreyColor,
                                  size: fontSize14,
                                  bold: true,
                                ).animate(delay: 1100.milliseconds).fade()
                              ],
                            ))
                        .animate(delay: 1100.milliseconds)
                        .fade()
                        .moveY(begin: 50, end: 0),
                  ],
                ),
                button_helper(
                        onpress: () => viewModel.next(context),
                        color: kcPrimaryColor,
                        width: screenHeightCustom(context, 0.2),
                        child: text_helper(
                          data: "Next",
                          font: poppins,
                          color: kcDarkGreyColor,
                          size: fontSize14,
                          bold: true,
                        ))
                    .animate(delay: 1300.milliseconds)
                    .fade()
                    .moveY(begin: 50, end: 0),
              ],
            ),
          ),
        ));
  }

  @override
  CategoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoryViewModel();
}
