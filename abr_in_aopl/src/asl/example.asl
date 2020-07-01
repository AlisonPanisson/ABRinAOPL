// Agent sample_agent in project abr_in_aopl

{ include("reasoning/ABRinAOPL.asl") }

/* Initial beliefs and rules */




/* Plans */

+!check_arg(Content): argument(Content,Arg) 
	<- .print("I have an argument ", Arg, " supporting ", Content).
	
+!check_arg(Content): not(argument(Content,Arg)) 
	<- .print("I do not have an argument ", Arg, " supporting ", Content).
