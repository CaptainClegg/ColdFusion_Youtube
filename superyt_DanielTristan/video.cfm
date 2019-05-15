<cfif NOT IsDefined("URL.video")>
    <cflocation url="./">        
</cfif>

<cfset PageTitle = "Welcome to SuperYT">
<cfinclude template="header.cfm">

<cfquery name="GetVideos" datasource="superyt_group2">
SELECT *
FROM Videos v, Users u
WHERE v.UserID = u.UserID AND v.VideoID = '#URL.video#'
ORDER BY VideoPublishDate DESC
</cfquery>

<cfoutput query="GetVideos">
    <cfif #VideoActive# eq 0>
        <cfif NOT IsDefined("session.access")>
            <cflocation url="./">        
        </cfif>
        <cfif NOT #session.access# eq 9>
            <cflocation url="./">        
        </cfif>
    </cfif>
</cfoutput>
    
<cfquery name="GetComments" datasource="superyt_group2">
SELECT *
FROM Comments c, Users u
WHERE c.VideoID = '#URL.video#' AND u.UserID = c.UserID
ORDER BY CommentDate DESC
</cfquery>



    
<section class="container">
<cfoutput query="GetVideos">
<cfinclude template="VideoEmbed.cfm">
    
<cfif IsDefined("session.access")>
<!--- logged in ---> 
<cfquery name="GetFollowed" datasource="superyt_group2">
SELECT *
FROM Followers
WHERE FollowerID = #session.userid# AND FolloweeID = #GetVideos.UserID#
</cfquery>

<cfquery name="GetLiked" datasource="superyt_group2">
SELECT *
FROM Likes
WHERE UserID = #session.userid# AND VideoID = #URL.video#
</cfquery>
    
<div class="col-sm-2">
<form action="FollowAction.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="FollowerID" maxlength="11" value="#session.userid#" required>
    <input hidden name="FolloweeID" maxlength="11" value="#GetVideos.UserID#" required>
    <br>
    <cfif #session.userid# eq #GetVideos.UserID#>
        
    <cfelseif GetFollowed.RecordCount GTE 1>
        <!--- followed --->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Un-Follow #UserName#</button>
    <cfelse>
        <!---not followed--->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Follow #UserName#</button>
    </cfif>
</form>
</div>
    
    
    
<div class="col-sm-2">
<form action="LikeAction.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="UserID" maxlength="11" value="#session.userid#" required>
    <input hidden name="VideoID" maxlength="11" value="#URL.video#" required>
    <br>
    <cfif #session.userid# eq #GetVideos.UserID#>
    <cfelseif GetLiked.RecordCount GTE 1>
        <!--- liked --->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Un-Like Video</button>
    <cfelse>
        <!---not liked--->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Like Video</button>
    </cfif>
</form>
</div>
    
    
<div class="col-sm-2">
<form action="VideoDelete.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="VideoID" maxlength="11" value="#URL.video#" required>
    <br>
    <cfif (#session.access# eq 9) OR (#session.userid# eq #GetVideos.UserID#)>
        <!--- admin delete --->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Delete Video</button>
    <cfelse>
    </cfif>
</form>
</div>
    

<cfif #session.access# eq 9>
<div class="col-sm-2">
<form action="DisableVideo.cfm" method="post" enctype="multipart/form-data">
    <input hidden name="VideoActive" maxlength="11" value="#VideoActive#" required>
    <input hidden name="VideoID" maxlength="11" value="#URL.video#" required>
    <br>
    <cfif #VideoActive# eq 1>
        <!--- enabled --->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Disable Video</button>
    <cfelse>
        <!---disabled--->
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Enable Video</button>
    </cfif>
</form>
</div>
</cfif>
    
    
    
    
    
    </div>
    <br><br>
    <div class="row" style="border-top-style: solid">
        <div class="col-sm-4">
            <h3>Add Comment</h3>
            <form action="CommentAction.cfm" method="post" enctype="multipart/form-data">
                <input hidden name="UserID" maxlength="11" value="#session.userid#" required>
                <input hidden name="VideoID" maxlength="11" value="#URL.video#" required>
                <textarea class="form-control mr-sm-2" name="CommentBody" id="CommentBody" required></textarea>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Comment</button>
            </form>
            
            
            
            
            
        </div>
    </div>
<cfelse>
<!--- logged out --->  
    <div class="col-sm-5">
        <h3 style="color: indianred">Create an account to like this video or follow this user. You can also comment on videos.</h3>
    </div>
    </div>
</cfif>

    

        
</cfoutput>    
    <br><br>
<div class="row" style="border-top-style: solid">
    <div class="col-sm-5">
        <h3>Video Comments</h3>
        <br>
        <cfoutput query="GetComments">
            <div style="border-style: solid">
            <a href="profile.cfm?name=#UserName#"><cfif FileExists("#TheLocation#\#userid#-500.jpg")>
                                <img src="#TheFilePath#/images/profiles/#userid#-500.jpg" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                            <cfelse>
                                <img src="images/anon.png" alt="#username#" style="border-radius: 10px; max-width: 25px; height: 25px; float: left;">
                        </cfif><h5>#UserDisplayName#</h5></a>
                <h6>#DateFormat(CommentDate, "mmm d, yyyy")# #TimeFormat(CommentDate, "h:mm tt")#</h6>
                
            <p style="text-indent: 3em;">#CommentBody#</p>
                <cfif IsDefined("session.access")>
                    <cfloop query="GetVideos">
                <cfif (#session.access# eq 9) OR (#session.userid# eq #GetVideos.UserID#) OR (#session.userid# eq #GetComments.UserID#)>
                    <form action="CommentDelete.cfm" method="post" enctype="multipart/form-data">
                        <input hidden name="CommentID" maxlength="11" value="#GetComments.CommentID#" required>
                        <input hidden name="VideoID" maxlength="11" value="#URL.video#" required>
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Delete Comment</button>
                    </form>
                </cfif>
                        </cfloop>
                </cfif>
            </div>
        </cfoutput>
            
    </div>
</div>    

</section>

      

    
<cfinclude template="footer.cfm">
