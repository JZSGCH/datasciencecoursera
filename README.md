## Hello to all

## This is how my script run_analysis.R works

0. It reads files from both train and test folders and merge each train file with the corresponding
   test file (example : merging X_train.txt with X_test.txt, and so on). 
   Files read and combined are X, y, features, subject and activity labels files.

0. It extracts the columns specifying mean() or std() from the combined X files using a pattern 
    with the grep function (that is it defines a pattern mean() or std(), retrieve column index 
	corresponding to this pattern then extracts them to put it in a new data frame)
	 
0. It binds activity ids and subjects ids to the variables 

0. It retrieves activity names from the activity_labels and binds them in the file
  
0. It renames variables column with their real names
  
0. It calculates the mean of each column for each subject, activity
  
0. It writes the result down to a txt file named tidyset.txt
