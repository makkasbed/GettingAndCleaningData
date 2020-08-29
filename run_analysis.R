# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each
#    activity and each subject. 
analyze <- function() {
        
        library(data.table)
        
        
        #loading parameterized values
        ##########################################################
        source("config.R")
        source("functions.R")
        
        
        # data frame for the train dataset
        train.dataset <- create.set("train")
        
        # data frame for the test dataset
        test.dataset <- create.set("test")
        
      
        # merge the training and test data
        total.dataset <- rbind(train.dataset, test.dataset)
        
        # column names
        colnames(total.dataset) <- dataset.column.names()
        # cols to extract
        total.dataset <- extract.columns.dataset(total.dataset)
        # activity names
        total.dataset <- label.activity.column(total.dataset)
        
        
        # Creating and exporting the new dataset
        write.table(create.new.dataset(total.dataset), 
                    "finaldataset.txt",
                    sep=",",
                    row.names = FALSE,
                    quote = FALSE)
        print("Done! The finaldataset.txt file is in your working directory.")
}   