<cfif NOT IsDefined("session.access")>
    <cflocation url="./">
</cfif>
<cfif IsDefined("form.VideoTitle")>
    <cfquery name="AddVideo" datasource="superyt_group2">
    INSERT INTO Videos(VideoTitle, VideoPublishDate, VideoDesc, UserID, PlatformID, VideoURL, VideoKey)
    VALUES(<cfqueryparam value="#form.VideoTitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
        <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">,
        <cfqueryparam value="#form.VideoDesc#" cfsqltype="CF_SQL_LONGVARCHAR">,
        <cfqueryparam value="#form.UserID#" cfsqltype="CF_SQL_INTEGER" maxlength="11">,
        <cfqueryparam value="#form.PlatformID#" cfsqltype="CF_SQL_INTEGER" maxlength="11">,
        <cfqueryparam value="#form.VideoURL#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
        <cfqueryparam value="#form.VideoKey#" cfsqltype="CF_SQL_VARCHAR" maxlength="150">)
    </cfquery>
    
    <!--
    <cfquery name="UpdateVideoDescription" datasource="superyt_group2">
    UPDATE videos
    SET VideoDesc = #form.VideoDesc#
    WHERE     
    </cfquery>
    -->

    <cfquery name="GetVideoID" datasource="superyt_group2">
    SELECT MAX(VideoID) AS MaxVideoID
    FROM Videos
    </cfquery>
    <cfoutput  query="GetVideoID">
    <cflocation url="video.cfm?video=#MaxVideoID#">
    </cfoutput>
<cfelse>
    <cflocation url="./">
</cfif>