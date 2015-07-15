##Assuming we downloaded, unzipped the files and set our working directory to our data folder

##Reading files train and test files

train <- read.table(file = ".\\train\\X_train.txt", header = FALSE, sep = "")
test <- read.table(file = ".\\test\\X_test.txt", header = FALSE, sep = "")

##Reading the y train to know which activity is logged
trainact <- read.table(file = ".\\train\\y_train.txt", header = FALSE, sep = "")
testact <- read.table(file = ".\\test\\y_test.txt", header = FALSE, sep = "")

##Reading the train and test subjects
trainsub <- read.table(file = ".\\train\\subject_train.txt")
testsub <- read.table(file = ".\\test\\subject_test.txt")

##Readin features  and activity label files and naming columns properly

features <- read.table(file = "features.txt", col.names = c("id_feature", "lbl_feature"))
actlabels <- read.table(file = "activity_labels.txt", col.names = c("Id_Activity","Lib_Activity"))


##Merging data from train and test

combi <- rbind(train, test)
combiact <-rbind(trainact,testact)
combisub <-rbind(trainsub,testsub)

##Removing objects no longer useful
rm(train,test,trainact,testact, trainsub,testsub)

##Creating a pattern to extract specific columns with mean() or std() as column name

ptnmeanstd <- "*mean\\(\\)|*std\\(\\)"

##Creating the index of extraction 

ndx <- grep(ptnmeanstd, features$lbl_feature)

##Checking the index is correct
features[ndx,]
##Everything looks okay and let's keep it to add propoer variable names later
VarNames <- features[ndx,]

##Extracting only the measurements on the mean and standard deviation for each measurement (part 2)
combifit <-combi[,ndx]

##Adding the activity column and the subject column
combifit <- cbind(combiact, combifit)
combifit <- cbind(combisub,combifit)

##Naming the first and second column of our combifit to merge it then with the labels
names(combifit)[1] <- "Id_Subject"
names(combifit)[2] <- "Id_Activity"

##Adding the labels of activity to the dataset merging via the Id_Activity column in both sets (part3)
combilab<-merge(actlabels,combifit, by = "Id_Activity", all.y = TRUE)

##Removing objects no longer useful
rm(combifit, combiact, combisub)

##Creating a vector with variable names
Varvector <- as.vector(unlist(VarNames[2]))

##Renaming all columns from the start top avoid mistakes (part 4)
names(combilab) <- c("Id_Activity", "Lbl_Activity", "Id_Subject", Varvector)

##Producing the tidy set via an aggregation using the mean function grouped by Subject and activity
tidyset <- aggregate(. ~ Id_Activity+Lbl_Activity+Id_Subject ,data = combilab , mean)

##Writing tidyset to a table
write.table(tidyset,file="tidyset.txt", row.names = F )

##Cleaning up the working space
rm(actlabels,combi,combilab,features,VarNames)

