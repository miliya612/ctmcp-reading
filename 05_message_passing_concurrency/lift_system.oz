% Compose Port Object

declare
fun {NewPortObject Init Fun}
   Sin Sout in
   thread {FoldL Sin Fun Init Sout} end
   {NewPort Sin}
end

declare
fun {NewPortObject2 Proc}
   Sin in
   thread for Msg in Sin do {Proc Msg} end end
   {NewPort Sin}
end

% Timer

declare
fun {Timer}
   {NewPortObject2
    proc {$ Msg}
       case Msg of starttimer(T Pid) then
	  thread {Delay T} {Send Pid stoptimer} end
       end
    end}
end

% ControllersComponent
declare
fun {Controller Init}
   Tid={Timer}
   Cid={NewPortObject Init
	fun {$ state(Motor F Lid) Msg}
	   case Motor
	   of running then
	      case Msg
	      of stoptimer then
		 {Send Lid 'at'(F) }
		 state(stopped F Lid)
	      end
	   [] stopped then
	      case Msg
	      of step(Dest) then
		 if F==Dest then
		    state(stopped F Lid)
		 elseif F<Dest then
		    {Send Tid starttimer(5000 Cid)}
		    state(running F+1 Lid)
		 else % F>Dest
		    {Send Tid starttimer(5000 Cid)}
		    state(running F-1 Lid)
		 end
	      end
	   end
	end
       }
in Cid end

% FloorsComponents
declare
fun {Floor Num Init Lifts}
   Tid={Timer}
   Fid={NewPortObject Init
	fun {$ state(Called) Msg}
	   case Called
	   of notcalled then Lran in
	      case Msg
	      of arrive(Ack) then
		 {Browse 'Lift at floor '#Num#': opens doors'}
		 {Send Tid starttimer(5000 Fid)}
		 state(doorsopen(Ack))
	      [] call then
		 {Browse 'Floor '#Num#' calls a lift!'}
		 Lran=Lifts.(1+{OS.rand} mod {Width Lifts})
		 {Send Lran call(Num)}
		 state(called)
	      end
	   [] called then
	      case Msg
	      of arrive(Ack) then
		 {Browse 'Lift at floor '#Num#': open doors'}
		 {Send Tid starttimer(5000 Fid)}
		 state(dooropen(Ack))
	      [] call then
		 state(called)
	      end
	   [] doorsopen(Ack) then
	      case Msg
	      of stoptimer then
		 {Browse 'Lift at floor '#Num#': close doors'}
		 Ack=unit
		 state(notcalled)
	      [] arrive(A) then
		 A=Ack
		 state(doorsopen(Ack))
	      [] call then
		 state(doorsopen(Ack))
	      end
	   end
	end
       }
in Fid end


% LiftsComponent
declare
fun {ScheduleLast L N}
   if L\=nil andthen {List.last L}==N then L
   else {Append L {N}} end
end
declare
fun {Lift Num Init Cid Floors}
   {NewPortObject Init
    fun {$ state(Pos Sched Moving) Msg}
       case Msg
       of call(N) then
	  {Browse 'Lift '#Num#' needed at floor '#N}
	  if N==Pos andthen {Not Moving} then
	     {Wait {Send Floors.Pos arrive($)}}
	     state(Pos Sched false)
	  else Sched2 in
	     Sched2={ScheduleLast Sched N}
	     if {Not Moving} then
		{Send Cid step(N)} end
	     state(Pos Sched2 true)
	  end
       [] 'at'(NewPos) then
	  {Browse 'Lift '#Num#'at floor '#NewPos}
	  case Sched
	  of S|Sched2 then
	     if NewPos==S then
		{Wait {Send Floors.S arrive($)}}
		if NewPos==nil then
		   state(NewPos nil false)
		else
		   {Send Cid step(Sched2.1)}
		   state(NewPos Sched2 true)
		end
	     else
		{Send Cid step(S)}
		state(NewPos Sched Moving)
	     end
	  end
       end
    end}
end

% building
declare
proc {Building FN LN ?Floors ?Lifts}
   Lifts={MakeTuple lifts LN}
   for I in 1..LN do Cid in
      Cid={Controller state(stopped 1 Lifts.I)}
      Lifts.I={Lift I state(1 nil false) Cid Floors}
   end
   Floors={MakeTuple floors FN}
   for I in 1..FN do
      Floors.I={Floor I state(notcalled) Lifts}
   end
end

declare F L in
{Building 10 2 F L}
{Send F.9 call}
{Send F.10 call}
{Send L.1 call(4)}
{Send L.2 call(5)}