<html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>


% rebase('base.tpl', title='Python')

<body>
	<div class="row">
		<div class="mt-2 col-md-12">
        <h3 class="text-center text-white pt-5">   </h3>
		<h3>Here you can see results for a selected job and export them in an Excel file</h3>
        <h3 class="text-center text-white pt-5">   </h3>
		</div>
	</div>

    <form action="" method="post">
        <div class="form-group">
            <label for="exampleFormControlSelect1">Select job to see its results</label>
            <select class="form-control" id="exampleFormControlSelect1" name="jobChoosing">
            %for i in formularList:
                <option value={{i[0]}}>{{i[1]}}</option>
            %end
            </select>
        </div>
        <button type="submit" class="btn btn-primary mb-2">Show results for selected job</button>
    </form>
    
    
    %if (showTable and resultTable==[]):
        <div class="alert alert-secondary" role="alert">
            Results for this job are not available yet. Go to YourJobs page and run the scrapper to get them.
        </div>
    %end

    %if showTable and resultTable!=[]:
	<div class="row">
		<div class="mt-2 col-md-12">
		<h3>Results for the chosen job</h3>
		</div>
	</div>

        <table class="table table-striped">
            <thead>
                <tr>
                <th scope="col">Departure city</th>
                <th scope="col">Arrival city</th>
                <th scope="col">Departure date</th>
                <th scope="col">Departure time</th>
                <th scope="col">Arrival time</th>
                <th scope="col">Price</th>
                <th scope="col">Price per km</th>
                <th scope="col">Fully booked</th>
                <th scope="col">Date obtained</th>
                </tr>
            </thead>
            <tbody>
                %for row in resultTable:
                <tr>
                     %for col in row:
                        <td>{{col}}</td>
                     %end
                </tr>
                %end
                <tr>
            </tbody>
        </table>
        <div class="mt-2 col-md-12">
            <h3 class="text-center text-white pt-5">   </h3>
            <div>
            <a class="btn btn-primary" href="/download" role="button">Download as excel file</a>
            </div>
            <h3 class="text-center text-white pt-5">   </h3>
        </div>
    %end


</body>
</html>