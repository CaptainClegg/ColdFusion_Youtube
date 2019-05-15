    <cfquery name="DeleteLiked" datasource="superyt_group2">
    DELETE FROM Videos
    WHERE VideoID = #form.VideoID#
    </cfquery>

<cflocation url="./">