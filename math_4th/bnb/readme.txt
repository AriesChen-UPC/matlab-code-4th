README FOR THE BNBGUI

INSTALLATION

To function BNB needs: 
Matlab 5.3 or newer
Optimization Toolbox 2.0
the Courier-LD font (8 points, regular)

Unzip BNB.zip to an empty directory that's in the MATLAB path. Make 
sure you unzip using folder names. This because some files must be 
placed in a subdirectory called private.

USAGE

BNB has a graphical user interface (GUI). To run it type BNBGUI at the 
Matlab prompt. The program has been used (and tested) with Matlab 
5.3.1.29215a (R11.1).

A short explanation of how branch and bound works: A problem with an 
integer variable is first being solved with the integer variable 
considered continuous (the first sub-problem). After this the program 
generated sub problems where the domain of the variable (still 
continuous) is being restricted. This is called branching. Then it 
solves these sub-problems. This process continues until the variable is 
fixed to a (integer) value.
The advantage of this approach (when compared with explicit 
enumeration) lies in the fact that not all the sub-problems have to be 
solved (fathoming, i will not explain how this works here). Important 
for the user is that branch-and-bound only works when the problem is 
formulated continuous. 

BNB20 is useful for making choices. Say you want the algorithm to make 
an optimal choice between 3 materials. Define 3 0-1-variables (integer 
variables with domain 0-1). Somewhere in your formulas you use the 
hardness of the material. Because the problem has to be formulated 
continuous you should formulate the hardness like this:
hardness=x(1:3).*[hardness1 hardness2 hardness3];
And somewhere else in your formulas you use the weight:
weight=x(1:3).*[weight1 weight2 weight3]; etc.
Of course you want to end with one of the materials being picked, so 
you add to your linear constrains x(1)+x(2)+x(3)=1. 

ALGORITHM

The algorithm is BNB20.m. It is a simple branch-and-bound type 
algorithm. Its specifications are:
* Depth-first traversal with backtracing.
* Both the variable to branch on and the branch to traverse are chosen 
by simple 
heuristics.
* The algorithm detects 0-1 variables with constrains like 
x(a)+x(b)+x(c)+..=1 
and adapts the branching to it.
* To solve the nonlinear sub-problems BNB20 uses fmincon from the 
optimization 
toolbox 2.0.
For more info at the Matlab prompt type help BNB20.

OPTIMIZATION TOOLBOX VERSION 2.0 (R11) 

To get rid of bugs and to stop fmincon from hanging make the following 
chances:

In optim/private/nlconst.m ($Revision: 1.20 $  $Date: 1998/08/24 
13:46:15 $):
Get EXITFLAG independent of verbosity.
After the lines:                 disp('  less than 2*options.TolFun but 
constraints are not satisfied.')    
                              end
                              EXITFLAG = -1;   
                           end
                        end
                        status=1;
add the line: if (strncmp(howqp, 'i',1) & mg > 0), EXITFLAG = -1; end;
(This bug was found by Ingar Solberg)

In optim/private/qpsub.m ($Revision: 1.21 $  $Date: 1998/09/01 21:37:56 
$):
Stop qpsub from hanging.
After the line: %   Andy Grace 7-9-90. Mary Ann Branch 9-30-96.
add the line: global maxSQPiter; 
and changed the line: maxSQPiters = Inf;
to the line: if exist('maxSQPiter','var'), maxSQPiters = maxSQPiter; 
else 
maxSQPiters=inf; end; 
I guess there was a reason to put maxSQPiters at infinity, but this 
works fine for me.

Koert Kuipers
e-mail koertkuipers@yahoo.com
Fysische Informatica
Applied Physics
University of Groningen        
The Netherlands