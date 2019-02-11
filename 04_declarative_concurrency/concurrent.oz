declare X0 X1 X2 X3 in
thread
   Y0 Y1 Y2 Y3 in
   {Browse [Y0 Y1 Y2 Y3]}
   Y0=X0+1
   Y1=X1+Y0
   Y2=X2+Y1
   Y3=X3+Y2
   {Browse completed}
end
{Browse [X0 X1 X2 X3]}

X0=0
X1=1
X2=2
X3=3

declare
proc {ForAll L P}
   case L of nil then skip
   [] X|L2 then {P X} {ForAll L2 P} end
end

declare L in
thread {ForAll L Browse} end

declare L1 L2 in
thread L=1|L1 end
thread L1=2|3|L2 end
thread L2=4|nil end

{ForAll [1 2 3 4] Browse}

declare
fun {Fib X}
   if X =< 2 then 1
   else thread {Fib X-1} end + {Fib X-2} end
end

{Browse {Fib 26}}

% 4.3.1.

declare
fun {Generate N Limit}
   if N<Limit then
      N|{Generate N+1 Limit}
   else nil end
end
declare
fun {Sum Xs A}
   case Xs
   of X|Xr then
      {Sum Xr A+X}
   [] nil then A
   end
end

local Xs S in
   thread Xs={Generate 0 15000} end
   thread S={Sum Xs 0} end
   {Browse S}
end

% with higer iterator

local Xs S in
   thread Xs={Generate 0 15000} end
   thread S={FoldL Xs fun {$ X Y} X+Y end 0} end
   {Browse S}
end

% multi consumer

local Xs S1 S2 S3 in
   thread Xs={Generate 0 150000} end
   thread S1={Sum Xs 0} end
   thread S2={Sum Xs 0} end
   thread S3={Sum Xs 0} end
end

% Transducer & Pipeline

% Filter for streaming

local Xs Ys S in
   thread Xs={Generate 0 150000} end
   thread Ys={Filter Xs IsOdd} end
   thread S={Sum Ys 0} end
   {Browse S}
end

% Sieve of Eratosthenes

declare
fun {Sieve Xs}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
      thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
      X|{Sieve Ys}
   end
end

local Xs Ys in
   thread Xs={Generate 2 100000} end
   thread Ys={Sieve Xs} end
   {Browse Ys}
end

% 不要なスレッドを生成しないようにする
% nまでの素数を生成するには、√nまでの倍数をフィルタリングすればいい

declare
fun {SieveImpr Xs M}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
      if X=<M then
	 thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
      else Ys=Xr end
      X|{SieveImpr Ys M}
   end
end

local Xs Ys in
   thread Xs={Generate 2 100000} end
   thread Ys={SieveImpr Xs 316} end
   {Browse Ys}
end

% flow control with demand-driven concurrency

declare
proc {DGenerate N Xs}
   case Xs of X|Xr then
      X=N
      {DGenerate N+1 Xr}
   end
end

declare
fun {DSum ?Xs A Limit}
   {Delay 100}
   if Limit>0 then
      X|Xr=Xs
   in
      {DSum Xr A+X Limit-1}
   else A end
end

local Xs S in
   thread {DGenerate 0 Xs} end
   thread S={DSum Xs 0 150000} end
   {Browse S}
end

% bordered buffer

declare
proc {Buffer N ?Xs Ys}
   fun {Startup N ?Xs}
      if N==0 then Xs
      else Xr in Xs=_|Xr {Startup N-1 Xr} end
   end

   proc {AskLoop Ys ?Xs ?End}
      case Ys of Y|Yr then Xr End2 in
	 Xs=Y|Xr    % バッファから要素を取り出す
	 End=_|End2 % バッファに補充する
	 {AskLoop Yr Xr End2}
      end
   end
   End={Startup N Xs}
in
   {AskLoop Ys Xs End}
end

local Xs Ys S in
   thread {DGenerate 0 Xs} end % Producerスレッド
   thread {Buffer 4 Xs Ys} end % バッファスレッド
   thread S={DSum Ys 0 150000} end % Consumerスレッド
   {Browse Xs} {Browse Ys}
   {Browse S}
end

