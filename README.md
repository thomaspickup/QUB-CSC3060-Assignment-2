# CSC3060: Assignment 2
This is the project repository for assignment 2 on the CSC3060 at Queen's University Belfast.  

## Project Brief
In this assignment, we will use the features you developed in Assignment 1 to solve classification problems. Specifically, you will fit classifiers to your image data, in order to build and evaluate useful models that can predict the class labels for unseen images. This assignment is to be completed individually.

With the exception of Section 4, this assignment must be completed in R. Section 4 can be completed in Python, Java or R. Convenient and commonly used machine learning packages are available for R and Python, such as “class”, “caret” and “randomForest” (in the case of R). When you use a procedure that has an element of randomness (e.g. creating cross-validation folds) please use the seed value 3060 (your code should give the same results each time it runs).

### Section 1
For this section, you will make use of the dataset you created for Assignment 1. Your feature file STUDENTNR_features.CSV, which was uploaded as part of your work on Assignment 1, is the starting point for this task. At a minimum, your “features” file should contain the non-custom features specified at the beginning of Assignment 1 (all students should at least have these features, if you do not then please contact the lecturer, quoting your student number).

#### Section 1.1
Using the feature with the most significant difference for the categories “digit” and “letters” in Assignment 1 Section 3.8, fit a logistic regression classifier using this feature to discriminate between “digits” and “letters”. (If you failed to find the best feature in Assignment 1 Section 3.8, you can guess a feature you think may be useful, justifying your choice). Fit your model using all the available data (i.e. do not split into training and test sets) and report the accuracy of this model over the data used in training.

#### Section 1.2
Using the first 8 features of your “features” file, fit a logistic regression classifier using these 8 features to discriminate between “digits” and “letters”. Fit your model using all the available data (i.e. do not split into training and test sets) and report the accuracy of this model over the data used in training.

#### Section 1.3
Using 7-fold cross-validation, repeat the logistic regressions of Sections 1.1 and 1.2, and report the cross-validated accuracy of the models. Give a brief discussion of the results for the four models, and in particular describe whether the accuracy estimates you have calculated will be valid for new items drawn from the same population as your training dataset.

#### Section 1.4
How do your model accuracies compare to a simple model that classifies everything in your dataset as “digit”? Do your models distinguish between the “digits” and “letters” categories for images not used in training significantly more accurately than a “random” model that randomly responds “letter” 50% of the time and “digit” 50% of the time? (Hint: consider the binomial distribution).

#### Section 1.5
Extend your 8-feature solution to 1.3 to investigate (a) how often each of 7 digits are incorrectly classified as “letter” and (b) how often each of the 7 letter symbols are incorrectly classified as “digit”. Are there any interesting patterns in this accuracy data? 

### Section 2
Larger sets of training and test symbol data have been created for you. You can download the data at the URL that was emailed to you. These data are for your use only and should not be shared with others (to use other people’s data will be considered collusion). These data are to be used in Sections 2, 3 & 4.

These data consist of:
* a dataset of 420 training items for each of the 21 symbols (8820 training items in total). The features are in the same format as Assignment 1. You can ignore the last three features (the custom features from Assignment 1), which have been set to 0. For each training instance there are three files:
    * the features of the image, as described in Assignment 1
    * the pixels of the image (which you can use to calculate additional custom features that you think may be useful for classification, if you wish).
    * a png image of the item (which may be useful for data cleaning).
* a dataset of 140 test items for each of the 21 symbols, in a random order (2940 test items in total). Note that the symbol labels have been set to “00” for these items – you do not have access to the correct label for these items! These test items are to be used for Section 4 below.

In this section, you are to perform classification with respect to the 21 symbol categories.

#### Section 2.1
Perform k-nearest-neighbour classification with k = {1,3,5,7,9,11,15,19,23,31} on the training set, using the first 10 features in the “*-features.csv” files (note that the first 2 columns are just the label and the index; the features start from the third column). Report the accuracy over the training set for each value of k (do not worry in this subsection about overfitting to the training data).

#### Section 2.2
Perform k-nearest-neighbour classification with k = {1,3,5,7,9,11,15,19,23,31} using 5-fold cross- validation, using the same 10 features as in 2.1. Report the cross-validated accuracy for each value of k. Create a figure similar to FIGURE 2.17 of the ISLR text book, showing the classification error rate over the training set and the cross-validated classification error rate for each value of 1/k. Briefly interpret the results of 2.1 and 2.2 with reference to your graph.

#### Section 2.3
Find out how often each symbol is confused for each other symbol, on the basis of your cross- validated results from Section 2.2 (using the value of k that gave the best overall cross-validated accuracy). Consider suitable ways of visualising the results. Report the pair of digits that are the most confusable in the dataset, on the basis of your cross-validation results (using the value of k that gave the best accuracy).

### Section 3
In this section, you are to perform classification with respect to the 21 symbol categories.

#### Section 3.1
Perform classification using bagging of decision trees using 5-fold cross-validation. Evaluate the resulting model using number of bags = {25, 50, 200, 400}. Report the accuracy of your model using both out-of-bag estimation and cross-validation. Briefly explain and interpret the results for this set of models.

#### Section 3.2
Perform classification with random forests using 5-fold cross-validation. Calculate multiple random forest solutions using number of trees between 25 and 400 (increments of 5) and number of predictors considered at each node = {2, 4, 6, 8}. Evaluate the models using cross-validation. Find the combination of tree-number and predictor-number giving the best cross-validated accuracy (this is called a “grid search” of the two hyper-parameters, number of trees and number of predictors). Briefly visualise, explain and interpret the results for this set of models.

### Section 4
Build a model that predicts the symbol for each of the test items. You can use any set of features you wish, explaining and justifying your choices. Your goal is to try to come up with the best final model you can for classifying symbols. If you created custom features or combinations of features that were useful for discriminating symbols in Assignment 1, you may wish to consider those again here. You are free to use any methods you like (clearly explaining and justifying your choices). You may wish to consider random forests and/or dimensionality reduction. Put your predictions in a file called STUDENTNR_section4_predictions.csv. The format of this file should be one item index followed by one symbol label per line, comma-delimited. Each line corresponds to the prediction you make for each of the 2940 test items (e.g. the first line might be “000,23”, indicating you predict label “11” for test item 000). The number of lines must match the number of test items, and the order of lines much match the indices for the test items. This section may be completed using R (recommended), Python or Java.

## Usage
### Folder Structure
```bash
├── 40145342_assignment2_report.pdf
├── 40145342_section4_predictions.txt
├── section1_code
|   ├──
|   └──
├── section2_code
|   ├── 
|   └──
├── section3_code
|   ├──
|   └──
├── section4_code
|   ├── 
|   └──
└── training_dataset
```

## ToDo

## Notes
