
### Introduction
This project is an R script that performs data cleaning of data provided by the "Human Activity Recognition Using Smartphones Data Set" project
And produces a tidy data set in a csv file that shows reading for one subject performing one of six activities.
In addition to the subject and the activity, each reading row has 66 different averages of readings for that subject while performing the activity

### Project content
README.md file describing the project  
CodeBook.md file describing the data set  
run_analysis.R file an R script file to generate the tidy data  


### Setup and running the script
1. Download the input dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip the file
3. put the unziped folder "UCI HAR Dataset" in your working directory  so the test data will be in the following path:  <workingDirectory>\UCI HAR Dataset\train
4. The R script file "run_analysis.R" should go in the working directory as well
5. The script contains no functions. to run it simply source the script file from r command:  source('run_analysis.R')
6. This will generate a CSV file called "tidyData.txt" in the project working directory