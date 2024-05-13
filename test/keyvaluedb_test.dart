import 'package:flutter_test/flutter_test.dart';
import 'package:idb_shim/idb.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'keyvaluedb_test.mocks.dart';

// TODO: test opening webdb, desktop file, mobile file, opening existing vs new, test getting,
// test setting values.

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([IdbFactory, Database])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
