import 'package:e_commerce_task/views/items_list/items_list.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/actions_row.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/search_section.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class TransactionsListScreen extends StatelessWidget {
  const TransactionsListScreen({Key? key}) : super(key: key);

  static const routeName = '/transactionsListScreen';

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: heightSize,
              width: widthSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SearchSection(),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: TransactionsList(
                        widthSize: widthSize, heightSize: heightSize),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: ActionsRow(),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Transactions'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ItemsListScreen.routeName);
          },
          icon: const Icon(Icons.add),
        ),
      ],
      centerTitle: true,
    );
  }
}
