<cfset TheLocation = "C:\ColdFusion11\cfusion\wwwroot\superyt_DanielTristan\images\profiles">
<cfset TheFilePath = "/superyt_DanielTristan">

<cfquery name="CheckUserName" datasource="superyt_group2">
SELECT *
FROM Users
WHERE UserName = '#form.UserName#'
</cfquery>

<cfif CheckUserName.RecordCount GTE 1>
    <h1>Sorry, that User Name is already taken.</h1>
    <cfabort>
</cfif>

<cfquery name="CheckEmail" datasource="superyt_group2">
SELECT *
FROM Users
WHERE UserEmail = '#form.UserEmail#'
</cfquery>

<cfif CheckUserName.RecordCount GTE 1>
    <h1>Sorry, that Email is already associated with an account. Please choose another.</h1>
    <cfabort>
</cfif>


<cfquery name="InsertAccount" datasource="superyt_group2">
INSERT INTO Users(UserName, UserPassword, UserDisplayName, UserDesc, UserEmail, UserAddDate, UserLastLogin)
VALUES(<cfqueryparam value="#form.UserName#" cfsqltype="CF_SQL_VARCHAR" maxlength="45">,
        <cfqueryparam value="#form.UserPassword#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
        <cfqueryparam value="#form.UserDisplayName#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
        <cfqueryparam value="#form.UserDesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="250">,
        <cfqueryparam value="#form.UserEmail#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
        <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">,
        <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">)
</cfquery>

<cfquery name="GetNewUser" datasource="superyt_group2">
SELECT MAX(UserID) AS MaxUserID
FROM Users
</cfquery>
<cfif IsDefined("form.UserPhoto")>
    <cffile action="upload"
            filefield="UserPhoto"
            destination="#TheLocation#"
            nameconflict="OVERWRITE"
            accept="image/*">
        
    <cffile action="rename"
            source="#TheLocation#\#File.ServerFile#"
            destination="#TheLocation#\#GetNewUser.MaxUserID#-raw.jpg">
        
    <cfimage action="resize"
             source="#TheLocation#\#GetNewUser.MaxUserID#-raw.jpg"
             destination="#TheLocation#\#GetNewUser.MaxUserID#-500.jpg"
             width="500"
             height=""
             overwrite="Yes">
        
    <cfimage action="resize"
             source="#TheLocation#\#GetNewUser.MaxUserID#-raw.jpg"
             destination="#TheLocation#\#GetNewUser.MaxUserID#-100.jpg"
             width="100"
             height=""
             overwrite="Yes">
</cfif>
        
        
<cfquery name="CheckPassword" datasource="superyt_group2">
SELECT *
FROM Users
WHERE UserName = '#form.UserName#' AND UserPassword = '#form.UserPassword#'
</cfquery>
        
        
<cfset session.access = #CheckPassword.UserLevel#>
<cfset session.username = "#CheckPassword.UserName#">
<cfset session.userid = #CheckPassword.UserID#>
<cflocation url="profile.cfm?name=#CheckPassword.UserName#">