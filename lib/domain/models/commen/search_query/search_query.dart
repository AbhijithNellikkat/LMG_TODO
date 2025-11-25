import 'package:json_annotation/json_annotation.dart';

part 'search_query.g.dart';

@JsonSerializable()
class SearchQuery {
  @JsonKey(name: 'query')
  String? search;
  int? limit;
  int? page;

  SearchQuery({this.search, this.limit, this.page});

  factory SearchQuery.fromJson(Map<String, dynamic> json) {
    return _$SearchQueryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    // return _$SearchQueryToJson(this);
    return {
      if (search != null && search!.isNotEmpty) 'query': search,
      if (limit != null) 'limit': limit,
      if (page != null) 'page': page,
    };
  }

  SearchQuery copyWith({String? search, int? limit, int? page}) {
    return SearchQuery(
      search: search ?? this.search,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }
}
