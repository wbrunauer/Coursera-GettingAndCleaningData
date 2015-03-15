==================================================================
Codebook - Getting and Cleaning Data Project, Coursera
==================================================================
## Version 1.0
(c) Wolfgang Brunauer

## Source
This code book builds on the information provided on [this site] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by the [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html). The data can be downloaded via [this link:](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Study Design
The description of the study design provided here is a short version of the README.txt file provided in the [original dataset] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
- The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
- The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows.
- The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
- From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Each feature vector is a row on the text file.

###The original dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

### Additional Files
The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Variable Description
### Original feature labels
The original feature labels are constituted as follows (suqared brackets do not appear in the labels):
[Prefix][Body: first part][Body: second part (optional)][Body: third part (optional)]-[Suffix: first part]-[Suffix: second part (optional)]

- Prefix: 
  - 't' (for time) 
  - 'f' (for frequency domain signals)
- Body: first part 
  - BodyAcc: BodyAcceleration
  - GravityAcc: GravityAcceleration   
  - BodyGyro: GravityAcceleration
- Body: second part (optional) 
  - Jerk: Jerk Signal              
- Body: third part (optional - with or without second part)
  - Mag: Magnitude
- Suffix: first part, describing the functions applied on the signals. These are:
  - mean(): Mean value
  - std(): Standard deviation
  - mad(): Median absolute deviation 
  - max(): Largest value in array
  - min(): Smallest value in array
  - sma(): Signal magnitude area
  - energy(): Energy measure. Sum of the squares divided by the number of values. 
  - iqr(): Interquartile range 
  - entropy(): Signal entropy
  - arCoeff(): Autorregresion coefficients with Burg order equal to 4
  - correlation(): correlation coefficient between two signals
  - maxInds(): index of the frequency component with largest magnitude
  - meanFreq(): Weighted average of the frequency components to obtain a mean frequency
  - skewness(): skewness of the frequency domain signal 
  - kurtosis(): kurtosis of the frequency domain signal 
  - bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
  - angle(): Angle between to vectors. 
- Suffix: second part (optional), describing 3-axial signals in the X, Y and Z directions 

For example, feature 'tBodyGyroJerkMag-mean()' consists of prefix 't', Body(1) 'BodyGyro', Body(2) 'Jerk', Body (3) <NA>, Suffix(1) 'mean()', Suffix(2) <NA>

Note that there is an obvious mistake in labelling, where "Body" appears twice, e.g. in 'fBodyBodyAccJerkMag-mean()'.

### Transformed feature labels for tidy data
In order to increase readability, the feature labels were transformed and permuted (the function applied was put to the front). Special characters are removed. 
- Prefix (1): The function applied on the signals (corresponds to suffix(1) above); brackets are removed.
- Prefix (2): 
  - 'Time' (for time) 
  - 'FrequencyDomainSignals' (for frequency domain signals)
- Body (1), (2) and (3): "written out" to be self-explanatory, resulting in:
  - 'BodyAcceleration'
  - 'GravityAcceleration'   
  - 'AngularVelocity'
  - 'JerkSignal'              
  - 'Magnitude'
- Suffix: directions:
  - 'dirX'
  - 'dirY'
  - 'dirZ'

For the example above, this results in Prefix (1) 'mean', Prefix (2) 'Time', Body(1) 'AngularVelocity', Body(2) 'JerkSignal', Body (3) <NA>, Suffix <NA>, i.e.: meanTimeBodyAngularVelocityJerkSignal

### ID variables
The measurements are identified by two ID variables:
- subject: one of 30 volunteers, range 1,...,30.
- activityLabel: one of 5 activities
  - 1 WALKING
  - 2 WALKING_UPSTAIRS
  - 3 WALKING_DOWNSTAIRS
  - 4 SITTING
  - 5 STANDING
  - 6 LAYING

### Meaurement units:
Features are normalized and bounded within [-1,1].

## Tidy Data Set
- The tidy data set is derived from the above described data as a subset of features, where only measurements on 'mean' and 'std' are taken. 
- The data is aggregated using grouping on activity within subject (resulting in 30 times 6 = 180 rows).

## Acknowledgement
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
