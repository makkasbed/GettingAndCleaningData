This repo contains the solution of the assignment in Week 4 of Getting and Cleaning Data in the data science specialization

# Background

One of the most exciting areas in all of data science right now is wearable computing - see for example this article ( http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/ ). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data
The source data for this assignment can be found at the URL below:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Steps
The run_analysis.R is the main script and to execute them, perform the following:

- Unzip the file getdata-projectfiles-UCI HAR Dataset.zip in your working directory. 
- Place the scripts run_analysis.R, functions.R and config.R in your working directory. 
- Load the run_analysis.R by executing source("run_analysis.R")
- Then execute the function analyze()

analyze() uses the parameters defined in config.R and custom transformation functions in functions.R, and generates a file called finaldataset.txt in your working directory.