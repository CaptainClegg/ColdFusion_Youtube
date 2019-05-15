<cfif #form.UserLevel# eq 1>
        <!--- enabled --->
    <cfquery name="DisableProfile" datasource="superyt_group2">
    UPDATE Users
    SET UserLevel = 0
    WHERE UserName = '#form.UserName#'
    </cfquery>
<cfelse>
        <!---disabled--->
    <cfquery name="EnableProfile" datasource="superyt_group2">
    UPDATE users
    SET UserLevel = 1
    WHERE UserName = '#form.UserName#'
    </cfquery>
</cfif>
    
<cflocation url="profile.cfm?name=#form.UserName#">