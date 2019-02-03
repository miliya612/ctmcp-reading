% P.138
% リストXsの要素の合計を求める関数SumListについて考える。
% 問題を状態変換の列に作り直す。すなわち、状態S0からはじめて順次S1, S2, ...に変形し、答えを含む最終状態Sfinalに至るようにする。すでに見たリストの部分の合計をA, まだ計算していない残りのリストをYsとすると、中間状態Siは対(A,Ys)となる。また、初期状態S0は(0, Xs)となる。
% 再帰呼び出しのたびAはYs.0だけ増え、Ysは1つ減る。これから、次の関数が得られる。

% fun {SumList A Xs}
%    case Xs
%    of nil then A
%    [] X|Xr then {SumList A+X Xr}
%    end
% end

% この関数{SumList A Xs}において、Aの初期値は0である。これを隠蔽化して、次のように定義できる。

local
   fun {IterSumList A Xs}
      case Xs
      of nil then A
      [] X|Xr then {IterSumList A+X Xr}
      end
   end
in
   fun {SumList Xs}
      {IterSumList 0 Xs}
   end
end

{Browse {SumList [3 1 6]}}

% 実行できないつらい