set.seed(3060)

# Sets the location variables and the working directory
training_set.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/training_dataset"
test_set.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/test_dataset"
section_code.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342/section4_code"
output_file.location <- "/Users/thomaspickup/Documents/University/CSC3060/Assignments/Assignment2_40145342"

## Imports Traing Set
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

## Imports Test Set
setwd(test_set.location)

# Finds all the CSV files in that path with the suffix features.csv
test_set.files <- list.files(pattern="*features.csv")

# Goes through the list of files and imports the data into training_set.data
test_set.data <- list()
for (i in 1:length(test_set.files)) {
  test_set.data[[i]] <- read.csv(test_set.files[i], header=FALSE, sep=",")
}

# Calls RBind on training_set.data and creates one dataframe from the individual ones
test_set.dataframe <- do.call(rbind, test_set.data)


## Now to perform the statistical analysis
library(class)
library(Boruta)

# Uses the Boruta Algorithm to select the best features
training_set.classifier <- Boruta(V1~., data=na.omit(training_set.dataframe), doTrace=2)
training_set.selected <- names(training_set.classifier$finalDecision[training_set.classifier$finalDecision %in% c("Confirmed")]) 
print(training_set.selected)

# Gets the values of the rows of all the rows selected above for the training set
training_set.x <- cbind(training_set.dataframe$V3,training_set.dataframe$V4,training_set.dataframe$V5,training_set.dataframe$V6,training_set.dataframe$V7,training_set.dataframe$V8,training_set.dataframe$V9,training_set.dataframe$V10,training_set.dataframe$V11,training_set.dataframe$V12,training_set.dataframe$V13,training_set.dataframe$V14,training_set.dataframe$V15,training_set.dataframe$V16,training_set.dataframe$V17,training_set.dataframe$V18,training_set.dataframe$V19)

# Stores the rows not selected for the training set in the test set
test_set.x <- cbind(test_set.dataframe$V3,test_set.dataframe$V4,test_set.dataframe$V5,test_set.dataframe$V6,test_set.dataframe$V7,test_set.dataframe$V8,test_set.dataframe$V9,test_set.dataframe$V10,test_set.dataframe$V11,test_set.dataframe$V12,test_set.dataframe$V13,test_set.dataframe$V14,test_set.dataframe$V15,test_set.dataframe$V16,test_set.dataframe$V17,test_set.dataframe$V18,test_set.dataframe$V19)

# Gets the labels for the test and training sets
training_set.labels <- as.character(training_set.dataframe$V1)
test_set.index <- test_set.dataframe$V2

knn.pred <- knn(training_set.x,test_set.x,training_set.labels,k=7)
knn.df <- data.frame(knn.pred)
test_set.index <- formatC(test_set.index, width = 4, format = "d", flag = "0") 
predictions <- data.frame(cbind(test_set.index, knn.df))

setwd(output_file.location)
write.table(predictions, "40145342_section4_predictions.csv", sep = ",",  col.names = FALSE, row.names = FALSE)
