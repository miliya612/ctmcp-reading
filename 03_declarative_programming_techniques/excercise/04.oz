% P.138
% まだ計算していない残りの数の最大値: M
% 問題を状態変換の列に作り直す。すなわち、状態S0からはじめて順次S1, S2, ...に変形し、答えを含む最終状態Sfinalに至るようにする。
% 既に計算した計算結果をA, まだ計算していない残りの数の最大値、すなわち残りの計算回数をMとすると、中間状態Siは対(A,M)となる。また、初期状態S0は(1, N)となる。
% 再帰呼び出しのたびAはM倍され、Mは1つ減る。これから、次の関数が得られる。

declare
fun {Fact N}
   fun {FactIter M A}
      if M==0 then A
      elseif M>0 then {FactIter M-1 A*M}
      else raise domainError end
      end
   end
in
   {FactIter N 1}
end
