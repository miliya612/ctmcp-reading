% 小数を定義域に含めていないため。下記のようにする。

declare
fun {Abs X} if X<0.0 then ~X else X end end

{Browse {Abs ~0.24555}}