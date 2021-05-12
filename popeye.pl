% ---------------------------------------------- Regras Mov {s()} -----

%% ---------------------mov direita:
%
s([X,Y], [Xprox,Y],_,_,ListaGarrafa):-
    X<10,
    Xprox is X + 1,
    not(pertence([Xprox,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox,Y],PB)).

s([X,Y], [Xprox,Y],[CabecaObjetivos|_],_,_):-
    X<10,
    Xprox is X + 1,
    posicaoBrutus(PB),
    [CabecaObjetivos] == PB,
    pertence([Xprox,Y],PB).



s([X,Y], [Xprox2,Y],_,_,ListaGarrafa):-
    X<9,
    Xprox is X + 1,
    pertence([Xprox,Y],ListaGarrafa),
    Xprox2 is X + 2,
    not(pertence([Xprox2,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox2,Y],PB)).

%% ---------------------mov esquerda:
%
s([X,Y], [Xprox,Y],[CabecaObjetivos|_],_,ListaGarrafa):-
    X>1,
    Xprox is X - 1,
    not(pertence([Xprox,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    [CabecaObjetivos] == PB,
    pertence([Xprox,Y],PB).

s([X,Y], [Xprox,Y],_,_,ListaGarrafa):-
    X>1,
    Xprox is X - 1,
    not(pertence([Xprox,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox,Y],PB)).


s([X,Y], [Xprox2,Y],_,_,ListaGarrafa):-
    X>2,
    Xprox is X -1,
    pertence([Xprox,Y],ListaGarrafa),
    Xprox2 is X - 2,
    not(pertence([Xprox2,Y],ListaGarrafa)),
    posicaoBrutus(PB),
    not(pertence([Xprox2,Y],PB)).

%%---------------------mov cima direita:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):-
    X<10,
    Y<5,
    pertence([X,Y],ListaEscadas),
    Xprox is X + 1,
    Yprox is Y + 1,
    pertence([Xprox,Yprox],ListaEscadas).

%%---------------------mov cima esquerda:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):-
    X>1,
    Y<5,
    pertence([X,Y],ListaEscadas),
    Xprox is X - 1,
    Yprox is Y + 1,
    pertence([Xprox,Yprox],ListaEscadas).

%%--------------------mov baixo direita:
%
s([X,Y], [Xprox,Yprox],_,ListaEscadas,_):-
    X<10,
    Y>1,
    Xprox is X + 1,
    Yprox is Y - 1,
    pertence([X,Y],ListaEscadas),
	pertence([Xprox,Yprox],ListaEscadas).

%%---------------------mov baixo esquerda:
%
s([X,Y], [Xprox,Yprox],_, ListaEscadas,_):-
    X>1,
    Y>1,
    Xprox is X - 1,
    Yprox is Y - 1,
    pertence([X,Y],ListaEscadas),
    pertence([Xprox,Yprox],ListaEscadas).





% adicionar not(pertence([Xprox,Y],ListaGarrafa)). --> anda uma casa se estiver livre
% implementar sucessão para salto --> proxima casa está ocupada por
% garrafa

% -------------------------------------------Tamanho da lista:

tamanho([],0).
tamanho([_|Cauda],N):-
        tamanho(Cauda,N1),
        N is N1+1.

% -------------------------------------------Fatos mapa:
%escada([2,1]).
%escada([3,2]).
%escada([5,2]).
%escada([4,3]).
%escada([9,3]).
%escada([10,4]).
%escada([7,4]).
%escada([6,5]).

escada([1,2]).
escada([2,1]).
escada([5,2]).
escada([4,1]).

coracao([4,1]).
%coracao([4,2]).
%coracao([10,3]).
%coracao([8,4]).
%coracao([10,5]).

garrafa([]).


posicaoEspinafre([]). %posições iguais para teste
posicaoBrutus([[3,1]]).

%  TODO: implementar regra para não permitir dois objetos na mesma
%  posição.

%------------------------------------Formatação dos fatos:


formaListaCoracoes(ListaCoracoes):-bagof(Coordenada,coracao(Coordenada),ListaCoracoes).

%A condição de parada desse bagof() será: acabaram os fatos escada(Coordenada).
formaListaEscadas(ListaEscadas):-bagof(Coordenada,escada(Coordenada),ListaEscadas).

formaListaGarrafas(ListaGarrafas):-bagof(Coordenada,garrafa(Coordenada),ListaGarrafas).

formaListaObjetivos(R2):-
        formaListaCoracoes(LC),
	posicaoEspinafre(PE),
	concatena(LC,PE,R1),
        posicaoBrutus(PB),
        concatena(R1,PB,R2).


%-----------------------------------Algoritmos Dependencias:

concatena([Cabeca|Cauda],L2,[Cabeca|Resultado]):-concatena(Cauda,L2,Resultado).
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

solucao_bl(EstadoInicial, CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas):-bl([[EstadoInicial]], CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas). %encapsula


% - A solução unifica com [EstadoAtual|Caminho] pq se o meta eh true a
% solução eh o estado atual.
bl([[EstadoAtual|Caminho]|_],CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas):-
        meta([EstadoAtual|Caminho],CaminhoSolucao,ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

bl([Cabeca|Cauda], CaminhoSolucao, ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas):-
	estende(Cabeca,ListaSucessores,ListaObjetivos,ListaEscadas,ListaGarrafas),
	concatena(Cauda,ListaSucessores,NovaFronteira),
	bl(NovaFronteira, CaminhoSolucao, ListaObjetivos,CaminhoTemp,ListaEscadas,ListaGarrafas).

meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp,_,_):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        CaudaObjetivo == [], % É o ultimo objetivo (deverá ser o Brutus) e a busca pode terminar
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoSolucao).

%separa a lista de objetivo em CabecaObjetivo e CaudaObjetivo
meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp,ListaEscadas,ListaGarrafas):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        not(CaudaObjetivo == []),
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoTemp2),
        solucao_bl(EstadoAtual,CaminhoSolucao,CaudaObjetivo,CaminhoTemp2,ListaEscadas,ListaGarrafas),!. %sem esse corte a busca continua para outro meta e acaba falhando a busca% toda


%--------------------------------------------- main():
%
main(EstadoInicial,CaminhoSolucao) :-
        formaListaObjetivos(ListaObjetivos),
        formaListaEscadas(ListaEscadas),
        formaListaGarrafas(ListaGarrafas),
	solucao_bl(EstadoInicial, CaminhoSolucao, ListaObjetivos,[],ListaEscadas,ListaGarrafas).





