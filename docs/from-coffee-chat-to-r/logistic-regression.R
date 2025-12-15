#--------------------------------------------------------------------------------------------------------
#- Adjusting for Bias V. Understanding Confounding in Effect Measures: Marginal vs Stratified -----------
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/logistic-regression-5.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/logistic-regression-5.html
#--------------------------------------------------------------------------------------------------------

#- Generation of data frame "dat" --------------------------
dat <- data.frame(
  cancer = c(1, 0, 1, 0,   1, 0, 1, 0),
  coffee = c(1, 1, 0, 0,   1, 1, 0, 0),
  smoke  = c(1, 1, 1, 1,   0, 0, 0, 0),
  n      = c(14, 266, 4, 76,  1, 99, 8, 792)
)

#- Analysis using glm() without adjustment -----------------
fit_logit1 <- glm(
  cancer ~ coffee,
  family  = binomial(link = "logit"),
  weights = n,
  data    = dat
)
odds_ratio1 <- exp(coef(fit_logit1)[["coffee"]])
print(odds_ratio1)

#- Analysis using glm() with adjustment --------------------
fit_logit2 <- glm(
  cancer ~ coffee+smoke,
  family  = binomial(link = "logit"),
  weights = n,
  data    = dat
)
odds_ratio2 <- exp(coef(fit_logit2)[["coffee"]])
print(odds_ratio2)