% ---------------------------------------------- Regras Mov {s()} -----

%% mov direita
 s([X,Y], [Xprox,Y]):- X<10, Xprox is X + 1. % adicionar
% not(pertence([Xprox,Y],ListaGarrafa)). implementar sucessão para salto

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

coracao([6,1]).
coracao([5,1]).
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

solucao_bl(EstadoInicial, CaminhoSolucao,ListaObjetivos,CaminhoTemp):-bl([[EstadoInicial]], CaminhoSolucao,ListaObjetivos,CaminhoTemp). %encapsula



% - A solução unifica com [EstadoAtual|Caminho] pq se o meta eh true a
% solução eh o estado atual.
bl([[EstadoAtual|Caminho]|_],CaminhoSolucao,ListaObjetivos,CaminhoTemp):-
        meta([EstadoAtual|Caminho],CaminhoSolucao,ListaObjetivos,CaminhoTemp). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

bl([Cabeca|Cauda], CaminhoSolucao, ListaObjetivos,CaminhoTemp):-
	estende(Cabeca,ListaSucessores),
	concatena(Cauda,ListaSucessores,NovaFronteira),
	bl(NovaFronteira, CaminhoSolucao, ListaObjetivos,CaminhoTemp).

meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        CaudaObjetivo == [], % É o ultimo objetivo (deverá ser o Brutus) e a busca pode terminar
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoSolucao).

%separa a lista de objetivo em CabecaObjetivo e CaudaObjetivo
meta([EstadoAtual|Caminho],CaminhoSolucao,[CabecaObjetivo|CaudaObjetivo],CaminhoTemp):-
        EstadoAtual == CabecaObjetivo, % o estado atual realmente corresponde a um objetivo
        not(CaudaObjetivo == []),
        concatena([EstadoAtual|Caminho],CaminhoTemp,CaminhoTemp2),
        solucao_bl(EstadoAtual,CaminhoSolucao,CaudaObjetivo,CaminhoTemp2),!. %sem esse corte a busca continua para outro meta e acaba falhando a busca% toda


%--------------------------------------------- main():
%
main(EstadoInicial,CaminhoSolucao) :-
        formaListaObjetivos(ListaObjetivos),
	solucao_bl(EstadoInicial, CaminhoSolucao, ListaObjetivos,[]).
