#############################################
## Getting and Cleaning Data Course Project##
#############################################

## Overall description
# In this code, the following steps are performed:

# Preparation: Download and unzip the data for the course project
# Question 1) Merge the training and the test sets to create one data set.
# Question 2) Extract only the measurements on the mean and standard deviation for each measurement. 
# Question 3) Use descriptive activity names to name the activities in the data set.
# Question 4) Appropriately label the data set with descriptive variable names.
# Question 5) From the data set in step 4, create a second, independent tidy data set. 

# The dataset from question 5) is written to a text file and uploaded for grading.

#############################################
## Preparation: Download and unzip the data for the course project
#############################################
## Load packages, set wd
# dplyr for question 5
library(dplyr)

# # Create and set working directory 
# if (!file.exists("C:/R/work/course_3/project")) {
#         dir.create("C:/R/work/course_3/project")
# }
# setwd("C:/R/work/course_3/project")

#############################################
## Downloading data from the web, unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./rundata.zip") #,method="curl"

fileConn<-file("date_download.txt")
writeLines(date(), fileConn)
close(fileConn)

# Unzip data to working directory
unzip("rundata.zip", exdir = ".")
#file.remove("rundata.zip")

list.files(".")

#############################################
## Question 1) Merges the training and the test sets to create one data set.
#############################################
# Load data
path <- "UCI HAR Dataset"
type <- c("train","test")
nam <- c("subject","y","X")

# create name vector for data set
features <- read.table(file.path(".", path, "features.txt"),sep="",header=F,stringsAsFactors=F)
feature_names <- c("subject","activityLabel",features[,2])

# Create list including two elements: 
# training and test data, each with files combined to one data frame
# Step 1: Function for reading data and combining to data set
readBindData <- function(nam,type) {
        dat <- list()
        for (j in nam) {
                get <- file.path(".", path, i, paste(j, "_", i, ".txt",sep=""))
                dat[[j]] <- read.table(get, sep="", header=F)
        }       
        datFlat <- do.call("cbind",dat)
        return(datFlat)
}

# Step 2: Looping over both types (training and test), appending
rundata <- list()
for (i in type) {
        rundata[[i]] <- readBindData(nam=nam,type=i)
        names(rundata[[i]]) <- feature_names
        rundata[[i]]$type <- i
}
runLarge <- do.call("rbind",rundata)

#############################################
## Question 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#############################################
# Extract measures on mean and std based on name list using regex matching
toMatch <- c("mean\\(","std\\()")
feature_names_short <- c(feature_names[1:2],grep(paste(toMatch,collapse="|"),feature_names,value=T))
# Apply reduced name list to obtain small data set
runSmall <- runLarge[,feature_names_short]

#############################################
## Question 3) Uses descriptive activity names to name the activities in the data set.
#############################################
# Reading activity labels
get <- file.path(".", path, "activity_labels.txt")
activityLabels <- read.table(get, sep="", header=F, stringsAsFactor=F)

# Create factor using activity labels
runLabel <- runSmall
runLabel$activityLabel <- factor(runLabel$activityLabel,
                                  levels=activityLabels[,1],labels=activityLabels[,2])

#############################################
## Question 4) Appropriately labels the data set with descriptive variable names.
#############################################
# Take names from features_info.txt:
feature_names_informative <- feature_names_short
# prefix 't': Time
feature_names_informative <- sub("^t","Time",feature_names_informative)
# prefix 'f': FrequencyDomainSignals
feature_names_informative <- sub("^f","FrequencyDomainSignals",feature_names_informative)
# BodyAcc: BodyAcceleration
feature_names_informative <- sub("BodyAcc","BodyAcceleration",feature_names_informative)
# GravityAcc: GravityAcceleration
feature_names_informative <- sub("GravityAcc","GravityAcceleration",feature_names_informative)
# BodyGyro: AngularVelocity
feature_names_informative <- sub("BodyGyro","AngularVelocity",feature_names_informative)
# Jerk: JerkSignal
feature_names_informative <- sub("Jerk","JerkSignal",feature_names_informative)
# Mag: Magnitude
feature_names_informative <- sub("Mag","Magnitude",feature_names_informative)
# '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions: dirX, dirY, dirZ
feature_names_informative <- sub("\\-X","DirX",feature_names_informative)
feature_names_informative <- sub("\\-Y","DirY",feature_names_informative)
feature_names_informative <- sub("\\-Z","DirZ",feature_names_informative)
# mean() and sd(): put to the front
feature_names_informative[grep("mean\\(",feature_names_informative)] <- 
        paste0("mean",feature_names_informative[grep("mean\\(",feature_names_informative)])
feature_names_informative[grep("std\\(",feature_names_informative)] <- 
        paste0("std",feature_names_informative[grep("std\\(",feature_names_informative)])
# remove mean() and std()
feature_names_informative <- gsub(paste("\\-mean\\(\\)","\\-std\\(\\)",sep="|"),"",feature_names_informative)
# Obviously a copy-paste error in the original names: BodyBody, e.g. fBodyBodyAccJerkMag
feature_names_informative <- gsub("BodyBody","Body",feature_names_informative)

# Apply new names
names(runLabel) <- feature_names_informative

#############################################
## Question 5) From the data set in step 4, creates a second, independent tidy data set 
#############################################
# with the average of each variable for each activity and each subject.

# Use the dplyr package
# Step 1: group by subject and activity label
# Step 2: use the summarise_each function
runMeans <- runLabel %>% 
                group_by(subject,activityLabel) %>% 
                        summarise_each(funs(mean))


#############################################
## Write dataset from question 5) to text file
#############################################
write.table(runMeans,file="./tidy.txt",row.name=FALSE)

