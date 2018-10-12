#Script for bonusing many workers at once. Make sure to set the bonusAmount to the correct amount for your study.
#Fill out WorkerBonus.csv

library("MTurkR")

Sys.setenv(AWS_ACCESS_KEY_ID = "YOURKEYHERE")
Sys.setenv(AWS_SECRET_ACCESS_KEY = "YOURSECRETKEYHERE")

bonusAmount=2.00

#reading the file where the worker data is stored
data=read.csv("WorkerBonus.csv",header=TRUE)

#vector with names of the workers we want to compensate
workers=as.character(data$WorkerID)

#vector with assignments for the workers in workers
assignments=as.character(data$AssignmentID)

for (i in 1:length(workers)) {
  GrantBonus(workers[i],assignments[i],bonusAmount,"Did better than previous participant. Well done!")
}
