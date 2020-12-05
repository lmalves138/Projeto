import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'model/user.dart';
import 'model/preco.dart';
import 'model/coment.dart';




void main() async{
  //Registrar o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto',
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.green[100],
        
        fontFamily: 'Georgia',
      ),
      
      initialRoute: '/tela1',
      routes: {
        '/tela1' : (context) => TelaLogin(),
        '/menu' : (context) => Menu(),
        '/tela3' : (context) => Porcoes(),
        '/tela4' : (context) => Sobremesa(),
        '/tela5' : (context) => Bebidas(),
        '/tela6' : (context) => Desenvolvedor(),
        '/telpreco' : (context) => TelaPreco(),
        '/telcomentario' : (context) => TelaComentario(),
        '/telcadastro' : (context) => TelaCadastro(),

        

        
      },
    )
  );

  
  
}

// Tela de Login

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var db = FirebaseFirestore.instance;

  //Lista dinamica do objetos da classe Usuários
  List<Usuarios> usuarios = List();


  //Declaração de um objeto "ouvinte" da coleção usuarios
  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState(){
    super.initState();

    //Registrar o ouvidor para monitorar qualquer tipo de alteração
    // na coleção Usuários do FireStore

    ouvidor?.cancel();
    ouvidor = db.collection("usuarios").snapshots().listen( (res){

      setState((){
        usuarios = res.docs.map((e) => Usuarios.fromMap(e.data(), e.id)).toList();

      });
    });
  }



  var txtLogin = TextEditingController();
  var txtSenha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')        
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Icon(
            Icons.people, size: 100, color: Theme.of(context).primaryColor
          ),

          campoTexto("Login", txtLogin),
          campoTexto("Senha", txtSenha),
          botao("Logar"),
          botao1("Cadastrar")
        ],),
      ),
      
    );
  }
  Widget campoTexto(rotulo, variavelControle){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: variavelControle,
        style: TextStyle(fontSize: 25),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18
          )
        ),
        validator: (value){
          return (value
          .isEmpty) ? "Campo Obrigatório" : null;
        },
      ),

    );
  }

  Widget botao(rotulo){
    return Container(
      
      padding: EdgeInsets.only(top: 20),
      child: RaisedButton(
        color: Colors.black,
        child: Text(
          rotulo,
          style: TextStyle(color: Colors.white,),
        ),
        onPressed: () async{

          
          if(txtLogin.text == '' || txtSenha.text == ''){
            showAlertDialog1(context);

          }else{
            
            Navigator.pushNamed(context, '/menu');
          }

          
          
          /*await usuarios.get().then((QuerySnapshot q){
            q.docs.forEach((d) {
              
              
              //print('Id: ${d.id}');              
              //print('Email: ${d['email']}');
            }
            );
          }
          );*/                    

        },
       
      ),
    );
  }

    Widget botao1(rotulo){
    return Container(
      
      padding: EdgeInsets.only(top: 20),
      child: RaisedButton(
        color: Colors.black,
        child: Text(
          rotulo,
          style: TextStyle(color: Colors.white,),
        ),
        onPressed: (){
          
          db.collection("usuarios").add(

            {
                "email": txtLogin.text,
                "senha": txtSenha.text
            }
          );
        }
       
      ),
    );
  }
}

// Menu de telas

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Menu"),),
      body: Container(
        padding: EdgeInsets.all(60),
        child: ListView(
          children: [
            Text("Menu", style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),

            ListTile(              
              title: Text('Porções', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/porcoes.jpg'                
              ),
              onTap: () {
                Navigator.pushNamed(context, '/tela3');
              },
            ),
            SizedBox(height: 15),

            ListTile(              
              title: Text('Sobremesas', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/torta_de_morango.jpg'               
              ),

              onTap: () {
                Navigator.pushNamed(context, '/tela4');
                
              },
            ),

            SizedBox(height: 15),

            ListTile(              
              title: Text('Bebidas', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/Bebidas.jpg', scale: 1,               
              ),

              onTap: () {

                Navigator.pushNamed(context, '/tela5');
                
              },
            ),

            SizedBox(height: 15),

            ListTile(              
              title: Text('Nossa Historia', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/historia.jpeg', scale: 1,               
              ),
              
              
              onTap: () {
                Navigator.pushNamed(context, '/tela6');
                
                
              },
            ),

             SizedBox(height: 15),

            ListTile(              
              title: Text('Tabela de Preços', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/precos.png', scale: 1,               
              ),
              
              
              onTap: () {
                Navigator.pushNamed(context, '/telpreco');
                
                
              },
            ),

             SizedBox(height: 15),

            ListTile(              
              title: Text('Comentários e Sugestões', style: TextStyle(fontSize: 24),),
              leading: Image.asset(
                'imagens/comentario.jpg', scale: 1,               
              ),
              
              
              onTap: () {
                Navigator.pushNamed(context, '/telcomentario');
                
                
              },
            )


          ],
        ),
      ) ,
      
    );
  }
}

// Tela Porções

class Porcoes extends StatefulWidget {
  @override
  _PorcoesState createState() => _PorcoesState();
}

class _PorcoesState extends State<Porcoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Porções"),),
      body: SingleChildScrollView(
              child: Column(children: [
          MenuWidget('Mista: Calabresa, contra filé, isca de tilápia e mandioca. ', '', 'imagens/porcoes.jpg'),
          MenuWidget('Batata Especial: Batata, queijo e bacon ', '', 'imagens/batata_queijo.jpg'),
          MenuWidget('Cupim Casqueirado ', '', 'imagens/cupim.jpg'),
          MenuWidget('Isca de Tilápia ', '', 'imagens/peixe.jpg'),
          MenuWidget('Torresmo ', '', 'imagens/torresmo.jpg')
          
        ],),
      ),
      
    );
  }
}

//Tela sobremesa

class Sobremesa extends StatefulWidget {
  @override
  _SobremesaState createState() => _SobremesaState();
}

class _SobremesaState extends State<Sobremesa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Porções"),),
      body: SingleChildScrollView(
              child: Column(children: [
          MenuWidget('Torta de Morango ', '', 'imagens/torta_de_morango.jpg'),
          MenuWidget('Torta Tentação ', '', 'imagens/torta_tentacao.jpg'),
          MenuWidget('Petit Gateau ', '', 'imagens/petit_gateau.jpg'),
          MenuWidget('Torta Alemã ', '', 'imagens/torta_alema.jpg'),
          
        ],),
      ),
      
    );
  }
}

// Tela Bebidas

class Bebidas extends StatefulWidget {
  @override
  _BebidasState createState() => _BebidasState();
}

class _BebidasState extends State<Bebidas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Porções"),),
      body: SingleChildScrollView(
              child: Column(children: [
          MenuWidget('Brahma ', ' ', 'imagens/brahma.jpg'),
          MenuWidget('Heineken ', ' ', 'imagens/heineken.jpg'),
          MenuWidget('Stella ', '', 'imagens/stella.jpg'),
          MenuWidget('Refrigerante ', '', 'imagens/refrigerantes.jpg'),
          
        ],),
      ),
      
    );
  }
}

// Tela desenvolvedor


class Desenvolvedor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("História"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Column(children: [
        
        Image.asset('imagens/eu.jpeg', scale: 1.5 ),
        Text("Este app foi elaborado pelo desenvolvedor Leonardo Martins Alves como forma de avaliação dos conhecimentos adquiridos na disciplina de Dispositivos Móveis, ministrada pelo Prof. Dr. Rodrigo Plotze. \n A proposta do aplicativo é fornecer um cardápio genérico intuitivo e de fácil navegação.", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Georgia'),)
                
          
          
        ],),
      ),
      
    );
  }
}



// Elementos do Cardápio



class MenuWidget extends StatelessWidget {
 

  final String desc;
  final String valor;
  final String foto;

  //contrutor

  MenuWidget(this.desc, this.valor, this.foto) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding espaçamento entre as bordas
      padding: EdgeInsets.all(30),// pode ser usado .symmetric(horizontal: qtd ou vertical: qtd ) ou from TRB(200,0,0,0) O = L
      // margin é utilizado para a borda da janela até o elemento container
      margin: EdgeInsets.all(30),
      //decoration colocar borda no container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),

        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
      ),
      
      child: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(desc, style: TextStyle(fontSize: 20),),              
              Text(valor, style: TextStyle(fontSize: 20, color: Colors.black45), ),
            ],
          ),
          SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(foto, scale: 1.5,)
          )
        ],),
      )

    );
  }
}


showAlertDialog1(BuildContext context) 
{ 
    
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pushNamed(context, '/tela1'); },
  );
  
  AlertDialog alerta = AlertDialog(
    title: Text("Usuário ou senha invalido!"),
    content: Text("Informe usuário e senha."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}



//
// TELA PREÇO
//
class TelaPreco extends StatefulWidget {
  @override
  _TelaPrecoState createState() => _TelaPrecoState();
}

class _TelaPrecoState extends State<TelaPreco> {

  var db = FirebaseFirestore.instance;

  //Lista Dinâmica de objetos da classe Café
  List<Produto> produtos = List();

  //Declaração de um objeto "ouvinte" da coleção Cafés do Firestore
  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState(){
    super.initState();

    //Registrar o "ouvidor" para monitorar qualquer tipo de alteração
    //na coleção CAFES do FireStore
    ouvidor?.cancel();

    ouvidor = db.collection("produtos").snapshots().listen( (res) {

      setState(() {
        produtos = res.docs.map((e) => Produto.fromMap(e.data(), e.id)).toList();
      });

    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabela de Preços"),    
        
      ),


      body: StreamBuilder<QuerySnapshot>(

        stream: db.collection("produtos").snapshots(),
        builder: (context,snapshot){

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("Erro ao conectar no Firebase"));
            case ConnectionState.waiting:  
              return Center(child: CircularProgressIndicator());
            default: return ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context,index){

                  return ListTile(

                    title: Text(produtos[index].nome, style: TextStyle(fontSize: 24)),
                    subtitle: Text(produtos[index].preco, style: TextStyle(fontSize: 18)),
                    /*trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){

                        //Apagar o documento selecionado
                        db.collection("cafes").doc(cafes[index].id).delete();

                      },
                    ),

                    onTap: (){

                      //Abrir a tela de Cadastro passando o ID
                      //do documento como parâmetro  
                      Navigator.pushNamed(
                        context, '/cadastro',
                        arguments: cafes[index].id
                      );

                    }*/

                  );

                }
            );

          }
        }

      ),



      /*floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/cadastro", arguments: null);
        },
      ),
      backgroundColor: Colors.brown[50],*/
    );
  }
}



// TELA comentário
//
class TelaComentario extends StatefulWidget {
  @override
  _TelaComentarioState createState() => _TelaComentarioState();
}

class _TelaComentarioState extends State<TelaComentario> {

  var db = FirebaseFirestore.instance;

  //Lista Dinâmica de objetos da classe Café
  List<Comentario> comentarios = List();

  //Declaração de um objeto "ouvinte" da coleção Cafés do Firestore
  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState(){
    super.initState();

    //Registrar o "ouvidor" para monitorar qualquer tipo de alteração
    //na coleção CAFES do FireStore
    ouvidor?.cancel();

    ouvidor = db.collection("comentarios").snapshots().listen( (res) {

      setState(() {
        comentarios = res.docs.map((e) => Comentario.fromMap(e.data(), e.id)).toList();
      });

    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comentários e Sugestões"),    
        
      ),


      body: StreamBuilder<QuerySnapshot>(

        stream: db.collection("comentarios").snapshots(),
        builder: (context,snapshot){

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text("Erro ao conectar no Firebase"));
            case ConnectionState.waiting:  
              return Center(child: CircularProgressIndicator());
            default: return ListView.builder(
                itemCount: comentarios.length,
                itemBuilder: (context,index){

                  return ListTile(

                    title: Text(comentarios[index].nome, style: TextStyle(fontSize: 24)),
                    subtitle: Text(comentarios[index].comentario, style: TextStyle(fontSize: 18)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){

                        //Apagar o documento selecionado
                        db.collection("comentarios").doc(comentarios[index].id).delete();

                      },
                    ),

                    onTap: (){

                      //Abrir a tela de Cadastro passando o ID
                      //do documento como parâmetro  
                      Navigator.pushNamed(
                        context, '/telcadastro',
                        arguments: comentarios[index].id
                      );

                    }

                  );

                }
            );

          }
        }

      ),



      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/telcadastro", arguments: null);
        },
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}



// TELA CADASTRO
//
class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtNome = TextEditingController();
  var txtComent = TextEditingController();
  

  var db = FirebaseFirestore.instance;

  //Recuperar um DOCUMENTO  a partir do ID
  void getDocumentById(String id) async{

    await db.collection("comentarios").doc(id).get()
      .then((doc){

        txtNome.text = doc.data()['nome'];
        txtComent.text = doc.data()['comentario'];
        
    });

  }


  @override
  Widget build(BuildContext context) {

    final String id = ModalRoute.of(context).settings.arguments;

    if ( id != null ){
      if (txtNome.text == '' && txtComent.text == ''){
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Comentários e Sugestões"),
        centerTitle: true,
        
      ),
      body: Container(
          padding: EdgeInsets.all(50),
          child: Column(children: [
            
            //CAMPO NOME
            TextField(
              controller: txtNome,
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //CAMPO Comentário
            TextField(
              controller: txtComent,
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Comentário",
              ),
            ),
            SizedBox(
              height: 30,
            ),

          //BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: Colors.brown[500],
                    child: Text("salvar",style: TextStyle(color: Colors.white, fontSize: 20)),
                    
                    onPressed: () async{
                      if (id == null){

                          //ADICIONAR um novo DOCUMENTO a COLEÇÃO
                          await db.collection("comentarios").add(
                            {
                              "nome" : txtNome.text,
                              "comentario" : txtComent.text
                            }
                          );
                      }else{
                        await db.collection("comentarios").doc(id).update(
                          {
                            "nome" : txtNome.text,
                            "comentario" : txtComent.text
                          }
                        );
                      }
                      Navigator.pop(context);

                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: Colors.brown[500],
                    child: Text("cancelar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ])),
      backgroundColor: Colors.brown[50],
    );
  }
}



