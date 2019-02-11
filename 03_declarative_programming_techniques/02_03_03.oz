% 3.7 ニュートン法による球根(第4版)

fun {Sqrt X}
   fun {SqrtIter Guess}
      fun {Improve}
	 (Guess + X/Guess) / 2.0
      end
      fun {GoodEnough}
	 {Abs X-Guess*Guess}/X < 0.00001
      end
   in
      if{GoodEnough} then Guess
      else
	 {SqrtIter {Improve}}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess}
end
