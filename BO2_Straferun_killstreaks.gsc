Straferun_killstreaks(command)
{
    command = strTok(command, ",");

    if (isDefined(command[0]))
    {
        switch (command[0])
        {
            case "Call Straferun":
            self endon("stop_straferun");
            planelimit = 15;
            for( plane = 0; plane < planelimit; plane++ )
            {
                startnode = getvehiclenode( "warthog_start", "targetname" );
                level.planestraferun[plane] = spawnvehicle( level.straferunmodel, "straferun", level.straferunvehicle, startnode.origin, ( 0, 0, 0 ) );
                level.planestraferun[plane] setowner( self );
                level.planestraferun[plane].owner = self;
                level.planestraferun[plane] thread maps\mp\killstreaks\_straferun::playcontrail();
                level.planestraferun[plane].gunsoundentity = spawn( "script_model", plane gettagorigin( "tag_flash" ) );
                level.planestraferun[plane].gunsoundentity linkto( plane, "tag_flash", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                level.planestraferun[plane] thread maps\mp\_vehicles::follow_path( startnode );
                wait 2;
            }
            break;

            case "Fire Rockets":
            self.functions["fire_rockets"] = isDefined(self.functions["fire_rockets"]) ? undefined : true;
            while(isDefined(self.functions["fire_rockets"]))
            {
                for( plane = 0; plane < level.planestraferun.size; plane++ )
                {
                    level.planestraferun[plane] thread maps\mp\killstreaks\_straferun::firerockets();
                }
                wait 2;
            }
            break;

            case "Straferun Return Home":
            self notify("stop_straferun");
            for( plane = 0; plane < level.planestraferun.size; plane++ )
            {
                level.planestraferun[plane] thread maps\mp\killstreaks\_straferun::leavemap();
            }
            break;

            default:
            //self iprintln("Unknown command in command[0]: " + command[0]);
            break;
        }
    }
    else
    {
        //self iprintln("Command[0] not defined.");
    }
}