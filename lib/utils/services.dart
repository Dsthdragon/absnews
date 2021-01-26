import 'dart:io';
import 'package:absnews/video_models/channel_info.dart';
import 'package:absnews/video_models/viideos_list.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'constants.dart';

class Services {
  //
  static const CHANNEL_ID = 'UC-b2yq-1H15-VC-kS8M1DSg';
  static const _baseUrl = 'www.googleapis.com';




  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList(
      {String playListId, String pageToken}) async {
        String rawURL = 'https://www.googleapis.com/youtube/v3/search?type=video&eventType=live&order=date&part=snippet&channelId=UC-b2yq-1H15-VC-kS8M1DSg&maxResults=10&key=AIzaSyC1WSKrb5tkSgJpUcd26CLnQsISVUgeZko';
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    //  'type':'video', 'eventType':'live',
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }

}