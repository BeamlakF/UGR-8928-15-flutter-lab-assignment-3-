import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/main.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/repository/album_repository.dart';
import 'package:untitled/service/api_service.dart';

final testRepository = AlbumRepository(
  albumService: AlbumService(httpClient: http.Client()),
);

void main() {
  testWidgets('Album list loads and displays', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(repository: testRepository));

    // Let the Bloc load albums (wait for async)
    await tester.pumpAndSettle();

    // Check that AlbumListScreen shows at least one album title (replace with your expected text)
    expect(find.textContaining('Album'), findsWidgets);

    // Optionally test tapping on an album to navigate to details
    // await tester.tap(find.textContaining('Album').first);
    // await tester.pumpAndSettle();
    // expect(find.byType(AlbumDetailScreen), findsOneWidget);
  });
}
