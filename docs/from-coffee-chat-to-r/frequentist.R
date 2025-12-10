#---------------------------------------------------------------------------------------------------------
#- Frequentist Thinking II. P-Value Explanations That Seem Plausible at First Glance ---------------------
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/frequentist-2.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/frequentist-2.html
#  Required packages: survival ---------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------

#- Generation of data frame "dat" --------------------------
set.seed(46)
dat <- generate_data(hr1 = 2, hr2 = 1.5)  # true HR for death = 1.5

#- Analysis using coxph() ----------------------------------
# install.packages("survival") # if needed
library(survival)

fit <- coxph(Surv(time_os, status_os) ~ stoma, data = dat)
summary(fit)


#---------------------------------------------------------------------------------------------------------
#- Frequentist Experiments I. P-Value Explanations That Seem Plausible at First Glance -------------------
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/frequentist-4.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/frequentist-4.html
#  Required packages: survival ---------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------

#- Definition of function ----------------------------------
generate_data <- function(n = 200, hr1, hr2) {
  # Stoma: 1 = with stoma, 0 = without stoma
  stoma <- rbinom(n, size = 1, prob = 0.4)
  # Sex: 0 = WOMAN, 1 = MAN
  sex <- rbinom(n, size = 1, prob = 0.5)
  # Age: normal distribution (stoma group slightly older)
  age <- rnorm(n, mean = 65 + 3 * stoma, sd = 8)
  
  # Hazards for relapse and death (larger hazard implies earlier event)
  hazard_relapse   <- ifelse(stoma == 1, hr1 * 0.10, 0.10)
  hazard_death     <- ifelse(stoma == 1, hr2 * 0.10, 0.10)
  hazard_censoring <- 0.05
  
  # Latent times to relapse, death, and censoring
  t_relapse   <- rexp(n, rate = hazard_relapse)
  t_death     <- rexp(n, rate = hazard_death)
  t_censoring <- rexp(n, rate = hazard_censoring)
  
  # Overall survival (OS)
  # status_os = 1 → death (event of interest)
  # status_os = 0 → censored
  time_os   <- pmin(t_death, t_censoring)
  status_os <- as.integer(t_death <= t_censoring)  # 1 = death, 0 = censored
  
  # Relapse-free survival (RFS)
  # status_rfs = 1 → relapse or death whichever comes first (event of interest)
  # status_rfs = 0 → censored
  time_rfs   <- pmin(t_relapse, t_death, t_censoring)
  status_rfs <- integer(n)
  status_rfs[time_rfs == t_relapse & time_rfs < t_censoring] <- 1  # relapse
  status_rfs[time_rfs == t_death   & time_rfs < t_censoring] <- 1  # death
  
  # Cumulative incidence of relapse (CIR)
  # status_cir = 1 → relapse (event of interest)
  # status_cir = 2 → death as competing risk
  # status_cir = 0 → censored
  
  time_cir <- pmin(t_relapse, t_death, t_censoring)
  status_cir <- integer(n)
  status_cir[time_cir == t_relapse & time_cir < t_censoring] <- 1
  status_cir[time_cir == t_death   & time_cir < t_censoring] <- 2
  
  data.frame(
    id         = 1:n,
    sex        = factor(sex, levels = c(0, 1), labels = c("WOMAN", "MAN")),
    age        = age,
    stoma      = factor(stoma, levels = c(0, 1),
                        labels = c("WITHOUT STOMA", "WITH STOMA")),
    time_os    = time_os,
    status_os  = status_os,
    time_rfs   = time_rfs,
    status_rfs = status_rfs,
    time_cir   = time_cir,
    status_cir = status_cir
  )
}

#- Generation of data frame "dat" --------------------------
set.seed(46)
dat <- generate_data(hr1 = 2, hr2 = 1.5)

#- Aalen-Johansen curves of CIR using cifplot() ------------
library(cifmodeling)
aj_event1 <- cifplot(Event(time_cir, status_cir) ~ stoma,
                     data         = dat,
                     outcome.type = "competing-risk", 
                     type.y       = "surv",
                     label.y      = "1-Aalen-Johansen",
                     code.event1  = 1, 
                     code.event2  = 2
)
aj_event2 <- cifplot(Event(time_cir, status_cir) ~ stoma,
                     data         = dat,
                     outcome.type = "competing-risk", 
                     type.y       = "risk",
                     label.y      = "Aalen-Johansen",
                     code.event1  = 2, 
                     code.event2  = 1
)
aj_list <- list(aj_event1$plot, aj_event2$plot)
aj_panel <- cifpanel(rows.columns.panel = c(1,2), plots=aj_list)
print(aj_panel)

#- Kaplan-Meier curves of CIR using cifplot() --------------
dat$status_cir1 <- as.numeric(dat$status_cir==1)
km_event1 <- cifplot(Event(time_cir, status_cir1) ~ stoma,
                     data         = dat,
                     outcome.type = "survival", 
                     type.y       = "surv",
                     label.y      = "Kaplan-Meier"
)
dat$status_cir2 <- as.numeric(dat$status_cir==2)
km_event2 <- cifplot(Event(time_cir, status_cir2) ~ stoma,
                     data         = dat,
                     outcome.type = "survival", 
                     type.y       = "risk",
                     label.y      = "1-Kaplan-Meier"
)
km_list <- list(km_event1$plot, km_event2$plot)
km_panel <- cifpanel(rows.columns.panel = c(1,2), plots=km_list)
print(km_panel)


#---------------------------------------------------------------------------------------------------------
#- Frequentist Experiments II. Understanding Confidence Intervals via Hypothetical Replications in R -----
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/frequentist-5.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/frequentist-5.html
#  Required packages: survival ---------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------

#- Definition of function ----------------------------------
calculate_coverage <- function(model = c("coxph", "finegray"),
                               n, hr1, hr2, hr_true) {
  model <- match.arg(model)
  set.seed(46)
  replications <- 1000
  covered <- logical(replications)
  
  for (r in seq_len(replications)) {
    dat <- generate_data(n, hr1, hr2)
    
    if (identical(model, "coxph")) {
      fit <- coxph(Surv(time_os, status_os) ~ stoma, data = dat)
    } else if (identical(model, "finegray")) {
      # Fine?Gray model for competing risks (subdistribution hazards)
      dat$fstatus_cir <- factor(dat$status_cir,
                                levels = 0:2,
                                labels = c("censor", "relapse", "death"))
      fgdat <- finegray(Surv(time_cir, fstatus_cir) ~ ., data = dat)
      fit <- coxph(Surv(fgstart, fgstop, fgstatus) ~ stoma,
                   weight = fgwt, cluster = id, data = fgdat)
    }
    
    ci_log <- confint(fit)  # CI for log(HR)
    covered[r] <- (ci_log[1] <= log(hr_true) && log(hr_true) <= ci_log[2])
  }
  
  mean(covered)  # estimated coverage
}

#- Simulation with n=200------------------------------------
# install.packages("survival") # if needed
library(survival)

coverage_200 <- calculate_coverage(model = "coxph", n = 200,
                                   hr1 = 2, hr2 = 1.5, hr_true = 1.5)

print(coverage_200)

#- Simulation with n=100, 400 and 800-----------------------
coverage_100 <- calculate_coverage(model = "coxph", n = 100,
                                   hr1 = 2, hr2 = 1.5, hr_true = 1.5)
coverage_400 <- calculate_coverage(model = "coxph", n = 400,
                                   hr1 = 2, hr2 = 1.5, hr_true = 1.5)
coverage_800 <- calculate_coverage(model = "coxph", n = 800,
                                   hr1 = 2, hr2 = 1.5, hr_true = 1.5)

print(coverage_100)
print(coverage_200)
print(coverage_400)
print(coverage_800)

#---------------------------------------------------------------------------------------------------------
#- Frequentist Experiments III. Alpha, Beta, and Power: The Fundamental Probabilities Behind Sample Size -
# 
#  Original article (En): https://gestimation.github.io/coffee-and-research/en/frequentist-6.html
#  Original article (JP): https://gestimation.github.io/coffee-and-research/jp/frequentist-6.html
#  Required packages: powerSurvEpi -----------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------

#- Calculation with allocation ratio 1:1 -------------------
# install.packages("powerSurvEpi") # if needed
library(powerSurvEpi)

ssizeCT.default(
  power = 0.9,
  k     = 1,                      # allocation ratio (nE : nC)
  pE    = 0.6,                    # return-to-work rate in stoma group
  pC    = 0.8,                    # return-to-work rate in non-stoma group
  RR    = log(1 - 0.8) / log(1 - 0.6),  # approximate HR from return rates
  alpha = 0.05
)

#- Calculation with allocation ratio 1:2 -------------------
ssizeCT.default(
  power = 0.9,
  k     = 0.5,                  # allocation ratio 1:2
  pE    = 0.6,
  pC    = 0.8,
  RR    = log(1 - 0.8) / log(1 - 0.6),
  alpha = 0.05
)

#- Calculation with allocation ratio 1:4 -------------------
ssizeCT.default(
  power = 0.9,
  k     = 0.25,                 # allocation ratio 1:4
  pE    = 0.6,
  pC    = 0.8,
  RR    = log(1 - 0.8) / log(1 - 0.6),
  alpha = 0.05
)
