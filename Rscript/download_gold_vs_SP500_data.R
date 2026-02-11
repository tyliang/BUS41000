# Download real Gold and S&P 500 data
# This script downloads actual historical price data

library(quantmod)

# Download Gold (GLD ETF) and S&P 500 data from Yahoo Finance
# Using period from Jan 2020 to Jan 2026
cat("Downloading Gold (GLD ETF) data from Yahoo Finance...\n")
getSymbols("GLD", src = "yahoo", from = "2020-01-01", to = "2026-01-31", auto.assign = TRUE)

cat("Downloading S&P 500 data from Yahoo Finance...\n")
getSymbols("^GSPC", src = "yahoo", from = "2020-01-01", to = "2026-01-31", auto.assign = TRUE)

# Convert to monthly data and calculate returns
gld_monthly <- to.monthly(GLD, indexAt = "lastof", OHLC = FALSE)
sp500_monthly <- to.monthly(GSPC, indexAt = "lastof", OHLC = FALSE)

# Calculate monthly returns (percentage change)
gld_returns <- diff(log(Cl(gld_monthly))) * 100
sp500_returns <- diff(log(Cl(sp500_monthly))) * 100

# Remove first NA value
gld_returns <- gld_returns[-1]
sp500_returns <- sp500_returns[-1]

# Create dataframe
gold_data <- data.frame(
  Date = index(gld_returns),
  SP500 = as.numeric(sp500_returns),
  Gold = as.numeric(gld_returns)
)

# Remove any rows with NA
gold_data <- na.omit(gold_data)

cat("\nData Summary:\n")
cat(sprintf("Number of observations: %d\n", nrow(gold_data)))
cat(sprintf("Date range: %s to %s\n", 
            format(min(gold_data$Date), "%Y-%m"),
            format(max(gold_data$Date), "%Y-%m")))
cat(sprintf("\nGold returns: Mean=%.2f%%, SD=%.2f%%\n", 
            mean(gold_data$Gold), sd(gold_data$Gold)))
cat(sprintf("S&P 500 returns: Mean=%.2f%%, SD=%.2f%%\n", 
            mean(gold_data$SP500), sd(gold_data$SP500)))
cat(sprintf("Correlation: %.3f\n", cor(gold_data$Gold, gold_data$SP500)))

# Save to CSV
write.csv(gold_data, "gold_sp500_data.csv", row.names = FALSE)
cat("\nData saved to: gold_sp500_data.csv\n")

# Run regression
cat("\n=== Regression Results ===\n")
gold_model <- lm(Gold ~ SP500, data = gold_data)
print(summary(gold_model))

# Hypothesis tests
beta_gold <- coef(gold_model)[2]
se_gold <- summary(gold_model)$coefficients[2, 2]
t_stat_zero <- summary(gold_model)$coefficients[2, 3]
t_stat_one <- (beta_gold - 1) / se_gold
ci_gold <- confint(gold_model)[2,]

cat("\n=== Hypothesis Tests ===\n")
cat(sprintf("H0: beta = 0, t-stat = %.2f (p = %.4f)\n", t_stat_zero, summary(gold_model)$coefficients[2, 4]))
if (abs(t_stat_zero) > 2) {
  cat("REJECT H0: Gold IS correlated with S&P 500\n")
} else {
  cat("FAIL TO REJECT H0: Gold appears uncorrelated with S&P 500\n")
}

cat(sprintf("\nH0: beta = 1, t-stat = %.2f\n", t_stat_one))
if (abs(t_stat_one) > 2) {
  cat(sprintf("REJECT H0: Gold beta = %.2f (differs from market risk)\n", beta_gold))
} else {
  cat("FAIL TO REJECT H0: Gold has similar risk to market\n")
}

cat(sprintf("\n95%% CI for beta: [%.2f, %.2f]\n", ci_gold[1], ci_gold[2]))
