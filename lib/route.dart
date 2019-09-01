class Route {
  String path;
  String method;
  List<Function> _callbacks;

  Route(this.method, this.path){}

  Route append(Function func) {
    this._callbacks.add(func);
    return this;
  }
}