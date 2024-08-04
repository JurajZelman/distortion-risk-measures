# Distortion risk measures

This repository contains my BSc [thesis](./papers/Risk%20and%20ratio%20measures%20in%20portfolio%20optimization%20-%20Zelman%20(2021).pdf) on the topic of distortion risk measures, namely in the optimization of distortion reward-risk ratios in portfolio management. The summary of the proposed model can be found in [Kopa, Zelman (2021)](./papers/Distortion%20risk%20measures%20in%20portfolio%20optimization%20-%20Kopa,%20Zelman%20(2021).pdf) paper presented at the MME2021 conference, which was written with my supervisor [doc. RNDr. Ing. Miloš Kopa, Ph.D.](https://www2.karlin.mff.cuni.cz/~kopa/). The thesis was awarded the Price of Josef Stefan for an excellent BSc thesis at the Department of Probability and Mathematical Statistics, the Faculty of Mathematics and Physics, Charles University in Prague. The implementation of the model in the specialized optimization software [GAMS](https://www.gams.com/) can be found in the [`scripts`](./scripts/) folder.

The new formulation of coherent distortion risk measures via linear programming can be found in [Kopa (2021)](./papers/Risk%20minimization%20using%20distortion%20risk%20measures%20via%20linear%20programming%20-%20Kopa%20(2021).pdf).

## Abstract of the thesis

This thesis is focused on distortion risk measures and distortion reward-risk ratios. Firstly, we summarize the properties of these measures related to
coherency axioms and stochastic dominance. We present the proofs and explain
the assumptions for consistency of distortion risk measures with stochastic dominance. Furthermore, their relation to Value-at-Risk and Expected Shortfall is
explained, and numerous examples of these measures are presented. Then, the
basics of the theory of distortion reward-risk ratios are provided. The main
theoretical result of this thesis is the proposition of the distortion reward-risk optimization model. We propose this model with the assumption of a discrete loss random variable that has realizations with equal probabilities. Lastly, we analyze and discuss the results and limitations of our implementation in the specialized optimization software GAMS on real financial data. As it turns out, the class of distortion risk measures is prospective because it allows us to re-weight probabilities in the distribution and to model the risk-aversion preferences.
