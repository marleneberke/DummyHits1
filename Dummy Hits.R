createDummyHits <- function(worker, amount) {

# Create Qualification
newqual <- CreateQualificationType(paste('QualificationForWorker', worker),
                                   paste('TemporaryQualificationFor', worker), 
                                   'Active')
# If you get the error that that qualification already exists, then that means we set up a dummy hit
# for that worker sometime in the past. If that happens, just make a slight change to the 'Qualification
# for Worker ' or 'Temporary Qualification for ' text, like taking out a space


# Assign Qualification to Worker
AssignQualification(newqual$QualificationTypeId, worker, value="100")

# Generate QualificationRequirement data structure
qr <- GenerateQualificationRequirement(newqual$QualificationTypeId, "=", "100", preview = TRUE)
# Create HIT
temphit <- 
  CreateHIT(title= paste("Temporary HIT for ", worker),
            description = paste("Temporary HIT for ", worker),
            reward = amount,
            keywords = worker,
            duration = seconds(hours=1),
            # attach the new QualificationRequirement data structure:
            qual.req = qr, 
            expiration = seconds(days=3),
            # one second delay in autoapproval:
            auto.approval.delay = '1', 
            # a question string or hitlayoutid must be specified:
            # this example uses the simple `questionform.txt` example (from below)
            question = paste(readLines("questionsform.txt"), collapse='')) 

# Optionally, contact worker about the HIT. Only works if worker completed one of your assignments.
# ContactWorker(worker, 'Complete HIT to get paid',
#               "I have created a HIT for you to be paid. Just search for your worker ID.\n
#               All you have to do is selection Yes and submit. You will be paid automatically.\n
#               Sorry for the hassle.")

# Optionally, approve assignment (if auto-approval not set)
#ApproveAllAssignments(hit = hit)

# Dispose QualificationType after assignment approved
# DisposeQualificationType(newqual$QualificationTypeId)
}