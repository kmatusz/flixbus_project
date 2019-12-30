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
		<h3>Here you can define the attributes of your new search</h3>
		</div>
	</div>

    <form>     
        <div class="form-group">
            <label for="exampleFormControlInput1">Job name</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="Define your search title">
        </div>
        <div class="form-group">
            <label for="exampleFormControlSelect1">Departure City</label>
            <select class="form-control" id="exampleFormControlSelect1">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            </select>
        </div>
        <div class="form-group">
            <label for="exampleFormControlSelect1">Arrival City</label>
            <select class="form-control" id="exampleFormControlSelect1">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            </select>
        </div>        
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputEmail4">Departure date from:</label>
                <input type="date" name="DepFrom" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
            <div class="form-group col-md-6">
                <label for="inputPassword4">Departure date to:</label>
                <input type="date" name="DepFrom" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputEmail4">Arrival date from:</label>
                <input type="date" name="DepFrom" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
            <div class="form-group col-md-6">
                <label for="inputPassword4">Arrival date to:</label>
                <input type="date" name="DepFrom" max="2100-12-31" min="2010-01-01" class="form-control" id="inputEmail4" >
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
     </form>


</body>
</html>