declare X0 X1 X2 X3 in
thread
   Y0 Y1 Y2 Y3 in
   {Browse [Y0 Y1 Y2 Y3]}
   Y0=X0+1
   Y1=X1+Y0
   Y2=X2+Y1
   Y3=X3+Y2
   {Browse completed}
end
{Browse [X0 X1 X2 X3]}

X0=0
X1=1
X2=2
X3=3

declare
proc {ForAll L P}
   case L of nil then skip
   [] X|L2 then {P X} {ForAll L2 P} end
end

declare L in
thread {ForAll L Browse} end

declare L1 L2 in
thread L=1|L1 end
thread L1=2|3|L2 end
thread L2=4|nil end

{ForAll [1 2 3 4] Browse}

declare
fun {Fib X}
   if X =< 2 then 1
   else thread {Fib X-1} end + {Fib X-2} end
end

{Browse {Fib 50}}