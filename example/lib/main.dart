import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tornpaper/tornpaper.dart';

void main() {
  runApp(MyApp());
}

/// Example App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tornpaper Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Tornpaper Example'),
    );
  }
}

/// Example Mainpage
class MyHomePage extends StatefulWidget {

  /// Constructor
  MyHomePage({Key? key, required this.title}) : super(key: key);

  /// Example title
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Done
  bool tornedTop = true;
  bool tornedBottom = true;
  bool tornedLeft = true;
  bool tornedRight = true;
  bool hasBorder = true;
  Color tornColor = Colors.black;
  double tornDeepness = 5.0;
  double seedValue = 200;
  int stepWidth = 8;
  double tornWidth = 1.0;
  Color backgroundColor = const Color.fromRGBO(215, 215, 160, 1.0);
  bool hasNoise = false;
  Color noiseColor = Colors.white;
  bool hasShadow = true;
  Color shadowColor = Colors.black;
  int shadowOffsetBottom = 8;
  int shadowOffsetRight = 8;

  void changeShadowColor(Color color) {
    setState(() => shadowColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  TornPaper(
                      key: UniqueKey(),
                      backgroundColor: backgroundColor,
                      hasNoise: hasNoise,
                      noiseColor: noiseColor,
                      hasBorder: hasBorder,
                      tornWidth: tornWidth,
                      tornColor: tornColor,
                      tornDeepness: tornDeepness,
                      seed: seedValue.toInt(),
                      stepWidth: stepWidth,
                      hasShadow: hasShadow,
                      shadowColor: shadowColor,
                      shadowOffset: Offset(shadowOffsetBottom.toDouble(),
                          shadowOffsetRight.toDouble()),
                      tornedSides: [
                        if (tornedTop) TornedSide.top,
                        if (tornedRight) TornedSide.right,
                        if (tornedLeft) TornedSide.left,
                        if (tornedBottom) TornedSide.bottom
                      ],
                      child: Container()),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "TornPaper - Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Row(
                              children: const [
                                const Text("Torned Sides"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: tornedTop,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tornedTop = value!;
                                    });
                                  },
                                ),
                                const Text("Top"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: tornedBottom,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tornedBottom = value!;
                                    });
                                  },
                                ),
                                const Text("Bottom"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: tornedLeft,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tornedLeft = value!;
                                    });
                                  },
                                ),
                                const Text("Left"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: tornedRight,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tornedRight = value!;
                                    });
                                  },
                                ),
                                const Text("Right"),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Torn StepWidth"),
                                Slider(
                                  value: stepWidth.toDouble(),
                                  min: 1,
                                  max: 50,
                                  divisions: 49,
                                  label: stepWidth.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      stepWidth = value.toInt();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Torn Deepness"),
                                Slider(
                                  value: tornDeepness.toDouble(),
                                  min: 0,
                                  max: 20,
                                  divisions: 200,
                                  label: tornDeepness.toStringAsFixed(2),
                                  onChanged: (double value) {
                                    setState(() {
                                      tornDeepness = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: hasBorder,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      hasBorder = value!;
                                    });
                                  },
                                ),
                                const Text("Has Border "),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Text("Border Color "),
                                  IconButton(
                                      icon: const Icon(Icons.color_lens),
                                      color: tornColor,
                                      onPressed: !hasBorder
                                          ? null
                                          : () => showShadowColorDialog(
                                              context,
                                              tornColor,
                                              (color) => setState(
                                                  () => tornColor = color)))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Text("Torn width"),
                                  Slider(
                                    value: tornWidth.toDouble(),
                                    min: 0.1,
                                    max: 10.0,
                                    divisions: 99,
                                    label: tornWidth.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        tornWidth = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Text("Seed"),
                                Slider(
                                  value: seedValue.toDouble(),
                                  min: 0,
                                  max: 1000,
                                  divisions: 500,
                                  label: seedValue.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      seedValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Background Color "),
                                IconButton(
                                    icon: const Icon(Icons.color_lens),
                                    color: Colors.black,
                                    onPressed: () => showShadowColorDialog(
                                        context,
                                        backgroundColor,
                                        (color) => setState(
                                            () => backgroundColor = color)))
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: hasShadow,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      hasShadow = value!;
                                    });
                                  },
                                ),
                                const Text("Has Shadow"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Text("Shadow Color "),
                                  IconButton(
                                      icon: const Icon(Icons.color_lens),
                                      color: shadowColor,
                                      onPressed: hasShadow
                                          ? () => showShadowColorDialog(
                                              context,
                                              shadowColor,
                                              (color) => setState(
                                                  () => shadowColor = color))
                                          : null)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Text("Shadow Offset "),
                                  Column(
                                    children: [
                                      Slider(
                                        value: shadowOffsetBottom.toDouble(),
                                        min: -100,
                                        max: 100,
                                        divisions: 200,
                                        label: shadowOffsetBottom
                                            .round()
                                            .toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            shadowOffsetBottom = value.toInt();
                                          });
                                        },
                                      ),
                                      Slider(
                                        value: shadowOffsetRight.toDouble(),
                                        min: -100,
                                        max: 100,
                                        divisions: 200,
                                        label: shadowOffsetRight
                                            .round()
                                            .toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            shadowOffsetRight = value.toInt();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            const Text("Experimental"),
                            Row(
                              children: [
                                Checkbox(
                                  value: hasNoise,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      hasNoise = value!;
                                    });
                                  },
                                ),
                                const Text("Has Noise"),
                                IconButton(
                                    icon: const Icon(Icons.color_lens),
                                    color: noiseColor,
                                    onPressed: () => showShadowColorDialog(
                                        context,
                                        noiseColor,
                                        (color) => setState(
                                            () => noiseColor = color))),
                                const Text("Warning: Extremly unperformant!"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showShadowColorDialog(
      BuildContext context, Color color, Function(Color color) setColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ColorPicker(
                pickerColor: color,
                onColorChanged: setColor,
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text("OK"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
