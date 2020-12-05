class Usuarios {
  String id;
  String email;
  String senha;


  Usuarios(this.id, this.email, this.senha);

  Usuarios.fromMap(Map<String, dynamic> map, String id) {
    this.id = id ?? '';    
    this.email = map['email'];
    this.senha = map['senha'];
    
  }
}
