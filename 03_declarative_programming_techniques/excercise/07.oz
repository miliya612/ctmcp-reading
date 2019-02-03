% 第1の引数について再帰するAppend関数

declare
fun {AppendFirst Ls Ms}
   case Ls
   of nil then Ms
   [] X|Lr then X|{Append Lr Ms}
   end
end


% 第2の引数について再帰するAppend関数
declare
fun {AppendSecond Ls Ms}
   case Ms
   of nil then Ls
   [] X|Mr then {Append {Append Ls [X] } Mr}
   end
end

{Browse {AppendSecond [1 2 3] [5 8 6]}}

% 上記の第2引数[5 8 6]の状態遷移を追う。
% 初回呼び出しのとき、マッチした条件をもとにX=5 Mr=[8 6]と束縛される。
% 内側のAppendが{Append [1 2 3] [5]}と呼ばれる。
% 内側のAppendが処理され、マッチした条件をもとにX=5 Mr = nilと束縛される。
% 内側のAppendが{Append [1 2 3] [5]}と呼ばれる。
% ...
% これより、内側のAppendの第2引数はnilとならないため、終了しない。

% ...はずだけど終了した。