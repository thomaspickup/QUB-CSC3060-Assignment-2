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

# Sets the amount of folds and then splits the dataset into that amount
kfoldsk = 5
training_set.dataframe <- training_set.dataframe[sample(nrow(training_set.dataframe)),]
training_set.dataframe$folds <- cut(seq(1,nrow(training_set.dataframe)),breaks=kfoldsk,labels=FALSE)

# Imports the classes needed for classification and plotting
library(ipred)
library(ggplot2)

# Sets list of bags to use
nbag = c(25, 50, 200, 400)
accuracies = c()

# Goes through each value of list of bags
for (n in nbag) {
  k_accuracies = c()
  
  for(i in 1:kfoldsk) {
    # Splits the dataset into test and training based on fold
    training_set.this_fold  = training_set.dataframe[training_set.dataframe$folds != i,] 
    test_set.this_fold = training_set.dataframe[training_set.dataframe$folds == i,] 
    
    # Trains tree and then fits ß
    training_set.tree <- bagging(as.factor(V1)~., training_set.this_fold, nbagg=n, coob=TRUE)
    test_set.prediction <- predict(training_set.tree, test_set.this_fold)
    
    # Works out ammount of correct predictions
    test_set.prediction == test_set.this_fold$V1
    nr_correct = nrow(test_set.this_fold[correct_list,])
    
    # Works out accuracy rate
    this_acc_rate = nr_correct/nrow(test_set.this_fold)
    
    # Adds to list for this number of bags
    k_accuracies <- cbind(k_accuracies, this_acc_rate)
  }
  
  # Adds the mean for this amount of bags to the total accuracy rate
  accuracies = cbind(accuracies, mean(k_accuracies))
  
  # DEBUG - Prints Progress
  print(paste(n ,"/" ,mean(k_accuracies)))
}

# Plots accuracy graph
accuracies.dataframe = as.data.frame(t(accuracies))
accuracies.dataframe = cbind(nbag, accuracies.dataframe)
ggplot(accuracies.dataframe, aes(x=nbag, y=V1)) + geom_bar(stat = "identity")
setwd(section_code.location)
ggsave("part1_accuracy_graph.png")
