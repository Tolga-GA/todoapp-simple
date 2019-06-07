final String _colId        = 'id';
final String _colContent   = 'content';

class Note {

  static final String table = 'Note';
  int _id;
  String _content;
  
  static initDB() {
    return '''
      CREATE TABLE $table (
        $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_colContent TEXT
      )
    ''';
  }

  Note( this._content );

  Note.widthId( this._id, this._content );

  Note.fromMapObject( Map<String, dynamic> map ) {
    this._id = map[_colId];
    this._content = map[_colContent];
  }

  int get id => _id;
  String get content => _content;
  
  set content( String content ) {
    this._content = content;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if( _id != null ) {
      map[_colId] = _id;
    }
    map[_colContent] = _content;

    return map;
  }
}