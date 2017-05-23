
library("AzureML")
ws <- workspace()
dat <- download.intermediate.dataset(
  ws,
  experiment = "a157d79c7cce4f78967c26821298745b.f-id.158ed1d910f245c6b2d78fe5a8bfa529",
  node_id = "d2e71f76-7378-4fee-bb84-ceba731b6e5e-2701",
  port_name = "Results dataset",
  data_type_id = "GenericCSV"
)

head(dat)

summary(dat)

sd(dat$ArrDelay)

boxplot(dat$ArrDelay)

hist(dat$ArrDelay, breaks = 30)

library(ggplot2)
library(repr)
options(repr.plot.width = 6, repr.plot.height = 2)

# Function to plot conditioned histograms
fli_hist <- function(x) {
    # library(gridExtra)
    
    # Compute the bin width
    rg <- range(dat[, x])
    bw <- (rg[2] - rg[1]) / 30
    
    # Define the title
    title <- paste('Histogram of', x, 'conditioned by ArrDel15')
    
    # Create the histogram
    ggplot(dat, aes_string(x)) +
    geom_histogram(aes(y = ..count..), binwidth = bw) +
    facet_grid(. ~ ArrDel15) + ggtitle(title)
}

# Create histograms for specified features
plot_cols <- c('DepDelay', 'CRSArrTime', 'CRSDepTime',
               'DayofMonth', 'DayOfWeek', 'Month')
lapply(plot_cols, fli_hist)

# Scatter plot using color to differentiate points
fly_scatter <- function(x) {
    title <- paste('ArrDelay vs.', x, 'with color by ArrDel15')
    ggplot(dat, aes_string(x, 'ArrDelay')) +
    geom_point(aes(color = ArrDel15)) + ggtitle(title)
}

# Define columns for making scatter plots
plot_cols <- c('DepDelay', 'CRSArrTime', 'CRSDepTime',
               'DayofMonth', 'DayOfWeek', 'Month')
lapply(plot_cols, fly_scatter)


