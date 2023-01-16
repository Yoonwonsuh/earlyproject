import 'package:earlyproject/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../constants/common_size.dart';

class AdressPage extends StatelessWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: common_padding, right: common_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: '도로명으로 검색',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24, minHeight: 24)),
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  minimumSize: Size(10, 48),
                  backgroundColor: Theme.of(context).primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore_outlined, color: Colors.white),
                  Text(
                    '현재위치로 찾기',
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              )),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: common_padding),
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.image),
                  trailing: ExtendedImage.asset('assets/imgs/tomato.png'),
                  title: Text('타이틀 ${index}'),
                  subtitle: Text('서브타이틀'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
