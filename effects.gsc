// Menu: Effect
    self MenuTitle( "EffectTable", "Effect" );
    self Option( "Stop Bullets Effect", ::multiple_functions_Table, "Delete", "Set Effect" );
    self ToggleCheckBox( "Path Trail Effect", isDefined( player.functions["path_for_trail_FX"] ), ::multiple_functions_Table, "undefined", "Path Trail Effect" );
    self SliderValue( "Scale", 1, 1, 100, self.presets["MULTIPLIER_SLIDER"], ::multiple_functions_Table, "Setting Effect,Effect_Scale" );
    self SliderValue( "Lifetime", 1, 1, 100, self.presets["MULTIPLIER_SLIDER"], ::multiple_functions_Table, "Setting Effect,Effect_Lifetime" );
    if(isDefined(level.GetEffect) && level.GetEffect.size)
    for(af = 0; af < level.GetEffect.size; af++)
    self Option( level.GetEffect[af], ::multiple_functions_Table, level.GetEffect[af], "Set Effect" );
    else
    self Option("No Effect Found");

multiple_functions_Table(parameter, command, player)
{
    parameter = strTok(parameter, ",");
    command = strTok(command, ",");

    if (isDefined(command[0]))
    {
        switch (command[0])
        {
            case "Set Effect":
            if(parameter[0] == "Delete")
            {
                self notify("End_Effect_Test");
                break;
            }

            if(!isDefined( self.functions["Effect_Setting"] ))
            {
                self.functions["Effect_Setting"] = true;
                self.functions["Effect_Scale"] = 1;
                self.functions["Effect_Lifetime"] = 1;
            }

            self notify("End_Effect_Test");
            self endon("End_Effect_Test");
            while (1)
            {
                self waittill("weapon_fired");
                // Get player position and direction
                start = self getEye() + (0,0,-10);
                forward = AnglesToForward(self getPlayerAngles());
                end = start + forward * 10000;

                // Trace bullet path
                trace = bulletTrace(start, end, false, self);

                impactPos = trace["position"];
                impactNormal = trace["normal"];
                impactAngles = VectorToAngles(impactNormal);

                // Step along path for trail FX
                numSteps = 10;
                stepVec = (impactPos - start) / numSteps;

                if(isDefined( self.functions["path_for_trail_FX"] ))
                {
                    for(i = 0; i < numSteps; i++)
                    {
                        pos = start + stepVec * i;
                        #ifdef WW2
                        SpawnScaleFX(level.var_611[parameter[0]], pos, self.angles, 0.5, 0.2);
                        #else
                        SpawnScaleFX(level._effect[parameter[0]], pos, self.angles, 0.5, 0.2);
                        #endif
                }
                }

                // Impact effect
                #ifdef WW2
                SpawnScaleFX(level.var_611[parameter[0]], impactPos, impactAngles, self.functions["Effect_Scale"], self.functions["Effect_Lifetime"]);
                #else
                SpawnScaleFX(level._effect[parameter[0]], impactPos, impactAngles, self.functions["Effect_Scale"], self.functions["Effect_Lifetime"]);
                #endif
            }
            break;

            case "Path Trail Effect":
            self.functions["path_for_trail_FX"] = isDefined(self.functions["path_for_trail_FX"]) ? undefined : true;
            break;

            case "Setting Effect":
            self.functions[command[1]] = NumberValue(parameter[0]);
            if(command[1] == "Effect_Lifetime")
            self iPrintlnBold("" + ReturnTime(NumberValue(parameter[0])));  
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

SpawnScaleFX(effect, origin, angles, scale, lifetime)
{
    if (!isDefined(effect))
        return;

    if (!isDefined(scale))
        scale = 1;

    if (!isDefined(lifetime))
        lifetime = 2;

    numFX = int(scale * 3);  // number of FX copies
    radius = scale * 10;

    fxEntities = [];

    // Spawn FX copies
    for (i = 0; i < numFX; i++)
    {
        angle = (360 / numFX) * i;
        offset = (cos(angle) * radius, sin(angle) * radius, 0);

        fx = SpawnFX(effect, origin + offset);
        TriggerFX(fx);

        fxEntities[fxEntities.size] = fx;
    }

    // Thread a cleanup for just this group of FX
    thread deleteFXArrayAfter(fxEntities, lifetime);
}

deleteFXArrayAfter(fxEntities, lifetime)
{
    wait lifetime;

    for (i = 0; i < fxEntities.size; i++)
    {
        if (isDefined(fxEntities[i]))
            fxEntities[i] delete();
    }
}

NumberValue( stringVal )
{
    floatElements = strtok( stringVal, "." );
    floatVal      = int( floatElements[0] );
    if( isDefined( floatElements[1] ) )
    {
        modifier = 1;
        for ( i = 0; i < floatElements[1].size; i++ )
        modifier *= 0.1;
        
        floatVal += int ( floatElements[1] ) * modifier;
    }
    return floatVal;    
}

ReturnTime(seconds)
{
    hours = 0;
    minutes = 0;
    if(seconds > 59)
    {
        minutes = int(seconds / 60);
        seconds = (int(seconds * 1000)) % 60000;
        seconds = seconds * 0.001;
        if(minutes > 59)
        {
            hours = int(minutes / 60);
            minutes = (int(minutes * 1000)) % 60000;
            minutes = minutes * 0.001;
        }
    }
    if(hours < 10)
    {
        hours = "0" + hours;
    }
    if(minutes < 10)
    {
        minutes = "0" + minutes;
    }
    seconds = int(seconds);
    if(seconds < 10)
    {
        seconds = "0" + seconds;
    }
    combined = (((("" + hours) + ":") + minutes) + ":") + seconds;
    return combined;
}