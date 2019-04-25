goodSeatCount([_,o],GoodSeatCounter,GoodSeatCounter).	%when we reach the end of the list the tmp Counter becomes the final one 

goodSeatCount([e,e,X|Tail],TmpGoodSeatCounter,GoodSeatCounter):-	%if an empty seat has on her left an empty one we dont care what's on her right
	TmpGoodSeatCounter1 is TmpGoodSeatCounter + 1,					%and we increase the good seats counter
	goodSeatCount([e,X|Tail],TmpGoodSeatCounter1,GoodSeatCounter).

goodSeatCount([_,e,e|Tail],TmpGoodSeatCounter,GoodSeatCounter):-	%if an seat empty has on her right an empty one we dont care what's on her left
	TmpGoodSeatCounter1 is TmpGoodSeatCounter + 1,					%and we increase the good seats counter
	goodSeatCount([e,e|Tail],TmpGoodSeatCounter1,GoodSeatCounter).

goodSeatCount([o,e,o|Tail],TmpGoodSeatCounter,GoodSeatCounter):-	%if an seat empty has on her right and on her left occupied seats we skip her
	goodSeatCount([e,o|Tail],TmpGoodSeatCounter,GoodSeatCounter).

goodSeatCount([_,o,X|Tail],TmpGoodSeatCounter,GoodSeatCounter):-	%if a seat is occupied we skip her
	goodSeatCount([o,X|Tail],TmpGoodSeatCounter,GoodSeatCounter).


getFirst([X,Y|_],[X,Y],0):-!.	%get the first positon compination of [X,Y] seats 
getFirst([_|Tail],[X,Y],Position):-
	getFirst(Tail,[X,Y],Position1),
	!,
	Position is Position1 + 1.


occupySeat(Head,[e|Tail],NewSeatList):-	%turn an empty seat to occupied
	append(Head,[o|Tail],NewSeatList).

occupySeat(Head,[o|Tail],NewSeatList):-	%try to find the first empty seat while keeping to Head the seats that are being skipped
	append(Head,[o],NewHead),
	occupySeat(NewHead,Tail,NewSeatList).


getSeat(L,M):-	%if there are only two empty good seats
	goodSeatCount(L,0,2),
	getFirst(L,[e,e],P),	%get the best ones position
	length(L,Length),
	M is Length - 1 - P.	%find the correct postion because the one computed is for the reverse list and with 1 as base number not 0

getSeat(L,M):-	%of there are more than two good empty seats occupy one and try again
	goodSeatCount(L,0,Count),
	Count > 2,
	occupySeat([],L,NewL),
	getSeat(NewL,M).


myseat(L,M):-	%if the last seat is empty
	append(_,[e],L),
	length(L,M1),
	M is M1 - 1.

myseat([e|_],0).	%if the first seat is empty

myseat(L,M):- %if there are no good seats empty pick the last right empty
	goodSeatCount(L,0,0),
	reverse(L,R),
	getFirst(R,[e,_],P),
	length(L,Length),
	M is Length - 1 - P.

myseat(L,M):-	%in any other case try occupying etc
	reverse(L,R),
	getSeat(R,M).