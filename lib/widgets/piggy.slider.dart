import 'package:flutter/material.dart';

class PiggySlider extends StatelessWidget {
  const PiggySlider(
      {Key key,
      this.value,
      this.onChange,
      this.maxMinTextTrailing,
      this.trackColor})
      : super(key: key);

  final double value;
  final Function(double) onChange;
  final Text maxMinTextTrailing;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
          trackShape: CustomTrackShape(), thumbColor: Colors.black),
      child: Column(
        children: <Widget>[
          Slider(
            onChanged: (value) => onChange(value),
            min: 0,
            max: 100,
            activeColor: trackColor ?? Theme.of(context).primaryColor,
            inactiveColor: trackColor ?? Theme.of(context).primaryColor,
            divisions: 100,
            label: value.round().toString(),
            value: value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("0 "),
                  maxMinTextTrailing ?? Image.asset('assets/images/coin.png'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    value.round().toString() + " " + maxMinTextTrailing.data,
                    style: Theme.of(context).textTheme.display3,
                  ),             
                ],
              ),
              Row(
                children: <Widget>[
                  Text("100 ", style: Theme.of(context).textTheme.subtitle),
                  maxMinTextTrailing ?? Image.asset('assets/images/coin.png'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight + 35) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}