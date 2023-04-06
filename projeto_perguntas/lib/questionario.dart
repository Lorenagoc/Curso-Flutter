import 'package:flutter/material.dart';
import 'pergunta.dart';
import 'resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) quandoResponder;

  const Questionario({
    super.key,
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.quandoResponder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada].cast()['respostas']
        : [];

    return Column(
      children: <Widget>[
        Pergunta(perguntas[perguntaSelecionada]['pergunta'].toString()),
        ...respostas.map((resposta) {
          return Resposta(
              resposta['texto'].toString(),
              () =>
                  quandoResponder(int.parse(resposta['pontuacao'].toString())));
        }).toList(),
      ],
    );
  }
}
