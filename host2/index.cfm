<cfscript>
    info = [];
    ArrayAppend(info, cgi.request_url);
    ArrayAppend(info, getApplicationSettings().name);
    ArrayAppend(info, getApplicationSettings().mappings);

    ArrayAppend(info, "model.test" 
    ArrayAppend(info, new model.test().hello());
    ArrayAppend(info, "mapModel.test");
    ArrayAppend(info, new mapModel.test().hello());

    for (i in info){
        systemOutput(i, true);
        echo(serializeJson(i)  & "<br>");
    }
</cfscript>