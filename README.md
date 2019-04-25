# Principles-of-Programming-Languages-Homework-1
A set of five homeworks in Prolog for the class Principles of Programming Languages.

HW 1.1 is a predicate pokemon(L,N,S) where L, the input, is a list of pokemons, N is the amount of pokemons that can be evolved
and S is the name of the pokemon that can be evolved the most times. Each pokemon in L is in the type of (caterpie,12,33) where
caterpie is the name of the pokemon, 12 is the amount of candies needed to be evovled and 33 the amount of candied that the user currently
has for this specific pokemon.

HW 1.2 is a predicate mylunch(R,S,T) where R is the number of the row a customer is sitting in an airplane,
S is the alphabetic letter of his position and T is the output in seconds, in how much time he will be served having as
standards that every row has the letters a b c d e f, that two flight attendants are serving each one starting from the
first and third row and keeping a fixed distance of two between them etc.

HW 1.3 is a predicate palindromic(L,N) where L is a list of integers and N the least amount of additions between neighboor integers
of the list that can be done in order to have a palindromic list. For example, palindromic([1,4,3,2],N) should return N=2 because
[1,4,3,2]->[5,3,2]->[5,5].

HW 1.4 is a predicate mymatrix(N,M) which takes as input an integer N>2 and returns a matrix M fullfilling the following specifications.
1) The arithmetic average of each row is a number that exists in this row
2) The arithmetic average of each column is a number that exists in this column
3) Every integer can exist only once in the matrix
For example mymatrix(3,M) should return M=[[1,2,3],[4,5,6],[7,8,9]]

HW 1.5 is a predicate myseat(L,M) where L is a list that indicates the set-up of the seats in a train that has only one row of seats
and returns in M the optimal seat the customer should choose. The optimal is defined as: A good seat is defined as one that has either
in front of it or in the back an empty seat. The best seats are the first and the last since they will always be good seats. If both of
those are empty the customer would choose to go to the last (the far most right). If neither of those are empty the customer chooses to seat
to the one that will remain for the most time "good". Every new passenger entrying the train has the same logic so we as the first
passenger have to choose optimally when we enter the train having this strategy in mind. For example in myseat([e,e,o,e,e], M) M=4 since
both the first and the last are empty, we choose the last. In myseat([o,e,e,e,e,o], M) M=2. etc.
