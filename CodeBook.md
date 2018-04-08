## Code Book

# Overview

An assortment of data collected from 30 volunteers participating in 6 different activities while utilizing their smartphones.

# Used Files

  * features.txt: a list of all 561 features
  * activity_labels.txt: the six different activities
  * X_test.txt: observations of 9 of the volunteers
  * X_train.txt: observations of 21 of the 30 volunteers
  * y_test.txt: integers denoting the ID for each activity observation in X_test.txt
  * y_train.txt: integers denoting the ID for each activity observation in X_train.txt
  * subject_test.txt: integers denoting the ID for each volunteer in X_test.txt
  * subject_train.txt: integers denoting the ID for each volunteer in X_train.txt
  
# Steps

  * Ensure "data.table" and "reshape2" are installed
  * If not already done, download and unzip the dataset
  * Each of the used files were read and assigned to variables of the same name
  * Removed all feature columns except those pertaining to "mean()" and "std()"
  * Converted the activity column to a factor and added labels
  * Combined everything into a tidy data set where every subject has a row for each activity containing the mean for every feature
  * Exported the new data set to "tidy_data.txt"
