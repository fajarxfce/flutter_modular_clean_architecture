class GetProductRequest {
  final String? orderBy;
  final String? order; // 'asc' or 'desc'
  final int? paginate;
  final String? search;
  final int? page;
  final List<int>? categoryIds;
  final List<int>? subCategoryIds;
  final List<int>? merkIds;

  GetProductRequest({
    this.orderBy = 'products.id',
    this.order = 'asc',
    this.paginate = 10,
    this.search,
    this.page = 1,
    this.categoryIds,
    this.subCategoryIds,
    this.merkIds,
  });

  /// Convert to query parameters map for API call
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (orderBy != null) params['orderBy'] = orderBy;
    if (order != null) params['order'] = order;
    if (paginate != null) params['paginate'] = paginate;
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (page != null) params['page'] = page;

    // Handle array parameters
    if (categoryIds != null && categoryIds!.isNotEmpty) {
      for (var i = 0; i < categoryIds!.length; i++) {
        params['product_category_id[$i]'] = categoryIds![i];
      }
    }

    if (subCategoryIds != null && subCategoryIds!.isNotEmpty) {
      for (var i = 0; i < subCategoryIds!.length; i++) {
        params['product_sub_category_id[$i]'] = subCategoryIds![i];
      }
    }

    if (merkIds != null && merkIds!.isNotEmpty) {
      for (var i = 0; i < merkIds!.length; i++) {
        params['product_merk_id[$i]'] = merkIds![i];
      }
    }

    return params;
  }

  /// Copy with method for easy modification
  GetProductRequest copyWith({
    String? orderBy,
    String? order,
    int? paginate,
    String? search,
    int? page,
    List<int>? categoryIds,
    List<int>? subCategoryIds,
    List<int>? merkIds,
  }) {
    return GetProductRequest(
      orderBy: orderBy ?? this.orderBy,
      order: order ?? this.order,
      paginate: paginate ?? this.paginate,
      search: search ?? this.search,
      page: page ?? this.page,
      categoryIds: categoryIds ?? this.categoryIds,
      subCategoryIds: subCategoryIds ?? this.subCategoryIds,
      merkIds: merkIds ?? this.merkIds,
    );
  }
}
