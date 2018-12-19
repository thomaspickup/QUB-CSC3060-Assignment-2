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
