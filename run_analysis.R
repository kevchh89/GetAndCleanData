
###--------------------------Function----------------------###
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
###--------------------------------------------------------###

###-----------------------Open files-----------------------###
features<-read.table('features.txt',header=F,colClasses = 'character')
X_test<-read.csv("X_test.txt",header=F,colClasses = "character")
y_test<-read.csv("y_test.txt",header=F,colClasses = "factor")
subject_test<-read.csv("subject_test.txt",header=F,colClasses = "factor")
X_train<-read.csv("X_train.txt",header=F,colClasses = "character")
y_train<-read.csv("y_train.txt",header=F,colClasses = "factor")
subject_train<-read.csv("subject_train.txt",header=F,colClasses = "factor")
activity_labels<-read.delim("activity_labels.txt",header=F,colClasses = "character",sep=' ')
###--------------------------------------------------------###

####Test---------------------------------------------------###
arrange(X_test)
testbind<-cbind(y_test,subject_test,x)
colnames(testbind)<-c('Activity','Subject',features[,2])
row.names(testbind)<-NULL
####------------------------------------------------------###

####Train-----------------------------------------------------###
arrange(X_train)
trainbind<-cbind(y_train,subject_train,x)
colnames(trainbind)<-c('Activity','Subject',features[,2])
row.names(trainbind)<-NULL
###-----------------------------------------------------------###

###Merge-------------------------------------------------------###
tbmerge<-rbind(testbind,trainbind)
###------------------------------------------------------------###

###-------------mean and stdev-----------####
cols<-sort(c(grep('std',colnames(testbind)),grep('mean',colnames(testbind)),grep('Activity',colnames(testbind)),grep('Subject',colnames(testbind))))
tbfiltered<-tbmerge[,cols]
###--------------------------------------####


###---------------Descriptive activity names----------####
levels(tbfiltered[,1])<-activity_labels[,2]
###---------------------------------------------------####
###------------Mean by group--------------------------####
library(dplyr)
tbmeans<-tbfiltered %>%
  group_by(Activity,Subject) %>%
  summarise_all(funs(mean(., na.rm=TRUE)))
write.table(tbmeans,'TableStep5.txt',row.names = F)
###---------------------------------------------------####
getwd()




