import 'package:flutter_official_project/bean/celebrity_entity.dart';
import 'package:flutter_official_project/bean/celebrity_work_entity.dart';
import 'package:flutter_official_project/http/API.dart';
import 'package:flutter_official_project/http/http_request.dart';
import 'package:flutter_official_project/http/mock_request.dart';

class PersonDetailRepository {
  CelebrityEntity? celebrityEntity;
  CelebrityWorkEntity? celebrityWorkEntity;

  final HttpRequest _httpRequest = HttpRequest(API.BASE_URL);
  final MockRequest _mockRequest = MockRequest();
  
  PersonDetailRepository({this.celebrityEntity, this.celebrityWorkEntity});

  Future<PersonDetailRepository> requestAPI(String id) async {

    // var result = await _httpRequest.get('/v2/movie/celebrity/$id/works?apikey=0b2bdeda43b5688921839c8ecb20399b');
    // 这里修改为从本地 json 中获取数据
    var result = await _mockRequest.get(API.WORKS);
    celebrityWorkEntity = CelebrityWorkEntity.fromJson(result);

    // result = await _httpRequest.get('/v2/movie/celebrity/$id?apikey=0b2bdeda43b5688921839c8ecb20399b');
    // 这里修改为从本地 json 中获取数据
    result = await _mockRequest.get(API.CELEBRITY);
    celebrityEntity = CelebrityEntity.fromJson(result);
    
    return PersonDetailRepository(celebrityEntity: celebrityEntity, celebrityWorkEntity: celebrityWorkEntity);
  }
}
