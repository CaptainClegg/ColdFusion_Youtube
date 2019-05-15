<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      
    <cfset TheLocation = "C:\ColdFusion11\cfusion\wwwroot\superyt_DanielTristan\images\profiles">
    <cfset TheFilePath = "/superyt_DanielTristan">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/personal.css">
<cfoutput>
    <title>#PageTitle#</title>
</cfoutput>
  </head>
        
<cfquery name="GetPlatfroms" datasource="superyt_group2">
SELECT *
FROM Platforms
</cfquery>
  <body>
      
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="./">SuperYT</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      
      </ul>
      
      
      
      
      
      <cfif IsDefined("session.access")>
                <!--- logged in --->
          <cfoutput><a href="profile.cfm?name=#session.UserName#" class="btn btn-outline-primary mx-2">#session.UserName#</a></cfoutput>
          <button type="button" class="btn btn-outline-primary mx-2" data-toggle="modal" data-target="#addVideoModal">Add Video</button>
          
          
          <!--- Modal --->
                <div class="modal fade" id="addVideoModal" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel1">Add a Video</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <form class="form-inline my-2 my-lg-0" action="VideoAction.cfm" method="post" enctype="multipart/form-data">
                      <div class="modal-body">                          
                          <label class="col-sm-3 col-form-label" for="VideoTitle">Title</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="text" name="VideoTitle" id="VideoTitle" maxlength="255" required>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="VideoDesc">Description</label>
                          <div class="col-sm-9">
                              <textarea class="form-control mr-sm-2" name="VideoDesc" id="VideoDesc" required></textarea>
                          </div>
                          <cfoutput><input type="hidden" name="UserID" id="UserID" value="#session.userid#" required></cfoutput>
                          
                          <label class="col-sm-3 col-form-label" for="PlatformID">Platform</label>
                          <div class="col-sm-9">
                            <select name="PlatformID" id="PlatformID" required>
                            <option value="0">- Select Video Platform -</option>
                            <cfoutput query="GetPlatfroms">
                                <option value="#PlatformID#">#PlatformName#</option>
                            </cfoutput>
                            </select>
                          </div>
                          
                          <label class="col-sm-3 col-form-label" for="VideoURL">URL</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="text" name="VideoURL" id="VideoURL" maxlength="255" required>
                          </div> 
                          
                          <label class="col-sm-3 col-form-label" for="VideoKey">Video Key</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="text" name="VideoKey" id="VideoKey" maxlength="150" required>
                          </div> 
                          
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Create</button>
                      </div>
                      </form>
                    </div>
                  </div>
                </div>
          
          
          
          
          <a href="logout.cfm" class="btn btn-outline-primary mx-2">Logout</a>
      <cfelse>
                <!--- logged out --->
          
          <!--- Button trigger modal --->
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                  Join
                </button>

                <!--- Modal --->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Create a Profile</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <form class="form-inline my-2 my-lg-0" action="ProfileAction.cfm" method="post" enctype="multipart/form-data">
                      <div class="modal-body">                          
                          <label class="col-sm-3 col-form-label" for="UserName">User Name</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="text" name="UserName" id="UserName" maxlength="45" required>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="UserPassword">Password</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="password" name="UserPassword" id="UserPassword" maxlength="45" required>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="UserDisplayName">Display Name</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="text" name="UserDisplayName" id="UserDisplayName" maxlength="100" required>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="UserEmail">Email</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="email" name="UserEmail" id="UserEmail" maxlength="100" required>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="UserDesc">Description</label>
                          <div class="col-sm-9">
                              <textarea class="form-control mr-sm-2" name="UserDesc" id="UserDesc" maxlength="250" required></textarea>
                          </div>                          
                          <label class="col-sm-3 col-form-label" for="UserPhoto">Profile Photo</label>
                          <div class="col-sm-9">
                            <input class="form-control mr-sm-2" type="file" name="UserPhoto" id="UserPhoto" accept="image/*">
                          </div>                    
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Create</button>
                      </div>
                      </form>
                    </div>
                  </div>
                </div>
        
        
          
          
          
    <form class="form-inline my-2 my-lg-0" action="EntranceAction.cfm" method="post">
      <input class="form-control mr-sm-2" type="text" name="UserName" placeholder="Username" aria-label="UserName" required>
      <input class="form-control mr-sm-2" type="password" name="UserPassword" placeholder="Password" aria-label="UserPassword" required>
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Login</button>
    </form>
      </cfif>
          
          
          
          
          
          
          
          
          
          
      
    <form class="form-inline my-2 my-lg-0" action="search.cfm" method="post">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" id="Criteria" name="Criteria">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>