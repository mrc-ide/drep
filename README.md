
<!-- README.md is generated from README.Rmd. Please edit that file -->
drep
====

<!-- badges: start -->
<!-- badges: end -->
`drep` allows calculation of the Dengue Reproduction number, *R*<sub>0</sub>, from Force of Infection using the at-equilibrium number of primary, secondary, tertiary and quaternary infections in a population and their relative infectiousness. This is done assuming that Dengue transmission is at equilibrium.

Installation
------------

You can install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mrc-ide/drep")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(drep)
## basic example code
```

Define some parameters

-   number of age groups in the country human population (`n_age_groups`)
-   total human population of the country (`pop`)
-   the Force of Infection estimate (`FOI`)
-   relative infectiousness of the four dengue infections (`phis`)

``` r
n_age_groups <- 20
pop <- 500000
FOI <- 0.0235
phis <- c(1, 1, 1, 1)
```

Simulate some data

-   lower and upper age limits (`l_lim` and `u_lim`) of the country age groups
-   number of individuals in each age group (`n_j`)
-   proportion of individuals in each age gorup (`f_j`)

``` r
l_lim <- seq(0, 95, length.out = n_age_groups)
u_lim <- seq(5, 100, length.out = n_age_groups)
n_j <- sample(1:50, n_age_groups, replace = TRUE)
f_j <- n_j / sum(n_j)
```

Calculate the *R*<sub>0</sub>

``` r
R0 <- calculate_R0(FOI, pop, f_j, u_lim, l_lim, phis)
R0
#> [1] 2.800158
```
