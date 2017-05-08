library(data.table)
gaulton <- fread('../GaltonFamilies.csv')
head(gaulton)
dim(gaulton)

hist.plot <- function(df, col, bw, max, min){
  ggplot(df, aes_string(col)) + geom_histogram(binwidth = bw) + xlim(min, max)
}

hist.family <- function(df, col1, col2, num.bin.1 = nclass.FD(df[, col1]),
                        num.bin.2 = nclass.FD(df[, col2])){
  require(ggplot2)
  require(gridExtra)
  
  ## Compute bin width
  max <- max(max(df[, col1]), max(df[, col2]))
  min <- min(min(df[, col1]), min(df[, col2]))
  bin.width.1 <- (max - min) / num.bin.1
  bin.width.2 <- (max - min) / num.bin.2
  
  ## Create a first histogram
  p1 <- hist.plot(df, col1, bin.width.1, max, min)
  p1 <- p1 + geom_vline(xintercept = mean(df[, col1]), color = 'red', size = 1)
  
  ## Create a second histogram
  p2 <- hist.plot(df, col2, bin.width.2, max, min)
  p2 <- p2 + geom_vline(xintercept = mean(df[, col2]), color = 'red', size = 1)
  
  ## Stack the plots
  grid.arrange(p1, p2, nrow = 2, ncol = 1)
}

sons <- gaulton[gaulton$gender == 'male', ]
hist.family(sons, sons$childHeight, sons$mother)

daughters <- gaulton[gaulton$gender == 'female', ]
hist.family(daughters, daughters$childHeight, daughters$mother)

families.test <- function(df, col1, col2, paired = TRUE){
  t.test(df[, col1], df[, col2], paired = paired)
}

hist.family.conf <- function(df, col1, col2, num.bin.1 = nclass.FD(df[, col1]),
                             num.bin.2 = nclass.FD(df[, col2]), paired = FALSE){
  require(ggplot2)
  require(gridExtra)
  
  ## Compute the bin width
  max <- max(max(df[, col1]), max(df[, col2]))
  min <- min(min(df[, col1]), min(df[, col2]))
  bin.width.1 <- (max - min) / num.bin.1
  bin.width.2 <- (max - min) / num.bin.2
  
  mean1 <- mean(df[, col1])
  mean2 <- mean(df[, col2])
  t <- t.test(df[, col1], df[, col2], paired = paired)
  pv1 <- mean2 + t$conf.int[1]
  pv2 <- mean2 + t$conf.int[2]
  
  ## Plot a histogram
  p1 <- hist.plot(df, col1, bin.width.1, max, min)
  p1 <- p1 + geom_vline(xintercept = mean1, color = 'red', size = 1) +
    geom_vline(xintercept = pv1, color = 'red', size = 1, lty = 2) +
    geom_vline(xintercept = pv2, color = 'red', size = 1, lty = 2)
  
  p2 <- hist.plot(df, col2, bin.width.2, max, min)
  p2 <- p2 + geom_vline(xintercept = mean2, color = 'red', size = 1.5)
  
  ## Stack the plots
  grid.arrange(p1, p2, nrow = 2)
  
  print(t)
}

hist.family.conf(sons, sons$mother, sons$childHeight)
hist.family.conf(daughters, daughters$mother, daughters$childHeight)
hist.family.conf(daughters, daughters$father, daughters$childHeight)
