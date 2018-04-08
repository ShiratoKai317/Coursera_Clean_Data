## Download and compile UCI Data

# Check and install "data.table" if needed
if (!require("data.table")) {
  install.packages("data.table")
}

# Check and install "reshape2" if needed
if (!require("reshape2")) {
  install.packages("reshape2")
}

# Load the "data.table" and "reshape2" packages
require("data.table")
require("reshape2")

# Set strings to track relevant download information
zipfile <- "UCIdata.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# Checks to see if the dataset is downloaded already
if (!file.exists(zipfile)) {
  download.file(url, zipfile, mode = "wb")
}

# Unzip the dataset if it hasn't been yet
if (!file.exists(dir)) {
  unzip("UCIdata.zip", files = NULL, exdir = ".")
}

# Read the various datasets
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("UCI HAR Dataset/features.txt")[,2]
names(x_train) = features
names(x_test) = features

# Extract only the means and standard deviations
meanSTD <- grepl("mean|std", features)
x_test = x_test[, meanSTD]
x_train = x_train[,meanSTD]

# Add the activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, x_test)
train_data <- cbind(as.data.table(subject_train), y_train, x_train)

# Merge data
data = rbind(test_data, train_data)
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)

# Melt the data and write the tidy data to "tidy_data.txt"
melt_data = melt(data, id = id_labels, measure.vars = data_labels)
tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt")
