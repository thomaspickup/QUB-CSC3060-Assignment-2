set.seed(3060)

# Sets the location variables and the working directory
training_set.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/training_dataset"
section_code.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/section2_code"
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

# Imports the classes needed for classification and plotting
library(class)
library(ggplot2)

kfoldsk <- 5
training_set.dataframe <- training_set.dataframe[sample(nrow(training_set.dataframe)),]

training_set.dataframe$folds <- cut(seq(1,nrow(training_set.dataframe)),breaks=kfoldsk,labels=FALSE)

fs = c("V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")

ks = c(1,3,5,7,9,11,15,19,23,31)
accuracies = c()

for (knnk in ks) {
  k_accuracies = c()
  
  for(i in 1:kfoldsk) {
    training_set.this_fold  = training_set.dataframe[training_set.dataframe$folds != i,] 
    test_set.this_fold = training_set.dataframe[training_set.dataframe$folds == i,] 
    
    # fit knn model on this fold
    knn.pred = knn(training_set.this_fold[,fs], test_set.this_fold[,fs], training_set.this_fold$V1, k=knnk)
    
    correct_list = knn.pred == test_set.this_fold$V1
    nr_correct = nrow(test_set.this_fold[correct_list,])
    
    this_acc_rate = nr_correct/nrow(test_set.this_fold)
    
    k_accuracies <- cbind(k_accuracies, this_acc_rate)
  }
  
  accuracies = cbind(accuracies, mean(k_accuracies))
}

accuracies = t(accuracies)
accuracies = cbind(accuracies, ks)

# Plots as a bar chart
accuracies.dataframe = as.data.frame(accuracies)
ggplot(accuracies.dataframe, aes(x=ks, y=V1)) + geom_bar(stat = "identity")
setwd(section_code.location)
ggsave("part2_accuracy_graph.png")
