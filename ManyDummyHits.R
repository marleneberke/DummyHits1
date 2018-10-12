#Script for compensate several different workers at once. Requires Dummy Hits.R. Fill out WorkerCompensation.csv

#Loading the package MTurkR. 
#This assumes that you have already installed MTurkR with command install.packages("MTurkR")
library("MTurkR")

Sys.setenv(AWS_ACCESS_KEY_ID = "YOURKEYHERE")
Sys.setenv(AWS_SECRET_ACCESS_KEY = "YOURSECRETKEYHERE")

source("Dummy Hits.R")

#reading the file where the worker data is stored
data=read.csv("WorkerCompensation.csv",header=TRUE)

#vector with names of the workers we want to compensate
workers=as.character(data$WorkerId)

#vector with amount of compensation for the workers in workers
amounts=as.character(data$Amount)

if (length(workers)!=length(amounts)){
  print('You need to specify an amount to pay each worker. The two vectors must have equal length')
}

for (i in 1:length(workers)) {
  createDummyHits(workers[i],amounts[i])
}

