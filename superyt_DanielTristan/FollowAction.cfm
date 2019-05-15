<cfquery name="GetFollowed" datasource="superyt_group2">
SELECT *
FROM Followers
WHERE FollowerID = #form.FollowerID# AND FolloweeID = #form.FolloweeID#
</cfquery>

<cfif GetFollowed.RecordCount GTE 1>
        <!--- followed --->
    <cfquery name="DeleteFollow" datasource="superyt_group2">
    DELETE FROM Followers
    WHERE FollowerID = #form.FollowerID# AND FolloweeID = #form.FolloweeID#
    </cfquery>
<cfelse>
        <!---not followed--->
    <cfquery name="CreateFollow" datasource="superyt_group2">
    INSERT INTO Followers (FollowerID, FolloweeID)
    VALUES (#form.FollowerID#, #form.FolloweeID#)
    </cfquery>
</cfif>
    
<cflocation url="#cgi.HTTP_REFERER#">