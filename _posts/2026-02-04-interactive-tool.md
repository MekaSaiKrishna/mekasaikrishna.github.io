---
title: "Interactive Computational Tool"
date: 2026-02-04
categories: [Research, Tools]
tags: [Python, Simulation]
---
Check out my interactive simulation below:

<iframe src="/apps/plot.html" width="100%" height="500px" frameborder="0"></iframe>



## CHILE MODEL YOUNG'S MODULUS:

<iframe src="/apps/plot2.html" width="950px" height="700px" frameborder="0"></iframe>



## RESIN CURE KINETICS:

### Autocatalytic + Diffusion Model

$\displaystyle\frac{d\alpha}{dt} = \displaystyle\frac{Ae^{-E_a/RT}\alpha^m(1-\alpha)^n}{\left(1 + e^{C\left(\alpha - (\alpha_{C0} + \alpha_{CT}T)\right)} \right)}$

Material: 8552 Resin

| Property      | Value                 | Units      |
|---------------|-----------------------|------------|
| $E_a$         | $66500$               | J/mol      |
| $A$           | $1.53 \times 10^5$    | $sec^{-1}$ |
| $m$           | $0.813$               | —          |
| $n$           | $2.74$                | —          |
| $C$           | $43.1$                | —          |
| $\alpha_{C0}$ | $-1.684$ | —          |
| $\alpha_{CT}$ | $5.46 \times 10^{-3}$             | $^K^{-1}$ |


<iframe src="/apps/plot3.html" width="950px" height="700px" frameborder="0"></iframe>


## Viscosity Model

$\mu = A_{\mu}exp(E_{\mu}/RT)\left[\alpha_g/(\alpha_g-\alpha)\right]^{(A+B\alpha)}$

| Property     | Value                  | Units |
|--------------|------------------------|-------|
| $A_{\mu}$    | $3.45 \times 10^{-10}$ | Pa.s  |
| $E_{\mu}$    | $76536$                | J/mol |
| $A$          | $3.8$                  | —     |
| $B$          | $2.5$                  | —     |
| $\alpha_{g}$ | $0.47$                 | —     |

