<html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>


% rebase('base.tpl', title='Define new job')

<body>
	<div class="row">
		<div class="mt-2 col-md-12">
		<h3 class="text-center text-white pt-5">   </h3>
        <h3>Here you can define the attributes of your new search</h3>
        <h3 class="text-center text-white pt-5">   </h3>
		</div>
	</div>

        % if (message=="ok"):
             <div class="alert alert-success" role="alert">
                Your new search job was defined correctly. Your data is now retrieved.
             </div>
         % end


        % if (message!="" and message!="ok"):
             <div class="alert alert-warning" role="alert">
                {{message}}
             </div>
         % end

    <form id="NewJob-form" class="form" action="" method="post">     
        <div class="form-group">
            <label for="JobNameDefine">Job name</label>
            <input type="text" class="form-control" id="JobNameDefine" name="JobNameDefine" placeholder="Define your search title">
        </div>
        <div class="form-group">
            <label for="DepartureCitySelect">Departure City</label>
            <select class="form-control" id="DepartureCitySelect" name="DepCity">
                <option value=''> </option>
            %for i in cityList:
                <option value={{i[0]}}>{{i[1]}}</option>
            %end
            </select>
        </div>
        <div class="form-group">
            <label for="ArrivalCitySelect">Arrival City</label>
            <select class="form-control" id="ArrivalCitySelect" name="ArrCity">
                <option value=''> </option>
            %for i in cityList:
                <option value={{i[0]}}>{{i[1]}}</option>
            %end
            </select>
        </div>        
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="DepFrom">Departure date from:</label>
                <input type="date" name="DepFrom" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
            <div class="form-group col-md-6">
                <label for="DepTo">Departure date to:</label>
                <input type="date" name="DepTo" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Create and run your job</button>
     </form>


</body>
</html>