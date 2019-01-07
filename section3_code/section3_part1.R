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

model <- glm(V1 ~ V3 + V4 + V5,family=binomial(link='logit'),data=training_set.dataframe)
?glm
# Imports the classes needed for classification and plotting
library(tree)

training_set.tree <- tree(as.factor(V1)~., training_set.dataframe)

plot(training_set.tree)
text(training_set.tree, pretty =0)

training_set.train = sample(1: nrow(training_set.dataframe), 200)
training_set.test = training_set.dataframe[-training_set.train,]

training_set.tree = tree(as.factor(V1)~.,training_set.dataframe, subset = training_set.train)
training_set.pred = predict(training_set.tree, training_set.test, type = "class")
training_set.test.labels <- training_set.dataframe$V1[-training_set.train]

mean(training_set.pred == training_set.test.labels)

training_set.tree.cv = cv.tree(training_set.tree, FUN = prune.misclass)
plot(training_set.tree.cv)
text(training_set.tree.cv, pretty =0)
