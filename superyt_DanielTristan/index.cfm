<cfset PageTitle = "Welcome to SuperYT">
<cfinclude template="header.cfm">

<cfif IsDefined("session.access")>
<!--- logged in ---> 
    
<cfquery name="GetVideos" datasource="superyt_group2" maxrows="5">
SELECT *
FROM Videos v, Users u, Followers f
WHERE v.UserID = u.UserID AND u.UserID = f.FolloweeID AND f.FollowerID = #session.UserID#
ORDER BY VideoPublishDate DESC
</cfquery>
    
<cfelse>
<!--- logged out --->    
<cfquery name="GetVideos" datasource="superyt_group2" maxrows="5">
SELECT *
FROM Videos v, Users u
WHERE v.UserID = u.UserID
ORDER BY VideoPublishDate DESC
</cfquery>
    
</cfif>
<section class="container">
<cfoutput query="GetVideos">
<cfinclude template="VideoEmbed.cfm">   
    </div>
</cfoutput>    
    
</section>

      

    
<cfinclude template="footer.cfm">
