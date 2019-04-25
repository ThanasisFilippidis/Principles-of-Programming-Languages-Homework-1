seatDelay(f,1).	%the standard time every seat needs to be served when air hostess on its row
seatDelay(e,2).
seatDelay(d,3).
seatDelay(c,6).
seatDelay(b,5).
seatDelay(a,4).


mylunch1(_,Row,Row,SeatTime,CurrentTime,TotalTime):-	%when air hostess arrives at row Row the time is the CurrentTime(passed) +  
	TotalTime is SeatTime + CurrentTime.				%the time the seat needs to be served

mylunch1(1,TmpRow,Row,SeatTime,CurrentTime,TotalTime):-	%if the air hostess hasnt passed the row Row and is in the first row of the two
	TmpRow =< Row,										%that she is going to serve before moving forward the serving table
	CurrentTime1 is 7 + CurrentTime,
	TmpRow1 is TmpRow + 1,
	mylunch1(2,TmpRow1,Row,SeatTime,CurrentTime1,TotalTime).	%try next serving the next

mylunch1(2,TmpRow,Row,SeatTime,CurrentTime,TotalTime):-	%if the air hostess hasnt passed the row Row and is in the second row of the two
	TmpRow =< Row,										%that she is going to serve before moving forward the serving table
	CurrentTime1 is 7 + 2 + CurrentTime,
	TmpRow1 is TmpRow + 1 + 2,
	mylunch1(1,TmpRow1,Row,SeatTime,CurrentTime1,TotalTime). %move the table and after continue serving


mylunch(R,S,T):-	%first (the back one) air hostess tries to serve the seat starting from row 1
	seatDelay(S,SeatTime),
	mylunch1(1,1,R,SeatTime,0,T).

mylunch(R,S,T):-	%if the first failed the second (the frond one) air hostess will serve the seat starting by row 3
	seatDelay(S,SeatTime),
	mylunch1(1,3,R,SeatTime,0,T).