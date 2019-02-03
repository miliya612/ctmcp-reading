declare
fun {Bisec F A B}
   fun {BisecIter A B}
      X = (A+B) / 2.0
      R = {F X}
   in
      if {GoodEnough R} then X
      else A1 B1 in
	 A1#B1 = {Improve A B X R}
	 {BisecIter A1 B1}
      end
   end
   fun {GoodEnough R}
      {Abs R} < 0.00001
   end
   fun {Improve A B X R}
      if R > 0.0 then A#X
      else
	 X#B
      end
   end
in
   {BisecIter A B}
end

{Browse {Bisec fun{$ X} X*X-4.0 end ~6.0 6.0}}