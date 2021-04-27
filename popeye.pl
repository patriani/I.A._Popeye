

% ---------------------------------------------- Regras Mov {s()} -----


%% mov direita

s([X,Y], [Xprox,Y],ListaEscadas):- X<9, Xprox is X + 1. % adicionar not(pertence([Xprox,Y],ListaGarrafa)).
%implementar sucessão para salto

%% mov esquerda
s([X,Y], [Xprox,Y],ListaEscadas):- X>0, Xprox is X - 1. % adicionar not(pertence([Xprox,Y],ListaGarrafa)). --> anda uma casa se estiver livre
% implementar sucessão para salto --> proxima casa está ocupada por
% garrafa




% ---------------------------------------------------------------------


meta(X,Y):- X = Y. % [XAtual,YAtual] = [XObjetivo,YObjetivo]

estende([EstadoAtual|Caminho],ListaSucessores,ListaEscadas):-
	bagof([Sucessor,EstadoAtual|Caminho], (s(EstadoAtual,Sucessor,ListaEscadas), not(pertence(Sucessor,[EstadoAtual|Caminho]))), ListaSucessores),!. %pesquisar

estende(_,[],_). %revisar

pertence(E, [E|_]).
pertence(E, [_|Cauda]):- pertence(E, Cauda).

% codigo bl:

solucao_bl(EstadoInicial, ListaEscadas, Objetivo, CaminhoSolucao):-bl([[EstadoInicial]], ListaEscadas, Objetivo, CaminhoSolucao). %encapsula

bl([[EstadoAtual|Caminho]|_],ListaEscadas,Objetivo,[EstadoAtual|Caminho]):-
    meta(EstadoAtual,Objetivo). %achou resultado na cabeça da lista de análise: forma "CaminhoSolução" com EstadoAtual + Caminho percorrido até ele.

bl([Cabeca|Cauda],ListaEscadas,Objetivo, CaminhoSolucao) :-
	estende(Cabeca,Sucessores,ListaEscadas),
	concatena(Cauda,Sucessores,NovaFronteira),
	bl(NovaFronteira,ListaEscadas,Objetivo, CaminhoSolucao).

% [[X,Y],...]

main(EstadoInicial, ListaEscadas, PosicaoEspinafre, CaminhoSolucao) :-
	solucao_bl(EstadoInicial, ListaEscadas, PosicaoEspinafre, CaminhoSolucao).

	% ?- main([1,1],[[[2,1],[2,2]]],[9,3],S).

%!
%escada([2,1]).
%escada([3,2]).
%escada([5,2]).
%escada([4,3]).
%escada([9,3]).
%escada([10,4]).
%escada([7,4]).
%escada([6,5]).
%
%posicaoEspinafre([9,5]).
%posicaoBrutus([10,5]).
%
% %A condição de parada desse bagof() será: acabaram os fatos escada(Coordenada).
% formaListaEscada(ListaEscadas):-bagof(Coordenada,escada(Coordenada),ListaEscadas).
%
% formaListaObjetivos():-concatena(ListaEscadas,PosicaoEspinafre,R1),concatena(R1,PosicaoBrutus,R2).
%
