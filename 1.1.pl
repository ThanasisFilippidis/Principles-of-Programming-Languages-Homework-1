nEvolutions((PokeType,ReqCandies,AvCandies),TmpNum,(PokeType,Num)):-	%return in Num the amoun of evolution available for a pokemon
	Balance is AvCandies - ReqCandies,
	Balance >= 0,
	AvCandies1 is Balance + 2,
	TmpNum1 is TmpNum + 1,
	nEvolutions((PokeType,ReqCandies,AvCandies1),TmpNum1,(PokeType,Num)).

nEvolutions((PokeType,ReqCandies,AvCandies),Num,(PokeType,Num)):-
	Balance is AvCandies - ReqCandies,
	Balance < 0.


listNEvolutions([],[]).

listNEvolutions([Head|Tail],[NewHead|NewTail]):-	%make a list in form of (Pokemon name, available evolutions)
	listNEvolutions(Tail,NewTail),
	nEvolutions(Head,0,NewHead).


evolutionSum([],0).

evolutionSum([(_,Num)|Tail],EvSum):-	%find the total amount of evolutions (the sum of each pokemon's evolutions)
	evolutionSum(Tail,TempSum),EvSum is Num + TempSum.


maxEvolutionsPokemon([],_,MaxName,MaxName).

maxEvolutionsPokemon([(PokemonName,Num)|Tail],TmpM,_,MaxName):-	%find which pokemon has the most evolutions available
	Num > TmpM, maxEvolutionsPokemon(Tail,Num,PokemonName,MaxName).

maxEvolutionsPokemon([(_,Num)|Tail],TmpM,TmpName,MaxName):-
	Num =< TmpM, maxEvolutionsPokemon(Tail,TmpM,TmpName,MaxName).

maxEvolutionsPokemon([(PokemonName,Num)|Tail],MaxName):-
	maxEvolutionsPokemon(Tail,Num,PokemonName,MaxName).


pokemon(L,N,S):-
	listNEvolutions(L,NewL),
	evolutionSum(NewL,N),
	maxEvolutionsPokemon(NewL,S).