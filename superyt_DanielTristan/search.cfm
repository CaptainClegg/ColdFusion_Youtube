<cfif NOT isdefined("form.Criteria")>
    <cflocation url="index.cfm">
</cfif>
    
<cfset PageTitle = "Welcome to SuperYT">
<cfset Description = "Search SuperYT">
<cfset Keywords = "Search, Users, Videos">
<cfinclude template="header.cfm">

<cfquery name="GetVideos" datasource="superyt_group2">
SELECT *
FROM Videos v, Users u
WHERE v.UserID = u.UserID AND VideoTitle LIKE '%#form.Criteria#%'
ORDER BY VideoPublishDate
</cfquery>

<cfquery name="GetUsers" datasource="superyt_group2">
SELECT *
FROM users
WHERE UserDisplayName LIKE '%#form.Criteria#%' 
ORDER BY UserDisplayName
</cfquery>



<!-- Banner -->
        <header class="container">
            <div class="row">
                
                
                <div class="col-sm-12 banner">
                    <cfoutput>
                        <h1>Search: #form.Criteria#</h1>
                    </cfoutput>
                </div>
                
            </div>
            
        </header>
<!-- Content -->

   <section class="container">
        <div class="row">
            
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading"><h2>Video Search Results</h2></div>
                <div class="panel-body">
                    <cfif GetVideos.RecordCount IS NOT 0>
                            
                            <cfoutput query="GetVideos">
                                <cfinclude template="VideoEmbed.cfm">   
    </div>
                            </cfoutput>
                            
                        <cfelse>Sorry, no videos with that name on our site.
                        </cfif>
                </div>
                </div>
            </div>
            
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-heading"><h2>User Search Results</h2></div>
                <div class="panel-body">
                    <cfif GetUsers.RecordCount IS NOT 0>
                    <cfoutput query="GetUsers">
                        <a href="profile.cfm?name=#UserName#"><cfif FileExists("#TheLocation#\#userid#-500.jpg")>
                                <img src="#TheFilePath#/images/profiles/#userid#-500.jpg" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                            <cfelse>
                                <img src="images/anon.png" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                        </cfif><h1> #UserDisplayName#</h1></a>
                        <br>
                    </cfoutput>
                    <cfelse>Sorry, no users with that name on our site.
                    </cfif>
                </div>
                </div>
            </div>

			
			
			
            </div>
        

    </section>
	
	
<cfinclude template="footer.cfm">