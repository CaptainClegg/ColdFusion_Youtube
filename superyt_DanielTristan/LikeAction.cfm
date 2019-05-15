<cfquery name="GetLiked" datasource="superyt_group2">
SELECT *
FROM Likes
WHERE UserID = #form.UserID# AND VideoID = #form.VideoID#
</cfquery>

<cfif GetLiked.RecordCount GTE 1>
    <!--- liked --->
    <cfquery name="DeleteLiked" datasource="superyt_group2">
    DELETE FROM Likes
    WHERE UserID = #form.UserID# AND VideoID = #form.VideoID#
    </cfquery>
<cfelse>
    <!---not liked--->
    <cfquery name="CreateLiked" datasource="superyt_group2">
    INSERT INTO Likes (UserID, VideoID)
    VALUES (#form.UserID#, #form.VideoID#)
    </cfquery>
</cfif>
<cflocation url="video.cfm?video=#VideoID#">