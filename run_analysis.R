#Prerequisites:
#1. Set the working directory to folder containing this R script.
#2. Add the unzipped raw dataset to the current working directory

#Load dplyr and tidyr packages
library(dplyr)
library(tidyr)

#Read the files. 
activity_labels<-read.csv("UCI HAR Dataset/activity_labels.txt",header=FALSE,sep ="",col.names = c("item","activity"))
features<-read.csv("UCI HAR Dataset/features.txt",header=FALSE,sep ="",col.names = c("item","feature"))
subject_test<-read.csv("UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep ="",col.names = c("subject_no"))
X_test<-read.csv("UCI HAR Dataset/test/X_test.txt",header=FALSE,sep ="")
y_test<-read.csv("UCI HAR Dataset/test/y_test.txt",header=FALSE,sep ="",col.names = c("activity"))
subject_train<-read.csv("UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep ="",col.names = c("subject_no"))
X_train<-read.csv("UCI HAR Dataset/train/X_train.txt",header=FALSE,sep ="")
y_train<-read.csv("UCI HAR Dataset/train/y_train.txt",header=FALSE,sep ="",col.names = c("activity"))

#Add appropriate column labels on X test/train.
colnames(X_test)<-features$feature
colnames(X_train)<-features$feature

#Get only data on mean and stdev, the first 6 columns
X_test<-X_test[,c(1:6)] 
X_train<-X_train[,c(1:6)] 

#Add column on subject# and activity
X_test <-X_test %>%
    mutate(subject=subject_test$subject_no) %>%
    mutate(activity=y_test$activity)

X_train <- X_train%>%
    mutate(subject=subject_train$subject_no) %>%
    mutate(activity=y_train$activity)

#Merge the 2 datasets
merged_data<-bind_rows(X_test,X_train)

#Reoder data columns
merged_data<-select(merged_data, c(7:8,1:6))

#Group data and measure mean
measurements <- merged_data %>%
    group_by(activity,subject) %>%
    summarize(mean_X = mean(`tBodyAcc-mean()-X`),
            mean_Y = mean(`tBodyAcc-mean()-Y`),
            mean_Z = mean(`tBodyAcc-mean()-Z`),
            std_X = mean(`tBodyAcc-std()-X`),
            std_Y = mean(`tBodyAcc-std()-Y`),
            std_Z = mean(`tBodyAcc-std()-Z`)
    )

write.table(measurements, file = "output_data.txt",row.name=FALSE,sep = ",")