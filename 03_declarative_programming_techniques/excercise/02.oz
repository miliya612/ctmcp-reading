declare
fun {Cbrt X}
   fun {Improve Guess}
      (X / (Guess*Guess) + 2.0*Guess)/3.0
   end
   fun {GoodEnough Guess}
      % 要検討
      {Abs X-Guess*Guess*Guess} / X < 0.00001
   end
   fun {CbrtIter Guess}
      if {GoodEnough Guess} then Guess
      else
	 {CbrtIter {Improve Guess}}
      end
   end
   Guess = 1.0
in
   {CbrtIter Guess}
end

{Browse {Cbrt 2.0}}
