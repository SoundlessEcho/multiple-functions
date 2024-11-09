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
