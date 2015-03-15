==========================================
Getting and Cleaning Data - Course Project
==========================================
## Version 1.0
(c) Wolfgang Brunauer

## Overall Remarks
This is the repository for the Getting and Cleaning Data course project, including code to generate the data and code book

## Scripts included in this repo
- Additionally to this file (`README.md`), a code book (`CodeBook.md`) is available that descirbes the original and derived data sets. 
- Furthermore, an R-script (`run_analysis.R`) is available that performs all data manipulation to obtain the "tidy" data set. This script can be run as long as the Samsung data is in the working directory. 

## Steps performed in the R-script `run_analysis.R`
### Preparation: 
Download and unzip the data for the course project

### Question 1) Merge the training and the test sets to create one data set.
- Load data from unzipped folder
- Create name vector for labelling features in the data set
- Reading in the data:
  - Step 1: Function for reading data and combining to one data set for each training and test data.
  - Step 2: Looping over both types (training and test data), appending to one data set. This data set is called `runLarge`.
  
### Question 2) Extract only the measurements on the mean and standard deviation for each measurement. 
- Extract measures on mean and std based on name list using regex matching (in R-function `grep`).
- The resulting data set is called `runSmall`.

### Question 3) Use descriptive activity names to name the activities in the data set.
- Read in `activity_labels.txt`.
- Using R-function `factor`, I apply `labels` on the `levels` as defined in the activity labels data. 

### Question 4) Appropriately label the data set with descriptive variable names.
- Based on the original names in `features_info.txt`, I construct more informative feature names.
- Details can be found in the code book available in this repo (`CodeBook.md`)`.

### Question 5) From the data set in step 4, create a second, independent tidy data set. 
This is done using the `ddplyr` package
- Step 1: group by `subject` and `activityLabel`
- Step 2: use the `summarise_each` function to calculate the `mean` over all remaining variables.