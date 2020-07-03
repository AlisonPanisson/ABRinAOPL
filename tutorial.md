# Tutorial

This tutorial is based on JaCaMo Eclipse Plugin. More information about JaCaMo is available [here](http://jacamo.sourceforge.net/).
Also, you need to be familiar with [Jason](http://jason.sourceforge.net/wp/) agent-oriented programming language.

## Installing JaCaMo Eclipse Plugin
- [Install Eclipse IDE](https://www.eclipse.org/downloads/)
- Install JaCaMo plugin following the instruction in this [link](http://jacamo.sourceforge.net/eclipseplugin/tutorial/)
- Create a new JaCaMo Project 


## Importing the Argumentation-Based Reasoning Mechanism

- Download the argumentation-based reasoning mechanism from [here](../abr_in_aopl/src/asl/reasoning/ARBinAOPL.asl)
- Upload that file to your JaCaMo Project
- Include the argumentation-based reasoning mechanism as part of your agents' code using the following command:

```javascript
{ include("reasoning/ABRinAOPL.asl") }
```
You are already able to implement argumentation-based agents. You only need to use the predicate `argument(I)` or `argument(I,Arg)` in order to make agents to query the argumentation-based reasoning mechanism as they usually query their beliefs bases. `argument(I)` returns `true` when the agent has an acceptable argument supporting the information unified in `I`, and `false` otherwise. `argument(I,Arg)` also returns, unified in `Arg`, the beliefs and inferences rules that support that information.

## Knowledge representation

The argumentation reasoning mechanism will interpret all beliefs and (usual) inference rules in Jason agents:
- Belief: `penguin(tweety).`
- Usual inference rules in Jason: `father(P1,P2):- progenitor(P1,P2) & male(P1).`

In addition, the argumentation-based reasoning mechanism is able to interpret strict and defeasible inference rules represented using Jason predicates as follows:
- Strict Inferences: `strict_inf(Head,Body)`, for example, `strict_inf(father(P1,P2),[progenitor(P1,P2),male(P1)])`
- Defeasible Inferences: `defeasible_inf(Head,Body)`, for example, `defeasible_inf(flies(X),bird(X))`

Also, we are able to represent assumption in Jason agents using inference rules that combine strong negation and negation-as-failure:
- Assumptions: `asm(good_person(Person)) :- not(~good_person(Person))`, i.e., I can assume that a person is a good person if I am not able to infer (or believe) that person is not a good person.

## Examples 

### The Tweety example

One of the most famous examples of defeasible reasoning is the so-called Tweety Example.

"Tweety is a penguin, penguins are birds, and birds fly, but penguins do not fly". 

We are able to represente such defeasible infereces as follows:

```javascript
defeasible_inf(flies(A),bird(A)).
defeasible_inf(~flies(A),penguin(A)).
strict_inf(bird(A),penguin(A)).
penguin(tweety).
```
Now, imagine that an agent needs to decide between to leave a bird in a tree or in the ground, and that decision is based on the capability of such a bird to fly:

```javascript
+!leave_bird(A): argument(flies(A)) <- leave_at_tree(A).
+!leave_bird(A): argument(~flies(A)) <- leave_at_ground(A).
```
In our example, the agent has only an acceptable argument to `~flies(tweety)`, thus, when making such decision, `tweety` is going to be leaved at the ground. 

### The Paper Submission Example

We have published an example in which a student (me in that time) was writing a paper to a conference called BRACIS (Brazilian Conference on Intelligent Systems), and the student believed that their paper was good. When someone beliefs that their paper is good and they have submitted that paper for a particular conference, they can concluse (in a defeasible way, of course) that the paper is going to be accepted to that conference. With a accepted paper, the student can conclude that they need to go to the conference. This knowledge is represented as follows:

```javascript
defeasible_inf(go_to(L),[held_in(C,L),accepted(P,C)]).
defeasible_inf(accepted(P,C),[submitted(P,C),good(P)]).
submitted(paper_45,bracis).
good(paper_45).
held_in(bracis,recife).
```

An agent is able to make a decision about requesting a ticket to `recife` if it is able to construct an acceptable argument to go to `recife`. Considering the knowledge above, the agent does have an argument for that, and it can request the ticket using the following plan: 

```javascript
+!buyTicket(L):- argument(go_to(L),Arg) <- request_ticket(L).
```

However, imagine that the agent has checked the BRACIS web page and realised that the page limit for BRACIS papers is 6 pages and the agent has, unfortunatelly, submitted a longer paper than allowed, and longer paper are *strictly* not accepted:

```javascript
strict_inf(~accepted(P,C),[longer_for(P,C),submitted(P,C)]).
strict_inf(longer_for(P,C),[paper_length(P,X),allowed_length(C,Y),X>Y]).
paper_length(paper_45,9).
allowed_length(bracis,6).
```

With this new information the agent is not able to construct an argument to `go_to(recife)`, thus it is not able to request the ticket. 

> **Note:** Our paper had the correct lenght and it has been accepted to BRACIS that year, and it is available [here](https://www.computer.org/csdl/proceedings/bracis/2016/3566/00/07839555.pdf)
