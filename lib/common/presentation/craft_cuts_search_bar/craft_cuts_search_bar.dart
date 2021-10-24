import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';

class CraftCutsSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginatedSearchBar(
      itemBuilder: (
        context, {
        required int index,
        item,
      }) =>
          Container(),
      onSearch: ({
        required pageIndex,
        required pageSize,
        required searchQuery,
      }) async =>
          [],
    );
  }
}
