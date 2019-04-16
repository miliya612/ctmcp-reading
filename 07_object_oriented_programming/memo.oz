% 7.1. クラス例Counter(class構文による)

class Counter
   attr val
   meth init(Value)
      val:=Value
   end
   meth browse
      {Browse @val}
   end
   meth inv(Value)
      val:=@val+Value
   end
end

C={New Counter init(0)}
{C inc(6)} {C inc(6)}
{C browse}

% データフロー実行

% 動かない例
local X in {C inc(X)} X=5 end
{C browse}

% 動く例
declare S in
local X in
   thread
      {C inc(X)}
      S=unit
   end
   X=5
end
{Wait S}
{C brose}

% 7.2. class構文を使わないCounter定義

local
   proc {Init M S}
      init(Value)=M in (S.val):=Value
   end
   proc {Browse2 M S}
      {Browse @(S.val)}
   end
   proc {Inc M S}
      inc(Value)=M in (S.val):=@(S.val)+Value
   end
in
   Counter=c(attrs:[val] methods:m(init:Init browse:Browse2 inc: Inc))
end

% 7.3. Counterオブジェクトを生成すること

fun {New Class Init}
   Fs={Map Class.attrs fun {$ X} X#{NewCell _} end}
   S={List.toRecord state Fs}
   proc {Obj M}
      {Class.methods.{Label M} M S}
   end
in
   {Obj Init}
   Obj
end

% 属性を初期化すること

class OneApt
   attr streetName
   meth init(X) @streetName=X end
end
Apt1={New OneApt init(drottninggatan)}
Apt2={New OneApt init(rueNeuve)}

class YorkApt
   attr
      streetName:york
      streetNumber:100
      wallColor:_
      floorSurface:wood
   meth init skip end
end
Apt3={New YorkApt init}
Apt4={New YorkApt init}

L=linux
class RedHat attr ostype:L end
class SuSE attr ostype:L end
class Debian attr ostype:L end

% 7.6.

class Account
   attr balance:0
   meth transfer(Amt)
      balance:=@balance+Amt
   end
   meth getBal(Bal)
      Bal=@Balance
   end
   meth batchTransfer(AmtList)
      for A in AmtList do {self transfer(A)} end
   end
end

% extended Account: with logging

class LoggedAccount from Account
   meth transfer(Amt)
      {LogObj addentry(transfer(Amt))}
      ...
   end
end

% 7.9. 転嫁の実装

local
   class ForwardMixin
      attr Forward:none
      meth setForward(F) Forward:=F end
      meth otherwise(M)
	 if @Forward==none then raise undefinedMethod end
	 else {@Forward M} end
      end
   end
in
   fun {NewF Class Init}
      {New class $ from Class ForwardMixin end Init}
   end
end

class C1
   meth init skip end
   meth cube(A B) B=A*A*A end
end

class C2
   meth init skip end
   meth square(A B) B=A*A end
end

Obj1={NewF C1 init}
Obj2={NewF C2 init}
{Obj2 setForward(Obj1)}

{Obj2 cube(10 X)}

% 7.10. 委任の実装

local
   SetSelf={NewName}
   class DelegateMixin
      attr this Delegate:none
      meth !SetSelf(S) this:=S end
      meth set(A X) A:=X end
      meth get(A ?X) X=@A end
      meth setDelegate(D) Delegate:=D end
      meth Del(M S) SS in
	 SS=@this this:=S
	 try {self M} finally this:=SS end
      end
      meth call(M) SS in
	 SS=@this this:=self
	 try {self M} finally this:=SS end
      end
      meth otherwise(M)
	 if @Delegate==none then
	    raise undefinedMethod end
	 else
	    {@Delegate Del(M @this)}
	 end
      end
   end
in
   fun (NewD Class init)
      Obj={New class $ from Class DelegateMixin end init}
   in
      {Obj SetSelf(Obj)}
      Obj
   end
end

% 継承を使った例

class C1NonDel
   attr i:0
   meth init skip end
   meth inc(I) i:=@i+I end
   meth browse {self inc(10)} {Browse c1#@i} end
   meth c {self browse} end
end

class C2NonDel from C1NonDel
   attr i:0
   meth init skip end
   meth browse {self inc(100)} {Browse c2#@i} end
end

% 委譲を使った例

class C1
   attr i:0
   meth init skip end
   meth Inc(I)
      {@this set(i {@this get(i $)}+I)}
   end
   meth browse
      {@this inc(10)}
      {Browse c1#{@this get(i $)}}
   end
   meth c {@this browse} end
end
Obj1={NewD C1 init}

class C2
   attr i:0
   meth init skip end
   meth browse
      {@this inc(100)}
      {Browse c2#{@this get(i $)}}
   end
end
Obj2={NewD C2 init}
{Obj2 setDelegate(Obj1)}

% method wrapping: tracerの実装

fun {TraceNew Class Init}
   Obj={New Class Init}
   proc {TraceObj M}
      {Browse entering({Label M})}
      {Obj M}
      {Browse exiting({Label M})}
   end
in TracedObj end

% classでwrappingする

fun {TraceNew2 Class Init}
   Obj={New Class Init}
   TInit={NewName}
   class Tracer
      meth !TInit skip end
      meth otherwise(M)
	 {Browse entering({Label M})}
	 {Obj M}
	 {Browse exiting({Label M})}
      end
   end
in {New Tracer TInit} end

% Counter class with reflect

class Counter from ObjectSupport.reflect
   attr val
   meth init(Value)
      val:=Value
   end
   meth browse
      {Browse @val}
   end
   meth inc(Value)
      val:=@val+Valuie
   end
end

C1={New Counter init(0)}
C2={New Counter init(0)}
% 状態の転送
{C1 inc(10)}
local X in {C1 toChunk(X)} {C2 fromChunk(X)} end　% C2も値10を持つ

 % 7.14 OOStyle List

class ListClass
   meth isNil(_) raise undefinedMethod end end
   meth append(_ _) raise undefinedMethod end end
   meth display raise undefinedMethod end end
end

class NilClass from ListClass
   meth init skip end
   meth isNil(B) B=true end
   meth append(T U) U=T end
   meth display {Browse nil} end
end

class ConsClass from ListClass
   attr head tail
   meth init(H T) head:=H tail:=T end
   meth isNil(B) B=false end
   meth append(T U)
      U2={@tail append(T $)}
   in
      U={New ConsClass init(@head U2)}
   end
   meth display {Browse @head} {@tail display} end
end

L1={New ConsClass
    init(1 {New ConsClass
	    init(2 {New NilClass init})})}
L2={New ConsClass init(3 {New NilClass init})}
L3={L1 append(L2 $)}
{L3 display} % => 1, 2, 3, nil

% 7.15. 凡用sort class(継承使用)

class GenericSort
   meth init skip end
   meth qsort(Xs Ys)
      case Xs
      of nil then Ys = nil
      [] P|Xr then S L in
	 {self partition(Xr P S L)}
	 {Append {self qsort(S $)}
	  P|{self qsort(S $)} Ys}
      end
   end
   meth partition(Xs P Ss Ls)
      case Xs
      of nil then Ss=nil Ls=nil
      [] X|Xr then Sr Lr in
	 if {self less(X P $)} then
	    Ss=X|Sr Ls=Lr
	 else
	    Ss=Sr Ls=X|Lr
	 end
	 {self partition(Xr P Sr Lr)}
      end
   end
end

% 7.16 具体クラスにすること(継承使用)

class IntegerSort from GenericSort
   meth less(X Y B)
      B=(X<Y)
   end
end

class RationalSort from GenericSort
   meth less(X Y B)
      '/'(P Q)=X
      '/'(R S)=Y
   in B=(P*S<Q*R) end
end

% 7.18 凡用ソートクラス(高階プログラミング実行)

fun {MakeSort Less}
   class $
      meth init skip end
      meth qsort(Xs Ys)
	 case Xs
	 of nil then Ys = nil
	 [] P|Xr then S L in
	    {self partition(Xr P S L)}
	    {Append {self qsort(S $)}
	     P|{self qsort(S $)} Ys}
	 end
      end
      meth partition(Xs P Ss Ls)
	 case Xs
	 of nil then Ss=nil Ls=nil
	 [] X|Xr then Sr Lr in
	    if {self less(X P $)} then
	       Ss=X|Sr Ls=Lr
	    else
	       Ss=Sr Ls=X|Lr
	    end
	    {self partition(Xr P Sr Lr)}
	 end
      end
   end
end

% 7.19 具体クラスにする(高階プログラミング実行)

IntegerSort = {MakeSort fun {$ X Y} X<Y end}
RationalSort = {MakeSort fun {$ X Y}
			    '/'(P Q) = X
			    '/'(R S) = Y
			 in P*S<Q*R end}

ISort={New IntegerSort init}
RSort={New RationalSort init}
{Browse {ISort qsort([1 2 5 3 4] $)}}
{Browse {RSort qsort(['/'(23 3) '/'(34 11) '/'(47 17)] $)}}