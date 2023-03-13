import 'package:flutter/material.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = (MediaQuery.of(context).size.height -
        appBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: widthSize,
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FittedBox(child: Text("Name")),
                            const SizedBox(
                              height: 8,
                            ),
                            FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("PRO-SA2"),
                                  Text("6 x 320 ml"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const FittedBox(
                              child: Text(
                                "12.13 SR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: TextColumn(
                        label: "Quantity",
                        value: "50",
                      ),
                    ),
                    const Expanded(
                      child: TextColumn(
                        label: "Price",
                        value: "12.3 SR",
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text("Stock In"),
                        Icon(Icons.south, size: 36, color: Colors.green),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text("Inbound", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: TextColumn(
                        label: "Date",
                        value: "20/01/2022",
                      ),
                    ),
                    Expanded(
                      child: TextColumn(
                        label: "Time",
                        value: "7:00 AM",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text("Outbound", style: TextStyle(fontSize: 20)),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: TextColumn(
                        label: "Date",
                        value: "20/01/2022",
                      ),
                    ),
                    Expanded(
                      child: TextColumn(
                        label: "Time",
                        value: "1:00 PM",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Transaction Details'),
      centerTitle: true,
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        Text(label),
      ],
    );
  }
}
