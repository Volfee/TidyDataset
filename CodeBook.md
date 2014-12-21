Code Book
==========

Dataset information
-------------------

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Dataset modification
--------------------

In order to provide clean and easy-to-use dataset from raw data, the Samsung original dat had to be combined. For this reason I combined the test_subject, performed activity, and technical data (+ data headers) into one dataset. Then the techinical data headers were renamed in order to avoid doubled names. The columns were filtered just ot present mean and std. deviations of records. For activity there was id provided that had to be combined with activity dictionary. Id was replaced with regular activity names. The test and training data sets was combined and each record recieved information from which data set it comes form (column - dataSource). Data, then, was sorted according to subject and then activity.

Finally data are grouped by activity and subject and means are calculated for groups.

Final dataset variables description
-----------------------------------
id_subject - id of the test subject

activity - name of activity performed

dataSource - indicates whether the record comes from training or test dataset

technicalVariables (rest of variables) - values for technical variables
