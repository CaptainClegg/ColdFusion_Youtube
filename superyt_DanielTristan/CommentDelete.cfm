<cfquery name="DeleteComment" datasource="superyt_group2">
DELETE FROM Comments
WHERE CommentID = #form.CommentID#
</cfquery>

<cflocation url="video.cfm?video=#form.VideoID#">