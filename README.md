# Inteligência Artificial Popeye

  Este projeto foi baseado no jogo Popeye, produzido pela Nintendo em 1982.Este programa é de fácil utilização e apresenta uma adaptação do jogo pela construção da Base de Conhecimento(BC: "popeye.pl"). No jogo original a Olivia Palito (um dos personagens presentes que foi dispensado na adaptação para o projeto) disponibiliza corações no mapa enquanto garrafas são arremessadas, e que devem ser evitadas. Para simplificação do projeto de disciplina de Inteligência Artificial (SIN 323 UFV-CRP) tanto os corações quanto as garrafas se tornaram objetos estáticos. O objetivo também foi modificiado. O personagem principal do jogo, Popeye, deve capturar todos os corações do mapa, recolher o espinafre e por fim derrotar o vilão Brutus (persongaem estático). 

* **Objetivo do Programa**

Por meio do método Busca em Largura (BL) o protagonista pode percorrer um mapa de 5 andares, com 10 casas em cada andar, se movendo verticalmente por meio de escadas e horizontalmente evitando garrafas por meio de salto. Se há apenas uma garrafa a sua frente ele pode salta, caso haja duas ou uma garrafa e o Brutus logo após ele não poderá saltar. A BL foi utilizada pela capacidade de encontrar soluções ótimas (caminhos eficientes) de acordo com a disposição do mapa configurado na BC.

* **Configuração do Mapa**

A limitação do mapa é definida de acordo com as regras de movimentação (regras de sucessão s()). Já os corações e garrafas são definidas pelos fatos: coracao([X,Y]) e garrafa([X,Y]), em que X (coordenada do eixo horizontal) e Y (coordenada do eixo vertical) devem receber valores baseados no mapa(exemplo com componentes do jogo):

   ![image](https://user-images.githubusercontent.com/43487367/119179513-5f575200-ba45-11eb-90ec-77920e3ca834.png)


A limitação de utilização é de acordo com a possibilade de movimentação do personagem no contexto de disposição dos obstáculos. 

As escadas possuem implementação um pouco distinta dos outros fatos. Foi utilizado link(A,B) formando uma origem e um destino. Para que uma escada possa ser usada tanto para subir quanto para descer é necessário: "link([4,1],[5,2])." e "link([5,2],[4,1])." .Dessa forma as escadas não terão seus limites confundidos.

A posição do útimo e do penúltimo objetivo foram implementadas utilizando encapsulamento da coordenada em uma lista: "posicaoEspinafre([[4,3]])." "posicaoBrutus([[10,5]]).". Com esse encpsulamento é possível unir os corações junto a esses dois fatos para formar uma lista de objetivos.


* **Utilização** 
 
 Para executar o código é recomendado utilizar o Swi-Prolog (utilizado durante o desenvolvimento). Após abrir o programa o usuário deve utilizar a opção de consulta de documento (“Consult”) no campo “File”, presente no canto superior esquerdo. Com isso basta efetuar a consulta, via comando (de acordo com a linguagem Prolog), referente a regra que deseja obter uma resposta. Algumas regras, como de formação de listas ("formaListaObjetivos(ListaObjetivos).", por exemplo) podem ser chamdas de maneira independente à BL. Para verificar a execução completa o usuário deve inserir uma posição inicial do Popeye, perguntar pelo caminho da traçado na busca e fornecer também uma variável (terceiro parâmetro) para retorno da pontuação calculada pela coleta de corações (cada coração tem o valor do andar multiplicado por 100):
 
 ?-main([1,1],Caminho,Pontuacao).
 
 Neste exemplo o Popeye começa na primeira casa (coordenada X) do primeiro andar (coordenada Y) e recebe um vetor em "Caminho" com todas as posições percorridas no mapa. O vetor será apresentado em ordem decrescente e posições dublicadas, com excessão do Brutus, representam encontro com um Elemento Objetivo e sequência na busca com o novo estado inicial sendo o ponto de coleta do objetivo.
 
* **Exemplo Execução** 

![image](https://user-images.githubusercontent.com/43487367/119181643-42704e00-ba48-11eb-8cf2-e1b23999d89e.png)

A variável "S" foi utilizada para retorno do caminho. O caminho à cada objetivo está representado graficamente por uma linha e com a cor correspondente marcando o caminho definido por sequência de coordenadas [X,Y]. A pontuação é retornada em "P" e foi equivalente a 1800.

 
