from crawler_usage import jobRunner

# runs scrapper for selected job
# this is only a first scrach of this function -> to be filled out to really work with scrapper


def runJob(jobID):
    # jobID is a key from a database
    # remember to update last_run column in jobs table
    job_runner = jobRunner(reset_db=False)

    job_runner.run_job_from_job_id(jobID)

    print("scrapper run for " + str(jobID))
    return True
