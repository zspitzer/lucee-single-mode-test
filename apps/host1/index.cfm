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
    logger("--new regular.regularMapping()" );
    logger(new regular.regularMapping().hello());

    logger("--createObject(regular.regularMapping)" );
    logger(createObject("regular.regularMapping").hello());

    logger("--createObject(/regular/regularMapping)" );
    logger(createObject("/regular/regularMapping").hello());

    logger(" " );
    // via implicit root mapping
    logger("--new baseMapping.baseMapping()" );
    logger(new baseMapping.baseMapping().hello());

    logger("--createObject(baseMapping.baseMapping)" );
    logger(createObject("baseMapping.baseMapping").hello());

    logger("--createObject(/baseMapping/baseMapping)" );
    logger(createObject("/baseMapping/baseMapping").hello());
    logger(" " );
    // via componentPaths
    logger("--new componentMapping()" );
    logger(new componentMapping().hello());

    logger("--createObject(componentMapping)" );
    logger(createObject("componentMapping").hello());

    for (i in info){
        systemOutput(i, true);
        if ( isSimpleValue(i) ){
            if ( i contains "testtwo" )
                echo(":x: #i#<br>#chr(10)#");
            else 
                echo("#i#<br>#chr(10)#");
        } else {
            if ( serializeJson(i) contains "testtwo" )
                echo(":x: #serializeJson(i)#<br>#chr(10)#");
            else 
                echo("#serializeJson(i)#<br>#chr(10)#");
        }
    }

    systemOutput("", true);
    echo("<hr>#chr(10)##chr(10)#");
    systemOutput("#### componentCacheList()", true);
    echo("#### componentCacheList()#chr(10)##chr(10)#");

    componentCache = componentCacheList();
    loop collection="#componentCache#" key="k" value="v" {
        systemOutput("#k#: #v# <br>", true);
        echo("#k#: #v# <br>#chr(10)#");
    }

</cfscript>