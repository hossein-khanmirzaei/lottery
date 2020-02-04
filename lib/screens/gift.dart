import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/widgets/rec.dart';

class GiftScreen extends StatefulWidget {
  @override
  _GiftScreenState createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  var _isLoading = false;
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
                        // child: ListView.builder(
                        //   itemCount: _stores.length,
                        //   itemBuilder: (context, index) {
                        //     return GestureDetector(
                        //       onTap: () {
                        //         Provider.of<StoreProvider>(context,
                        //                 listen: false)
                        //             .setCurrentStore(_stores[index].id);
                        //         Navigator.of(context)
                        //             .pushNamed(StoreDetailScreen.routeName);
                        //       },
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Colors.grey,
                        //           ),
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //         margin: EdgeInsets.only(
                        //             left:
                        //                 MediaQuery.of(context).size.width / 12,
                        //             right:
                        //                 MediaQuery.of(context).size.width / 12,
                        //             top: 20),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: <Widget>[
                        //             Expanded(
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: <Widget>[
                        //                   Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: Text(
                        //                       _stores[index].name,
                        //                       style: TextStyle(fontSize: 18),
                        //                     ),
                        //                   ),
                        //                   Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: Align(
                        //                       alignment: Alignment.bottomLeft,
                        //                       child: Text(
                        //                         'شماره واحد: ' +
                        //                             _stores[index]
                        //                                 .unitNumber
                        //                                 .toString(),
                        //                         style: TextStyle(fontSize: 12),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
