<html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>


% rebase('base.tpl', title='Python')

<body>
	<div class="row ">
		<div class="mt-2 col-md-12" style="margin-top:15px">
        <h3 class="text-center text-white pt-5">   </h3>
		<h3>Here you can see your defined jobs and run them</h3>
        <h3 class="text-center text-white pt-5">   </h3>
		</div>
	</div>
    

    <div class="row align-items-center" style="margin-top:15px">
        <p> You can choose which jobs you want to run </p>
    </div>

    <form action="/yourjobs" method="post">
    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col"> Job Name </th>
                <th scope="col"> Time of creation </th>
                <th scope="col"> Time of last run </th>
            </tr>
        </thead>
        <tbody>
            %iter=0
                %for row in table: 
                    <%
                    iter=iter+1
                    rowNumerId="customCheck"+str(iter)
                    %>
                        <tr>
                            <td>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="checkJob" value={{row[0]}} id={{rowNumerId}}>
                                    <label class="custom-control-label" for={{rowNumerId}}>{{iter}}</label>
                                </div>
                            </td>
                            %for col in row[1:]:
                            <td>{{col}}</td>
                            %end
                        </tr>
                %end
             %end
        </tbody>
    </table>
    <button type="submit" class="btn btn-primary mb-2">Run selected jobs</button>
    </form>

    <div class="row mt-10 align-items-center" style="margin-top:25px">
        <p> You can also run all of your jobs </p>
    </div>
    <div class="row">
        <form action="" method="post">
            <input class="btn btn-primary" type="submit" name="runAll" value="Run all"> 
        </form>
    </div>


    
</body>
</html>