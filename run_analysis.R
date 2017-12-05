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

#Get only data on mean and stdev
mean_std_indices<-grep("mean|std",features$feature)
X_test<-X_test[,mean_std_indices] 
X_train<-X_train[,mean_std_indices] 

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
col_len<-length(colnames(merged_data))
merged_data<-select(merged_data, c((col_len-1):col_len,1:(col_len-2)))

#Group data and measure mean
measurements <- merged_data %>%
    group_by(activity,subject) %>%
    summarise_all(.funs=mean)

#Write output file on current working directory
write.table(measurements, file = "output_data.txt",row.name=FALSE,sep = ",")