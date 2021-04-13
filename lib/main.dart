import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(Login());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // VARIAVEIS
  var _formKey = GlobalKey<FormState>();
  final _tUser = TextEditingController();
  final _tPassword = TextEditingController();
  var _infoText = "";

  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }

  // Widget button
  _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.blue,
        child:
        Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Game()),
            );
          }
        },
      ),
    );
  }

  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Usuário", _tUser,),
              _editText("Senha", _tPassword,),
              _buttonLogin(),
              _textInfo(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: () => (print ("")))
        ],
      ),
      body: _body(),
    );


  }
}
class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tResposta = TextEditingController();
  var _gameType = ["Digite uma letra vogal", "Digite um número par", "Digite um número ímpar"];
  var _infoText = "Digite uma letra vogal";
  var _formKey = GlobalKey<FormState>();

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning app"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tResposta.text = "";
    var rng = new Random();
    setState(() {
      _infoText = _gameType[rng.nextInt(_gameType.length)];
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Resposta: ", _tResposta,),
              _buttonSubmit(),
              _textInfo(),
            ],
          ),
        ));
  }
  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonSubmit() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.blue,
        child:
        Text(
          "Enviar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _validarResposta();
          }
        },
      ),
    );
  }

  // Validar reposta enviada
  void _validarResposta(){
    setState(() {
      if (_infoText == _gameType[0]){
        if (_isVogal()){
          _showMyDialog("Parabéns, você acertou !","Continue assim ! Lembre de estudar todos os dias !");
        }else{
          _showMyDialog("Que pena, você errou !","Lembrando que as vogais são: A, E, I, O, U");
        }
      }else if (_infoText == _gameType[1]){
        if (int.parse(_tResposta.text) % 2 == 0){
          _showMyDialog("Parabéns, você acertou !","Continue assim ! Lembre de estudar todos os dias !");
        }else {
          _showMyDialog("Que pena, você errou !","Lembrando que os numeros pares são sempre divisíveis por 2");
        }
      }else{
        if (int.parse(_tResposta.text) % 2 != 0){
          _showMyDialog("Parabéns, você acertou !","Continue assim ! Lembre de estudar todos os dias !");
        }else {
          _showMyDialog("Que pena, você errou !","Lembrando que os numeros ímpares não são divisíveis por 2");
        }
      }
      _resetFields();
    });
  }
  bool _isVogal(){
    if (_tResposta.text.toUpperCase() == "A" || _tResposta.text.toUpperCase() == "E" || _tResposta.text.toUpperCase() == "I" ||
        _tResposta.text.toUpperCase() == "O" || _tResposta.text.toUpperCase() == "U"){
      return true;
    }
    return false;
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }

  Future<void> _showMyDialog(titulo, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}


