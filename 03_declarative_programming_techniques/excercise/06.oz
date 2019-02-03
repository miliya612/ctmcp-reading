local
   fun {IterReverse Rs Ys}
      case Ys
      of nil then Rs
      [] Y|Yr then {IterReverse Y|Rs Yr}
      end
   end
in
   fun {Reverse Xs}
      {IterReverse nil Xs}
   end
end

% 正しいことを表明する？

% 未操作のリスト: Rs
% 操作済みのリスト: Ys
% IterReverseに関して、状態不変表明P(Si)が常に真であることを証明する。
% 中間状態Siは(Rs, Ys)となることから、Pを次のように定義する。
% P((Rs, Ys))≡Xs= ...

% 帰納法を用いて証明する。

% ■最初にP(S0)を証明する。これは、S0=(0, 