class Text {
  String _text;
  String _fontStyle;
  int _fontSize;
  Text _textWidget;

  Text(text, fontStyle, fontSize) {
    this._text = text;
    this._fontSize = fontSize;
    this._fontStyle = fontStyle;
    this._textWidget = new Text(text, fontStyle, fontSize);
  }

  String get fontStyle => _fontStyle;
  int get fontSize => _fontSize;
  Text get textWidget => _textWidget;
  String get text => _text;

  set fontStyle(String value) {
    _fontStyle = value;
  }

  set text(String text) {
    _text = text;
  }

  set fontSize(int value) {
    _fontSize = value;
  }

  set textWidget(Text value) {
    _textWidget = value;
  }
}