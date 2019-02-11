% 3.8 ニュートン法による球根(第5版)
% 引数Guessは冗長だが、手続き値の生成回数をSqrt呼び出し時のみに抑えられることから、ImproveとGoodEnoughはSqrtIterの外に出す。

fun {Sqrt X}
   fun {Improve Guess}
      (Guess + Guess/X) / 2.0
   end
   fun {GoodEnough Guess}
      {Abs X-Guess*Guess}/X < 0.00001
   end
   fun {SqrtIter Guess}
      if {GoodEnough Guess} then Guess
      else
	 {SqrtIter {Improve Guess}}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess}
end
