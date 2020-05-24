class Tech {
  String flags;
  String graphic;
  String graphicAlt;
  String name;
  String req1;
  String req2;
  String helptext;

  Tech({
      this.flags,
      this.graphic,
      this.graphicAlt,
      this.name,
      this.req1,
      this.req2,
      this.helptext});

  Tech.fromJson(Map<String, dynamic> json) {
    flags = json['flags'];
    graphic = json['graphic'];
    graphicAlt = json['graphic_alt'];
    name = json['name'];
    req1 = json['req1'];
    req2 = json['req2'];
    helptext = json['helptext'];
  }
}