<cfif NOT IsDefined("URL.name")>
    <cflocation url="./">
</cfif>

<cfquery name="GetProfile" datasource="superyt_group2">
SELECT *
FROM Users
WHERE UserName = '#URL.name#'
</cfquery>
    
<cfquery name="GetVideos" datasource="superyt_group2" maxrows="5">
SELECT *
FROM Videos v, Users u
WHERE v.UserID = u.UserID AND u.UserName = '#URL.name#'
ORDER BY VideoPublishDate DESC
</cfquery>

<cfoutput query="GetVideos">
<cfquery name="GetFollowees" datasource="superyt_group2">
SELECT *
FROM Followers f, Users u
WHERE f.FollowerID = #UserID# AND u.UserID = f.FolloweeID
</cfquery>
</cfoutput>

<cfoutput query="GetProfile">
    <cfif #UserLevel# eq 0>
        <cfif NOT IsDefined("session.access")>
            <cflocation url="./">        
        </cfif>
        <cfif NOT #session.access# eq 9>
            <cflocation url="./">        
        </cfif>
    </cfif>
</cfoutput>

<cfset PageTitle = "#GetProfile.UserName#'s Profile">

<cfinclude template="header.cfm">


    
<section class="container">
    
    <cfoutput query="GetProfile">
    <div class="row">
        <cfif FileExists("#TheLocation#\#userid#-500.jpg")>
            <img src="#TheFilePath#/images/profiles/#userid#-500.jpg" alt="#username#" style="border-radius: 120px; max-width: 200px; height: 200px; float: left;">
            <cfelse>
                <img src="images/anon.png" alt="#username#" style="border-radius: 120px; max-width: 200px; height: 200px; float: left;">
        </cfif>
    </div>
    <div class="row">
        <h1>
        #UserDisplayName#
        </h1>
    </div>
    <div class="row">
        <p>#UserDesc#</p>
    </div>
    
</cfoutput>
    
    
    
    
    
    
    
    
    
<cfif IsDefined("session.access")>
<cfoutput query="GetVideos">
<!--- logged in ---> 
<cfquery name="GetFollowed" datasource="superyt_group2">
SELECT *
FROM Followers f, Users u
WHERE f.FollowerID = #session.userid# AND u.UserID = #GetVideos.UserID#
AND f.FolloweeID = u.UserID
</cfquery>
</cfoutput>
    
    
    
<cfoutput query="GetProfile">
    <cfif #session.access# eq 9>
<div class="col-sm-2">
<form action="DisableProfile.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="UserLevel" maxlength="11" value="#UserLevel#" required>
    <input hidden name="UserName" maxlength="11" value="#URL.name#" required>
    <br>
    <cfif #UserLevel# eq 1>
        
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Disable Profile</button>
    <cfelse>
        
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Enable Profile</button>
    </cfif>
</form>
</div>
</cfif>
</cfoutput>
    

<cfoutput query="GetFollowed">
<form action="FollowAction.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="FollowerID" maxlength="11" value="#session.userid#" required>
    <input hidden name="FolloweeID" maxlength="11" value="#FolloweeID#" required>
    <br>
    <cfif #session.username# eq #URL.name#>
    <cfelseif GetFollowed.RecordCount GTE 1>
        <!--- followed --->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Un-Follow #UserName#</button>
    <cfelse>
        <!---not followed--->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Follow #UserName#</button>
    </cfif>
</form>
</cfoutput>
    
<cfelse>
    <!--- not logged in --->
</cfif>
    
    
    
    
    
    
    <div class="col-sm-12">
        <h3>Following</h3>
        <cfoutput query="GetFollowees">
    <a href="profile.cfm?name=#UserName#"><cfif FileExists("#TheLocation#\#userid#-500.jpg")>
                                <img src="#TheFilePath#/images/profiles/#userid#-500.jpg" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                            <cfelse>
                                <img src="images/anon.png" alt="#username#" style="border-radius: 30px; width: 50px; height: 50px; float: left;">
                        </cfif><h4> #UserDisplayName#</h4></a>
                        <br>
        </cfoutput>
    </div>

<cfoutput query="GetVideos"> 
<cfinclude template="VideoEmbed.cfm">
    </div>
</cfoutput> 
    
    
</section>
    
<cfinclude template="footer.cfm">
