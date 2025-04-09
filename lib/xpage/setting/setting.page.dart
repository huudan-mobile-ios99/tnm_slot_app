import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament_client/lib/socket/socket_manager.dart';
import 'package:tournament_client/service/format.date.factory.dart';
import 'package:tournament_client/service/service_api.dart';
import 'package:tournament_client/utils/mycolors.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/widget/showsnackbar.dart';
import 'package:tournament_client/widget/textfield.dart';
import 'package:tournament_client/xpage/setting/bloc_setting/settting_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tournament_client/xpage/setting/dialog.confirm.dart';

class SettingPage extends StatefulWidget {
  SocketManager? mySocket;
  SettingPage({required this.mySocket, Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController controllerMinBet = TextEditingController();
  final TextEditingController controllerMaxBet = TextEditingController();
  final TextEditingController controllerTotalRoud = TextEditingController();
  final TextEditingController controllerCurrentRound = TextEditingController();
  final TextEditingController controllerLastUpdate = TextEditingController();
  final TextEditingController controllerBuyIn = TextEditingController();
  final TextEditingController controllerBuyInText = TextEditingController();
  final formatNumber = DateFormatter();

  //Setting JP VEGAS
  final TextEditingController controllerJPMin = TextEditingController(text: '${MyString.JPPriceMin}');
  final TextEditingController controllerJPMax = TextEditingController(text: "${MyString.JPPriceMax}");
  final TextEditingController controllerJPPercent = TextEditingController(text: "${MyString.JPPricePercent}");
  final TextEditingController controllerJPThreshold =TextEditingController(text: "${MyString.JPPriceThresHold}");
  final TextEditingController controllerJPduration =TextEditingController(text: "${MyString.JPThrotDuration}");
  //Setting JP LUCKY
  final TextEditingController controllerJPMin2 =
      TextEditingController(text: '${MyString.JPPriceMin2}');
  final TextEditingController controllerJPMax2 =
      TextEditingController(text: "${MyString.JPPriceMax2}");
  final TextEditingController controllerJPPercent2 =
      TextEditingController(text: "${MyString.JPPricePercent2}");
  final TextEditingController controllerJPThreshold2 =
      TextEditingController(text: "${MyString.JPPriceThresHold2}");
  final TextEditingController controllerJPduration2 =
      TextEditingController(text: "${MyString.JPThrotDuration2}");
  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    controllerMinBet.dispose();
    controllerMaxBet.dispose();
    controllerTotalRoud.dispose();
    controllerCurrentRound.dispose();
    controllerLastUpdate.dispose();

    controllerBuyIn.dispose();
    controllerBuyInText.dispose();
    super.dispose();
  }

  void _setControllerValues(SettingState state) {
    controllerMinBet.text = '${state.posts.first.minbet}';
    controllerMaxBet.text = '${state.posts.first.maxbet}';
    controllerTotalRoud.text = '${state.posts.first.remaingame}';
    controllerCurrentRound.text = '${state.posts.first.run}';
    controllerBuyIn.text = '${state.posts.first.buyin}';
    controllerLastUpdate.text =formatNumber.formatDateAndTime(state.posts.first.lastupdate);
    controllerBuyInText.text = '${state.posts.first.roundtext}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceAPIs = ServiceAPIs();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(MyString.padding16),
      child: BlocProvider(
          // lazy: false,
          create: (_) =>SetttingBloc(httpClient: http.Client())..add(SettingFetched()),
          child: BlocListener<SetttingBloc, SettingState>(
            listener: (context, state) {
              if (state.status == SettingStatus.success &&
                  state.posts.isNotEmpty) {
                  _setControllerValues(state);
              }
            },
            child: BlocBuilder<SetttingBloc, SettingState>(
              builder: (context, state) {
                switch (state.status) {
                  case SettingStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case SettingStatus.failure:
                    return const Center(
                        child: Text('An error orcur when fetch settings'));
                  case SettingStatus.success:
                    if (state.posts.isEmpty) {
                      return const Center(child: Text('No settings found'));
                    }
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Setting JP"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Tooltip(
                                    message: "Display JP in client view",
                                    child: ElevatedButton.icon(
                                        label: const Text("Display & View JP"),
                                        onPressed: () {
                                          showConfirmationDialog(context,"Setting JP: Display, View & Reset JP (vegas prize)",
                                            () {
                                            widget.mySocket!.emitJackpotNumberInit();
                                          });
                                        },
                                        icon:
                                            const Icon(Icons.airplay_rounded)),
                                  ),
                                  const SizedBox(
                                    width: MyString.padding24,
                                  ),
                                  Tooltip(
                                    message: "Display JP 2 in client view",
                                    child: ElevatedButton.icon(
                                        label: const Text("Display & View JP 2 "),
                                        onPressed: () {
                                          showConfirmationDialog(context,
                                              "Setting JP 2: Display, View & Reset JP 2 (lucky prize) ",
                                              () {
                                            widget.mySocket! .emitJackpot2NumberInit();
                                          });
                                        },
                                        icon:
                                            const Icon(Icons.airplay_rounded)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //VEGAS PRICE
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon:const Icon(Icons.attach_money_outlined),
                                    label: "Min JP",
                                    text: controllerJPMin.text,
                                    controller: controllerJPMin,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon:const Icon(Icons.attach_money_outlined),
                                    label: "Max JP",
                                    text: controllerJPMax.text,
                                    controller: controllerJPMax,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon:
                                        const Icon(Icons.attach_money_outlined),
                                    label: "Threshold JP",
                                    text: controllerJPThreshold.text,
                                    controller: controllerJPThreshold,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon: const Icon(Icons.percent),
                                    label: "Percent JP",
                                    text: controllerJPPercent.text,
                                    controller: controllerJPPercent,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon: const Icon(Icons.timer),
                                    label: "Duration(second)",
                                    text: controllerJPduration.text,
                                    controller: controllerJPduration,
                                    enable: false,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          //LUCKY PRICE
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon:const Icon(Icons.attach_money_outlined),
                                    label: "Min JP 2",
                                    text: controllerJPMin2.text,
                                    controller: controllerJPMin2,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon: const Icon(Icons.attach_money_outlined),
                                    label: "Max JP 2",
                                    text: controllerJPMax2.text,
                                    controller: controllerJPMax2,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon:
                                        const Icon(Icons.attach_money_outlined),
                                    label: "Threshold JP 2",
                                    text: controllerJPThreshold2.text,
                                    controller: controllerJPThreshold2,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon: const Icon(Icons.percent),
                                    label: "Percent JP 2",
                                    text: controllerJPPercent2.text,
                                    controller: controllerJPPercent2,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 6,
                                    icon: const Icon(Icons.timer),
                                    label: "Duration 2(second)",
                                    text: controllerJPduration2.text,
                                    controller: controllerJPduration2,
                                    enable: false,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          //JP button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                iconAlignment: IconAlignment.start,
                                onPressed: () {
                                  showConfirmationDialog(context,
                                      "Update Setting JP (Vegas Prize)", () {
                                    debugPrint("showConfirmationDialog JP");
                                    debugPrint(
                                        "Percent value: ${controllerJPPercent.text}");
                                    debugPrint(
                                        "Min value: ${controllerJPMin.text}");
                                    debugPrint(
                                        "Max value: ${controllerJPMax.text}");
                                    debugPrint(
                                        "defaultThreshold value: ${controllerJPThreshold.text}");
                                    debugPrint(
                                        "duration value: ${controllerJPduration.text}");

                                    Map<String, dynamic> newSettings = {
                                      "oldValue":
                                          double.parse(controllerJPMin.text),
                                      "returnValue": double.parse(controllerJPMin
                                          .text), // Example of updating just one or more fields
                                      "limit":
                                          double.parse(controllerJPMax.text),
                                      "defaultThreshold": double.parse(
                                          controllerJPThreshold.text),
                                      "throttleInterval": double.parse(
                                          controllerJPduration.text),
                                      "percent":
                                          double.parse(controllerJPPercent.text)
                                    };
                                    validateInput(
                                                percent:
                                                    controllerJPPercent.text,
                                                min: controllerJPMin.text,
                                                max: controllerJPMax.text,
                                                threshold: controllerJPThreshold
                                                    .text) ==
                                            true
                                        ? {
                                            widget.mySocket!
                                                .updateJackpotSettings(
                                                    newSettings),
                                            showSnackBar(
                                                context: context,
                                                message: "Setting JP Update")
                                          }
                                        : showSnackBarError(
                                            context: context,
                                            message:
                                                "Setting JP Not Update, Invalid Fields");
                                  });
                                },
                                label: const Text("Update Setting"),
                                icon: const Icon(Icons.settings_outlined),
                              ),
                              const SizedBox(
                                width: MyString.padding24,
                              ),
                              ElevatedButton.icon(
                                iconAlignment: IconAlignment.start,
                                onPressed: () {
                                  showConfirmationDialog(context,"Update Setting JP (Lucky Price)", () {
                                    debugPrint("showConfirmationDialog JP 2");
                                    debugPrint(
                                        "Percent2 value: ${controllerJPPercent2.text}");
                                    debugPrint(
                                        "Min2 value: ${controllerJPMin2.text}");
                                    debugPrint(
                                        "Max2 value: ${controllerJPMax2.text}");
                                    debugPrint(
                                        "defaultThreshold2 value: ${controllerJPThreshold2.text}");
                                    debugPrint(
                                        "duration2 value: ${controllerJPduration2.text}");

                                    Map<String, dynamic> newSettings = {
                                      "oldValue": double.parse(controllerJPMin2.text),
                                      "returnValue": double.parse(controllerJPMin2.text), // Example of updating just one or more fields
                                      "limit":double.parse(controllerJPMax2.text),
                                      "defaultThreshold": double.parse(controllerJPThreshold2.text),
                                      "throttleInterval": double.parse(controllerJPduration2.text),
                                      "percent": double.parse(controllerJPPercent2.text)
                                    };
                                    validateInput(
                                                percent:
                                                    controllerJPPercent2.text,
                                                min: controllerJPMin2.text,
                                                max: controllerJPMax2.text,
                                                threshold:
                                                    controllerJPThreshold2
                                                        .text) ==
                                            true
                                        ? {
                                            widget.mySocket!
                                                .updateJackpot2Settings(
                                                    newSettings),
                                            showSnackBar(
                                                context: context,
                                                message: "Setting JP 2  Update")
                                          }
                                        : showSnackBarError(
                                            context: context,
                                            message:
                                                "Setting JP 2  Not Update, Invalid Fields");
                                  });
                                },
                                label: const Text("Update Setting 2"),
                                icon: const Icon(Icons.settings_outlined),
                              ),
                            ],
                          ),

                          const Divider(color: MyColor.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Setting Game"),
                              Tooltip(
                                message: "Display game setting in client view",
                                child: ElevatedButton.icon(
                                    label: const Text("Dislay"),
                                    onPressed: () {
                                      showConfirmationDialog(
                                        context, "Setting Game", () {
                                        widget.mySocket!.emitSetting();
                                      });
                                    },
                                    icon: const Icon(Icons.airplay_rounded)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon:const Icon(Icons.attach_money_outlined),
                                    label: "Min Bet",
                                    text: controllerMinBet.text,
                                    controller: controllerMinBet,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon: const Icon(Icons.attach_money_outlined),
                                    label: "Max Bet",
                                    text: controllerMaxBet.text,
                                    controller: controllerMaxBet,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon:
                                        const Icon(Icons.attach_money_outlined),
                                    label: "Buy-In (Minutes)",
                                    text: controllerBuyIn.text,
                                    controller: controllerBuyIn,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding04,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon: const Icon(Icons.lock_clock_rounded),
                                    label: "Buy-In (Text)",
                                    text: controllerBuyInText.text,
                                    controller: controllerBuyInText,
                                    enable: true,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon: const Icon(Icons.airplay),
                                    label: "Remain Round",
                                    text: controllerTotalRoud.text,
                                    controller: controllerTotalRoud,
                                    enable: true,
                                    textinputType: TextInputType.number),
                                const SizedBox(
                                  width: MyString.padding08,
                                ),
                                mytextFieldTitleSizeIcon(
                                    width: width / 5,
                                    icon: const Icon(Icons.airplay),
                                    label: "Current Round",
                                    text: controllerCurrentRound.text,
                                    controller: controllerCurrentRound,
                                    enable: true,
                                    textinputType: TextInputType.number),
                              ],
                            ),
                          ),

                           ElevatedButton.icon(
                              icon: const Icon(Icons.settings_outlined),
                              onPressed: () {
                                debugPrint("Update Setting ");
                                showConfirmationDialog(
                                  context,
                                  "Update Setting",
                                  () {
                                    // Action when confirmed
                                    // debugPrint("Confirmed action executed");
                                    // debugPrint("min: ${controllerMinBet.text}");
                                    // debugPrint("max: ${controllerMaxBet.text}");
                                    // debugPrint("current: ${controllerCurrentRound.text}");
                                    // debugPrint("total: ${controllerTotalRoud.text}");
                                    // debugPrint("buy in: ${controllerBuyIn.text}");
                                    // debugPrint("buy in note: ${controllerBuyInNote.text}");

                                    serviceAPIs
                                        .updateSetting(
                                            remaintime:'${state.posts.first.remaintime}',
                                            remaingame: int.parse(controllerTotalRoud.text),
                                            minbet: int.parse(controllerMinBet.text),
                                            maxbet: int.parse(controllerMaxBet.text),
                                            run: int.parse(controllerCurrentRound.text),
                                            lastupdate: DateTime.now().toIso8601String(),
                                            gamenumber:state.posts.first.gamenumber!,
                                            roundtext:controllerBuyInText.text,
                                            gametext:state.posts.first.gametext!,
                                            buyin:int.parse(controllerBuyIn.text))
                                        .then((v) {
                                      if (v['status'] == 1) {
                                        showSnackBar(
                                            context: context,
                                            message: "${v['message']}");
                                      } else {
                                        showSnackBar(
                                            context: context,
                                            message: "Can not update setting ");
                                      }
                                    }).whenComplete(() {
                                      debugPrint('complete update APIs');
                                    });
                                  },
                                );
                              },
                              label: const Text("Update Setting")),
                        ],
                      ),
                    );
                }
              },
            ),
          )),
    );
  }
}

bool? validateInput(
    {String? percent, String? min, String? max, String? threshold}) {
  // Check if all inputs are provided and are numbers
  final percentNumber = double.tryParse(percent ?? '');
  final minNumber = double.tryParse(min ?? '');
  final maxNumber = double.tryParse(max ?? '');
  final thresholdNumber = double.tryParse(threshold ?? '');
  // Return false if any input is null or not a number
  if (percentNumber == null ||
      minNumber == null ||
      maxNumber == null ||
      thresholdNumber == null) {
    return false;
  }
  // Validate percent < 1
  if (percentNumber >= MyString.JPPercentMax) {
    return false;
  }
  // Validate min < threshold < max
  if (!(minNumber < thresholdNumber && thresholdNumber < maxNumber)) {
    return false;
  }
  return true; // All validations passed
}
