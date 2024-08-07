import 'package:rideshare/ui/common/app_colors.dart';
import 'package:rideshare/ui/common/app_strings.dart';
import 'package:rideshare/ui/common/ui_helpers.dart';
import 'package:rideshare/ui/common/uihelper/text_helper.dart';
import 'package:rideshare/ui/common/uihelper/text_veiw_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/apihelpers/apihelper.dart';
import 'chating_viewmodel.dart';

class ChatingView extends StackedView<ChatingViewModel> {
  ChatingView({Key? key, required this.id, required this.did})
      : super(key: key);
  String id, did;

  @override
  Widget builder(
    BuildContext context,
    ChatingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcPrimaryColor,
        title: text_helper(
          data: "Chat",
          font: poppins,
          color: kcDarkGreyColor,
          size: fontSize14,
          bold: true,
        ),
      ),
      backgroundColor: white,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiHelper.allchatbyid(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['c'].toString() == '[]') {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    List l = List.of(snapshot.data['c']).reversed.toList();
                    return ListView.builder(
                      itemCount: l.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: l[index]['sendby'] ==
                                  viewModel.sharedpref.readString("number")
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: l[index]['sendby'] ==
                                        viewModel.sharedpref
                                            .readString("number")
                                    ? getColorWithOpacity(Colors.green, 0.3)
                                    : getColorWithOpacity(Colors.amber, 0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: text_helper(
                                data: l[index]['mess'].toString(),
                                font: montserrat,
                                color: kcDarkGreyColor,
                                size: fontSize12,
                                bold: true,
                                textAlign: TextAlign.start,
                              )),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Icon(
                    Icons.error,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: text_view_helper(
                        hint: "Enter Message",
                        showicon: true,
                        icon: const Icon(Icons.chat),
                        background: getColorWithOpacity(kcVeryLightGrey, 0.4),
                        controller: viewModel.chat)),
                InkWell(
                  onTap: () async {
                    await ApiHelper.addchat(
                        id,
                        {
                          "sendby": viewModel.sharedpref.readString("number"),
                          "mess": viewModel.chat.text,
                          "date": DateTime.now().toString()
                        },
                        did);
                    viewModel.chat.clear();
                    viewModel.notifyListeners();
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getColorWithOpacity(kcVeryLightGrey, 0.4),
                      ),
                      child: const Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatingViewModel();
}
