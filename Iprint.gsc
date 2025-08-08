/*
How to call
self CustomIPrint("String Here"); // use 1 string array
self CustomIPrint("String 1,String 2,String 3"); // use multiple string array

How to Make It Work for You:
To integrate this system into your project, you'll need to use your own createText parameters. My setup relies on setSafeText, but if your menu uses setText instead, you must ensure an overflow fix is implemented otherwise, you may run into string-related crashes or instability.

Here my createText parameter
createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, isLevel = "self", glowColor, glowAlpha, moveOverTime, fadeOverTime, changeFontScaleOverTime, team )

Bonus: You won't encounter the (CG_Spawn: no free entities} overflow error when using my custom iPrint system. Unlike setTypeWriterFX, which can cause the game to overflow when used excessively, my system includes a string overflow fix that allows for safe and repeated usage without any performance issues.
*/

CustomIPrint( parameter, command = "Add To Queue Text", hud = self.customPrintHud )
{
    parameter = strTok(parameter, ",");
    command = strTok(command, ",");
    switch(command[0])
    {
        case "Add To Queue Text":
        if(!isDefined(self.customPrintQueue))
        self.customPrintQueue = [];
        
        for( array = 0; array < parameter.size; array++ )
        self.customPrintQueue[self.customPrintQueue.size] = parameter[array];

        if(!isDefined(self.processingPrintQueue) || self.processingPrintQueue == false)
        {
            self.processingPrintQueue = true;
            self thread CustomIPrint("undefined","Process IPrint");
        }
        break;

        case "Process IPrint":
        self endon("disconnect");
        self endon("death");
        // If game does not have a overflow fix use no animate to save on string use.
        #ifdef MWR || BO3
        self.functions["isAnimate"] = undefined;
        #else
        self.functions["isAnimate"] = true;
        #endif

        if(!isDefined(self.customPrintHud))
        {
            self.customPrintHud = createText(
            "default", 1.5, "CENTER", "CENTER",
            0, 210, 1, 1, "", (1,1,1), "self",
            (0,0,0), 0, 0, 0, 0, undefined);
        }

        if(isDefined(self.functions["isAnimate"]))
        {
            while(self.customPrintQueue.size > 0)
            {
                msg = self.customPrintQueue[0];
                self.customPrintQueue = arrayRemoveIndex(self.customPrintQueue, 0);

                self.customPrintHud.alpha = 1;
                self CustomIPrint(msg, "Animate Decoder Text");

                // Hold for a moment after message fully displays
                wait 2.0;

                self.customPrintHud fadeOverTime(0.5);
                self.customPrintHud.alpha = 0;

                wait 0.5;
            }
        }
        else
        {
            while(self.customPrintQueue.size > 0)
            {
                msg = self.customPrintQueue[0];
                self.customPrintQueue = arrayRemoveIndex(self.customPrintQueue, 0);

                self.customPrintHud.alpha = 1;
                self.customPrintHud setSafeText(msg);

                wait 4.5;

                // Fade out before next message
                self.customPrintHud fadeOverTime(0.5);
                self.customPrintHud.alpha = 0;

                wait 0.5;
            }
        }

        if(isDefined(self.customPrintHud))
        {
            self.customPrintHud destroy();
            self.customPrintHud = undefined;
        }

        self.processingPrintQueue = false;
        break;

        case "Animate Decoder Text":
        charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

        for (i = 0; i <= parameter[0].size; i++)
        {
            for (f = 0; f < 3; f++)
            {
                flicker = "";
                for (x = 0; x < i; x++)
                flicker += "^7" + parameter[0][x];
                flicker += "^1" + charset[randomInt(charset.size)];
                hud setSafeText(flicker);
                wait 0.05;
            }

            real = "";
            for (x = 0; x < i; x++)
            real += "^7" + parameter[0][x];
            hud setSafeText(real);
            wait 0.05;
        }
        break;

        default:
        //self iprintln("Unknown command in command[0]: " + command[0]);
        break;
    }
}

arrayRemoveIndex(array, index)
{
    newArray = [];
    for (i = 0; i < array.size; i++)
    {
        if (i != index)
            newArray[newArray.size] = array[i];
    }
    return newArray;
}



