import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';
import '../constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender=Gender.male;
  int height = 180;
  int weight = 60;
  int age = 19;
  Color maleCardColour = inactiveCardColour;
  Color femaleCardColour = inactiveCardColour;
  void updateColour(Gender selectedgender){
    //male card pressed
    if (selectedgender==Gender.male){
      if(maleCardColour==inactiveCardColour){
        maleCardColour=kActiveCardColour;
        femaleCardColour=inactiveCardColour;
      }
      else{
        maleCardColour=inactiveCardColour;
      }
    }
    //female card pressed
    if (selectedgender==Gender.female){
      if(femaleCardColour==inactiveCardColour){
        femaleCardColour=kActiveCardColour;
        maleCardColour=inactiveCardColour;
      }
      else{
        femaleCardColour=inactiveCardColour;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroungColor,
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        // selectedGender = Gender.female;
                        updateColour(Gender.male);
                      });
                    },
                    colour: maleCardColour,
                    // colour:  selectedGender==Gender.male
                    //     ? kActiveCardColour
                    //     : inactiveCardColour,
                    cardChild: IconContent(
                        icon: FontAwesomeIcons.mars, label: 'MALE'),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        // selectedGender = Gender.female;
                        updateColour(Gender.female);
                      });
                    },
                    colour: femaleCardColour,
                    // colour: selectedGender == Gender.female
                    //     ? kActiveCardColour
                    //     : inactiveCardColour,
                    cardChild: IconContent(
                        icon: FontAwesomeIcons.venus, label: 'FEMALE'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ReusableCard(
                onPress: () {},
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kCardStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          min: 120,
                          max: 220,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kCardStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPress: () {
                                  setState(() {
                                    weight++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kCardStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPress: () {
                                  setState(() {
                                    age++;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BottomButton(
              buttonTitle: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc =CalculatorBrain(height: height, weight: weight);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.getResults(),
                      interpretation: calc.getInterpretation(),
                    )));
              },
            ),
          ],
        ));
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Gender>('selectedGender', selectedGender));
  }
}
