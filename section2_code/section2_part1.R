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

# Makes a training set of indexes lower than 6
training_set <- (training_set.dataframe$V2<6)

# Gets the values of the rows of all the rows selected above for the training set
training_set.x <- cbind(training_set.dataframe$V3,training_set.dataframe$V4,training_set.dataframe$V5,training_set.dataframe$V6,training_set.dataframe$V7,training_set.dataframe$V8,training_set.dataframe$V9,training_set.dataframe$V10,training_set.dataframe$V11,training_set.dataframe$V12)[training_set,]

# Stores the rows not selected for the training set in the test set
test_set.x <- cbind(training_set.dataframe$V3,training_set.dataframe$V4,training_set.dataframe$V5,training_set.dataframe$V6,training_set.dataframe$V7,training_set.dataframe$V8,training_set.dataframe$V9,training_set.dataframe$V10,training_set.dataframe$V11,training_set.dataframe$V12)[!training_set,]

# Gets the labels for the test and training sets
training_set.labels <- training_set.dataframe$V1[training_set]
test_set.labels <- training_set.dataframe$V1[!training_set]

# Stores the values of K to test and creates a blank list for the accuracies
ks = c(1,3,5,7,9,11,15,19,23,31)
accuracies = c()

# Runs the KNN algorithm for all values of K above and stores the accuracy of each value of K
for (k in ks){
  knn.pred=knn(training_set.x,test_set.x,training_set.labels,k=k)
  table(knn.pred,test_set.labels)
  accuracies = cbind(accuracies, mean(knn.pred==test_set.labels))
}

# Plots as a bar chart
accuracies.dataframe = as.data.frame(t(accuracies))
accuracies.dataframe = cbind(accuracies.dataframe, ks)
ggplot(accuracies.dataframe, aes(x=ks, y=V1)) + geom_bar(stat = "identity")
setwd(section_code.location)
ggsave("part1_accuracy_graph.png")
