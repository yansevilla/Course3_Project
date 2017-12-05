The raw data are processed following these procedures:
1. Read the files. 
2. Add appropriate column labels on X test/train.
3. Get only data on mean and stdev measurements using grep.
4. Add columns on subject# and activity
5. Merge the 2 datasets using bind_rows.
6. Reoder data columns, subject and activity columns first
7. Group data by subject and activity, and measure means.
8. Write output file on current working directory


The output tidy data set "output_data.txt" contains the following variables:

1. activity:  Links the class labels to the activity name which can be any of following:
        1 WALKING
        2 WALKING_UPSTAIRS
        3 WALKING_DOWNSTAIRS
        4 SITTING
        5 STANDING
        6 LAYING

2. subject: Person(subject) unique id who participated in the experiment (1 to 30)

3. mean_measurements: Average value of sensor signal measurement containing "mean" keyword and grouped according to activity and subject.

4. std_measurements: Average value of sensor signal measurement containing "std" keyword and grouped according to activity and subject.
