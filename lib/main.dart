import 'package:flutter/material.dart';

void main() {
  runApp(const EcoDescarta());
}

// CORES DO APLICATIVO
const verde = Color.fromARGB(255, 1, 87, 16);
const verdeClaro = Color.fromARGB(255, 55, 236, 103);
const fundo = Color(0xFFF7FAF7);

// MODELO DOS MATERIAIS
class MaterialEco {
  final String nome;
  final String categoria;
  final String orientacao;
  final IconData icone;

  MaterialEco({
    required this.nome,
    required this.categoria,
    required this.orientacao,
    required this.icone,
  });
}

// APLICATIVO
class EcoDescarta extends StatelessWidget {
  const EcoDescarta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoDescarta',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: verde,
        ),
        scaffoldBackgroundColor: fundo,
      ),
      home: const TelaPrincipal(),
    );
  }
}

// TELA PRINCIPAL
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int paginaAtual = 0;

  // BANCO DE DADOS LOCAL DE EXEMPLO
  final List<MaterialEco> materiais = [
    MaterialEco(
      nome: 'Garrafa PET',
      categoria: 'Plástico',
      orientacao: 'Esvazie e, se possível, encaminhe limpa '
          'à coleta seletiva.',
      icone: Icons.local_drink,
    ),
    MaterialEco(
      nome: 'Caixa de papelão',
      categoria: 'Papel',
      orientacao: 'Mantenha limpa e seca antes de encaminhar '
          'à coleta seletiva.',
      icone: Icons.inventory_2,
    ),
    MaterialEco(
      nome: 'Garrafa de vidro',
      categoria: 'Vidro',
      orientacao: 'Separe com cuidado e encaminhe ao ponto '
          'de coleta apropriado.',
      icone: Icons.wine_bar,
    ),
    MaterialEco(
      nome: 'Lata de refrigerante',
      categoria: 'Metal',
      orientacao: 'Esvazie e encaminhe à coleta seletiva.',
      icone: Icons.local_cafe,
    ),
    MaterialEco(
      nome: 'Casca de banana',
      categoria: 'Orgânico',
      orientacao: 'Pode ser destinada à compostagem, '
          'quando disponível.',
      icone: Icons.eco,
    ),
    MaterialEco(
      nome: 'Pilha usada',
      categoria: 'Especial',
      orientacao: 'Não descarte no lixo comum. Procure '
          'um ponto de coleta específico.',
      icone: Icons.battery_alert,
    ),
  ];

  final List<String> categorias = [
    'Todas',
    'Papel',
    'Plástico',
    'Vidro',
    'Metal',
    'Orgânico',
    'Especial',
  ];

  // TELAS DO APLICATIVO
  @override
  Widget build(BuildContext context) {
    final telas = [
      telaInicio(),
      telaConsulta(),
      telaQuiz(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EcoDescarta 🌱',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: verde,
        foregroundColor: Colors.white,
      ),

      body: IndexedStack(
        index: paginaAtual,
        children: telas,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: paginaAtual,
        onDestinationSelected: (index) {
          setState(() {
            paginaAtual = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.recycling),
            label: 'Descarte',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quiz',
          ),
        ],
      ),
    );
  }

  // TELA 1 - INÍCIO
  Widget telaInicio() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: verde,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.eco,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(height: 15),
              Text(
                'Pequenas atitudes,\n grandes transformações!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Aprenda a descartar corretamente '
                'e ajude a cuidar do planeta.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'O que você deseja fazer?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        cardInicio(
          Icons.search,
          'Consultar materiais',
          'Descubra como descartar cada resíduo.',
          1,
        ),

        cardInicio(
          Icons.quiz,
          'Quiz ambiental',
          'Teste seus conhecimentos sobre reciclagem.',
          2,
        ),

        const SizedBox(height: 15),

        const Text(
          'Por que reciclar?',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'A separação correta dos resíduos contribui '
          'para reduzir a poluição, economizar recursos '
          'naturais e preservar o meio ambiente.',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  // CARTÕES DA TELA INICIAL
  Widget cardInicio(
    IconData icone,
    String titulo,
    String descricao,
    int destino,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: verdeClaro,
          child: Icon(icone, color: verde),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(descricao),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          setState(() {
            paginaAtual = destino;
          });
        },
      ),
    );
  }

  // TELA 2 - CONSULTA DE MATERIAIS
  String pesquisa = '';
  String categoriaSelecionada = 'Todas';

  Widget telaConsulta() {
    final resultados = materiais.where((material) {
      final nome = material.nome.toLowerCase();
      final termo = pesquisa.toLowerCase();

      final correspondeNome = nome.contains(termo);

      final correspondeCategoria =
          categoriaSelecionada == 'Todas' ||
          material.categoria == categoriaSelecionada;

      return correspondeNome && correspondeCategoria;
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Guia de descarte',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Pesquise um material e descubra como '
          'realizar seu descarte.',
        ),

        const SizedBox(height: 20),

        TextField(
          onChanged: (valor) {
            setState(() {
              pesquisa = valor;
            });
          },
          decoration: InputDecoration(
            hintText: 'Ex: garrafa, papel, pilha...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'Categorias',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categorias.map((categoria) {
            return ChoiceChip(
              label: Text(categoria),
              selected: categoriaSelecionada == categoria,
              onSelected: (selecionado) {
                setState(() {
                  categoriaSelecionada = categoria;
                });
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        Text(
          '${resultados.length} materiais encontrados',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        ...resultados.map((material) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: verdeClaro,
                child: Icon(material.icone, color: verde),
              ),
              title: Text(
                material.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(material.categoria),
              trailing: const Icon(Icons.info_outline),
              onTap: () {
                mostrarOrientacao(material);
              },
            ),
          );
        }),

        if (resultados.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Nenhum material encontrado.',
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  // MOSTRAR ORIENTAÇÃO DO MATERIAL
  void mostrarOrientacao(MaterialEco material) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(material.nome),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categoria: ${material.categoria}'),
              const SizedBox(height: 12),
              Text(material.orientacao),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Entendi'),
            ),
          ],
        );
      },
    );
  }

  // TELA 3 - QUIZ AMBIENTAL
  int perguntaAtual = 0;
  int pontos = 0;
  bool finalizado = false;

  final List<Map<String, dynamic>> perguntas = [
    {
      'pergunta': 'Qual é a cor da lixeira destinada ao papel?',
      'opcoes': ['Azul', 'Vermelha', 'Verde', 'Amarela'],
      'resposta': 'Azul',
    },
    {
      'pergunta': 'Onde devemos descartar pilhas usadas?',
      'opcoes': [
        'No lixo comum',
        'Em pontos de coleta específicos',
        'Na natureza',
        'No ralo',
      ],
      'resposta': 'Em pontos de coleta específicos',
    },
    {
      'pergunta': 'Qual material pode ser reciclado?',
      'opcoes': [
        'Garrafa PET',
        'Restos de comida',
        'Papel sujo',
        'Guardanapo usado',
      ],
      'resposta': 'Garrafa PET',
    },
    {
      'pergunta': 'Qual é uma vantagem da reciclagem?',
      'opcoes': [
        'Aumentar a poluição',
        'Desperdiçar recursos',
        'Economizar recursos naturais',
        'Produzir mais lixo',
      ],
      'resposta': 'Economizar recursos naturais',
    },
    {
      'pergunta': 'O que fazer com uma lata de alumínio?',
      'opcoes': [
        'Jogar na rua',
        'Enterrar',
        'Encaminhar à coleta seletiva',
        'Jogar em rios',
      ],
      'resposta': 'Encaminhar à coleta seletiva',
    },
  ];

  Widget telaQuiz() {
    if (finalizado) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: verde,
                size: 75,
              ),

              const SizedBox(height: 20),

              const Text(
                'Quiz concluído!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Você acertou $pontos de ${perguntas.length} perguntas!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 19),
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: reiniciarQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Jogar novamente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: verde,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final pergunta = perguntas[perguntaAtual];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Quiz ambiental 🌎',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Pergunta ${perguntaAtual + 1} de ${perguntas.length}',
        ),

        const SizedBox(height: 10),

        LinearProgressIndicator(
          value: (perguntaAtual + 1) / perguntas.length,
          color: verde,
          backgroundColor: verdeClaro,
        ),

        const SizedBox(height: 30),

        Text(
          pergunta['pergunta'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        ...List<String>.from(pergunta['opcoes']).map((opcao) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed: () {
                responder(opcao);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: verde,
                padding: const EdgeInsets.all(17),
                alignment: Alignment.centerLeft,
              ),
              child: Text(opcao),
            ),
          );
        }),
      ],
    );
  }

  // CONFERIR RESPOSTA
  void responder(String opcao) {
    if (opcao == perguntas[perguntaAtual]['resposta']) {
      pontos++;
    }

    setState(() {
      if (perguntaAtual < perguntas.length - 1) {
        perguntaAtual++;
      } else {
        finalizado = true;
      }
    });
  }

  // REINICIAR QUIZ
  void reiniciarQuiz() {
    setState(() {
      perguntaAtual = 0;
      pontos = 0;
      finalizado = false;
    });
  }
}