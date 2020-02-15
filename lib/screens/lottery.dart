import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/lottery.dart';
import 'package:lottery/screens/lottery_detail%20copy.dart';
import 'package:lottery/widgets/countdown_timer.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/lottery.dart';

class LotteryScreen extends StatefulWidget {
  @override
  _LotteryScreenState createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  List<Lottery> _lotteries = [];
  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            child: Text('بستن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _getStoreList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<LotteryProvider>(context, listen: false)
          .fetchLotteries();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _lotteries =
          Provider.of<LotteryProvider>(context, listen: false).lotteryList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getStoreList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 32, left: 20, top: 10, bottom: 10),
                    child: Icon(
                      FontAwesomeIcons.trophy,
                      color: Colors.deepPurple,
                      size: 36,
                    ),
                  ),
                  Text(
                    'قرعه کشی',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                MyRec(width: MediaQuery.of(context).size.width),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                          itemCount: _lotteries.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<LotteryProvider>(context,
                                        listen: false)
                                    .setCurrentLottery(_lotteries[index].id);
                                Navigator.of(context)
                                    .pushNamed(LotteryDetailScreen.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 12,
                                    right:
                                        MediaQuery.of(context).size.width / 12,
                                    top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: MyCountdownTimer(
                                                  _lotteries[index].gEndDate),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
