<!doctype html>
<html ng-app="MainApp">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

    <title>FlixScrawler</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">


  </head>
  <body>

    <div class="container">
<!-- Static navbar -->

      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <div class="navbar-header">
             <a class="navbar-brand" href="/">FlixScrawler</a>
          </div>

          <div class="collapse navbar-collapse" id="navbarNav">
            % if isLoggedIn:
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="/newjob">Define New Job <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/yourjobs">Your Jobs</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/jobresults">See Job Results</a>
                </li>
              </ul>
             % end
            % if isAdmin:
             <div class="collapse navbar-collapse" id="navbarNav">
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link" href="/adminpanel">Scraper management <span class="sr-only">(current)</span></a>
                </li>
              </ul>
             % end
             % if isLoggedIn or isAdmin:
               <ul class="navbar-nav ml-auto">
			  		    <li class="add-margin-right navbar-item">
                  <a class="nav-link" href="/logout"> Logout</a>
					       </li>
                </ul>
              %end
            </div>
          

           
        



        </div><!--/.container-fluid -->
      </nav>

      {{!base}}
    </div>

  </body>
</html>
