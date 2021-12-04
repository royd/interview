import 'package:interview/client/book_client.dart';
import 'package:interview/client/get_book_response.dart';
import 'package:interview/client/models/book_dto.dart';
import 'package:interview/library_build_data.dart';
import 'package:rxdart/rxdart.dart';

class LibraryModel {
  LibraryModel({
    required BookClient client,
  }) : _client = client {
    client.addListener(_onClientChanged);
    _loadData();
  }

  final BookClient _client;
  final _data = BehaviorSubject<LibararyBuildData>();

  ValueStream<LibararyBuildData> get data => _data;

  Future<GetBookResponse> getBook({
    required int index,
  }) {
    return _client.getBookAtIndex(
      index: index,
    );
  }

  void putBook({
    required BookDto book,
  }) {
    _client.putBook(
      book: book,
    );
  }

  void deleteBook({
    required String id,
  }) {
    _client.deleteBook(
      id: id,
    );
  }

  void dispose() {
    _client.removeListener(_onClientChanged);
    _data.close();
  }

  Future _loadData() async {
    final response = await _client.getCount();
    final count = response.count;
    if (response.isSuccess && count != null && !_data.isClosed) {
      _data.add(
        LibararyBuildData(
          count: count,
        ),
      );
    }
  }

  void _onClientChanged() {
    _loadData();
  }
}
