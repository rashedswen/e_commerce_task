import 'dart:developer';

import 'package:e_commerce_task/viewModel/items_model.dart';
import 'package:e_commerce_task/views/transactions_list/widgets/e_commerce_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({
    super.key,
  });

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final _searchController = TextEditingController();
  FilterValues filterValues = FilterValues();
  bool _filterOn = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer<ItemsModel>(builder: (_, itemModel, child) {
        log("Search ${_searchController.text}");
        return SizedBox(
          height: constraints.maxHeight,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: EcommerceField(
                      label: "Search",
                      icon: Icons.search,
                      controller: _searchController,
                      onChanged: (value) {
                        itemModel.searchTransactions(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.filter_alt),
                          onPressed: () {
                            setState(() {
                              _filterOn = !_filterOn;
                            });
                          }),
                    ),
                  )
                ],
              ),
              if (_filterOn)
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Quantity Filter
                        const Text("Filter by quantity"),
                        FilterTypeRow(
                          valueAssigned: filterValues.quantity,
                          firstLable: "quantityAsce",
                          onPressed: (String value) {
                            log(filterValues.quantity);
                            setState(() {
                              filterValues =
                                  filterValues.copyWith(quantity: value);
                            });
                            itemModel.sortTransactions(
                              filterValues.type,
                              filterValues.quantity,
                            );
                          },
                          secondLable: "quantityDesc",
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        // Date Created Filter
                        const Text("Filter by date Created"),
                        FilterTypeRow(
                          valueAssigned: filterValues.dateCreated,
                          firstLable: "dateAsce",
                          onPressed: (value) {
                            setState(() {
                              filterValues =
                                  filterValues.copyWith(dateCreated: value);
                            });

                            log("${filterValues.dateCreated}Ascending");
                          },
                          secondLable: "dateDesc",
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        // Type Filter
                        const Text("Filter by type"),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    filterValues =
                                        filterValues.copyWith(type: "");
                                    itemModel.sortTransactions(
                                      filterValues.type,
                                      filterValues.quantity,
                                    );
                                  });
                                },
                                child: const Text("All"),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: FilterTypeRow(
                                valueAssigned: filterValues.type,
                                firstLable: "inbound",
                                onPressed: (value) {
                                  setState(() {
                                    log(filterValues.type);
                                    filterValues =
                                        filterValues.copyWith(type: value);
                                    itemModel.sortTransactions(
                                      filterValues.type,
                                      filterValues.quantity,
                                    );
                                  });
                                },
                                secondLable: "outbound",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      });
    });
  }
}

class FilterTypeRow extends StatefulWidget {
  const FilterTypeRow({
    super.key,
    required this.valueAssigned,
    required this.firstLable,
    required this.secondLable,
    required this.onPressed,
  });

  final String valueAssigned;

  final String firstLable;
  final String secondLable;

  final Function onPressed;

  @override
  State<FilterTypeRow> createState() => _FilterTypeRowState();
}

class _FilterTypeRowState extends State<FilterTypeRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: AlertDialogButton(
              onPressed: (String value) {
                widget.onPressed(value);
              },
              labe: widget.firstLable,
              selected: widget.valueAssigned == widget.firstLable),
        ),
        const Spacer(),
        Expanded(
          flex: 3,
          child: AlertDialogButton(
            onPressed: (value) {
              widget.onPressed(value);
            },
            labe: widget.secondLable,
            selected: widget.valueAssigned == widget.secondLable,
          ),
        ),
      ],
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({
    super.key,
    required this.onPressed,
    required this.labe,
    required this.selected,
  });

  final Function onPressed;
  final String labe;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed(labe);
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.grey,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Text(labe)),
    );
  }
}

class FilterValues {
  final String quantity;
  final String dateCreated;
  final String type;

  FilterValues(
      {this.quantity = "quantityAsce",
      this.dateCreated = "dateAsce",
      this.type = ""});

  FilterValues copyWith({
    String? quantity,
    String? dateCreated,
    String? type,
  }) {
    return FilterValues(
        quantity: quantity ?? this.quantity,
        dateCreated: dateCreated ?? this.dateCreated,
        type: type ?? this.type);
  }
}
