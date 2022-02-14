import 'package:exemplo36/inicio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
//inicializando o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//cadastrando o veiculo no firebase

//DIZENDO QUAL VAI SER O NOME DO DOC... no caso nome do DOC e FORD
  //FirebaseFirestore.instance.collection("carros").doc("ford").set({

//com o comando a baixo estamos add os dados na COLECTION CARROS
//e os DOCS com nome aleartorios
  FirebaseFirestore.instance.collection("carros").add({
    //add as CHAVES: CAMPOS q os documentos vao ter
    "nome": "ford ka",
    "preco": 20.00,
    "ano": "2010",
    "cidade": "tijucas",
    //essa CHAVE: CAMPO a baixo é EXTREAMENTE IMPORTANTE, pois na hora q nos formos
    //carregar todos os dados da COLLECTION, podemos por exemplo passar assim
    //tipo ford: true, entao so vai mostrar MODELOS da FORD na hora de exibir
    //o q ta na COLLECTION
    //mas nesse esxemplo qu to usando ATIVO: TRUE
    "ativo": true
  });

//ASSIM como no comando acima nos estamos ADD dados a COLLECTION CARROS
//mas aqui nos estamos ADD dados diretamente no DOC "FORD-1"

  FirebaseFirestore.instance.collection("carros").doc("ford-1").set({
    //addicionando as CHAVE: CAMPO ao DOC FORD-1
    "nome": "ford mustang",
    "preco": 200.00,
    "ano": 2020,
    //a CHAVE ATIVO esta no tipo FALSE, entao quando nos fizermos uma busca
    //na COLLECTION CARROS, e pedir para mostrar apenas os dados da COLECTION
    //CARROS q estao com o ATIVO em TRUE, esses dados aqui nao ira aparecer
    "ativo": false,
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(home: inicio());
  }
}
