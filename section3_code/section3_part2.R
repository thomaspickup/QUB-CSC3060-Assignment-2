set.seed(3060)

# Sets the location variables and the working directory
training_set.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/training_dataset"
section_code.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/section3_code"
setwd(training_set.location)

# Finds all the CSV files in that path with the suffix features.csv
training_set.files <- list.files(pattern="*features.csv")

# Goes through the list of files and imports the data into training_set.data
training_set.data <- list()
for (i in 1:length(training_set.files)) {
  training_set.data[[i]] <- read.csv(training_set.files[i], header=FALSE, sep=",")
}

# Calls RBind on training_set.data and creates one dataframe from the individual ones
training_set.dataframe <- do.call(rbind, training_set.data)

# Sets amount of folds and splits
kfoldsk = 5
training_set.dataframe <- training_set.dataframe[sample(nrow(training_set.dataframe)),]
training_set.dataframe$folds <- cut(seq(1,nrow(training_set.dataframe)),breaks=kfoldsk,labels=FALSE)

# Imports
library(randomForest)
library(dplyr)
library(ggplot2)

# Sets up lists
pred_list = c(2, 4, 6, 8)
accuracies = c()
predicators = c()
trees = c()

for (t in seq(25,400,5)) {
  for (p in pred_list) {
    k_accuracies = c()
    
    for(i in 1:kfoldsk) {
      training_set.this_fold  = training_set.dataframe[training_set.dataframe$folds != i,] 
      test_set.this_fold = training_set.dataframe[training_set.dataframe$folds == i,] 
      
      # Fits random forest
      model <- randomForest(as.factor(V1)~., data=training_set.this_fold, mtry=p, ntree=t)
      predictions <- predict(model, test_set.this_fold, type = "class")

      correct_list = predictions == test_set.this_fold$V1
      nr_correct = nrow(test_set.this_fold[correct_list,])
      
      this_acc_rate = nr_correct/nrow(test_set.this_fold)
      
      k_accuracies <- cbind(k_accuracies, this_acc_rate)
    }
    print(paste("Completed:", t, p, sep = " "))
    trees = cbind(trees, t)
    predicators = cbind(predicators, p)
    accuracies = cbind(accuracies, mean(k_accuracies))
  }
}

# Plots Graph
results = cbind(t(predicators), t(trees), t(accuracies))
final_data = data.frame(results)
final_data <- final_data %>% arrange(desc(X3))
print(paste("Optimal Value of Predicators / Trees:",final_data$X1[1],"/", final_data$X2[1]))
prediction_plot <- ggplot(final_data, aes(X1, X2, fill = X3)) + geom_raster(hjust = 0, vjust = 0)
setwd(section_code.location)
ggsave("part2_accuracy_graph.png")
