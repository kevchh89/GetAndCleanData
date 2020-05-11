# GetAndCleanData

### --------------------------Function----------------------###
### This function is used to arrange the tables into a tidy format
### It uses a loop to split the strings (strsplit) on each then turns the values into numeric vectors and removes any missing value that could be present in the file, and finally it binds all the rows into a unique matrix
arrange<-function(y,x=NULL){
  for (i in 1:length(y[,1])) {
    if(!exists('x')){
      x<-NULL
    }else{
      m<-strsplit(y[i,]," ")
      m<-as.numeric(unlist(m))
      m<-m[which(!is.na(m))]
      x<-rbind(x,m) 
    }
  }
  x<<-x
}
### --------------------------------------------------------###


### -----------------------Open files----------------------- ###

### This section includes the functions to open all the files to process the data. Each of them are oppened in a particular class to in order to appropiatelly filter arrange, filter and summarise the data.
features<-read.table('features.txt',header=F,colClasses = 'character')
X_test<-read.csv("X_test.txt",header=F,colClasses = "character")
y_test<-read.csv("y_test.txt",header=F,colClasses = "factor")
subject_test<-read.csv("subject_test.txt",header=F,colClasses = "factor")
X_train<-read.csv("X_train.txt",header=F,colClasses = "character")
y_train<-read.csv("y_train.txt",header=F,colClasses = "factor")
subject_train<-read.csv("subject_train.txt",header=F,colClasses = "factor")
activity_labels<-read.delim("activity_labels.txt",header=F,colClasses = "character",sep=' ')
### -------------------------------------------------------- ###

#### -----------------------Test----------------------------###
#### This section arranges the "test" dataset by using the arrange function and then binding the columns with the respective data about the subjects and the activity measured 
arrange(X_test)
testbind<-cbind(y_test,subject_test,x)
colnames(testbind)<-c('Activity','Subject',features[,2])
row.names(testbind)<-NULL
#### ------------------------------------------------------###

#### ----------------------Train-----------------------------###
#### This section arranges the "train" dataset by using the arrange function and then binding the columns with the respective data about the subjects and the activity measured 
arrange(X_train)
trainbind<-cbind(y_train,subject_train,x)
colnames(trainbind)<-c('Activity','Subject',features[,2])
row.names(trainbind)<-NULL
### -----------------------------------------------------------###

### -----------------------Merge-------------------------------###
### This function merges both tables created into a single one, using the rbind function
tbmerge<-rbind(testbind,trainbind)
### ------------------------------------------------------------###

### -------------Mean and stdev-----------####
### Here we search for de colums that have 'mean' and 'std' in their names and merge them into a single table 
cols<-sort(c(grep('std',colnames(testbind)),grep('mean',colnames(testbind)),grep('Activity',colnames(testbind)),grep('Subject',colnames(testbind))))
tbfiltered<-tbmerge[,cols]
### --------------------------------------####


### ---------------Descriptive activity names----------####
### With this function we are able to replace the numbers of the activity with their respective label
levels(tbfiltered[,1])<-activity_labels[,2]
### ---------------------------------------------------####
### ------------Mean by group--------------------------####
### By using the dplyr package we can grop the data by the columns 'Activity' and 'Subject' and summarise their means. Finally we write the table in a text file.
library(dplyr)
tbmeans<-tbfiltered %>%
  group_by(Activity,Subject) %>%
  summarise_all(funs(mean(., na.rm=TRUE)))
write.table(tbmeans,'TableStep5.txt',row.names = F)
### ---------------------------------------------------####

