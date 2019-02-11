% 3.6 ニュートン法による球根(第3版)

fun {Sqrt X}
   fun {SqrtIter Guess X}
      fun {Improve Guess X}
	 (Guess + X/Guess) / 2.0
      end
      fun {GoodEnough Guess X}
	 {Abs X-Guess*Guess}/X < 0.00001
      end
   in
      if {GoodEnough Guess X} then Guess
      else
	 {SqrtIter {Improve Guess X} X}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess X}
end
