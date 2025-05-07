<cfscript>
    function logger( mess ){
        ArrayAppend( info, mess );
        WriteLog( text=mess, type="INFO", log="application" );
    }

    info = [];
    logger(cgi.request_url);
    logger(getApplicationSettings().name);
    logger(getApplicationSettings().mappings);

    logger("--model.test" );
    logger(new model.test().hello());

    logger("--createObject(model.test)" );
    logger(createObject("model.test").hello());

    logger("--createObject(/model/test)" );
    logger(createObject("/model/test").hello());


    logger("--mapModel.test");
    logger(new mapModel.test().hello());

    logger("--createObject(mapModel.test)" );
    logger(createObject("mapModel.test").hello());

    logger("--createObject(/mapModel/test)" );
    logger(createObject("/mapModel/test").hello());

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