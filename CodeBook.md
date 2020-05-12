The run analysis_script uses a function (arrange) to arrange the data into a tidy format from which the user would be able to process and filter it more easily.

In order tu run the script the working directory must contain the files 'X_test.txt', 'y_test.txt', 'X_train.txt', 'y_train.txt', 'subject_test.txt', 'subject_train.txt', 'features.txt' and 'activity_labels.txt'.

The final output is a file that contains the sumarized means of the mean and standard deviation of each variable observed grouped according to subject and activity.

X_test -> Test data set before processing. Extracted from the text file with the same name.          

X_train -> Train data set before processing. Extracted from the text file with the same name.

y_test -> Contains the activity of each row in the test data set. Extracted from the text file with the same name.

y_train -> Contains the activity of each row in the train data set. Extracted from the text file with the same name.

subject_test -> Contains the subject of each row in the test data set.     

subject_train -> Contains the subject of each row in the train data set.

features -> It contains the name of each variable observed in the X_test and X_train.

activity_labels -> Data frame loaded from the file 'activity_labels.txt'. It contains the labels corresponding to each number in the 'Activity' column from each table.

arrange-> Is a function that splits the string of each row and, converts it into numeric vector and merge the rows in a single matrix. 

x -> Output of the function arrange.

testbind -> Data frame that matches the output of the function 'arrange' (x) applied in the X_test and the corresponding activity and subject.
        
trainbind -> Data frame that matches the output of the function 'arrange'(x) applied in the X_train and the corresponding activity and subject.
         
cols -> Numeric vector that contain the location of the columns with means and standard deviations of the tables.
   
tbfiltered -> Data frame of the merged table that contains only info about standard deviatons and mean.
      
tbmeans -> Data frame that sumarises the mean of each variable of the 'tbfiltered' data frame grouping by activity and subject.         

tbmerge -> Merged table of the of the train and test data sets.
         
