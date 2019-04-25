palindromic1(L,L,N,N).		%if list L is the same with its reversed the its palindromic then the sum's made are N

palindromic1([X|LTail],[X|_],TmpN,N):-	%if the first number of L is the same with the first of R(with R being L reversed)
	append(NewLTail,[X],LTail),	%then drop the last element (X) of the tail of list L that has a head equal to X too
	reverse(NewLTail,NewRTail),	%get the reverse of the new List without the X's
	palindromic1(NewLTail,NewRTail,TmpN,N).

palindromic1([X,Y|LTail],[Z|_],TmpN,N):-
	X < Z,	%if the first number of the list is less than the first of the reversed list (so than the last one)
	NewX is X + Y,	%add the first with the second to NewX
	append([NewX],LTail,NewLTail),	%make NewX the new first number of the list
	reverse(NewLTail,NewR),	%take the reverse of the new list
	NewTmpN is TmpN + 1,	%increase the amount of sum's made counter
	palindromic1(NewLTail,NewR,NewTmpN,N).

palindromic1([X|_],[Z,Y|RTail],TmpN,N):-
	X > Z,	%if the first number of the list is greater than the first of the reversed list (so than the last one)
	NewZ is Z + Y,	%add the last with the semifinal to NewZ
	append([NewZ],RTail,NewRTail),	%make NewZ the new first number of the reversed list
	reverse(NewRTail,NewL),	%reverse the new reversed to take the new original oriented
	NewTmpN is TmpN + 1,	%increase the amount of sum's made counter
	palindromic1(NewL,NewRTail,NewTmpN,N).

palindromic(L,N):-
	reverse(L,R),
	palindromic1(L,R,0,N).	%start with the original L list, its reversed R, a sum's counter equal to 0