% ---------------------------------------------- Regras Mov {s()} -----

%% ---------------------mov direita:
%implementação utilizando a chamada padrão de regra de sucessão:

s([X,Y], [Xprox,Y],_,_,ListaGarrafa):- % caso de movimentação mais simples para direita
    X<10, % as condições de tamanho do X e do Y limitam o movimento dando ilusão de mapa em execução
    Xprox is X + 1, % incremento do X simula movimento horizontal (eixo X) para direita
    not(pertence([Xprox,Y],ListaGarrafa)), % essa regra não aceita quando a próxima casa à direita da atual é uma garrafa
    posicaoBrutus(PB),
    not(pertence([Xprox,Y],PB)). % essa regra não é utilizada para "derrotar" o Brutus (passar por ele)

s([X,Y], [Xprox,Y],[CabecaObjetivos|_],_,_):- % movimentação para direita quando o Brutus está na próxima casa
    X<10,
    Xprox is X + 1,
    posicaoBrutus(PB),
    [CabecaObjetivos] == PB,
    pertence([Xprox,Y],PB).% essa condição faz com que essa seja a única regra de movimentação para direita que trate o caso do Brutus ser a casa seguinte

s([X,Y], [Xprox2,Y],_,_,ListaGarrafa):- % salto para direita
    X<9, % o limite máximo da casa atual é 8 para essa regra porque a movimentação ocorre em incremento de 2
    Xprox is X + 1,
    pertence([Xprox,Y],ListaGarrafa),
    Xprox2 is X + 2,
    not(pertence([Xprox2,Y],ListaGarrafa)), % essas ultimas linhas especificam que não há salto quando existem duas garrafas consecutivas ou garrafa+Brutus
    posicaoBrutus(PB),
    not(pertence([Xprox2,Y],PB)).

%% ---------------------mov esquerda:
%
s([X,Y], [Xprox,Y],[CabecaObjetivos|_],_,ListaGarrafa):- % movimentação para esquerda quando o Brutus está na próxima casa
    X>1, % em movimentações para esquerda o X deve ser maior que um porque um decremento levaria à posição 0 que eh considerada como fora do limite do mapa
    Xprox is X - 1,
    not(pertence([Xprox,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    [CabecaObjetivos] == PB,
    pertence([Xprox,Y],PB).

s([X,Y], [Xprox,Y],_,_,ListaGarrafa):- % caso mais simples de movimentação para esquerda
    X>1,
    Xprox is X - 1,
    not(pertence([Xprox,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox,Y],PB)).


s([X,Y], [Xprox2,Y],_,_,ListaGarrafa):- % salto para esquerda
    X>2,
    Xprox is X -1,
    pertence([Xprox,Y],ListaGarrafa),
    Xprox2 is X - 2,
    not(pertence([Xprox2,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox2,Y],PB)).

%%---------------------mov cima direita:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):- % movimentação em escada subindo para diagonal direita
    X<10,
    Y<5,
    pertence([X,Y],ListaEscadas),
    Xprox is X + 1,
    Yprox is Y + 1,
    pertence([Xprox,Yprox],ListaEscadas), link([X,Y],[Xprox,Yprox]).

%%---------------------mov cima esquerda:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):- % movimentação em escada subindo para diagonal esquerda
    X>1,
    Y<5,
    pertence([X,Y],ListaEscadas),
    Xprox is X - 1,
    Yprox is Y + 1,
    pertence([Xprox,Yprox],ListaEscadas), link([X,Y],[Xprox,Yprox]).

%%--------------------mov baixo direita:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):- % movimentação em escada descendo para direita
    X<10,
    Y>1,
    Xprox is X + 1,
    Yprox is Y - 1,
    pertence([X,Y],ListaEscadas),
	pertence([Xprox,Yprox],ListaEscadas), link([X,Y],[Xprox,Yprox]).

%%---------------------mov baixo esquerda:
%
s([X,Y], [Xprox,Yprox],_, ListaEscadas,_):- % movimentação em escada descendo para esquerda
    X>1,
    Y>1,
    Xprox is X - 1,
    Yprox is Y - 1,
    pertence([X,Y],ListaEscadas),
    pertence([Xprox,Yprox],ListaEscadas), link([X,Y],[Xprox,Yprox]).

% -------------------------------------------Fatos mapa:
% Origem e destino das escadas
link([4,1],[5,2]).
link([5,2],[4,1]).
link([10,2],[9,3]).
link([9,3],[10,2]).
link([9,3],[10,4]).
link([10,4],[9,3]).
link([2,3],[1,4]).
link([1,4],[2,3]).
link([3,4],[2,5]).
link([2,5],[3,4]).
link([6,4],[7,5]).
link([7,5],[6,4]).

%Lista de escadas

escada([4,1]).
escada([5,2]).
escada([10,2]).
escada([2,3]).
escada([9,3]).
escada([1,4]).
escada([3,4]).
escada([6,4]).
escada([10,4]).
escada([2,5]).
escada([7,5]).

%coracao([]).
coracao([10,1]).
coracao([1,2]).
coracao([2,2]).
coracao([3,3]).
coracao([7,3]).
coracao([9,5]).

garrafa([2,1]).
garrafa([8,1]).
garrafa([7,2]).
garrafa([5,3]).
garrafa([6,3]).
garrafa([4,4]).
garrafa([5,4]).
garrafa([9,4]).
garrafa([8,5]).


posicaoEspinafre([[4,3]]). %posições iguais para teste
posicaoBrutus([[10,5]]).
%------------------------------------Organização dos fatos:

%A condição de parada desse bagof() será: acabaram os fatos escada(Coordenada).
formaListaCoracoes(ListaCoracoes):-bagof(Coordenada,coracao(Coordenada),ListaCoracoes).

formaListaEscadas(ListaEscadas):-bagof(Coordenada,escada(Coordenada),ListaEscadas).

formaListaGarrafas(ListaGarrafas):-bagof(Coordenada,garrafa(Coordenada),ListaGarrafas).

% "formaListaObjetivos()" implementa a lista de objetivos colocando em
% ordem:
%    1. Coletar Coracoes
%    2. Comer Espinafre
%    3. Derrotar Brutus

formaListaObjetivos(R2):-
        formaListaCoracoes(LC),
	posicaoEspinafre(PE),
	concatena(LC,PE,R1),
        posicaoBrutus(PB),
        concatena(R1,PB,R2).

%---------------------------------------Regra de Pontuação:

pontuacao([X,Y],Pontuacao,PontuacaoAtualizada):-
    formaListaCoracoes(Coracoes),
    pertence([X,Y],Coracoes), % consulta se o objetivo atual passado pelo meta é um coracao
    PontuacaoAtualizada is (Pontuacao + Y*100). % um coração vale 100 vezes o valor do andar que se encontra

%-----------------------------------Algoritmos Dependencias:

concatena([Cabeca|Cauda],L2,[Cabeca|Resultado]):-concatena(Cauda,L2,Resultado). % regra padrão de concatenação de elementos
concatena([],L,L).

% ! estende() chama bagof() de forma que o sucessor eh escolhido a
% partir da regra de sucessão (movimentação). Caso seja um sucessor
% válido ele eh acrescentado à cabeça da lista alternativa como novo
% estado atual dela. Após feito isso este estado atual eh acrescido à
% ListaSucessores.

estende([EstadoAtual|Caminho],ListaSucessores,ListaObjetivos,ListaEscadas,ListaGarrafas):-
	bagof([Sucessor,EstadoAtual|Caminho], (s(EstadoAtual,Sucessor,ListaObjetivos,ListaEscadas,ListaGarrafas), not(pertence(Sucessor,[EstadoAtual|Caminho]))), ListaSucessores),!. %pesquisar

estende(_,[],_,_,_).

pertence(E, [E|_]).
pertence(E, [_|Cauda]):- pertence(E, Cauda).

% --------------------------------------------codigo bl():

solucao_bl(EstadoInicial, CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal):-bl([[EstadoInicial]], CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal). % encapsula EstadoInicial para unificações durante a busca


% Este passo da Busca em Largura verifica se algum objetivo foi
% atingido, inclusive verifica se a busca terminou (Lista de Objetivos
% vazia)
bl([[EstadoAtual|Caminho]|_],CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal):-
        meta([EstadoAtual|Caminho],CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

% Caso a busca não tenha sido concluida a busca em largura expande o
% caminho alternativo na cabeça da lista de caminhos em busca de um
% objetivo.
bl([Cabeca|Cauda], CaminhoSolucao, ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal):-
	estende(Cabeca,ListaSucessores,ListaObjetivos,ListaEscadas,ListaGarrafas),
	concatena(Cauda,ListaSucessores,NovaFronteira),
	bl(NovaFronteira, CaminhoSolucao, ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal).

meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp,_,_,PontuacaoCorrente,PontuacaoFinal):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        CaudaObjetivo == [], % É o ultimo objetivo e a busca pode terminar
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoSolucao),
        PontuacaoFinal is PontuacaoCorrente. % impede que a pontuação seja zerada no retorno da recursão

%separa a lista de objetivo em CabecaObjetivo e CaudaObjetivo
meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        not(CaudaObjetivo == []),
        pontuacao(CabecaObjetivo,PontuacaoCorrente,PontuacaoAtualizada),
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoTemp2), % guarda o caminho correto até o objetivo atual permitindo que o popeye repita coordenadas durante sua movimentação até o próximo objetivo.
        solucao_bl(EstadoAtual,CaminhoSolucao,CaudaObjetivo,CaminhoTemp2,ListaEscadas,ListaGarrafas,PontuacaoAtualizada,PontuacaoFinal),!. %sem esse corte a busca continua para outro meta e acaba falhando a busca toda

meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        not(CaudaObjetivo == []),
        formaListaCoracoes(ListaCoracoes),
        not(pertence(EstadoAtual,ListaCoracoes)),
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoTemp2),
        solucao_bl(EstadoAtual,CaminhoSolucao,CaudaObjetivo,CaminhoTemp2,ListaEscadas,ListaGarrafas,PontuacaoCorrente,PontuacaoFinal),!.



%--------------------------------------------- main():
%
main(EstadoInicial,CaminhoSolucao,PontuacaoFinal) :-
        formaListaObjetivos(ListaObjetivos),
        formaListaEscadas(ListaEscadas),
        formaListaGarrafas(ListaGarrafas),
	solucao_bl(EstadoInicial, CaminhoSolucao, ListaObjetivos,[],ListaEscadas,ListaGarrafas,0,PontuacaoFinal).



%!  ?- main([1,1],S,P).
% *Exemplo de Pergunta para início do Popeye em [1,1] e pedido do
% caminho S e pontuação P.

