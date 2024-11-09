Test_Code(Data, Code, p1, p2, p3)
{
    switch(Code)
    {
        case 0:
        p1 hudMoveX(Data, p2);
        break;
        case 1:
        p1 hudMoveY(Data, p2);
        break;
        case 2:
        p1 hudMoveXY(Data, p2, p2);
        break;
        case 3:
        p1 hudFade(Data, p2);
        break;
        case 4:
        if(!isDefined( string ))
        {
            self thread refreshMenu();
            wait .2;
            string = self do_keyboard( p1, p2 );
            wait 1;
            self notify( "reopen_menu" );
        }
        if(!isDefined( string ))
        return;
        level.EditTime = Int(string);
        break;
        
        case 5:
        self endon("disconnect");
        if( !self areYouSure() )
        return;
        self lockMenu("lock", "open");
        wait 1;
        self thread progressbar( 0, 100, 1, 0.075);
        if(!self.StopYouFromSelectingOptionIfUsing)
        {
            self.StopYouFromSelectingOptionIfUsing = true;
            self iPrintlnbold("Task start.");
            Call = ["First Name 1", "First Name 2", "First Name 3", "First Name 4", "First Name 5", "First Name 6", "First Name 7", "First Name 8", "First Name 9", "First Name 10"];
            foreach( name in Call )
            {
                self iprintln("Call " + name + " for each");
                wait 1;// Loop Speed
            }
            self iPrintlnbold("Task ^2completed");
            self.StopYouFromSelectingOptionIfUsing = false;
            self waittill("progress_done");
            self lockMenu("unlock", "open");
        }
        break;
        
        case 6:
        //add code
        break;
        
        case 7:
        if(!isDefined(self.stringlimit["GET_STRING_LIMIT"]))
        {
            self.stringlimit["GET_STRING_LIMIT"] = true;
            MemoryAllocation( "Set", "GET_STRING_LIMIT", "true" );
            wait(.2);
            exitlevel(false);
        }
        else
        {
            self.stringlimit["GET_STRING_LIMIT"] = undefined;
            self.maxstringon = undefined;
            MemoryAllocation( "Set", "GET_STRING_LIMIT", "undefined" );
            self notify("Stop_MaxString");
            wait(.2);
            self.maxstringlimit destroy();
        }
        break;
        
        case 8:
        if(!isDefined(self.modellimit["GET_MODEL_LIMIT"]))
        {
            if(self.RemoveModel < 1)
            {
                self.modellimit["GET_MODEL_LIMIT"] = true;
                self.RemoveModel = 0;
                self thread GetMaxScriptModelLimit();
            }
        }
        else
        {
            self.modellimit["GET_MODEL_LIMIT"] = undefined;
            self.maxscript_modelon = undefined;
            self notify("Stop_MaxScript_Model");
            wait(.2);
            self.maxmodellimittext destroy();
            for( model = 1; self.RemoveModel; model++ )
            {
                self.maxmodellimit[model] delete();
                wait(.1);
                self iPrintlnBold( "Destroy Model: ^1" + model );
                self.RemoveModel --;
                if(self.RemoveModel == 0)
                break;
            }
        }
        break;
        
        case 9:
        // add code
        break;
        
        case 10:
        foreach(player in level.players)
        player thread createNewsBar("Welcome to "+self.presets["SET_TEXT_MENU_NAME"]+" ^2"+self getName()+" ^7| Access level: Host^7 | YouTube > ^1SoundlessEcho^7 for more mods", "Open Menu: ^2[{+speed_throw}] ^7+ ^2[{+melee}] ^7| Scroll Down: ^2[{+attack}] ^7 Scroll Up: ^2[{+speed_throw}] ^7| Select: ^2[{+activate}] ^7| Back:^2 [{+melee}] ^7| Close Menu: ^2[{+stance}]");
        break;
        
        case 11:
        // add code
        break;
        case 12:
        exitlevel(false);
        break;
        
        case 13:
        MemoryAllocation("Set", p1, Data);
        break;
        
        case 14:
        #ifdef BO2 || MW2 || MW3 || GHOSTS self iprintln("Test Option: ^2"+Data); #endif
        #ifdef BO3 
            #ifdef ZM
                self iPrintlnBold("Test Option: ^2"+Data);
            #endif
            self iprintln("Test Option: ^2"+Data);
        #endif
        break;
        case 15:
        level.TimeCheck = Data;
        break;
    }
}

// multiple functions, I use this in developer kit use this to understand my code.
multiple_functions(parameter, command)
{
    // Split parameters and command strings into arrays
    parameter = strTok(parameter, ",");
    command = strTok(command, ",");

    // Listen for events like disconnect, game ended, or player death
    self endon_multiple( "disconnect,game_ended,death" ); // Optional

    // Check if the command has at least one element to avoid out-of-bounds errors
    if (isDefined(command[0]))
    {
        // Why have more then one switch (command[0]). So if maybe you want to add a check switch (command[0]) use a if statements like if(player.sessionstate != "spectator") or if(!player isVerified()) and so forth.
        switch (command[0])
        {
            case "functions_1":
            // Placeholder for function 1 logic
            self iprintln("Function 1 is selected.");
            // How to defined parameter Examples
            // self Option( "Multiple Functions", ::multiple_functions, "parameter 0,parameter 1", "functions_1,undefined" );
            // Look at "parameter 0,parameter 1" parameter 0 = parameter[0] and parameter 1 = parameter[1] and so forth.
            // Why do it this way? So you don?t limit yourself on how many parameters you can use
            // If you need the parameter to be Integer or float self iprintln("Test Option: ^2" + NumberValue( parameter[0]) ); NumberValue will turn the string in to number it a Built in function for Developer Kit
            self iprintln("Test Option: ^2" + parameter[0] );
            self iprintln("Test Option: ^2" + parameter[1] );
            break;

            case "functions_2":
            // Placeholder for function 2 logic
            self iprintln("Function 2 is selected.");
            break;

            case "functions_3":
            // Placeholder for function 3 logic
            self iprintln("Function 3 is selected.");
            break;

            case "functions_4":
            // Placeholder for function 4 logic
            self iprintln("Function 4 is selected.");
            break;

            case "functions_5":
            // Placeholder for function 5 logic
            self iprintln("Function 5 is selected.");
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

    // Now check for command[1], if it exists, use a similar structure
    if (isDefined(command[1]))
    {
        // Why have more then one switch (command[0]). So if maybe you want to add a check switch (command[1]) use a if statements like if(player.sessionstate != "spectator") or if(!player isVerified()) and so forth.
        switch (command[1])
        {
            case "functions_1":
            self iprintln("Second command functions_1 selected.");
            // How to defined parameter Examples
            // self Option( "Multiple Functions", ::multiple_functions, "parameter 0,parameter 1", "undefined,functions_1" );
            // Look at "parameter 0,parameter 1" parameter 0 = parameter[0] and parameter 1 = parameter[1] and so forth.
            // Why do it this way? So you don?t limit yourself on how many parameters you can use
            // If you need the parameter to be Integer or float self iprintln("Test Option: ^1" + NumberValue( parameter[0]) ); NumberValue will turn the string in to number it a Built in function for Developer Kit
            self iprintln("Test Option: ^1" + parameter[0] );
            self iprintln("Test Option: ^1" + parameter[1] );
            break;

            case "functions_2":
            self iprintln("Second command functions_2 selected.");
            break;

            case "functions_3":
            self iprintln("Second command functions_3 selected.");
            break;

            case "functions_4":
            self iprintln("Second command functions_4 selected.");
            break;

            case "functions_5":
            self iprintln("Second command functions_5 selected.");
            break;

            default:
            //self iprintln("Unknown command in command[1]: " + command[1]);
            break;
        }
    }
    else
    {
        //self iprintln("Command[1] not defined.");
    }
}

endon_multiple( parameter )
{
    foreach( name in strTok( parameter, ","))
    self endon(name);
}