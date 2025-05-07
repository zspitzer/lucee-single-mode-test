<cfscript>
    function logger( mess ){
        ArrayAppend( info, mess );
        if ( isSimpleValue(mess) ) {
            WriteLog( text=mess, type="INFO", log="application" );
//            if ( mess contains "two" )                 throw "CFC from two on host1";
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

    // via application.cfc mapping
    logger("--new regular.regularMapping" );
    logger(new regular.regularMapping().hello());

    logger("--createObject(regular.regularMapping)" );
    logger(createObject("regular.regularMapping").hello());

    logger("--createObject(/regular/regularMapping)" );
    logger(createObject("/regular/regularMapping").hello());

    // via implicit root mapping
    logger("--new " );
    logger(new baseMapping.baseMapping().hello());

    logger("--createObject()" );
    logger(createObject("baseMapping.baseMapping").hello());

    logger("--createObject(/baseMapping/baseMapping)" );
    logger(createObject("/baseMapping/baseMapping").hello());

    // via componentPaths
    logger("--new componentMapping" );
    logger(new componentMapping().hello());

    logger("--createObject(componentMapping)" );
    logger(createObject("componentMapping").hello());

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