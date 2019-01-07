# Library Imports
library(ggplot2)
set.seed(3060)

# Working Directory & Code Directory
training_set.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/section1_code"
section_code.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/section1_code"
setwd(training_set.location)

# Import features CSV
ds <- read.table("40145342_features.csv", header=FALSE, sep=",")

# Next we create the dataframe
ds.df <- data.frame(ds)

# We can now split the data into subsets based upon the label
ds.lt_di <- subset(ds.df, V1 < 30)
ds.lt <- subset(ds.df, V1 < 20)
ds.di <- subset(ds.df, V1 > 20 & V1 < 30)
ds.ma <- subset(ds.df, V1 > 30)

# Now we add a column denoting whether something is a digit
# If digit column is 1 then the row contains a digit else its a letter
ds.lt_di$digit <- 0
ds.lt_di$digit[ds.lt_di$V1 > 20] <- 1

# Finally lets shuffle the dataset and break it into folds
kfolds <- 7
ds.lt_di <- ds.lt_di[sample(nrow(ds.lt_di)),]
ds.lt_di$folds <- cut(seq(1,nrow(ds.lt_di)),breaks=kfolds,labels=FALSE)

# Logistic Regression Model fit
glm_part1_fit <-glm(digit ~ V18, data = ds.lt_di, family = 'binomial') 
glm_part2_fit <-glm(digit ~ V3 + V4 + V5 + V6 + V8 + V9 + V10 + V11, data = ds.lt_di, family = 'binomial') 

## First re run part 1's model with CV
k_accuracy_correct = c()
k_accuracy_incorrect = c()

for(i in 1:kfolds) {
  # Works the predicted value based on the model created
  ds.lt_di[["predicted_val"]] = predict(glm_part1_fit, ds.lt_di[ds.lt_di$folds == i,], type="response")
  
  # Zeroes out a predicted class field and then predicts based on a predicted value of 05
  ds.lt_di[["predicted_class"]] = 0
  ds.lt_di[["predicted_class"]][ds.lt_di[["predicted_val"]] > 0.5] = 1
  
  # Looks to see how many correct guesses there are
  correct_items = ds.lt_di[["predicted_class"]] == ds.lt_di[["digit"]] 
  
  # Works out the proportion correct
  proportion_correct <- nrow(ds.lt_di[correct_items,])/nrow(ds.lt_di)
  
  # Works out the proportion incorrect
  proportion_incorrect <- nrow(ds.lt_di[!correct_items,])/nrow(ds.lt_di)
  
  # Prints out the proportion for debugging
  print(proportion_correct)
  
  # Adds accuracy to a table for working out the mean accuracy
  k_accuracy_correct <- cbind(k_accuracy_correct, proportion_correct)
  k_accuracy_incorrect <- cbind(k_accuracy_incorrect, proportion_incorrect)
}

part1_correct = mean(k_accuracy_correct)
part1_incorrect = mean(k_accuracy_incorrect)

# Results table to plot
proportion <- c("correct", "incorrect")
values <- c(part1_correct, part1_incorrect)
results <- data.frame(proportion, values)

# Plot histogram of results
ggplot(results, aes(x = proportion, y = values)) + geom_bar(position = 'dodge', stat="identity") + geom_text(aes(label=values), position=position_dodge(width=0.9), vjust=-0.25)

# Change workspace to section_code and then saves plot
setwd(section_code.location)
ggsave("part1_accuracy_graph_cv.png")

setwd(training_set.location)

# Now lets re run part 2's fit
k_accuracy_correct = c()
k_accuracy_incorrect = c()

for(i in 1:kfolds) {
  # Works the predicted value based on the model created
  ds.lt_di[["predicted_val"]] = predict(glm_part2_fit, ds.lt_di[ds.lt_di$folds == i,], type="response")
  
  # Zeroes out a predicted class field and then predicts based on a predicted value of 05
  ds.lt_di[["predicted_class"]] = 0
  ds.lt_di[["predicted_class"]][ds.lt_di[["predicted_val"]] > 0.5] = 1
  
  # Looks to see how many correct guesses there are
  correct_items = ds.lt_di[["predicted_class"]] == ds.lt_di[["digit"]] 
  
  # Works out the proportion correct
  proportion_correct <- nrow(ds.lt_di[correct_items,])/nrow(ds.lt_di)
  
  # Works out the proportion incorrect
  proportion_incorrect <- nrow(ds.lt_di[!correct_items,])/nrow(ds.lt_di)
  
  # Prints out the proportion for debugging
  print(proportion_correct)
  
  # Adds accuracy to a table for working out the mean accuracy
  k_accuracy_correct <- cbind(k_accuracy_correct, proportion_correct)
  k_accuracy_incorrect <- cbind(k_accuracy_incorrect, proportion_incorrect)
}

part2_correct = mean(k_accuracy_correct)
part2_incorrect = mean(k_accuracy_incorrect)

# Results table to plot
proportion <- c("correct", "incorrect")
values <- c(part2_correct, part2_incorrect)
results <- data.frame(proportion, values)

# Plot histogram of results
ggplot(results, aes(x = proportion, y = values)) + geom_bar(position = 'dodge', stat="identity") + geom_text(aes(label=values), position=position_dodge(width=0.9), vjust=-0.25)

# Change workspace to section_code and then saves plot
setwd(section_code.location)
ggsave("part2_accuracy_graph_cv.png")
