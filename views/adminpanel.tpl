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
		<div class="col-md-12">
		<h3 class="text-center text-white pt-5">   </h3>
		<h3>Hello {{loginName}} </h3>
		<h4>Here you can check the current state of FlixScrawler environment. </h4>
		<h3 class="text-center text-white pt-5">   </h3>
		</div>
	</div>


	<form action="" method="post">
        <div class="form-group">
            <label for="exampleFormControlSelect1">Select  information to show</label>
            <select class="form-control" id="exampleFormControlSelect1" name="admin_table_choosing">
            %for i in tables_list:
                <option value={{i}}>{{i}}</option>
            %end
            </select>
        </div>
        <button type="submit" class="btn btn-primary mb-2">Show selected information</button>
    </form>


    %if showTable:
	<div class="row">
		<div class="mt-2 col-md-12">
		<h3>Table content</h3>
		</div>
	</div>

        <table class="table table-striped">
            <thead>
                <tr>
                	%for col in selected_table_header:
                		<th scope="col">{{col}}</th>
                	%end
                </tr>
            </thead>
            <tbody>
                %for row in selected_table_content:
                <tr>
                     %for col in row:
                        <td>{{col}}</td>
                     %end
                </tr>
                %end
                <tr>
            </tbody>
        </table>
        
    %end


</body>
</html>