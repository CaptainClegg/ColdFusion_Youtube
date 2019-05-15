<h2>Create User with Password</h2>

<cfset salt = hash(generateSecretKey("AES"), "SHA-512")>
    
<p>Salt - <cfoutput>#salt#</cfoutput><br /><strong>store in database as "salt"</strong>
    
<cfset password = "socks2">
    
<p>Password - <cfoutput>#password#</cfoutput>
    
<cfset saltAndPassword = password & salt>
    
<p>Salt and Password -  <cfoutput>#saltAndPassword#</cfoutput>
    
<cfset encryptedSaltAndPassword = hash(saltAndPassword, "SHA-512", "utf-8", 860)>
       
<p>Encrypted Salt and Password - <cfoutput>#encryptedSaltAndPassword#</cfoutput><br /><strong>store in database as "userPassword"</strong>
    
    
<h2>Validate password</h2>
    
<cfparam name="form.password" default="socks2">
<cfparam name="CheckUserName.salt" default="#salt#">
<cfparam name="CheckUserName.userPassword" default="#encryptedSaltAndPassword#">    
    
<!--- Generate the encrypted salt and password based on the submitted password and the salt from the database --->

<cfset saltAndPassword2 = form.password & CheckUserName.salt>

<cfset encryptedSaltAndPassword2 = hash(saltAndPassword2, "SHA-512", "utf-8", 860)>

<!--- Test whether the generated salt and password match the value stored in the database userPassword field --->

<cfif CheckUserName.userPassword eq encryptedSaltAndPassword2>
    This password matches
<cfelse>
    This password doesn't match
</cfif>    