# Download real Bitcoin and S&P 500 data
# This script downloads actual historical price data

library(quantmod)

# Download Bitcoin-USD and S&P 500 data from Yahoo Finance
# Using period from Jan 2020 to Jan 2026 (6 years of monthly data)
cat("Downloading Bitcoin data from Yahoo Finance...\n")
getSymbols("BTC-USD", src = "yahoo", from = "2020-01-01", to = "2026-01-31", auto.assign = TRUE)

cat("Downloading S&P 500 data from Yahoo Finance...\n")
getSymbols("^GSPC", src = "yahoo", from = "2020-01-01", to = "2026-01-31", auto.assign = TRUE)

# Convert to monthly data and calculate returns
btc_monthly <- to.monthly(`BTC-USD`, indexAt = "lastof", OHLC = FALSE)
sp500_monthly <- to.monthly(GSPC, indexAt = "lastof", OHLC = FALSE)

# Calculate monthly returns (percentage change)
btc_returns <- diff(log(Cl(btc_monthly))) * 100
sp500_returns <- diff(log(Cl(sp500_monthly))) * 100

# Remove first NA value
btc_returns <- btc_returns[-1]
sp500_returns <- sp500_returns[-1]

# Create dataframe
crypto_data <- data.frame(
  Date = index(btc_returns),
  SP500 = as.numeric(sp500_returns),
  Bitcoin = as.numeric(btc_returns)
)

# Remove any rows with NA
crypto_data <- na.omit(crypto_data)

cat("\nData Summary:\n")
cat(sprintf("Number of observations: %d\n", nrow(crypto_data)))
cat(sprintf("Date range: %s to %s\n", 
            format(min(crypto_data$Date), "%Y-%m"),
            format(max(crypto_data$Date), "%Y-%m")))
cat(sprintf("\nBitcoin returns: Mean=%.2f%%, SD=%.2f%%\n", 
            mean(crypto_data$Bitcoin), sd(crypto_data$Bitcoin)))
cat(sprintf("S&P 500 returns: Mean=%.2f%%, SD=%.2f%%\n", 
            mean(crypto_data$SP500), sd(crypto_data$SP500)))
cat(sprintf("Correlation: %.3f\n", cor(crypto_data$Bitcoin, crypto_data$SP500)))

# Save to CSV
write.csv(crypto_data, "bitcoin_sp500_data.csv", row.names = FALSE)
cat("\nData saved to: bitcoin_sp500_data.csv\n")

# Run the regression
crypto_model <- lm(Bitcoin ~ SP500, data = crypto_data)
cat("\n=== Regression Results ===\n")
print(summary(crypto_model))

# Test hypotheses
beta <- coef(crypto_model)[2]
se_beta <- summary(crypto_model)$coefficients[2, 2]
t_beta0 <- summary(crypto_model)$coefficients[2, 3]
t_beta1 <- (beta - 1) / se_beta

cat("\n=== Hypothesis Tests ===\n")
cat(sprintf("H0: beta = 0, t-stat = %.2f (p < 0.001)\n", t_beta0))
if (abs(t_beta0) > 2) {
  cat("REJECT H0: Bitcoin IS correlated with S&P 500\n")
}

cat(sprintf("\nH0: beta = 1, t-stat = %.2f\n", t_beta1))
if (abs(t_beta1) > 2) {
  cat(sprintf("REJECT H0: Bitcoin beta = %.2f (differs from market risk)\n", beta))
} else {
  cat("Cannot reject H0: Bitcoin has similar risk to market\n")
}

# 95% CI
ci <- confint(crypto_model)[2,]
cat(sprintf("\n95%% CI for beta: [%.2f, %.2f]\n", ci[1], ci[2]))
