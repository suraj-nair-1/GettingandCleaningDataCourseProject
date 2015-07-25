# Getting and Cleaning Data Course Project

## run_analysis.R

The primary function of the run_analysis.R file is to read in the messy data from the UCI HAR Dataset and create a clean dataset, as well as a new dataset containing the averages for each activity for each subject.  
The file will work properly as long as it is in the same working directory as the UCI HAR Dataset folder.

The file relies of the plyr and dplyr packages which are loaded into the program at the beginning of the file. 

A general outline of the program:
* Reads in data from the UCI HAR dataset
* Merges the training and test data into one data frame.
* Labels the columns with the appropriate names.
* Extracts only the columns pertaining to means or standard deviations
* Gives the activity column descriptive names
* Makes a new table that consists of the average of each mean or standard deviation measurment for each activity for each subject.
* Writes this new dataset to the file tidydata.txt