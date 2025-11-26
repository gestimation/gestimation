

##########################################################
# ::: {.callout-note title="シミュレーションデータの生成"}

set.seed(46)

# ストーマ保有あり(1)/なし(0)

stoma <- rbinom(200, size = 1, prob = 0.4)

# 性別 0 = 女性, 1 = 男性

sex <- rbinom(200, size = 1, prob = 0.5)

# 年齢：正規分布から生成（ストーマあり群を少し高齢に）

age <- rnorm(200, mean = 65 + 3 * stoma, sd = 8)

# 生存時間：指数分布（ストーマあり群の予後の期待値10年、ストーマなし群の予後の期待値15年）

hazard <- ifelse(stoma == 1, 1 / 10, 1 / 15)
time   <- rexp(200, rate = hazard)

# ランダムな打ち切り（0 = 打ち切り, 1 = イベント）

status <- rbinom(200, size = 1, prob = 0.9)

dat <- data.frame(
  age   = age,
  sex   = factor(sex, levels = c(0, 1), labels = c("WOMAN", "MAN")),
  stoma = factor(stoma, levels = c(0, 1), labels = c("WITHOUT STOMA", "WITH STOMA")),
  time  = time,
  status = status
)

head(dat)



##########################################################
#  ::: {.callout-note title="連続データと2値データの要約"}

library(ggplot2)

ggplot(dat, aes(x = age, fill = stoma)) +
  geom_histogram(alpha = 0.5, position = "identity", bins = 20) +
  labs(x = "AGE", y = "FREQUENCY", fill = "STOMA") +
  theme_minimal()

table(STOMA = dat$stoma, SEX = dat$sex)

##########################################################
# ::: {.callout-note title="生存曲線による生存時間データの要約"}

library(cifmodeling)

survival_curve <- cifcurve(Event(time, status) ~ stoma,data = dat, outcome.type = "survival")
cifplot(survival_curve)


######################################################################## 
# ::: {.callout-note title="シミュレーションデータ（再発あり）の生成"}
set.seed(46)
n <- 200

# ストーマ保有あり(1)/なし(0)
stoma <- rbinom(n, size = 1, prob = 0.4)

# 性別 0 = 女性, 1 = 男性
sex <- rbinom(n, size = 1, prob = 0.5)

# 年齢：正規分布から生成（ストーマあり群を少し高齢に）
age <- rnorm(n, mean = 65 + 3 * stoma, sd = 8)

hazard_relapse   <- ifelse(stoma == 1, 0.20, 0.12)  # 再発ハザード（大きいほど早く起こる）
hazard_death     <- ifelse(stoma == 1, 0.10, 0.07)  # 死亡ハザード
hazard_censoring <- 0.05                            # 打ち切りハザード（群に依存しない）

t_relapse   <- rexp(n, rate = hazard_relapse)   # 再発までの潜在時間
t_death     <- rexp(n, rate = hazard_death)     # 死亡までの潜在時間
t_censoring <- rexp(n, rate = hazard_censoring) # 打ち切りまでの潜在時間

## --- 全生存期間（OS） -------------------

time_os   <- pmin(t_death, t_censoring)
status_os <- as.integer(t_death <= t_censoring)  # 1 = 死亡, 0 = 打ち切り

## --- 無再発存期間（RFS） ----------

time_rfs <- pmin(t_relapse, t_death, t_censoring)

status_rfs <- integer(n)
status_rfs[time_rfs == t_relapse & time_rfs < t_censoring] <- 1 # 再発
status_rfs[time_rfs == t_death & time_rfs < t_censoring] <- 1   # 死亡

## --- 累積再発率（CIR） + 競合リスク ----
# イベント1: 再発
# イベント2: 再発を経験しない死亡
# 0: 打ち切り

time_cir <- pmin(t_relapse, t_death, t_censoring)

status_cir <- integer(n)
status_cir[time_cir == t_relapse & time_cir < t_censoring] <- 1 # イベント1: 再発
status_cir[time_cir == t_death & time_cir < t_censoring] <- 2     # イベント2: 競合リスクとしての死亡

## --- データフレームにまとめる --------------------------------

dat <- data.frame(
  age        = age,
  sex        = factor(sex, levels = c(0, 1), labels = c("WOMAN", "MAN")),
  stoma      = factor(stoma, levels = c(0, 1),
                      labels = c("WITHOUT STOMA", "WITH STOMA")),
  time_os    = time_os,
  status_os  = status_os,
  time_rfs   = time_rfs,
  status_rfs = status_rfs,
  time_cir   = time_cir,
  status_cir = status_cir
)

head(dat)



######################################################################## 
# ::: {.callout-note title="全生存期間（OS）のKaplan–Meier曲線"}

# devtools::install_github("gestimation/cifmodeling") #インストールが必要なら実行 
library(cifmodeling)

cifplot(Event(time_os, status_os) ~ stoma,
        data         = dat,
        outcome.type = "survival",
        label.y      = "Overall survival"
)


######################################################################## 
# ::: {.callout-note title="無再発生存期間（RFS）のKaplan–Meier曲線"}

cifplot(Event(time_rfs, status_rfs) ~ stoma,
        data         = dat,
        outcome.type = "survival",
        label.y      = "Relapse-free survival"
)

  
######################################################################## 
#  ::: {.callout-note title="累積発生率（CIR）のAalen-Johansen曲線の違い"}

cifplot(Event(time_cir, status_cir) ~ stoma,
        data         = dat,
        outcome.type = "competing-risk",
        label.y      = "Cumulative incidence of relapse"
)


######################################################
generate_data <- function(hr1, hr2) {
#  set.seed(46)

  age <- rnorm(n, mean = 65 + 3 * stoma, sd = 8)
  stoma <- rbinom(200, size = 1, prob = 0.4)
  hazard_relapse   <- ifelse(stoma == 1, hr1*0.10, 0.10) # 再発のrate（大きいほど早く起こる）
  hazard_death     <- ifelse(stoma == 1, hr2*0.10, 0.10) # 死亡のrate
  hazard_censoring <- 0.05                               # 打ち切りハザード（群に依存しない）
  
  t_relapse   <- rexp(200, rate = hazard_relapse)   # 再発までの潜在時間
  t_death     <- rexp(200, rate = hazard_death)     # 死亡までの潜在時間
  t_censoring <- rexp(200, rate = hazard_censoring) # 打ち切りまでの潜在時間
  
  ## --- 全生存期間（OS） -------------------
  
  time_os   <- pmin(t_death, t_censoring)
  status_os <- as.integer(t_death <= t_censoring)  # 1 = 死亡, 0 = 打ち切り
  
  ## --- 無再発存期間（RFS） ----------
  
  time_rfs <- pmin(t_relapse, t_death, t_censoring)
  
  status_rfs <- integer(200)
  status_rfs[time_rfs == t_relapse & time_rfs < t_censoring] <- 1 # 再発
  status_rfs[time_rfs == t_death & time_rfs < t_censoring] <- 1   # 死亡
  
  ## --- 累積再発率（CIR） + 競合リスク ----
  # イベント1: 再発
  # イベント2: 再発を経験しない死亡
  # 0: 打ち切り
  
  time_cir <- pmin(t_relapse, t_death, t_censoring)
  
  status_cir <- integer(200)
  status_cir[time_cir == t_relapse & time_cir < t_censoring] <- 1 # イベント1: 再発
  status_cir[time_cir == t_death & time_cir < t_censoring] <- 2     # イベント2: 競合リスクとしての死亡
  
  ## --- データフレームにまとめる --------------------------------
  
  dat <- data.frame(
    id         = 1:200,
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

######################################################
library(survival)
dat <- generate_data(0.5, 0.5)
dat$fstatus_cir <- factor(dat$status_cir,
                          levels = 0:2,
                          labels = c("censor",
                                     "relapse",
                                     "death"))


######################################################
fit_cox <- coxph(Surv(time_os, status_os) ~ stoma, data = dat)
summary(fit_cox)
confint_cox <- confint(fit_cox)
print(confint_cox[1])
print(confint_cox[2])
beta_true <- 0
covered <- as.integer(confint_cox[1] <= beta_true && beta_true <= confint_cox[2])

######################################################
fgdat <- finegray(Surv(time_cir, fstatus_cir) ~ ., data=dat)
fit_finegray <- coxph(Surv(fgstart, fgstop, fgstatus) ~ stoma, weight=fgwt, cluster=id, data=fgdat)
print(fit_finegray)

confint_finegray <- confint(fit_finegray)
print(confint_finegray[1])
print(confint_finegray[2])
beta_true <- 0
covered_finegray <- as.integer(confint_finegray[1] <= beta_true && beta_true <= confint_finegray[2])
print(covered_finegray)


calculate_coverage <- function(model=c("Cox","Fine-Gray"), hr1, hr2, hr_true) {
  set.seed(46)
  replications=1000
  covered <- numeric(replications)

  for (r in seq_len(replications)) {
    dat <- generate_data(hr1, hr2)
    if (identical(model, "Cox")) {
      fit <- coxph(Surv(time_os, status_os) ~ stoma, data = dat)
    } else if (identical(model, "Fine-Gray")) {
      dat$fstatus_cir <- factor(dat$status_cir,
                                levels = 0:2,
                                labels = c("censor",
                                           "relapse",
                                           "death"))
      fgdat <- finegray(Surv(time_cir, fstatus_cir) ~ ., data=dat)
      fit <- coxph(Surv(fgstart, fgstop, fgstatus) ~ stoma, weight=fgwt, cluster=id, data=fgdat)
    }
    confidence_interval <- confint(fit)
    covered[r] <- as.integer(confidence_interval[1] <= log(hr_true) && log(hr_true) <= confidence_interval[2])
  }
  coverage <- mean(covered)
  return(coverage)
}
coverage_cox <- calculate_coverage(model="Cox", hr1=2, hr2=1.5, hr_true=1.5)
print(coverage_cox)

coverage_finegray <- calculate_coverage(model="Fine-Gray", hr1=0.5, hr2=0.5)
print(coverage_finegray)





library(survival)

## 1回のシミュレーションで「CIに真のHRが含まれたか？」を返す関数
one_sim_cox_coverage <- function(
    n_per_group = 200,
    lambda0     = 0.1,   # control hazard
    HR_true     = 1.5,   # true hazard ratio (treatment vs control)
    lambda_cens = 0.05   # censoring hazard
) {
  n0 <- n_per_group
  n1 <- n_per_group
  
  ## --- 群別のイベント時間 ---
  # 対照群: rate = lambda0
  t0 <- rexp(n0, rate = lambda0)
  # 治療群: rate = lambda0 * HR_true
  t1 <- rexp(n1, rate = lambda0 * HR_true)
  
  ## --- 検閲時間 ---
  c0 <- rexp(n0, rate = lambda_cens)
  c1 <- rexp(n1, rate = lambda_cens)
  
  ## --- 観測時間とステータス ---
  time0 <- pmin(t0, c0)
  status0 <- as.integer(t0 <= c0)
  
  time1 <- pmin(t1, c1)
  status1 <- as.integer(t1 <= c1)
  
  time   <- c(time0, time1)
  status <- c(status0, status1)
  A      <- c(rep(0, n0), rep(1, n1))
  
  dat <- data.frame(time = time,
                    status = status,
                    A = factor(A))
  
  ## --- Cox 回帰 (phreg 的なもの) ---
  fit <- coxph(Surv(time, status) ~ A, data = dat)
  
  ## 推定されたlog-HRと95%CI
  beta_hat <- coef(fit)[["A1"]]
  se_beta  <- sqrt(vcov(fit)[1, 1])
  
  ci_lower <- beta_hat - qnorm(0.975) * se_beta
  ci_upper <- beta_hat + qnorm(0.975) * se_beta
  
  ## 真の log-HR
  beta_true <- log(HR_true)
  
  ## CIが真の値を含んでいるか？
  covered <- as.integer(ci_lower <= beta_true && beta_true <= ci_upper)
  
  ## おまけでHR推定値も返しておく
  list(
    covered = covered,
    beta_hat = beta_hat
  )
}




##########################################################
#::: {.callout-note title="全生存期間（OS）のKaplan–Meier曲線"}

library(cifmodeling)

fit_os <- cifcurve(
  Event(time_os, status_os) ~ stoma,
  data         = dat,
  outcome.type = "survival"   # 単一イベントの生存時間データ
)

plot_os <- cifplot(fit_os)
plot_os

##########################################################
# ::: {.callout-note title="無病生存期間（DFS）のKaplan–Meier曲線"}

fit_dfs <- cifcurve(
  Event(time_dfs, status_dfs) ~ stoma,
  data         = dat,
  outcome.type = "survival"   # 「再発 or 死亡」を1イベントとして扱う
)

plot_dfs <- cifplot(fit_dfs)
plot_dfs



##########################################################
# ::: {.callout-note title="無再発期間（RFT）のAalen-Johansen曲線の違い"}

library(cifmodeling)
# 3. 無再発期間の競合リスク解析（Aalen–Johansen CIF）
# Event(time_rft, event_rft) で、
#   1 = 再発（interest）
#   2 = 再発を経験しない死亡（競合リスク）
#   0 = 打ち切り

fit_cr <- cifcurve(
  Event(time_rft, event_rft) ~ stoma,
  data         = dat,
  outcome.type = "competing-risk"
)

plot_cr <- cifplot(fit_cr)  # デフォルトでCIF（riskスケール）を描画
plot_cr


##########################################################




sim_cox_nonPH_coverage <- function(
    nsim        = 1000,
    n_per_group = 200,
    lambda0       = 0.1,
    lambda1_early = 0.05,
    lambda1_late  = 0.30,
    t_change      = 3,
    lambda_cens   = 0.05,
    seed          = 2026
) {
  set.seed(seed)
  
  cov_early <- numeric(nsim)
  cov_late  <- numeric(nsim)
  
  for (b in seq_len(nsim)) {
    res <- one_sim_cox_nonPH(
      n_per_group   = n_per_group,
      lambda0       = lambda0,
      lambda1_early = lambda1_early,
      lambda1_late  = lambda1_late,
      t_change      = t_change,
      lambda_cens   = lambda_cens
    )
    cov_early[b] <- res$covered_early
    cov_late[b]  <- res$covered_late
  }
  
  coverage_early <- mean(cov_early)
  coverage_late  <- mean(cov_late)
  
  se_early <- sqrt(coverage_early * (1 - coverage_early) / nsim)
  se_late  <- sqrt(coverage_late  * (1 - coverage_late)  / nsim)
  
  list(
    nsim           = nsim,
    n_per_group    = n_per_group,
    coverage_early = coverage_early,
    coverage_late  = coverage_late,
    se_early       = se_early,
    se_late        = se_late
  )
}

## 実行例
res_nonPH <- sim_cox_nonPH_coverage(
  nsim        = 1000,
  n_per_group = 200
)

res_nonPH
