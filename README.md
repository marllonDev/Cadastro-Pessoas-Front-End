# Cadastro Pessoas - Flutter Front-End

## Sobre o Projeto
Aplicação mobile desenvolvida em Flutter para cadastro de pessoas e carros, consumindo uma API Flask no backend. Permite alternar entre tema claro/escuro e idiomas (Português/Inglês).

## Como Iniciar a Aplicação

1. **Pré-requisitos:**
   - Flutter instalado ([Guia oficial](https://docs.flutter.dev/get-started/install))
   - Dispositivo físico ou emulador configurado

2. **Instale as dependências:**
   ```sh
   flutter pub get
   ```

3. **Execute o app:**
   ```sh
   flutter run
   ```

> Certifique-se de que o backend Flask está rodando e acessível pelo endereço configurado no app (`http://10.0.2.2:8000` para Android Emulator ou `http://localhost:8000` para web).

## Entidades

### Pessoa
- **Campos:**
  - `nome` (string)
  - `idade` (int)
  - `email` (string)

### Carro
- **Campos:**
  - `nome` (string)
  - `ano` (int)
  - `marca` (string)
  - `preco` (float)

## Endpoints da API

### Pessoa
- **Criar Pessoa:**
  - `POST /pessoas`
  - **Body:**
    ```json
    {
      "nome": "João",
      "idade": 30,
      "email": "joao@email.com"
    }
    ```


### Carro
- **Criar Carro:**
  - `POST /carros`
  - **Body:**
    ```json
    {
      "nome": "Fusca",
      "ano": 1980,
      "marca": "Volkswagen",
      "preco": 15000.0
    }
    ```


## Exemplos de Chamada à API

### Flutter (usando http)
```dart
final url = Uri.parse('http://10.0.2.2:8000/pessoas');
final response = await http.post(
  url,
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'nome': 'Maria',
    'idade': 25,
    'email': 'maria@email.com',
  }),
);
```

## Observações
- O app alterna entre português e inglês.
- O tema pode ser alternado entre claro e escuro.
- Certifique-se de que o backend está ativo antes de cadastrar.


## Sobre mim
𝐒𝐞𝐧𝐢𝐨𝐫 𝐃𝐚𝐭𝐚 𝐄𝐧𝐠𝐢𝐧𝐞𝐞𝐫

Com 𝟰+ 𝘆𝗲𝗮𝗿𝘀 de experiência no mundo da tecnologia, eu me desenvolvo na interseção entre engenharia de dados e inovação. Atualmente, estou criando ecossistemas de dados escaláveis como 𝗦𝗲𝗻𝗶𝗼𝗿 𝗗𝗮𝘁𝗮 𝗘𝗻𝗴𝗶𝗻𝗲𝗲𝗿. Aperfeiçoei minhas habilidades em setores que moldam as economias - desde 𝗺𝗮𝗶𝗼𝗿𝗲𝘀 𝗯𝗮𝗻𝗰𝗼𝘀 𝗱𝗼 𝗕𝗿𝗮𝘀𝗶𝗹 e 𝘀𝗲𝗴𝘂𝗿𝗮𝗱𝗼𝗿𝗮𝘀 𝗹𝗶𝗱𝗲𝗿𝗲𝘀 𝗺𝘂𝗻𝗱𝗶𝗮𝗶𝘀, até o 𝗺𝗮𝗶𝗼𝗿 𝗽𝗿𝗼𝗱𝘂𝘁𝗼𝗿 𝗱𝗲 𝗰𝗲𝗿𝘃𝗲𝗷𝗮 do mundo, e agora estou causando impacto no 𝘀𝗲𝘁𝗼𝗿 𝗱𝗼 𝗰𝗿𝗲𝗱𝗶𝘁𝗼. 

💡 𝗣𝗼𝗿𝗾𝘂𝗲 𝗲𝘂 𝗺𝗲 𝗱𝗲𝘀𝘁𝗮𝗰𝗼? \
Eu 𝗮𝗿𝗾𝘂𝗶𝘁𝗲𝘁𝗼 𝗽𝗶𝗽𝗲𝗹𝗶𝗻𝗲𝘀 de dados robustos para 𝗙𝗼𝗿𝘁𝘂𝗻𝗲 𝟱𝟬𝟬 𝗽𝗹𝗮𝘆𝗲𝗿𝘀, otimizei os sistemas legados para nuvem (𝗔𝗪𝗦/𝗔𝘇𝘂𝗿𝗲) que forneceram insights acionáveis por meio de estruturas ETL/ELT escaláveis. Da análise financeira em tempo real à otimização da cadeia de suprimentos de cervejarias, eu transformo dados brutos em ativos estratégicos. 

✨ 𝗔𝗹𝗲𝗺 𝗱𝗼 𝗰𝗼𝗱𝗶𝗴𝗼: \
Um aprendiz permanente obcecado com a democratização de dados e a solução ágil de problemas. Vamos nos conectar se você estiver 𝗮𝗽𝗮𝗶𝘅𝗼𝗻𝗮𝗱𝗼 sobre a nuvem, eficiência do 𝗗𝗲𝘃𝗢𝗽𝘀 ou o papel dos dados na transformação dos setores!

Me siga: [Linkedin](https://www.linkedin.com/in/marllonzuc/) \
Meu Blog: [Blog](https://datatrends.me/)


![Logo](https://media.licdn.com/dms/image/v2/D4D03AQEFlFTNmApBhQ/profile-displayphoto-shrink_800_800/B4DZbt9iTrHsAc-/0/1747749054334?e=1753315200&v=beta&t=VfBvrDxLmoAYccE0DW63MbSLz_ao9Xp_HQAfcyP7-og)
