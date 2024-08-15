import 'dart:developer';
import 'dart:io';


import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constant.dart';
import 'package:spotify_clone/features/home/model/Song.dart';

import '../../../core/providers/current_user_notifier.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<Exception, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
    required String uploadedBy,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ServerConstant.BASE_URL}/songs/upload'));

      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath('songFile', selectedAudio.path),
            await http.MultipartFile.fromPath(
                'coverArt', selectedThumbnail.path),
          ],
        )
        ..fields.addAll(
          {
            'artist': artist,
            'title': songName,
            'hexCode': hexCode,
            'uploadedBy': uploadedBy,
          },
        )
        ..headers.addAll(
          {
            'Authorization': "Bearer $token",
          },
        );
      final res = await request.send();

      if (res.statusCode != 200) {
        return Left(Exception(await res.stream.bytesToString()));
      }

      return Right(await res.stream.bytesToString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Either<Exception, List<Song>>> getAllSongs({
    required String token,
  }) async {
    
    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.BASE_URL}/songs/getAll'),
        headers: {
          'Authorization': "Bearer $token",
        },
      );
      

      if (res.statusCode != 200) {
        return Left(Exception(res.body));
      }
      
      
      
      
      List<Song> songs = Song.fromJsonList(res.body);
    
      return Right(songs);
    } catch (e) {
      
      throw Exception(e.toString());
    }
  }


  Future<Either<Exception, List<Song>>> getAllFavorite({
    required String token,
  }) async {

    try {
      final res = await http.get(
        Uri.parse('${ServerConstant.BASE_URL}/songs/favorites'),
        headers: {
          'Authorization': "Bearer $token",
        },
      );
      

      if (res.statusCode != 200) {
        return Left(Exception(res.body));
      }
      
      
      
      
      List<Song> songs = Song.fromJsonList(res.body);
    
      return Right(songs);
    } catch (e) {
      
      throw Exception(e.toString());
    }
  }

  Future<Either<Exception, String>> favoriteSong({
    required String songId,
    required String token,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${ServerConstant.BASE_URL}/songs/favorite/$songId'),
        headers: {
          'Authorization': "Bearer $token",
        },
      );

      if (res.statusCode != 200) {
        return Left(Exception(res.body));
      }

      return Right(res.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Either<Exception, String>> unFavoriteSong({
    required String songId,
    required String token,
  }) async {
    try {
      final res = await http.delete(
        Uri.parse('${ServerConstant.BASE_URL}/songs/favorite/$songId'),
        headers: {
          'Authorization': "Bearer $token",
        },
      );

      if (res.statusCode != 200) {
        return Left(Exception(res.body));
      }

      return Right(res.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
