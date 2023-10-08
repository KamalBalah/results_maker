import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class SheetTableWidget extends StatelessWidget {
  const SheetTableWidget({
    super.key,
    required this.listData,
    required this.isRTL,
  });

  final List<List<Data?>> listData;
  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Table(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            defaultColumnWidth: const FlexColumnWidth(50),
            columnWidths: const {
              0: FlexColumnWidth(150),
              1: FlexColumnWidth(70)
            },
            border: TableBorder.all(
              width: 1,
              color: Colors.black,
            ),
            children: [
              TableRow(
                children: listData[0]
                    .map((Data? e) => Container(
                          padding: (e?.cellIndex.columnIndex ?? 1) > 0
                              ? null
                              : const EdgeInsetsDirectional.only(start: 10),
                          child: Text(
                            e?.value.toString() ?? "NULL",
                            textAlign: (e?.cellIndex.columnIndex ?? 1) > 0
                                ? TextAlign.center
                                : TextAlign.start,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Table(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                  defaultColumnWidth: const FlexColumnWidth(50),
                  columnWidths: const {
                    0: FlexColumnWidth(150),
                    1: FlexColumnWidth(70)
                  },
                  border: TableBorder.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  children: listData
                      .sublist(1, listData.length)
                      .map(
                        (e) => TableRow(
                          children: e
                              .map(
                                (ee) => Container(
                                  padding: (ee?.cellIndex.columnIndex ?? 1) > 0
                                      ? const EdgeInsetsDirectional.only(
                                          bottom: 5,
                                          top: 5,
                                        )
                                      : const EdgeInsetsDirectional.only(
                                          start: 10,
                                          bottom: 5,
                                          top: 5,
                                        ),
                                  child: Text(
                                    ee?.value.toString() ?? "NULL",
                                    textAlign:
                                        (ee?.cellIndex.columnIndex ?? 1) > 0
                                            ? TextAlign.center
                                            : TextAlign.start,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
