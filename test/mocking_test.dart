import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:fall_24_flutter_course/templates/lab7/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'mocking_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Mock the response from the API with a 200 status code
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 1, "title": "Test Album"}', 200));

      final apiService = ApiService();
      expect(await apiService.fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Mock the response with a 404 status code
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final apiService = ApiService();
      expect(apiService.fetchAlbum(client), throwsException);
    });
  });
}
