<cfif #form.VideoActive# eq 1>
        <!--- enabled --->
    <cfquery name="DisableVideo" datasource="superyt_group2">
    UPDATE Videos
    SET VideoActive = 0
    WHERE VideoID = #form.VideoID#
    </cfquery>
<cfelse>
        <!---disabled--->
    <cfquery name="EnableVideo" datasource="superyt_group2">
    UPDATE Videos
    SET VideoActive = 1
    WHERE VideoID = #form.VideoID#
    </cfquery>
</cfif>
    
<cflocation url="video.cfm?video=#form.VideoID#">