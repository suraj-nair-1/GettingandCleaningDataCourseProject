#Loads appropriate Libraries
library(plyr)
library(dplyr)

#Step 1: Reads in an merges the subject, x, and y data for both the test and train folders
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject_train, subject_test)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x <- rbind(x_train, x_test)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y <- rbind(y_train, y_test)

#Creates a variable which represents which dataset the observation is from
length_test <- nrow(y_test)
length_train <- nrow(y_train)
status <- c(rep("train", length_train), rep("test", length_test))

#Binds all the data into one dataset
data <- cbind(subject, y, status, x)

#Step 4: Sets the column names for each column
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
ft <- features$V2
names <- c("subject", "activity", "status", ft)
names(data) <- names

#Removes duplicate columns
d <- data[, !duplicated(colnames(data))]

#Step 2: Extracts only the data for the mean and std of each measurmnet
g <- c(grep("subject|activity|status", names(d)), 
       grep("mean()", names(d), fixed = TRUE),
       grep("std()", names(d), fixed = TRUE)
)
dt <- select(d, g)

#Step 3: Uses the descriptive names for each activity
ac <- read.table("UCI HAR Dataset/activity_labels.txt")
ac_names <- ac$V2
dt <- mutate(dt, activity = ac_names[activity])

#Step 5: Creates a new data set with only the averages for the selected measurments
sbj <- rep(1:30, 6)
act <- rep(c(6, 4, 5, 1, 3, 2), each = 30)
avg <- data.frame(cbind(sbj, act))

#For each measurment, computes the average for the each activity for each subject
#and adds it to the table
for(i in 4:length(names(dt))){
    x <- c(tapply(as.numeric(dt[[i]]), list(as.factor(dt$subject), dt$activity),mean))
    avg <- cbind(avg, x)
    names(avg)[i - 1] <- names(dt)[i]
}

# Gives activities proper names and arranges the table by subject
avg <- mutate(avg, act = ac_names[act])
avg <- arrange(avg, sbj)

#Writes table to file
write.table(avg, file = "tidydata.txt", row.names = FALSE)

