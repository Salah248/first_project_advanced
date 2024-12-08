import 'package:first_project_advanced/data/network/error_handler.dart';
import 'package:first_project_advanced/data/response/responses.dart';

const cacheHomeKey = 'CACH_HOME_KEY';
const cacheHomeInterval = 60 * 1000; //1 minute cache in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCach(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time Cache

  Map<String, CachedItem> cachMap = Map();

  @override
  Future<HomeResponse> getHomeData() async{
    CachedItem? cachedItem =cachMap[cacheHomeKey];
    
if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)){
  // return the response from cache 

  return cachedItem.data ;

}else {
  // return an error that cache is not there or its not valid

  throw ErrorHandler.handle(DataSource.CACHE_ERROR);

}

  }

  @override
  Future<void> saveHomeToCach(HomeResponse homeResponse) async{
    cachMap[cacheHomeKey] = CachedItem(homeResponse);
  }
  
  @override
  void clearCache() {
   cachMap.clear();
  }
  
  @override
  void removeFromCache(String key) {
    cachMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cachTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}


extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis)
  {
    int currentTimeInImillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid =(currentTimeInImillis - cachTime) <= expirationTimeInMillis ;

return isValid ;
  }
} 