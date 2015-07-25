# Getting and Cleaning Data Course Project

## run_analysis.R

The primary function of the run_analysis.R file is to read in the messy data from the UCI HAR Dataset and create a clean dataset, as well as a new dataset containing the averages for each activity for each subject.  
The file will work properly as long as it is in the same working directory as the UCI HAR Dataset folder. 
The file relies of the plyr and dplyr packages which are loaded into the program at the beginning of the file. 