install.packages('knitr')
library(knitr)

install.packages('rmarkdown')

data("InsectSprays")
dim(InsectSprays)
table(InsectSprays[, 'spray'])
pie(table(InsectSprays[, 'spray']))
summary(InsectSprays[, 'count'])
hist(InsectSprays[, 'count'], xlab = 'Insect Counts', main = '')
