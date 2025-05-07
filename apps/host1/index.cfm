<cfscript>
    info = [];
    ArrayAppend(info, cgi.request_url);
    ArrayAppend(info, getApplicationSettings().name);
    ArrayAppend(info, getApplicationSettings().mappings);

    ArrayAppend(info, "--model.test" );
    ArrayAppend(info, new model.test().hello());

    ArrayAppend(info, "--createObject(model.test)" );
    ArrayAppend(info, createObject("model.test").hello());

    ArrayAppend(info, "--createObject(/model/test)" );
    ArrayAppend(info, createObject("/model/test").hello());


    ArrayAppend(info, "--mapModel.test");
    ArrayAppend(info, new mapModel.test().hello());

    ArrayAppend(info, "--createObject(mapModel.test)" );
    ArrayAppend(info, createObject("mapModel.test").hello());

    ArrayAppend(info, "--createObject(/mapModel/test)" );
    ArrayAppend(info, createObject("/mapModel/test").hello());


    for (i in info){
        systemOutput(i, true);
        echo(serializeJson(i)  & "<br>");
    }

    systemOutput("", true);
    echo("<hr>");
    systemOutput("#### componentCacheList()", true);
    echo("#### componentCacheList()");

    componentCache = componentCacheList();
    loop collection="#componentCache#" key="k" value="v" {
        systemOutput("#k#: #v# <br>", true);
        echo("#k#: #v# <br>");
    }

</cfscript>