roomkey(0,1).
roomkey(1,2).
roomkey(1,3).
roomkey(1,5).
roomkey(1,7).
roomkey(1,14).
roomkey(1,21).
roomkey(18,19).
roomkey(20,19).
roomkey(11,13).
roomkey(12,13).
roomkey(17,20).
roomkey(3,10).
roomkey(3,15).
% roomkey(4,6).
% roomkey(5,6).
roomkey(2,4).
roomkey(8,11).
roomkey(10,12).
roomkey(16,17).
roomkey(16,18).
roomkey(15,16).

roomcontainsroom(0,1).
roomcontainsroom(0,3).
roomcontainsroom(0,7).
roomcontainsroom(0,11).
roomcontainsroom(0,12).
roomcontainsroom(0,14).
roomcontainsroom(0,16).
roomcontainsroom(0,18).
roomcontainsroom(0,20).
roomcontainsroom(0,21).
roomcontainsroom(1,6).
roomcontainsroom(3,2).
roomcontainsroom(3,4).
roomcontainsroom(3,8).
roomcontainsroom(3,9).
roomcontainsroom(9,10).
roomcontainsroom(16,19).
roomcontainsroom(14,15).
roomcontainsroom(19,13).

roomcontainschest(13).

list_member(X,[X|_]).
list_append(A,T,T) :- list_member(A,T).
list_delete(X,[X|L1], L1).


% Recursive roomcontainsroom
% X -> outer room
% Y -> inner room
rrcr(X,Y):- roomcontainsroom(X,Y) ; (roomcontainsroom(X,Z) , rrcr(Z,Y)).

% Recursive can get key from
% X -> key
% Y -> current room
rcgkf(X,Y):- roomkey(Y,X) ; (roomkey(Y,K) , forall(member(M,roomcontainsroom(Y,K)),rcgkf(X,M))).

c(X,Y):- rrcr(Y,X).

cer(X,Y):-  TBE = [], 
            roomcontainsroom(X, Rooms),
            write(Rooms).
            % append(Rooms, TBE, TBE).

% cangetkeyfrom(R,F):- getkey(R, F) ; (getkey(X, F), roomcontainsroom(F, X), getkey(Y, X), roomcontainsroom(F, Y), cangetkeyfrom(R, Y)).

% getkey(K,F):- roomkey(F, K) ; (roomkey(F, X), roomcontainsroom(F, X), getkey(K, X)).

enterroomfrom(R,F):- cangetkeyfrom(R,F), (roomcontainsroom(F,R) ; roomcontainsroom(X,R), enterroomfrom(X,F)).

cangetkeyfrom(K,F):- roomkey(F, K) ; (roomkey(X, K), cangetkeyfrom(X, F), roomcontainsroom(F, X) ; (roomcontainsroom(Y, X), cangetkeyfrom(Y, F))).