/*
NOTE

comments = //
Remove comments to run code
Add comments to stop code from runing

isDefined() = check for true or undefined

size = number of arrays in Call = ["name_1", "name_2", "name_3", "name_4", "name_5", "name_6", "name_7", "name_8", "name_9", "name_10"];
call.size would = 10
*/
multiple_functions_syntax(parameter, command)
{
    // Split parameters and command strings into arrays
    parameter = strTok(parameter, ",");
    command = strTok(command, ",");

    // Check if the command has at least one element to avoid out-of-bounds errors
    if (isDefined(command[0]))
    {
        switch (command[0])
        {
            case "Basic Function":
            /*
            How to call Basic Function syntax

            Option Definition = ( "Name Function", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self Option( "Test Basic Function", ::multiple_functions, undefined, "Basic Function" );
            self Option( "Test Basic Function Parameter", ::multiple_functions, "Hello Parameter", "Basic Function" );

            SliderString Definition = ( "Name Function", "Name ID", "Name", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self SliderString( "Test Basic Function Parameter", "Hello 1, Hello 2", "Hello 1,Hello 2", ::multiple_functions, "Basic Function" );

            SliderValue Definition = ( "Name Function", "Number to start with", "Minimum number", "Max number", "Multiply number", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self SliderValue( "Test Basic Function Parameter", 0, 0, 50, 1, ::multiple_functions, "Basic Function" );
            */

            //self iPrintlnBold( "Placeholder for function logic: ^1" + parameter[0] ); // If you want to use parameter || Use iPrintlnBold to debug code
            self iPrintlnBold( "Placeholder for function logic: ^1Hello" ); // If not use parameter || Use iPrintlnBold to debug code
            break;

            case "If Function":
            /*
            How to call If statement syntax

            Option Definition = ( "Name Function", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self Option( "Test Basic Function Parameter", ::multiple_functions, "name_1", "If Function" );
            self Option( "Test Basic Function Parameter", ::multiple_functions, "name_2", "If Function" );
            */

            if(parameter[0] == "name_1") // if statement on one line of code
            self iPrintlnBold( "Placeholder for function logic: ^1" + parameter[0] ); // Use iPrintlnBold to debug code

            if(parameter[0] == "name_2") // if statement on more then one line of code
            {
                self iPrintlnBold( "Placeholder for function logic: ^1" + parameter[0] ); // Use iPrintlnBold to debug code
                wait 1; // Optional not needed
                self iPrintlnBold( "Placeholder for function logic: ^2" + parameter[0] ); // Use iPrintlnBold to debug code
            }
            break;

            case "Toggle Function":
            /*
            How to call Toggle Function syntax

            ToggleCheckBox Definition = ( "Name Function", "Toggle", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self ToggleCheckBox( "Test Toggle", isDefined( player.Toggle ), ::multiple_functions, undefined, "Toggle Function" );  

            Option Definition = ( "Name Function", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self Option( "Test Toggle", ::multiple_functions, undefined, "Toggle Function" );
            */
            if(!isDefined(self.Toggle))
            {
                self.Toggle = true;
                self iPrintlnBold( "Placeholder for function logic: ^1ON" ); // Use iPrintlnBold to debug code
            }
            else
            {
                self.Toggle = undefined;
                self iPrintlnBold( "Placeholder for function logic: ^1OFF" ); // Use iPrintlnBold to debug code
            }
            break;

            case "Boolean Function ":
            /*
            How to call Boolean Function syntax

            ToggleCheckBox Definition = ( "Name Function", "Toggle", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self ToggleCheckBox( "Test Boolean", isDefined( player.Boolean ), ::multiple_functions, undefined, "Boolean Function" );  
            */

            self.Boolean = isDefined(self.Boolean) ? undefined : true;

            // This is not needed, it here to show you how boolean works
            if(isDefined(self.Boolean)) // If True
            {
                self iPrintlnBold( "Placeholder for function logic: ^1ON" ); // Use iPrintlnBold to debug code
            }
            else // If undefined
            {
                self iPrintlnBold( "Placeholder for function logic: ^1OFF" ); // Use iPrintlnBold to debug code
            }
            break;

            case "For Each Function":
            /*
            How to call For Each Function syntax
            
            Option Definition = ( "Name Function", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self Option( "Test For Each Function", ::multiple_functions, undefined, "For Each Function" );
            */

            if(!self.StopYouFromSelectingOptionIfUsing) // If Not true run code
            {
                self.StopYouFromSelectingOptionIfUsing = true; // Code is ON
                self iPrintlnbold("Task start.");
                Call = ["name_1", "name_2", "name_3", "name_4", "name_5", "name_6", "name_7", "name_8", "name_9", "name_10"];
                foreach( name in Call )
                {
                    self iPrintlnBold("Placeholder for function logic: " + name ); // Use iPrintlnBold to debug code
                    wait 1;// Loop Speed note some cases you dont need wait statement test for yourself
                }
                self iPrintlnbold("Task ^2completed");
                self.StopYouFromSelectingOptionIfUsing = false; // Code is OFF
            }
            else self iPrintlnbold("Please wait");
            break;

            case "For Function":
            /*
            How to call For Each Function syntax

            Option Definition = ( "Name Function", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self Option( "Test For Function", ::multiple_functions, undefined, "For Function" );
            */
            if(!self.StopYouFromSelectingOptionIfUsing) // If Not true run code
            {
                self.StopYouFromSelectingOptionIfUsing = true; // Code is ON
                Call = ["name_1", "name_2", "name_3", "name_4", "name_5", "name_6", "name_7", "name_8", "name_9", "name_10"];
                for( variable = 0; variable < Call.size; variable++ )
                {
                    //self iPrintlnBold( "Placeholder for function logic: ^1" + variable ); // Use iPrintlnBold to debug code
                    self iPrintlnBold( "Placeholder for function logic: ^1" + Call[variable] ); // Use iPrintlnBold to debug code
                    wait 1; //Loop speed NOTE Loop Function need a wait time or use of waittill("name")
                }
                self iPrintlnbold("Task ^2completed");
                self.StopYouFromSelectingOptionIfUsing = false; // Code is OFF
            }
            else self iPrintlnbold("Please wait");
            break;

            case "Loop Function":
            /*
            How to call loop Function syntax

            ToggleCheckBox Definition = ( "Name Function", "Toggle", "Function", "parameter 1", "parameter 2", "parameter 3", "parameter 4", "parameter 5" )
            self ToggleCheckBox( "Test Loop", isDefined( player.LoopBoolean ), ::multiple_functions, undefined, "Loop Function" ); 

            */
            self.LoopBoolean = isDefined(self.LoopBoolean) ? undefined : true;
            while(isDefined(self.LoopBoolean))
            {
                self iPrintlnBold( "Placeholder for function logic: ^1Loop" ); // Use iPrintlnBold to debug code
                wait 1; //Loop speed NOTE Loop Function need a wait time or use of waittill("name")
                //self waittill("weapon_fired");
            }
            break;

            default:
            //self iprintln("Unknown command in command[0]: " + command[0]);
            break;
        }
    }
    //else self iprintln("Command[0] not defined.");
}