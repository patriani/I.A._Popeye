


% ---------------------------------------------- Regras Mov {s()} -----


%% mov direita

s([X,Y], [Xprox,Y]):- X<9, Xprox is X + 1. % adicionar not(pertence([Xprox,Y],ListaGarrafa)).
%implementar sucessão para salto

%% mov esquerda
s([X,Y], [Xprox,Y]):- X>0, Xprox is X - 1. % adicionar not(pertence([Xprox,Y],ListaGarrafa)). --> anda uma casa se estiver livre
% implementar sucessão para salto --> proxima casa está ocupada por
% garrafa




% -------------------------------------------Fatos mapa:

escada([2,1]).
escada([3,2]).
escada([5,2]).
escada([4,3]).
escada([9,3]).
escada([10,4]).
escada([7,4]).
escada([6,5]).

coracao([8,2]).
coracao([10,3]).
coracao([8,4]).
coracao([10,5]).

posicaoEspinafre([9,5]).
posicaoBrutus([10,5]).

%------------------------------------Formatação dos fatos:


formaListaCoracoes(ListaCoracoes):-bagof(Coordenada,coracao(Coordenada),ListaCoracoes).

%A condição de parada desse bagof() será: acabaram os fatos escada(Coordenada).
formaListaEscada(ListaEscadas):-bagof(Coordenada,escada(Coordenada),ListaEscadas).

formaListaObjetivos(ListaObjetivos):-concatena(LE,PE,R1),concatena(R1,PB,ListaObjetivos),formaListaEscada(LE),posicaoEspinafre(PE),posicaoBrutus(PB).

%-----------------------------------Algoritmos Dependencias:

concatena([Cabeca|Cauda],L2,[Cabeca|Resultado]):-concatena(Cauda,L2,Resultado).
concatena([],L,L).

meta(X,Y):- X = Y. % [XAtual,YAtual] = [XObjetivo,YObjetivo]

estende([EstadoAtual|Caminho],ListaSucessores):-
	bagof([Sucessor,EstadoAtual|Caminho], (s(EstadoAtual,Sucessor), not(pertence(Sucessor,[EstadoAtual|Caminho]))), ListaSucessores),!. %pesquisar

estende(_,[],_). %revisar

pertence(E, [E|_]).
pertence(E, [_|Cauda]):- pertence(E, Cauda).

% --------------------------------------------codigo bl():

solucao_bl(EstadoInicial, CaminhoSolucao):-bl([[EstadoInicial]], CaminhoSolucao). %encapsula

bl([[EstadoAtual|Caminho]|_],[EstadoAtual|Caminho]):-
    meta(EstadoAtual). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

bl([Cabeca|Cauda], CaminhoSolucao) :-
	estende(Cabeca,Sucessores),
	concatena(Cauda,Sucessores,NovaFronteira),
	bl(NovaFronteira, CaminhoSolucao).

%--------------------------------------------- main():
main(EstadoInicial, CaminhoSolucao) :-
	solucao_bl(EstadoInicial, CaminhoSolucao).














