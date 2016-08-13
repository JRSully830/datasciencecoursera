## Run_Analysis.R Data Cleaning Class Project
## Load files into R
    setwd("~/R")
    
    test <- read.table("Hardata\\UCI HAR Dataset\\test\\X_test.txt")
    train <- read.table("Hardata\\UCI HAR Dataset\\train\\X_train.txt")
    
    trainlbls <- read.table("Hardata\\UCI HAR Dataset\\train\\Y_train.txt")
    testlbls <- read.table("Hardata\\UCI HAR Dataset\\test\\Y_test.txt")
    trainsubs <-  read.table("Hardata\\UCI HAR Dataset\\train\\subject_train.txt")
    testsubs <-  read.table("Hardata\\UCI HAR Dataset\\test\\subject_test.txt")
    features <- read.table("Hardata\\UCI HAR Dataset\\features.txt") 
    activs <- read.table("Hardata\\UCI HAR Dataset\\activity_labels.txt") 
    
## Add row number to variable name to eliminate duplicate labels 
    features$V2 <- paste(features$V2,features$V1,sep="_")
    
## Assign feature names to columns
    colnames(train) <- features[,2]
    colnames(test) <- features[,2]
    
    library(dplyr);library(plyr)
    activs<- plyr::rename(activs,replace=c("V2"="activity"))
    trainsubs <- plyr::rename(trainsubs,replace=c("V1"="subjectnum"))
    testsubs <- plyr::rename(testsubs,replace=c("V1"="subjectnum"))
    
## Map activity descriptions to Activity IDs
    trainlbls <- inner_join(trainlbls,activs,by="V1")
    testlbls <- inner_join(testlbls,activs,by="V1")

## merge files    
    train <- cbind(train,trainlbls,trainsubs)
    test <- cbind(test,testlbls,testsubs)
    
    mergedDF <- rbind(train,test)
    mergedDF$V1 <- NULL
    
## Create First DataFrame of Measure Means and StdDevs only
    meanStdDev <- select(mergedDF,contains("mean()"), contains("std()"),
                         activity,subjectnum)
    
## Create Second DataFrame of Measure means grouped by Subject and Activity
    meanGroupBy<-aggregate(meanStdDev[,1:66], list(meanStdDev$subjectnum,
                                       meanStdDev$activity), mean,na.rm=TRUE)
    
    meanGroupBy <- plyr::rename(meanGroupBy,replace=c("Group.1"="subjectnum",
                                                      "Group.2"="activity"))

## write final output to text file    
    write.table(meanGroupBy,"meanGroupByJRS.txt",row.name=FALSE)
   
    