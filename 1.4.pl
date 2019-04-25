fillOddRow(Row,Row,_,ColumnCounter,N):-	%when making an odd table a row is finished when column counter is N + 1 and N the table dimension
	N is ColumnCounter - 1.

fillOddRow(TmpRow,Row,RowCounter,ColumnCounter,N):-
	X is ((RowCounter - 1) * N) + ColumnCounter,	%the element of an odd row is the row offset + the column in which the element is 
	append(TmpRow,[X],NewTmpRow),	%add the current element on the TmpRow
	ColumnCounter1 is ColumnCounter + 1,	%move the column indicator by one
	fillOddRow(NewTmpRow,Row,RowCounter,ColumnCounter1,N).


fillOddTable(Table,Table,ColumnCounter,N):-	%when making an odd table the table is finished when row counter is N + 1 and N the table dimension
	N is ColumnCounter - 1.

fillOddTable(TmpTable,Table,RowCounter,N):-
	fillOddRow([],Row,RowCounter,1,N),	%create an odd row
	append(TmpTable,[Row],NewTmpTable),	%add it to the table
	RowCounter1 is RowCounter + 1,	%move the row indicator by one
	fillOddTable(NewTmpTable,Table,RowCounter1,N).


myRowLength(Left,Right):-	%take two lists and make sure the Left has one more element tha the right
	length(Left,LeftLength),
	length(Right,RightLength),
	LeftLength is RightLength + 1.

getRowUpBoundMid(L,X):-	%get the element that is right after the middle of the row L
	append(Left,Right,L),	%split row L in two lists
	myRowLength(Left,Right),	%take the two lists and make sure the Left has one more element tha the right
	append([X],_,Right).	%take the first element of the right part so the one right after the middle of the list L


sumRowList([],Sum,Sum).

sumRowList([X|Tail],TmpSum,Sum):-	%take the sum of the elements of a list
	TmpSum1 is TmpSum + X,
	sumRowList(Tail,TmpSum1,Sum).

sumRowList(L,Sum):-
	sumRowList(L,0,Sum).


fillEvenRow(TmpRow,Row,_,N,N):-	%when we create an even table the last element of a row is equal to LastElement
	getRowUpBoundMid(TmpRow,X),	%so we take the element X the one right after the middle
	sumRowList(TmpRow,Sum),	%we take the sum of the list without the last element yet
	LastElement is (N * X) - Sum,	%and the last element is the (dimension * X) - the sum of the other elements
	append(TmpRow,[LastElement],Row).	%and we put the last element on the row

fillEvenRow(TmpRow,Row,RowCounter,ColumnCounter,N):-
	X is ((RowCounter - 1) * N * 2) + ColumnCounter,	%the element of an even row is the row offset * 2 * N + the column in which the element is if 
	append(TmpRow,[X],NewTmpRow),						%it is not the last one
	ColumnCounter1 is ColumnCounter + 1,
	fillEvenRow(NewTmpRow,Row,RowCounter,ColumnCounter1,N).


myColumnLength(Up,Down):-
	length(Up,UpLength),
	length(Down,DownLength),
	UpLength is DownLength + 1.


getColumnUpBoundMid(L,X):-	%get the first element of the row right after the middle of tha table
	append(Up,Down,L),
	myColumnLength(Up,Down),
	append([H],_,Down),
	append([X],_,H).


sumColumnList([],Sum,Sum).

sumColumnList([[X|_]|Tail],TmpSum,Sum):-	%get the sum of the first column of all rows
	TmpSum1 is TmpSum + X,
	sumColumnList(Tail,TmpSum1,Sum).

sumColumnList(L,Sum):-
	sumColumnList(L,0,Sum).


fillLastEvenRow(TmpRow,Row,_,ColumnCounter,N):-	%when we are on the last row last element we follow the above logic for even rows filling
	ColumnCounter is N - 1,
	getRowUpBoundMid(TmpRow,X),
	sumRowList(TmpRow,Sum),
	LastElement is (N * X) - Sum,
	append(TmpRow,[LastElement],Row).

fillLastEvenRow(TmpRow,Row,LastRowFirstElement,ColumnCounter,N):-	%when we are on the last row we follow the above logic for even rows filling
	X is LastRowFirstElement + ColumnCounter,						%but we start the TmpRow not empty but with the LastRowFirstElement
	append(TmpRow,[X],NewTmpRow),
	ColumnCounter1 is ColumnCounter + 1,
	fillLastEvenRow(NewTmpRow,Row,LastRowFirstElement,ColumnCounter1,N).


fillEvenTable(TmpTable,Table,N,N):-	%when we create the last row
	getColumnUpBoundMid(TmpTable,X),
	sumColumnList(TmpTable,Sum),
	LastRowFirstElement is (N * X) - Sum,	%the first element will be dimension * the element right after the middle of the first column - first's column sum
	fillLastEvenRow([LastRowFirstElement],LastRow,LastRowFirstElement,1,N),
	append(TmpTable,[LastRow],Table).


fillEvenTable(TmpTable,Table,RowCounter,N):-
	fillEvenRow([],Row,RowCounter,1,N),
	append(TmpTable,[Row],NewTmpTable),
	RowCounter1 is RowCounter + 1,
	fillEvenTable(NewTmpTable,Table,RowCounter1,N).


mymatrix(N,M):-	%if the dimension is even ask the even table question
	0 is mod(N,2),
	fillEvenTable([],M,1,N).

mymatrix(N,M):-	%if the dimension is odd ask the odd table question
	1 is mod(N,2),
	fillOddTable([],M,1,N).

