
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

# Create one data set from trining and test sets 

require(dplyr)

################################
# Add training data ############
################################

#Read table of names
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#Read table - id_subject
id_subject <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
names(id_subject) <- "id_subject"

#Read table - id_activity
activity <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
names(activity) <- "activity"

#Read table - data
data <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
names(data) <- make.unique(as.character(features$V2))

# Create data.frame
dirtyDatabase <- data.frame(c(id_subject, activity, data))

# Add activites by id & organize
activities <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
dirtyDatabase <- merge(dirtyDatabase, activities, by.x="activity", by.y="V1", all = TRUE)
dirtyDatabase <- mutate(dirtyDatabase, activity = V2)
dirtyDatabase <- mutate(dirtyDatabase, dataSource = "train")
dirtyDatabase <- arrange(dirtyDatabase, id_subject, activity)

#Only mean & std
tidyDatabase1 <- select(dirtyDatabase, contains("id_subject"), contains("activity"), contains("dataSource"), contains("mean"), contains("std"))


################################
# Add test data ################
################################

#Read table - id_subject
id_subject <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
names(id_subject) <- "id_subject"

#Read table - id_activity
activity <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
names(activity) <- "activity"

#Read table - data
data <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
names(data) <- make.unique(as.character(features$V2))

# Create data.frame
dirtyDatabase <- data.frame(c(id_subject, activity, data))

# Add activites by id & organize
activities <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
dirtyDatabase <- merge(dirtyDatabase, activities, by.x="activity", by.y="V1", all = TRUE)
dirtyDatabase <- mutate(dirtyDatabase, activity = V2)
dirtyDatabase <- mutate(dirtyDatabase, dataSource = "test")
dirtyDatabase <- arrange(dirtyDatabase, id_subject, activity)

#Only mean & std
tidyDatabase2 <- select(dirtyDatabase, contains("id_subject"), contains("activity"), contains("dataSource"), contains("mean"), contains("std"))


# Combine 2 datasets
tidyDatabase <- rbind(tidyDatabase1, tidyDatabase2)

rm(activities, activity, data, features, id_subject, dirtyDatabase, tidyDatabase1, tidyDatabase2)




# We need to dig deeper!

grupping <- group_by(tidyDatabase, id_subject, activity)

myCoolDataset <- summarise_each(grupping, funs(mean))

write.table(x = myCoolDataset, file = "dataset.txt", row.names = FALSE)
