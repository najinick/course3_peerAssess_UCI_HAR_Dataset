

##Reading activities
activities  <- read.table("UCI HAR Dataset/activity_labels.txt")

##Read features
features 	<- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

#Get  the mean and std columns
features 	<- features[grepl("-mean\\(\\)",features$V2) | grepl("-std\\(\\)",features$V2),]

##Read the features measurement files
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")

##Keep only column that we want, those with mean and std
xTrain <- xTrain[, features[,1]]
xTest  <- xTest[, features[,1]]

##Read rest of data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")


##Column Bind all training data together
trainData <- cbind(subjectTrain, yTrain, xTrain);

##Column Bind all test data together
testData <- cbind(subjectTest, yTest, xTest);

##Row Bind training and test data
fullData <- rbind(trainData, testData)

##Set column names on all the columns in the full data.. Subject, Activity, and the column names of features
colnames(fullData) <- c('Subject', 'ActivityNumber', features[,2])

##Add column names to activities table
colnames(activities) <- c('ActivityNumber', 'Activity')

##merging 
fullData <- merge(activities, fullData)

#Remove the ActivityNumber column
drops <- c("ActivityNumber")
fullData <- fullData[,!(names(fullData) %in% drops)]

##Split by Activity and Subject
groupedData <- split(fullData, list(fullData$Activity, fullData$Subject))

##Calculate means of numeric columns. This will generate a list of lists each containing 1 row
groupedMeans <- lapply(groupedData, function(df){ 
	numericColumns <- df[, 3:ncol(df)]	
	c(df[1,c(1,2)], colMeans(numericColumns))
})

#Generate result data frame
resultDf <- data.frame()
for (g in groupedMeans){
	
	#Make sure to convert activity to characters
	g$Activity <- as.character(g$Activity)
	
	#create one row df from list
	oneRowDf <- data.frame(matrix(unlist(g), nrow=1))
	
	#merge one row df with result df
	resultDf <- rbind(resultDf, oneRowDf)
	
	#get the column names from the list
	colNames <- names(g)
}

#set the column names on the result df
names(resultDf) <- colNames

#write results to csv file
write.csv(resultDf, file = "tidyData.txt")