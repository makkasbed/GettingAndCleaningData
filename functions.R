# This function imports the files and returns a data frame with subjects, activities 
# and measures.
# type is the type of dataset i.e. train or test
create.set <- function(type) {
        
        library(data.table)
        
        ## Check that set.type is valid
        if (!type %in% c("train","test")) {
                stop("invalid set.type. It must be train or test")
        }
        
        # Subject
        subjects.file.name = paste("subject_", type, extension, sep = "")
        subjects <- read.table(paste(working_directory, type, subjects.file.name, sep = sep), 
                               header = FALSE,
                               col.names = c("subject.id"),
                               colClasses = "integer")
        
        
        activities.file.name = paste("y_", type, extension, sep = "")
        activities <- read.table(paste(working_directory, type, activities.file.name, sep = sep), 
                                 header = FALSE,
                                 col.names = c("activity.id"), 
                                 colClasses = "factor")
        
        x.file.name = paste("X_", type, extension, sep = "")
        x.set <- read.fwf(paste(working_directory, type, x.file.name, sep = sep),
                          rep(16, times=561), 
                          header = FALSE,
                          colClasses = "numeric",
                          buffersize = 250)
        
        x.set
        
        output.set <- cbind(subjects, activities, x.set)
        
        output.set
}

# Function imports the features file and returns the column names for the merged 
# dataset.
dataset.column.names <- function() {
        # Loading features
        features.file.name = paste("features", extension, sep = "")
        features.file <- read.table(paste(working_directory, features.file.name, sep = sep), 
                                    sep = " ", 
                                    header = FALSE,
                                    col.names = c("feature.id","feature.description"),
                                    colClasses = c("factor","character"))
        # Return
        c("subject.id", "activity.id", features.file$feature.description)
}


# function extracts the subject, the activity and the measurements on the mean
# and standard deviation. 
extract.columns.dataset <- function(total.dataset) {
        # Choosing columns to extract
        column.names <- cbind(names(total.dataset))
        column.table <- data.frame(column.names)
        # mean columns
        column.table$extract <- grepl("-mean", column.table$column.names)
        # std columns
        column.table$extract <- column.table$extract | grepl("-std", column.table$column.names)
        column.table$extract[1:2] <- TRUE
        
        # get only cols to extract
        total.dataset <- total.dataset[,column.table$extract]
        # Return
        total.dataset
}



# Function extracts the subject, the activity and the measurements on the mean
# and standard deviation. 
label.activity.column <- function(total.dataset) {
        ## Loading activities
        activity.labels.file.name = paste("activity_labels", extension, sep = "")
        activity.labels.file <- read.table(paste(working_directory, activity.labels.file.name, sep = sep), 
                                           sep = " ", 
                                           header = FALSE,
                                           col.names = c("activity.id","activity.description"),
                                           colClasses = c("factor","factor"))
        
        new.total.dataset <- merge(activity.labels.file, total.dataset, all=TRUE)
        total.dataset <- new.total.dataset[,c(3,2,4:82)]
        # Return
        total.dataset
}


# Function creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 
create.new.dataset <- function(total.dataset) {
        library(plyr)
        library(reshape2)
        
        # variables
        vector.column.names <- names(total.dataset)
        vector.column.names <- vector.column.names[3:81]
        # Melting data frame
        dataset.melt <- melt(total.dataset,
                             id=c("subject.id","activity.description"),
                             measure.vars=vector.column.names)
        # Create the new dataset
        new.dataset <- dcast(dataset.melt, subject.id + activity.description ~ variable, mean)
        # Sorting the dataset    
        new.dataset <- arrange(new.dataset, subject.id, activity.description)
        # Return
        new.dataset
}
