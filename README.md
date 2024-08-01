# E-commerce App

Este é um aplicativo de e-commerce desenvolvido em Flutter utilizando o Bloc para gerenciamento de estado. O aplicativo possui funcionalidades como listagem de produtos, carrinho de compras, wishlist e atualização dinâmica da interface do usuário com base nos estados do Bloc.

## Funcionalidades

- **Listagem de Produtos**: Exibe uma lista de produtos disponíveis com informações como imagem, nome, descrição e preço. Os usuários podem adicionar produtos ao carrinho ou à wishlist.
- **Carrinho de Compras**: Exibe os produtos adicionados ao carrinho com detalhes como nome, quantidade, preço e subtotal. Permite aumentar ou diminuir a quantidade de cada produto, remover produtos do carrinho e calcular o total do pedido em tempo real.
- **Wishlist**: Exibe produtos que o usuário marcou como desejados, permitindo mover produtos da wishlist para o carrinho ou removê-los da wishlist.
- **Histórico de Pedidos**: (Funcionalidade futura) Apresentará uma lista de pedidos anteriores do usuário, detalhando informações como a data do pedido e os itens comprados.

## Estrutura do Projeto

- `lib/`
  - `blocs/`: Contém os BLoCs (Business Logic Components) para gerenciamento de estado.
  - `models/`: Contém os modelos de dados.
  - `repositories/`: Contém os repositórios para acesso a dados.
  - `screens/`: Contém as telas do aplicativo.
  - `widgets/`: Contém os widgets reutilizáveis.
    
## Instalação

1. Clone o repositório:
    ```sh
    git clone https://github.com/dbonfleur/state_mananger_bloc
    ```

2. Navegue até o diretório do projeto;

3. Instale as dependências:
    ```sh
    flutter pub get
    ```

4. Execute o aplicativo:
    ```sh
    flutter run
    ```

## Contato

Daniel Bonfleur - [danibonfleur@hotmail.com](mailto:danibonfleur@hotmail.com)

Link do Projeto: [https://github.com/dbonfleur/state_mananger_bloc](https://github.com/dbonfleur/state_mananger_bloc)
