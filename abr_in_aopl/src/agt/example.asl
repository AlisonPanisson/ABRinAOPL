// Agent sample_agent in project abr_in_aopl

{ include("reasoning/ABRinAOPL.asl") }

longer(X,Y):- X > Y.

/* Initial beliefs and rules */

/* Plans */

/* These plans show how the argumentation-based reasoning can be used in Agents' plans */

+!check_arg(Content): argument(Content,Arg) 
	<- .print("I have an argument ", Arg, " supporting ", Content).
	 
+!check_arg(Content): not(argument(Content,Arg)) 
	<- .print("I do not have an argument ", Arg, " supporting ", Content).
