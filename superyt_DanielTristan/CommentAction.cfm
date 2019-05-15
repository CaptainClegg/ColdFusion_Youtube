<cfquery name="CreateComment" datasource="superyt_group2">
INSERT INTO Comments (UserID, VideoID, CommentBody, CommentDate)
VALUES (<cfqueryparam value="#form.UserID#" cfsqltype="CF_SQL_INTEGER" maxlength="11">,
    <cfqueryparam value="#form.VideoID#" cfsqltype="CF_SQL_INTEGER" maxlength="11">,
    <cfqueryparam value="#form.CommentBody#" cfsqltype="CF_SQL_LONGVARCHAR">,
    <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">)
</cfquery>

<cflocation url="video.cfm?video=#form.VideoID#">