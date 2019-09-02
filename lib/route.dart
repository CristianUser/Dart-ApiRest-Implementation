class Route {
  String path;
  String method;
  // List<Function> _callbacks;
  Function callback;

  Route({this.method, this.path, this.callback}){}

  // Route append(Function func) {
  //   this._callbacks.add(func);
  //   return this;
  // }
}