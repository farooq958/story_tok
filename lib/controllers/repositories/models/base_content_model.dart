
abstract class CommonDataModel {
  Future<int> initiate(int index);
  Future<void> dispose() async {}
  Future<void> hold() async {}
}