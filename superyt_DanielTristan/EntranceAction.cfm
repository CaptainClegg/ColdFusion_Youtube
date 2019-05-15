<cfquery name="CheckPassword" datasource="superyt_group2">
SELECT *
FROM Users
WHERE UserName = '#form.UserName#' AND UserPassword = '#form.UserPassword#'
</cfquery>

<cfif CheckPassword.RecordCount IS NOT 0>
    <cfif #CheckPassword.UserLevel# eq 0>
        Sorry, this account has been disabled.
    <cfabort>
    </cfif>
    
    
    <cfquery name="update" datasource="superyt_group2">
    UPDATE Users
    SET UserLastLogin = #Now()#
    WHERE UserName = '#form.UserName#'
    </cfquery>
    
    <cfset session.access = #CheckPassword.UserLevel#>
    <cfset session.username = "#CheckPassword.UserName#">
    <cfset session.userid = #CheckPassword.UserID#>
    <cflocation url="#cgi.HTTP_REFERER#">
        
    
<cfelse>
    Sorry, that password doesn't work.
    <cfabort>


</cfif>