class Produto{
  String id;
  String nome;
  String preco;

  Produto(this.id, this.nome, this.preco);

  Produto.fromMap(Map<String,dynamic>map, String id){

    this.id = id ?? '';
    this.nome = map['nome'];
    this.preco = map['preco'];
  }
}