<cfoutput>
    
<cfquery name="GetLikes" datasource="superyt_group2">
SELECT *
FROM Likes
WHERE VideoID = #VideoID#    
</cfquery>
<br>
<div class="row">
  
<cfif PlatformID IS 1>
<!--- youtube --->    
    <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/#VideoKey#?rel=0" allowfullscreen>
          </iframe>
        </div>
    <cfelse>
        <div class="col-sm-3"> 
            <a href="video.cfm?video=#VideoID#"><img src="https://img.youtube.com/vi/#VideoKey#/hqdefault.jpg"  width="100%"></a>
        </div>
    </cfif>
    
<cfelseif PlatformID IS 2>
<!--- vimeo --->    
    <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" src="https://player.vimeo.com/video/#VideoKey#" allowfullscreen width="100%">
          </iframe>
        </div>
    <cfelse>
        <div class="col-sm-3"> 
            <a href="video.cfm?video=#VideoID#"><img src="images/vimeo.png"  width="100%"></a>
        </div>
    </cfif>
    
<cfelseif PlatformID IS 3>
    <!---Livestream--->
    <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" src="https://livestream.com/accounts/#VideoKey#/player?width=0&height=0&enableInfo=true&defaultDrawer=&autoPlay=false&mute=false" allowfullscreen>
          </iframe>
        </div>
    <cfelse>
        <div class="col-sm-3"> 
            <a href="video.cfm?video=#VideoID#"><img src="images/livestream.jpg"  width="100%"></a>
        </div>
    </cfif>
    
<cfelseif PlatformID IS 4>
        <!---Twitch--->
    <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm">
        <div class="embed-responsive embed-responsive-16by9">
        <iframe
        src="https://player.twitch.tv/?video=#VideoKey#&autoplay=false"
        frameborder="0"
        scrolling="no"
        allowfullscreen="true">
        </iframe>
        </div>
    <cfelse>
        <div class="col-sm-3"> 
            <a href="video.cfm?video=#VideoID#"><img src="images/twitch.png"  width="100%"></a>
        </div>
    </cfif>

    
<cfelseif PlatformID IS 5>
        <!---Facebook--->
    <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm">
    <div class="embed-responsive embed-responsive-16by9">
    <iframe src="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2#VideoKey#%2F&show_text=0" scrolling="no" frameborder="0" allowTransparency="true" allowFullScreen="true"></iframe>
    </div>
    <cfelse>
        <div class="col-sm-3"> 
            <a href="video.cfm?video=#VideoID#"><img src="images/facebook.png"  width="100%"></a>
        </div>
    </cfif>
    
</cfif>
    
<div class="col-sm-6">
    <h3><cfif NOT #cgi.script_name# eq "/superyt_DanielTristan/video.cfm"><a href="video.cfm?video=#VideoID#">#VideoTitle#</a><cfelse>#VideoTitle#</cfif></h3>
        <h4>By <cfif #cgi.script_name# eq "/superyt_DanielTristan/profile.cfm"> #UserDisplayName#<cfelse><a href="profile.cfm?name=#UserName#">
            <cfif #cgi.script_name# eq "/superyt_DanielTristan/video.cfm"><cfif FileExists("#TheLocation#\#userid#-500.jpg")>
                                <img src="#TheFilePath#/images/profiles/#userid#-500.jpg" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                            <cfelse>
                                <img src="images/anon.png" alt="#username#" style="border-radius: 40px; max-width: 70px; height: 70px; float: left;">
                        </cfif></cfif>
            #UserDisplayName#</a></cfif></h4>
    <h6>Uploaded on #DateFormat(VideoPublishDate, "mmm d, yyyy")# #TimeFormat(VideoPublishDate, "h:mm tt")#</h6>
            
    <p>#VideoDesc#</p>
    
</div>
<div class="col-sm-1">
    <br>
    <h6>#GetLikes.RecordCount# <cfif GetLikes.RecordCount IS 1>Like<cfelse>Likes</cfif></h6>
    <!---#CGI.HTTP_REFERER#
    #cgi.script_name#--->
</div>


</cfoutput>