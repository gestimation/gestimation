#--------------------------------------------------------------------------------------------------------
#- Effects and time III. Collapsibility of Effect Measures in Marginal and Stratified Tables ------------
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/effects-3.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/effects-3.html
#--------------------------------------------------------------------------------------------------------

#- Generation of data frame "dat" --------------------------
dat <- data.frame(
  treat = factor(c("palliative", "palliative", "chemotherapy", "chemotherapy"), 
                 levels = c("palliative", "chemotherapy")),
  death = c(1, 0, 1, 0),
  n     = c(30, 20, 15, 35)
)
dat

#- Analysis using glm() with identity link -----------------
fit_identity <- glm(
  death ~ treat,
  family  = binomial(link = "identity"),
  weights = n,
  data    = dat
)
risk_difference <- coef(fit_identity)[["treatchemotherapy"]]
print(risk_difference)

#- Analysis using glm() with log link ----------------------
fit_log <- glm(
  death ~ treat,
  family  = binomial(link = "log"),
  weights = n,
  data    = dat
)
risk_ratio <- exp(coef(fit_log)[["treatchemotherapy"]])
print(risk_ratio)

#- Analysis using glm() with logit link --------------------
fit_logit <- glm(
  death ~ treat,
  family  = binomial(link = "logit"),
  weights = n,
  data    = dat
)
odds_ratio <- exp(coef(fit_logit)[["treatchemotherapy"]])
print(odds_ratio)

#--------------------------------------------------------------------------------------------------------
#- Effects and time V. Distinguishing Time-Point, Time-Constant, and Time-Varying Effects: An R Example -
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/effects-5.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/effects-5.html
#  Required packages: cifmodeling -----------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------

#- Generation of data frame "dat" --------------------------
set.seed(46)
dat <- generate_data(hr1 = 2, hr2 = 1.5)

#- Analysis of OS using cifplot() --------------------------
# install.packages("cifmodeling") # if needed
library(cifmodeling)
cifplot(
  Event(time_os, status_os) ~ stoma,
  data         = dat,
  outcome.type = "survival",
  label.y      = "Overall survival"
)

#- Analysis using polyreg() with time.point=5 --------------
rr_at_5 <- polyreg(nuisance.model=Event(time_os,status_os)~1, exposure="stoma", data=dat, 
                   effect.measure1="RR", time.point=5, outcome.type="survival")
summary(rr_at_5)

#- Analysis using polyreg() with time.point=10 -------------
rr_at_10 <- polyreg(nuisance.model=Event(time_os,status_os)~1, exposure="stoma", data=dat, 
                    effect.measure1="RR", time.point=10, outcome.type="survival")
summary(rr_at_10)

#- Analysis using polyreg() with time.point=20 -------------
rr_at_20 <- polyreg(nuisance.model=Event(time_os,status_os)~1, exposure="stoma", data=dat, 
                    effect.measure1="RR", time.point=20, outcome.type="survival")
summary(rr_at_20)

