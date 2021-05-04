% ---------------------------------------------- Regras Mov {s()} -----

%% mov direita
s([X,Y], [Xprox,Y]):- X<10, Xprox is X + 1. % adicionar not(pertence([Xprox,Y],ListaGarrafa)).
%implementar sucessão para salto

%% mov esquerda
s([X,Y], [Xprox,Y]):-
        X>0,
        Xprox is X - 1.

% adicionar not(pertence([Xprox,Y],ListaGarrafa)). --> anda uma casa se estiver livre
% implementar sucessão para salto --> proxima casa está ocupada por
% garrafa

% -------------------------------------------Tamanho da lista:

tamanho([],0).
tamanho([_|Cauda],N):-
        tamanho(Cauda,N1),
        N is N1+1.

% -------------------------------------------Fatos mapa:
escada([2,1]).
escada([3,2]).
escada([5,2]).
escada([4,3]).
escada([9,3]).
escada([10,4]).
escada([7,4]).
escada([6,5]).

coracao([5,1]).
%coracao([10,3]).
%coracao([8,4]).
%coracao([8,5]).

posicaoEspinafre([]). %posições iguais para teste
posicaoBrutus([]).

%  TODO: implementar regra para não permitir dois objetos na mesma
%  posição.

%------------------------------------Formatação dos fatos:


formaListaCoracoes(ListaCoracoes):-bagof(Coordenada,coracao(Coordenada),ListaCoracoes).

%A condição de parada desse bagof() será: acabaram os fatos escada(Coordenada).
formaListaEscada(ListaEscadas):-bagof(Coordenada,escada(Coordenada),ListaEscadas).

%listaObjetivos([]).

formaListaObjetivos(R2):-
        formaListaCoracoes(LC),
	posicaoEspinafre(PE),
	concatena(LC,PE,R1),
        posicaoBrutus(PB),
        %listaObjetivos(S),
        concatena(R1,PB,R2).


%-----------------------------------Algoritmos Dependencias:

concatena([Cabeca|Cauda],L2,[Cabeca|Resultado]):-concatena(Cauda,L2,Resultado).
concatena([],L,L).

% ! estende() chama bagof() de forma que o sucessor eh escolhido a
% partir da regra de sucessão (movimentação). Caso seja um sucessor
% válido ele eh acrescentado à cabeça da lista alternativa como novo
% estado atual dela. Após feito isso este estado atual eh acrescido à
% ListaSucessores.

estende([EstadoAtual|Caminho],ListaSucessores):-
	bagof([Sucessor,EstadoAtual|Caminho], (s(EstadoAtual,Sucessor), not(pertence(Sucessor,[EstadoAtual|Caminho]))), ListaSucessores),!. %pesquisar

estende(_,[]).

pertence(E, [E|_]).
pertence(E, [_|Cauda]):- pertence(E, Cauda).

% --------------------------------------------codigo bl():

solucao_bl(EstadoInicial, CaminhoSolucao,ListaObjetivos):-bl([[EstadoInicial]], CaminhoSolucao,ListaObjetivos). %encapsula



% - A solução unifica com [EstadoAtual|Caminho] pq se o meta eh true a
% solução eh o estado atual.
bl([[EstadoAtual|Caminho]|_],[EstadoAtual|Caminho],ListaObjetivos):-
        meta(EstadoAtual,ListaObjetivos). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

bl([Cabeca|Cauda], CaminhoSolucao, ListaObjetivos):-
	estende(Cabeca,ListaSucessores),
	concatena(Cauda,ListaSucessores,NovaFronteira),
	bl(NovaFronteira, CaminhoSolucao, ListaObjetivos).

meta(EstadoAtual,[CabecaObjetivo|CaudaObjetivo]):- %separa a lista de objetivo em CabecaObjetivo e CaudaObjetivo
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        CaudaObjetivo == []. % É o ultimo objetivo (deverá ser o Brutus) e a busca pode terminar


%meta(EstadoAtual,[CabecaObjetivo|CaudaObjetivo]):- %separa a lista de
% objetivo em CabecaObjetivo e CaudaObjetivo
%        EstadoAtual == CabecaObjetivo, % o estado atual realmente
%        corresponde a um objetivo
%        CaudaObjetivo =\= []. % É o ultimo objetivo (deverá ser o
%        Brutus) e a busca pode terminar

%--------------------------------------------- main():
%
main(EstadoInicial,CaminhoSolucao) :-
        formaListaObjetivos(ListaObjetivos),
	solucao_bl(EstadoInicial, CaminhoSolucao, ListaObjetivos).
