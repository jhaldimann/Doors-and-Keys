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

bubble_sort(List,Sorted):-b_sort(List,[],Sorted).
b_sort([],Acc,Acc).
b_sort([H|T],Acc,Sorted):-bubble(H,T,NT,Max),b_sort(NT,[Max|Acc],Sorted).
   
bubble(X,[],[],X).
bubble(X,[Y|T],[Y|NT],Max):-nth0(0,X,A), nth0(0,Y,B), A>B,bubble(X,T,NT,Max).
bubble(X,[Y|T],[X|NT],Max):-nth0(0,X,A), nth0(0,Y,B), A=<B,bubble(Y,T,NT,Max).

% Can key K be reached from room F and if yes get list of keys necessary B
cangetkeyfrom(K,F,L,B):- (roomkey(F, K), list_append(K, L, B) ; (K > 0, list_append(K, L, A), roomkey(X, K), cangetkeyfrom(X,F,A,C), (roomcontainsroom(F,X), append([],C,B) ; (roomcontainsroom(Y,X), cangetkeyfrom(Y,F,C,B))))).

% Can reach room R from room F and if yes get list of keys necessary L
canreachroomfrom(R,F,L):- cangetkeyfrom(R,F,[],A), (roomcontainsroom(F,R), append([],A,L) ; (roomcontainsroom(Y,R), cangetkeyfrom(Y,F,[],L))).

% Can get chest from room F and if yes get list of keys necessary L
cangetchestfrom(F,L):- roomcontainschest(X), cangetkeyfrom(X,F,[],A), canreachroomfrom(X,F,B), union(A,B,C), sortbykey(F,C,D), append(D,["S"],L).

% Get tuple from key K and number keys necessary to reach N it as O=[N,K]
lengthkey(K,O):- cangetkeyfrom(K,0,[],B), length(B,N), O=[N,K]. 

% Get only key K from tuple of key and number of keys necessary to reach it 
getkeyonly(LK,K):- nth0(1,LK,K).

% Sort tuple list L of keys K and keys necessary to reach it N by N
sortbykey(F,L,O):- maplist(lengthkey, L, A), bubble_sort(A,S), maplist(getkeyonly, S, O).