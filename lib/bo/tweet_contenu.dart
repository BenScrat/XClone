class TweetContenu {
  final int id;
  final String author;
  final String message;

  const TweetContenu({
    required this.id,
    required this.author,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'message': message,
    };
  }

  factory TweetContenu.fromMap(Map<String, dynamic> map) {
    return TweetContenu(
      id: map['id'] as int,
      author: map['author'] as String,
      message: map['message'] as String,
    );
  }
}