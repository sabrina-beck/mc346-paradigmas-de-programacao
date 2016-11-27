%% Vai ter teste todas as aulas a partir da semana que vem...
%% Não vai ter notas de aulas de prolog porque ele não consegue instalar prolog no jupiter
%% Os testes de terça serão no início da aula

%% Prolog vem de **Pro**gramming in **Log**gic, e é muito diferente da programação imperativa tradicional.

%% Em prolog temos uma "base de conhecimento" (Knowledge base), e fazemos "perguntas" (queries) à base.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informações Práticas %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% O kernel que temos no jupiter é muito ruim - use o swi-prolog, que é livre e disponível para qualquer arquitetura.
%% abrir no terminal o repl do prolog e usar o seguinte comando para carregar um arquivo

consult(arquivo).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fatos                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
indian(curry).          %% curry é comida indiana
indian(dahl).
indian(tandori).
indian(kurma).

chinese(chow_mei).
chinese(chop-suei).
chinese(sweet_and_sour).
                        %% o exemplo ta em ingles, entao ele nao consgue fazer o exemplo em portugues
italian(pizza).
italian(spaghetti).

%% true --> achei no meu conhecimento
%% false --> não achei no meu conhecimento, nao significa que é falso

atomic(dahl).
|> true

atomic(indian).
|> true

%% Outro exemplo

male(john).
male(andrew).
male(peter).

female(ana).
female(mary).
female(beth).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Conjunção            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

parents(beth, john, ana).       %% john e ana são pais da beth
parents(mary, john, ana).
parents(andrew, john, ana).

parents(john, peter, sarah).
parents(ana, paul, karen).

parents(beth, john, X).
|> X = ana.

parents(X, john, Y).
|> X = beth,
   Y = ana;
   X = mary,
   Y = ana;
   X = andrew,
   Y = ana.

%% X e Y não são variáveis, depois de executada a query X e Y não possuem mais aqueles valores.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Regra                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% sister_of(X, Y)
%% X tem que ser female
%% parents de X precisam ser os parents de Y
sister_of(X, Y) :- female(X),
                   parents(X, F, M),
                   parents(Y, F, M).
sister_of(andrew, beth).
|> false

sister_of(beth, mary).
|> true

sister_of(mary, X).
|> X = beth;
   X = mary;
   X = andrew.

%% Para evitar que mary apareça como irmã dela mesma:
    %% ele se perdeu nos papéis em cima da mesa, procurando e procurando como verificar que X é 
    %% diferente de Y e falando "Porcariaa" --> desistiu pq é perda de tempo
sister_of(X, Y) :- female(X),
                   parents(X, F, M),
                   parents(Y, F, M),
                   X is not Y.          %% acho que é assim

%% O Igual é a unificação do prolog onde ele tenta pegar duas estruturas e fazer elas serem iguais (Pattern Matching?)
sister_of(mary, john) = sister_of(mary, Y).
|> Y = john

parents(X, Y, Z) = parents(parents(a, b, c), d, e).
|> X = parents(a, b, c),
   Y = d,
   Z = e.

presidente(sarney, 1985, 1990).
presidente(collor, 1990, 1992).
presidente(itamar, 1992, 1994).
presidente(fhc, 1995, 2002).
presidente(lula, 2003, 2010).
presidente(dilma, 2011, 2016).

listing(presidente). // lista todos os predicados

listing(sister_of). //mostra a definição da regra

governa(X, Y) :- presidente(X, A, B),
                 Y >= A,
                 Y <= B.

governa(sarney, 1988).
|> true

governa(X, 1988).
|> X = sarney;
   false.

governa(sarney, X).
|> ERROR: >=/2: Arguments are not sufficiently instantiate

%% calculando valores numéricos
populacao(usa, 203).
populacao(india, 548).
populacao(china, 800).
populacao(brazil, 108).

area(usa, 3).
area(india, 1).
area(china, 4).
area(brasil, 3).

%% a densidade Y do pais X
density(X, Y) :- populacao(X, P),
                 area(X, A),
                 Y is P / A.

density(china, X).
|> X = 200.

density(X, 200).
|> X = china;
   false.

%% numero é complicado
density(X, 67.666).
|> false

density(X, 67.6666666666666).
|> false

density(X, 67.6666666666666666666666).
|> usa

%% Exercicio
%% escreva um predicado grandpa_of(X, Y) que retorna verdadeiro quando X é avô de Y
grandpa_of(X, Y) :- male(X),
                    parents(X, F, _),
                    parents(F, Y, _).

grandpa_of(X, Y) :- male(X),
                    parents(X, _, M),
                    parents(M, Y, _).
