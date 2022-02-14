import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class inicio extends StatelessWidget {
  const inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //a variavel CONEXAO_FB vai receber APENAS os dados q o CAMPO ATIVO é TRUE
    //na colection CARROS
    var conexao_fb = FirebaseFirestore.instance
        .collection('carros')
        //aqui no .WHERE nos podemos colocar assim FORD isEqualTo: true entao ele
        //vai em todos os DOC e vai pegar apenas as informacoes q o CAMPO ATIVO
        //tiver o valor TRUE
        .where('ativo', isEqualTo: true)
        .snapshots();

//criando esqueleto do app
    return Scaffold(
      appBar: AppBar(
        title: Text('modelo de carros'),
      ),
      //o body do nosso app vai receber um StreamBuilder
      body: StreamBuilder(
        //o stream é os dados q vao estar na variavel CONEXAO_FB
        stream: conexao_fb,
        //o Stream é o o LINK/CANO, etc... q vai ficar monitorando os dados
        //q estao vindo do Firebase... e quando houver uma alteracao nos dados
        //tipo alterado um valor dos DOC do Firebase... Vai ser construido
        //um novo container por exemplo...
        builder: (
          //buildcontext tem a funcao de localizar cada widget na arvore de widgets
          //e fazer a uniao entre os widgets q estao em diferentes galhos
          //TBM NAO ENTENDI MTO BEM...
          //
          //context PELO O Q EU ENTENDI... serve para dizer de qual WIDGET/CLASSE
          //ou FUNCAO ta vindo a informacao q e passada
          //tipo vc recebeu uma ligacao no celular mas nao sabe para qual num retornar
          //pois o num q te ligou e privado(sem o CONTEXT), com o CONTEXT
          //vc sabe a quem retornar pois o numero vc sabe qual e, no lugar do numero
          //seria um WIDGET/CLASSE/FUNCAO... EU ACHO Q E ISSO https://www.youtube.com/watch?v=AhPovBem6CA
          BuildContext context,
          //um Assincrono Snapshot... Significa q outras partes do APP vao ser
          //CRIADAS/APARECEM na tela, enquanto aguarda a chegada dos dados
          //q vem da Firebase
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          //EU ACHO Q se o snapshot tiver DADOS, vai carregar o GIF a baixo
          if (!snapshot.hasData) {
            return const Center(
              //gif de carregando...
              child: CircularProgressIndicator(),
            );
          }
          //apos carregar os dados vai monstar um Scaffold/ESQUELETO do APP
          return Scaffold(
            body: SafeArea(
                child: Column(
              //percorrendo os DOC da Collection
              children: snapshot.data!.docs.map(
                (documents) {
                  return Column(children: [
                    //procurando nos DOC a CHAVE NOME e para cada DOC q tiver
                    //essa CHAVE o BUILDER acima vai criar um container
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                      child: Text(documents['nome']),
                    ),
                    //procurando nos DOC a CHAVE CIDADE e para cada DOC q tiver
                    //essa CHAVE o BUILDER acima vai criar um container
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                      child: Text(documents['cidade']),
                    ),
                    //nao em formato de CONTAINER, mas aqui vamos
                    //mostrar todas os DOC q tem o valor ANO
                    Text(documents['ano']),
                  ]);
                },
              ).toList(),
            )),
          );
        },
      ),
    );
  }
}
