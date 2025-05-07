<cfscript>
    function logger( mess ){
        ArrayAppend( info, mess );
        if ( isSimpleValue(mess) ) {
            WriteLog( text=mess, type="INFO", log="application" );
            if ( mess contains "two" )
                throw "CFC from two on host1";
        } else {
            for (var m in mess) {
                WriteLog( text=m.toJson(), type="INFO", log="application" );
            }
        }
    }

    info = [];
    logger(cgi.request_url);
    logger("ApplicationName: " & getApplicationSettings().name);
    logger("------------mappings-----------------");
    logger(getApplicationSettings().mappings);
    logger(" " );
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

    logger("--componentMapping.test");
    logger(new componentMapping.test().hello());

    logger("--createObject(componentMapping.test)" );
    logger(createObject("componentMapping.test").hello());

    logger("--createObject(/componentMapping/test)" );
    logger(createObject("/componentMapping/test").hello());


    for (i in info){
        systemOutput(i, true);
        echo(serializeJson(i)  & "<br>");
    }

    systemOutput("", true);
    echo("<hr>");
    systemOutput("#### componentCacheList()", true);
    echo("#### componentCacheList()#chr(10)#");

    componentCache = componentCacheList();
    loop collection="#componentCache#" key="k" value="v" {
        systemOutput("#k#: #v# <br>", true);
        echo("#k#: #v# <br>");
    }

</cfscript>