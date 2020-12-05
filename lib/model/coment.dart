class Comentario{
  String id;
  String nome;
  String comentario;

  Comentario(this.id, this.nome, this.comentario);

  Comentario.fromMap(Map<String,dynamic>map, String id){

    this.id = id ?? '';
    this.nome = map['nome'];
    this.comentario = map['comentario'];
  }
}