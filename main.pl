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
roomkey(4,6).
roomkey(5,6).
roomkey(6,8).
roomkey(6,9).
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
roomcontainsroom(3,5).
roomcontainsroom(3,8).
roomcontainsroom(3,9).
roomcontainsroom(9,10).
roomcontainsroom(16,19).
roomcontainsroom(14,15).
roomcontainsroom(19,13).
roomcontainsroom(21,17).

roomcontainschest(13).

union([X|Y],Z,W) :- member(X,Z),  union(Y,Z,W).
union([X|Y],Z,[X|W]) :- \+ member(X,Z), union(Y,Z,W).
union([],Z,Z).
member(X,[X|_]).
member(X,[_|TAIL]) :- member(X,TAIL).
list_append(A,T,T) :- member(A,T),!.
list_append(A,T,X) :- append([A],T,X).

cangetkeyfrom(K,F,L,B):- (roomkey(F, K), list_append(K, L, B) ; (K > 0, list_append(K, L, A), roomkey(X, K), cangetkeyfrom(X,F,A,C), (roomcontainsroom(F,X), append([],C,B) ; (roomcontainsroom(Y,X), cangetkeyfrom(Y,F,C,B))))).

canreachroomfrom(R,F,L):- cangetkeyfrom(R,F,[],A), (roomcontainsroom(F,R), append([],A,L) ; (roomcontainsroom(Y,R), cangetkeyfrom(Y,F,[],L))).

cangetchestfrom(F,L):- roomcontainschest(X), cangetkeyfrom(X,F,[],A), canreachroomfrom(X,F,B), union(A,B,L).