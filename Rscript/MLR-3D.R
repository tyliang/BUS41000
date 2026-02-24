library(ggplot2)
library(dplyr)
library(broom)
library(plotly)

data(mtcars)
str(mtcars)

# Markers and plane

mod3 <- lm(mpg ~ hp + wt, data = mtcars)

# Create a regular sequence for the grid, not just the raw data points
hp_seq <- seq(min(mtcars$hp), max(mtcars$hp), length.out = 60)
wt_seq <- seq(min(mtcars$wt), max(mtcars$wt), length.out = 30)

# Create grid context
grid <- expand.grid(hp = hp_seq, wt = wt_seq)
d <- data.frame(grid)
vals <- predict(mod3, newdata = d)

# Reshape into a matrix. nrow must match the length of the first variable in expand.grid
# (hp_seq), and ncol match the second (wt_seq).
# Note: plotly expects z to be a matrix of numeric values.
# If x and y are vectors, z must be a matrix such that z[i, j] matches x[i] and y[j].
plane <- matrix(vals, nrow = length(hp_seq), ncol = length(wt_seq))

# Cleanup
rm(d, grid, vals)

# Plot
# Note: For add_surface, x and y should be the unique vectors defining the grid axes.
p <- plot_ly(data = mtcars, x = ~wt, y = ~hp, z = ~mpg, opacity = 0.6) %>%
  add_markers() 

p %>% add_surface(x = ~wt_seq, y = ~hp_seq, z = ~plane, showscale = FALSE) %>%
  layout(showlegend = FALSE)
