# Tutorial

This tutorial is based on Jason Eclipse Plugin. 

## Installing JaCaMo Eclipse Plugin
- [Install Eclipse IDE](https://www.eclipse.org/downloads/)
- Install JaCaMo plugin following the instruction in this [link](http://jacamo.sourceforge.net/eclipseplugin/tutorial/)
- Create a new JaCaMo Project 


## Importing the Argumentation-Based Reasoning Mechanism

- Download the argumentation-reasoning mechanism from [here](../ABRinAOPL/src/reasonig/arb.asl)
- Upload that file to your JaCaMo Project
- Include the argumentation-based reasoning mechanism as part of your agents' code using the following command:
> 
```javascript
{ include("reasoning/ABRinAOPL.asl") }
```

- You are already able to implement argumentation-based agents!

## Knowledge representation

The argumentation reasoning mechanism will interpret all beliefs and (usual) inference rules in Jason agents:
- Belief: `penguin(tweety).`
- Usual inference rules in Jason: `father(P1,P2):- progenitor(P1,P2) & male(P1).`

In addition, the argumentation-based reasoning mechanism is able to interpret strict and defeasible inference rules represented using Jason predicates as follows:
- Strict Inferences: `strict_inf(Head,Body)`, for example, `strict_inf(father(P1,P2),[progenitor(P1,P2),male(P1)])`
- Defeasible Inferences: `defeasible_inf(Head,Body)`, for example, `defeasible_inf(flies(X),bird(X))`

Also, we are able to represent assumption in Jason agents using inference rules that combine strong negation and negation-as-failure:
- Assumption: asm(good_person(Person)) :- not(~good_person(Person))
