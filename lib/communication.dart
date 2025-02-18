// communication.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import './AuthManager.dart';

class ServerCommunication {
  static const String baseUrl = 'http://121.169.139.193:4000';

  List<Map<String, dynamic>> festivalList = [];

  Future<void> uploadImageWithText(
    File imageFile,
    String fName,
    String hash,
    String review,
  ) async {
    try {
      final AuthManager authManager = AuthManager();
      await authManager.init(); // AuthManager 초기화

      final String userId = authManager.userId;
      print(userId);

      final uri = Uri.parse('http://121.169.139.193:4000/api/photos/$userId');

      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile(
          'image',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: 'image.jpg',
          contentType: MediaType(
            'image',
            'jpeg',
          ),
        ))
        ..fields['F_name'] = fName
        ..fields['hash'] = hash
        ..fields['review'] = review;

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('이미지 및 텍스트 업로드 성공');
      } else {
        print('이미지 및 텍스트 업로드 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('이미지 및 텍스트 업로드 중 오류 발생: $e');
    }
  }

  List<Map<String, dynamic>> getFestivalList() {
    return festivalList;
  }
}
