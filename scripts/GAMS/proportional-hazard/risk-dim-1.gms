$Title Distortion Reward Risk Optimization

* Enable end-of-line comments
$onEolCom

option minlp=BARON;

* Definition of indices
Sets Assets Financial assets    / Asset1 * Asset10 /
     Time   Given time periods  / t1 * t10 /;
     
* Definition of indices
Alias(i, Time);
Alias(j, Time);

* Table of assets' losses for a given time period
Parameter l(Assets, Time);

* Reading input into the table l from the input excel file
$call   GDXXRW indata.xlsx trace=3 par=l rdim=1 cdim=1
$GDXIN  indata.gdx
$LOAD   l
$GDXIN

*Displaying our input data
Display l;
    
* Variables (definition of the permutation matrix and the objective value)
*
* p(i, j)       matrix consisting of 0 and 1
* Risk          objective value to be minimized
* w             portfolio weights, non-negative
* x(Time)       a vector with the same but ordered values of the vector v
* y(i)          a new vector consisting of values from x, but they are ordered

Variables
    p(i, j) permutation matrix 
    Risk objective value (Risk measure)
    Reward expected value (Reward measure)
    w(Assets) portfolio weights
    x(Time) portfolio losses
    y(i) new ordered vector ;
    
Binary variables p ;
Positive variables w ;

* Equations (objective function and permutation constraints)
*
* obj               to be minimized (currently has a provisional value)
* rowSum(i)         sum of rows in the permutation matrix
* columnSum(j)      sum of columns in the pertutation matrix
* newVector(i)      Definition of values of the new ordered vector y
* isOrdered         Constraints related to the ordering of values of the vector y

Equations
    obj                     objective function
    exValue                 expected value (reward measure)
*    minExValue              constraint related to the minimal expected value
    rowSum(i)               row summations                  
    columnSum(j)            column summations
    weights                 sum of weights must be equal to 1
*    maxWeights              limit on portfolio's weights
    portfolioLosses(Time)   calculation of portfolio losses
    positiveReturns         only positive returns allowed
    newVector(i)            new vector values' constrains
    isOrdered1              new vector values must be ordered
    isOrdered2
    isOrdered3
    isOrdered4
    isOrdered5              
    isOrdered6              
    isOrdered7              
    isOrdered8
    isOrdered9              ;

    rowSum(i)               .. sum(j, p(i,j)) =e= 1;               !! sum of each row must be equal to 1
    columnSum(j)            .. sum(i, p(i,j)) =e= 1;               !! sum of each column must be equal to 1
    weights                 .. sum(Assets, w(Assets)) =e= 1;       !! sum of weights must be equal to 1
    portfolioLosses(Time)   .. x(Time) =e= sum(Assets, l(Assets, Time)*w(Assets));
    newVector(i)            .. y(i) =e= sum(j, p(i, j)*x(j));      !! values in the new vector n must be equal to permuted values of v(j)
    isOrdered1              .. (y("t2") - y("t1")) =g= 0;          !! values in the new vector n must be ordered  
    isOrdered2              .. (y("t3") - y("t2")) =g= 0;              
    isOrdered3              .. (y("t4") - y("t3")) =g= 0;           
    isOrdered4              .. (y("t5") - y("t4")) =g= 0;
    isOrdered5              .. (y("t6") - y("t5")) =g= 0;
    isOrdered6              .. (y("t7") - y("t6")) =g= 0;
    isOrdered7              .. (y("t8") - y("t7")) =g= 0;
    isOrdered8              .. (y("t9") - y("t8")) =g= 0;
    isOrdered9              .. (y("t10") - y("t9")) =g= 0;
*    maxWeights(Assets)      .. w(Assets) =l= 0.3;
    exValue                 .. Reward =e= sum(Time, 2-y(Time))/card(Time);
    positiveReturns         .. Reward =g= 1.0;
*    minExValue              .. Reward =e= 1.02;
    obj                     .. Risk =e= y("t1") +
                                        (y("t2") - y("t1"))*(1 - 1/10)**(1/5) +
                                        (y("t3") - y("t2"))*(1 - 2/10)**(1/5) +
                                        (y("t4") - y("t3"))*(1 - 3/10)**(1/5) +
                                        (y("t5") - y("t4"))*(1 - 4/10)**(1/5) +
                                        (y("t6") - y("t5"))*(1 - 5/10)**(1/5) +
                                        (y("t7") - y("t6"))*(1 - 6/10)**(1/5) +
                                        (y("t8") - y("t7"))*(1 - 7/10)**(1/5) +
                                        (y("t9") - y("t8"))*(1 - 8/10)**(1/5) +
                                        (y("t10") - y("t9"))*(1 - 9/10)**(1/5) ;

Model definition
Model OptimalPortfolioRisk /all/ ;

*Setup of initial solution
w.l("Asset1") = 0.1;
w.l("Asset2") = 0.1;
w.l("Asset3") = 0.1;
w.l("Asset4") = 0.1;
w.l("Asset5") = 0.1;
w.l("Asset6") = 0.1;
w.l("Asset7") = 0.1;
w.l("Asset8") = 0.1;
w.l("Asset9") = 0.1;
w.l("Asset10") = 0.1;

* In order to find a solution we need to change the maxcycle limit
OptimalPortfolioRisk.optfile=1;

*$onecho > dicopt.opt
*maxcycles 2000
*$offecho


* Solving the model
Solve OptimalPortfolioRisk using MINLP maximizing Reward;

Display p.l, w.l, x.l, y.l, Risk.l, Reward.l;

* Writing output data into the output file
Execute_Unload 'outdataPH5dim1.gdx';
Execute 'GDXXRW outdataPH5dim1.gdx squeeze=n var w.l rng=Sheet1!b4:k4' ;
Execute 'GDXXRW outdataPH5dim1.gdx var Risk.l rng=Sheet1!m5:m5';
Execute 'GDXXRW outdataPH5dim1.gdx var Reward.l rng=Sheet1!n5:n5';


