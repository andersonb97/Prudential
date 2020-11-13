# Load Necessary Packages
library(readr)
library(dplyr)
library(DataExplorer)

# Read in the data
test <- read_csv("test.csv")
train <- read_csv("train.csv")
prud <- bind_rows(test, train)

# Correlation Plot.... its super messy... but it seems like there may be some
# collinearity
corrplot::corrplot(cor(lapply(prud, is.numeric) %>% unlist() %>% prud[,.]))
# Because of the collinearity I am thinking Lasso.


# Plot missing
missingPlot <- plot_missing(prud %>% .[,colSums(is.na(prud)) > 0])

# These are the variables that have missing data
missingVars <- missingPlot$data$feature
missingVars

# We should probably look at each one of them and see if they are necessary to
# keep in our model
prud %>% select(missingVars)
