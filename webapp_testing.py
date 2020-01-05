from crawler_usage import jobRunner

job_runner = jobRunner(reset_db=True)
job_runner._setup_before_running()
# job_runner.run_job_from_job_id(1)