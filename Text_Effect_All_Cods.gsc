self thread setModifyString( "Quantum Flux", "Text Go here", self.add_your_hud_to_link);

setModifyString(type, text, hud, colour)
{
    self endon("Toggle_ModifyString");
    switch(type)
    {
        case "Scan Colour":
        while(isDefined(hud))
        {
            dir = dir ? 0 : 1;
            for(e=0;e<text.size;e++)
            {
                //if(!isDefined(colour))
                colour = "^" + randomIntRange(1,7);
                string = "";
                for(x=0;x<text.size;x++)
                {
                    if( dir == 1 && e == x || dir == 0 && ((text.size - 1) - e) == x )
                    string += colour + text[x] + "^7";
                    else 
                    string += text[x];
                }
                hud setSafeText( string );
                wait .1;
            }
        }
        break;
        
        case "All Colour":
        while(isDefined(hud))
        {
            string = "";
            for(e=0;e<text.size;e++)
            string += "^" + randomIntRange(0,7) + text[e];    
            hud setSafeText( string );    
            wait 0.50;
        }
        break;
        
        case "Layer Colour":
        if(!isDefined(text) || !isDefined(hud))return;
    
        while(isDefined(hud))
        {
            if(isDefined(col))OldCol = col;
            
            if(isDefined(OldCol))
            {
                if(OldCol == 7)col = 0;
                else col += 1;
            }
            else
            {
                col    = 0;
                OldCol = 7;
            }
            
            for(a=0;a<text.size;a++)
            {
                string = "^"+col;
                for(b=0;b<text.size;b++)
                if(a == b)string += "^"+col+text[b]+"^"+OldCol;
                else string += text[b];
            
                hud SetSafeText(string);
                wait .1;
            } 
        }
        break;
        case "Glitch Colour":
        charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*";
        while(isDefined(hud))
        {
            string = "";
            for(i = 0; i < text.size; i++)
            {
                if(randomInt(10) > 7) // 30% chance to glitch
                string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                else
                string += "^" + randomIntRange(1, 7) + text[i];
            }
            hud setSafeText(string);
            wait 0.15;
        }
        break;
        case "Wave Colour":
            while(isDefined(hud))
            {
                time = getTime() / 1000;
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    wave = int(3.5 + 3.5 * sin(time + i));
                    string += "^" + wave + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
            break;

        case "Pulse Colour":
            col = 0;
            while(isDefined(hud))
            {
                string = "^" + col;
                for(i = 0; i < text.size; i++)
                    string += text[i];
                hud setSafeText(string);
                col = (col + 1) % 8;
                wait 0.3;
            }
            break;
        case "Rainbow Scroll":
            while(isDefined(hud))
            {
                string = "";
                offset = int(getTime() / 100) % 8;
                for(i = 0; i < text.size; i++)
                {
                    col = (i + offset) % 8;
                    string += "^" + col + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
            break;

        case "Typewriter":
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i++)
                {
                    string = "";
                    for(x = 0; x < i; x++)
                        string += "^7" + text[x];
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 1;
                hud setSafeText("");
                wait 0.5;
            }
            break;

        case "Blink":
            vis = true;
            while(isDefined(hud))
            {
                hud setSafeText(vis ? "^1" + text : "");
                vis = !vis;
                wait 0.5;
            }
            break;

        case "Color Sweep":
            col = 1;
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(i == col)
                        string += "^" + randomIntRange(1, 7) + text[i];
                    else if(i < col)
                        string += "^7" + text[i];
                    else
                        string += text[i];
                }
                hud setSafeText(string);
                col = (col + 1) % text.size;
                wait 0.1;
            }
            break;

        case "Invert Pulse":
            state = true;
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                    string += (state ? "^7" : "^1") + text[i];
                hud setSafeText(string);
                state = !state;
                wait 0.4;
            }
        break;
        case "Flash Flood":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                    {
                        if(x <= i)
                            string += "^" + randomIntRange(1, 7) + text[x];
                        else
                            string += "^7" + text[x];
                    }
                    hud setSafeText(string);
                    wait 0.1;
                }
                wait 0.5;
            }
        break;
        case "Strobe":
            color1 = "^1";
            color2 = "^7";
            toggle = true;
            while(isDefined(hud))
            {
                string = (toggle ? color1 : color2) + text;
                hud setSafeText(string);
                toggle = !toggle;
                wait 0.1;
            }
        break;
        case "Zebra Colour":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    color = (i % 2 == 0) ? "^1" : "^7";
                    string += color + text[i];
                }
                hud setSafeText(string);
                wait 0.3;
            }
        break;
        case "Fire Flicker":
            fireColors = ["^1", "^3", "^6"];
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                    string += fireColors[randomInt(fireColors.size)] + text[i];
                hud setSafeText(string);
                wait 0.12;
            }
        break;
        case "Scan Bar":
            col = "^2"; // green scan
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                        string += (x == i) ? col + text[x] : "^7" + text[x];
                    hud setSafeText(string);
                    wait 0.1;
                }
            }
        break;
        case "Shuffle":
            while(isDefined(hud))
            {
                shuffled = [];
                indexes = [];
                while(indexes.size < text.size)
                {
                    idx = randomInt(text.size);
                        indexes[indexes.size] = idx;
                }
                for(i = 0; i < indexes.size; i++)
                    shuffled[i] = text[indexes[i]];
                string = "";
                for(i = 0; i < shuffled.size; i++)
                    string += "^" + randomIntRange(1, 7) + shuffled[i];
                hud setSafeText(string);
                wait 0.2;
            }
        break;
            case "Matrix Drop":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^2" + charset[randomInt(charset.size)];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
        break;
        case "Wave Distort":
            phase = 0;
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    offset = int(2 * sin((phase + i) * 0.5));
                    string += "^7" + text[(i + offset + text.size) % text.size];
                }
                hud setSafeText(string);
                phase++;
                wait 0.1;
            }
        break;
        case "Lightning Flicker":
            while(isDefined(hud))
            {
                if(randomInt(10) > 7)
                {
                    hud setSafeText("^7" + text);
                    wait 0.05;
                    hud setSafeText("");
                    wait 0.05;
                    hud setSafeText("^7" + text);
                }
                else
                {
                    hud setSafeText("");
                }
                wait 0.2;
            }
        break;
        case "Color Stack":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                    {
                        if(x <= i)
                            string += "^" + randomIntRange(1, 7) + text[x];
                        else
                            string += "^7" + text[x];
                    }
                    hud setSafeText(string);
                    wait 0.1;
                }
                wait 0.5;
            }
        break;
        case "Sparks":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 8)
                        string += "^" + randomIntRange(1, 7) + text[i];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
        break;
        case "Fade In-Out":
            fadeColors = ["^0", "^1", "^3", "^7"];
            while(isDefined(hud))
            {
                for(i = 0; i < fadeColors.size; i++)
                {
                    hud setSafeText(fadeColors[i] + text);
                    wait 0.1;
                }
                for(i = fadeColors.size - 1; i >= 0; i--)
                {
                    hud setSafeText(fadeColors[i] + text);
                    wait 0.1;
                }
                wait 0.3;
            }
        break;
        case "Heartbeat":
            scaleUp = true;
            while(isDefined(hud))
            {
                hud.fontScale = scaleUp ? 2.0 : 1.5;
                hud setSafeText("^1" + text);
                scaleUp = !scaleUp;
                wait 0.3;
            }
        break;
        case "Jitter":
            while(isDefined(hud))
            {
                jittered = "";
                for(i = 0; i < text.size; i++)
                {
                    space = randomInt(2) ? " " : "";
                    jittered += "^7" + space + text[i];
                }
                hud setSafeText(jittered);
                wait 0.1;
            }
        break;
        case "Boom Bounce":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                    {
                        if(x == i)
                            string += "^" + randomIntRange(1, 7) + text[x] + "^7";
                        else
                            string += text[x];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
            }
        break;
        case "Noise Distortion":
            noiseSet = "@#$%&*!";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 7)
                        string += "^2" + noiseSet[randomInt(noiseSet.size)];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
        break;
        case "Glitch Break":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@#$%";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^1" + charset[randomInt(charset.size)];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.08;
            }
        break;
        case "Reveal Backwards":
            while(isDefined(hud))
            {
                for(i = text.size - 1; i >= 0; i--)
                {
                    string = "";
                    for(x = i; x < text.size; x++)
                        string += "^7" + text[x];
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.5;
                hud setSafeText("");
                wait 0.2;
            }
        break;
        case "Pixel Pulse":
            while(isDefined(hud))
            {
                index = randomInt(text.size);
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(i == index)
                        string += "^" + randomIntRange(1, 7) + text[i];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.07;
            }
        break;
        case "Code Rain Trail":
            while(isDefined(hud))
            {
                lead = randomInt(text.size);
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(i == lead)
                        string += "^2" + text[i]; // lead green
                    else
                        string += "^0" + text[i]; // dim
                }
                hud setSafeText(string);
                wait 0.07;
            }
        break;
        case "Magnet Bounce":
            while(isDefined(hud))
            {
                mid = int(text.size / 2);
                for(offset = 0; offset <= mid; offset++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i == mid - offset || i == mid + offset)
                            string += "^" + randomIntRange(1, 7) + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.3;
            }
        break;
        case "Smoke Drift":
            charset = ".,~ ";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^5" + charset[randomInt(charset.size)];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.1;
            }
        break;
        case "Sawblade Spin":
            colorIndex = 0;
            colors = [1, 2, 3, 4, 5, 6];
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    col = colors[(i + colorIndex) % colors.size];
                    string += "^" + col + text[i];
                }
                colorIndex++;
                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Decode Stream":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            result = [];
            for(i = 0; i < text.size; i++) result[i] = text[i];

            while(isDefined(hud))
            {
                done = true;
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(8) == 0)
                        char = result[i];
                    else
                    {
                        char = charset[randomInt(charset.size)];
                        done = false;
                    }
                    string += "^7" + char;
                }
                hud setSafeText(string);
                wait 0.1;
                if(done) wait 1.0;
            }
        break;
        case "Strobe Beacon":
            toggle = false;
            while(isDefined(hud))
            {
                color = toggle ? "^1" : "^6";
                hud setSafeText(color + text);
                toggle = !toggle;
                wait 0.1;
            }
        break;
        case "Shatter Drop":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += " "; // remove letter
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.5;
                hud setSafeText("^7" + text); // reset
                wait 0.5;
            }
        break;
        case "Neon Fade Loop":
            neon = [1, 3, 5, 6];
            colorIndex = 0;
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                    string += "^" + neon[(colorIndex + i) % neon.size] + text[i];

                hud setSafeText(string);
                colorIndex = (colorIndex + 1) % neon.size;
                wait 0.2;
            }
        break;
        case "Static Burn":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 7)
                        string += "^0" + text[i];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.2;
            }
        break;
        case "Surge Swipe":
            while(isDefined(hud))
            {
                surgeColor = randomIntRange(1, 7);
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^" + surgeColor + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.04;
                }
                wait 0.2;
            }
        break;
        case "Character Charge":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^6" + text[j];
                        else if(j < i)
                            string += "^5" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.3;
            }
        break;
        case "Scramble Typewriter":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i++)
                {
                    for(f = 0; f < 3; f++)
                    {
                        flicker = "";
                        for(x = 0; x < i; x++) flicker += "^7" + text[x];
                        flicker += "^1" + charset[randomInt(charset.size)];
                        hud setSafeText(flicker);
                        wait 0.05;
                    }
                    real = "";
                    for(x = 0; x < i; x++) real += "^7" + text[x];
                    hud setSafeText(real);
                    wait 0.05;
                }
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Pulse Flood":
            colors = [1, 2, 3, 4, 5, 6];
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i++)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                    {
                        if(x < i)
                            string += "^" + colors[x % colors.size] + text[x];
                        else
                            string += "^7" + text[x];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.3;
                for(i = text.size; i >= 0; i--)
                {
                    string = "";
                    for(x = 0; x < text.size; x++)
                    {
                        if(x < i)
                            string += "^" + colors[x % colors.size] + text[x];
                        else
                            string += "^7" + text[x];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.3;
            }
        break;
        case "Blink Trail Chase":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^1" + text[j];
                        else if(j == i - 1)
                            string += "^3" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
            }
        break;
        case "Jump Glitch":
            while(isDefined(hud))
            {
                index = randomInt(text.size);
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(i == index)
                        string += "^1" + " ";
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.08;
                hud setSafeText("^7" + text);
                wait 0.08;
            }
        break;
        case "Jitter Chaos":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.07;
            }
        break;
        case "Letter Cascade":
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j < i)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.5;
                hud setSafeText(" ");
                wait 0.2;
            }
        break;
        case "Stagger Glow":
            glowSize = 3;
            while(isDefined(hud))
            {
                for(start = 0; start < text.size; start++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i >= start && i < start + glowSize)
                            string += "^6" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.1;
                }
            }
        break;
        case "Color Meteor":
            colors = [6, 5, 3, 2];
            while(isDefined(hud))
            {
                for(i = 0; i < text.size + colors.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        index = i - j;
                        if(index >= 0 && index < colors.size)
                            string += "^" + colors[index] + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.06;
                }
                wait 0.3;
            }
        break;
        case "Random Color Pop":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                    string += "^" + randomIntRange(1, 7) + text[i];

                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Slice Reveal":
            slice = 2;
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i += slice)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j < i)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.3;
            }
        break;
        case "Focus Pulse":
            while(isDefined(hud))
            {
                mid = int(text.size / 2);
                for(p = 0; p < 3; p++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i == mid)
                            string += "^1" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.1;
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^7" + text[i];
                    hud setSafeText(string);
                    wait 0.1;
                }
                wait 0.3;
            }
        break;
        case "DNA Helix":
            while(isDefined(hud))
            {
                step = 0;
                while(isDefined(hud))
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        wave = int((sin(i + step) + 1) * 3);
                        string += "^" + wave + text[i];
                    }
                    hud setSafeText(string);
                    step++;
                    wait 0.07;
                }
            }
        break;
        case "Color Magnet":
            mid = int(text.size / 2);
            while(isDefined(hud))
            {
                for(dist = mid; dist >= 0; dist--)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i == mid - dist || i == mid + dist)
                            string += "^5" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.2;
            }
        break;
        case "Flicker Signal":
            while(isDefined(hud))
            {
                if(randomInt(10) > 7)
                    hud setSafeText("^0" + text);
                else
                    hud setSafeText("^7" + text);
                wait 0.03;
            }
        break;
        case "Slow Typewriter":
            while(isDefined(hud))
            {
                for(i = 0; i <= text.size; i++)
                {
                    string = "";
                    for(j = 0; j < i; j++)
                        string += "^7" + text[j];
                    hud setSafeText(string);
                    wait 0.15;
                }
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Dual Fade In":
            while(isDefined(hud))
            {
                for(i = 0; i <= int(text.size / 2); i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j < i || j >= text.size - i)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Ripple Pulse":
            mid = int(text.size / 2);
            while(isDefined(hud))
            {
                for(dist = 0; dist <= mid; dist++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i == mid - dist || i == mid + dist)
                            string += "^4" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.06;
                }
                wait 0.3;
            }
        break;
        case "Phantom Glitch":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 7)
                        string += " ";
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.06;
            }
        break;
        case "Echo Type":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    string += "^7" + text[i];
                    hud setSafeText(string);
                    wait 0.1;
                    hud setSafeText(string + " ");
                    wait 0.05;
                }
                wait 0.4;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Meltdown":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^1" + ".";
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Color Stretch":
            startCol = randomIntRange(1, 7);
            endCol = randomIntRange(1, 7);
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    ratio = i / NumberValue(text.size);
                    col = int(startCol + (endCol - startCol) * ratio);
                    string += "^" + col + text[i];
                }
                hud setSafeText(string);
                wait 0.3;
            }
        break;
        case "Cyber Grid":
            gridSize = 2;
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i += gridSize)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j >= i && j < i + gridSize)
                            string += "^2" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.08;
                }
            }
        break;
        case "Fractal Rebuild":
            charset = "[]{}|\/?<>@#";
            while(isDefined(hud))
            {
                for(stage = 0; stage <= 4; stage++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(randomInt(5) < stage)
                            string += "^7" + text[i];
                        else
                            string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.4;
            }
        break;
        case "Holo Fade In":
            charset = [".", ":", "-", "+", "*"];
            while(isDefined(hud))
            {
                for(stage = 0; stage < charset.size; stage++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^" + randomIntRange(1,7) + charset[stage];
                    hud setSafeText(string);
                    wait 0.06;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Disruption Flow":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 7)
                        string += " ";
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.08;

                if(randomInt(5) == 0)
                {
                    hud setSafeText("^7" + text);
                    wait 0.2;
                }
            }
        break;
        case "Binary Melt":
            charset = ["0", "1"];
            while(isDefined(hud))
            {
                for(step = 0; step <= text.size; step++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i < step)
                            string += "^7" + text[i];
                        else
                            string += "^" + randomIntRange(1, 7) + charset[randomInt(2)];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.4;
                hud setSafeText("");
                wait 0.2;
            }
        break;
        case "Color Explosion":
            mid = int(text.size / 2);
            while(isDefined(hud))
            {
                for(radius = 0; radius <= mid; radius++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i >= mid - radius && i <= mid + radius)
                            string += "^" + randomIntRange(1, 7) + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.3;
            }
        break;
        case "Cross Fade":
            while(isDefined(hud))
            {
                for(i = 0; i <= int(text.size / 2); i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j <= i || j >= text.size - i - 1)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.06;
                }
                wait 0.3;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Glitch Snap":
            charset = "!@#$%&*?+=<>|-";
            while(isDefined(hud))
            {
                for(f = 0; f < 4; f++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^" + randomIntRange(1,7) + charset[randomInt(charset.size)];
                    hud setSafeText(string);
                    wait 0.04;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Quantum Blink":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += " ";
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.04;
            }
        break;
        case "Ghost Trail":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^2" + text[j];
                        else if(j == i-1 || j == i-2)
                            string += "^5" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.06;
                }
                wait 0.2;
            }
        break;
        case "Hacked Cipher":
            charset = "X#!$@%&0123456789";
            while(isDefined(hud))
            {
                for(step = 0; step < 5; step++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                    hud setSafeText(string);
                    wait 0.05;
                }
                hud setSafeText("^7" + text);
                wait 0.6;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Collapse Inward":
            while(isDefined(hud))
            {
                for(i = 0; i <= int(text.size / 2); i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j >= i && j < text.size - i)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.3;
                hud setSafeText("");
                wait 0.2;
            }
        break;
        case "Shock Bounce":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(randomInt(10) > 6)
                        string += "^1" + text[i];
                    else
                        string += "^7" + text[i];
                }
                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Ascend Reveal":
            charset = "_-^.'`";
            while(isDefined(hud))
            {
                for(stage = 0; stage < charset.size; stage++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^" + randomIntRange(1, 7) + charset[stage];
                    hud setSafeText(string);
                    wait 0.05;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Center Explode":
            mid = int(text.size / 2);
            while(isDefined(hud))
            {
                for(radius = 0; radius <= mid; radius++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i >= mid - radius && i <= mid + radius)
                            string += "^" + randomIntRange(1, 7) + text[i];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.3;
                hud setSafeText("");
                wait 0.2;
            }
        break;
        case "Offset Flicker":
            while(isDefined(hud))
            {
                offset = randomInt(2);
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    pad = offset == 0 ? "" : " ";
                    string += "^7" + pad + text[i];
                }
                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Hacker Flash":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    string += "^2" + text[i];
                    hud setSafeText(string + "_");
                    wait 0.04;
                }
                wait 0.4;
                hud setSafeText("^7" + text);
                wait 0.4;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Decrypt Pulse":
            charset = "#@$%^&*()_+1234567890";
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    for(k = 0; k < 3; k++)
                    {
                        string = "";
                        for(j = 0; j < text.size; j++)
                        {
                            if(j == i)
                                string += "^1" + charset[randomInt(charset.size)];
                            else if(j < i)
                                string += "^7" + text[j];
                            else
                                string += " ";
                        }
                        hud setSafeText(string);
                        wait 0.03;
                    }
                }
                hud setSafeText("^7" + text);
                wait 0.6;
                hud setSafeText("");
                wait 0.4;
            }
        break;
        case "Terminal Type-In":
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    string += "^7" + text[i];
                    hud setSafeText(string + "_");
                    wait 0.07;
                }
                hud setSafeText(string);
                wait 0.6;
                hud setSafeText("");
                wait 0.4;
            }
        break;
        case "Decoder Crawl":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$%#@!";
            while(isDefined(hud))
            {
                for(step = 0; step < text.size; step++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i <= step)
                            string += "^7" + text[i];
                        else
                            string += "^5" + charset[randomInt(charset.size)];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Static Scramble":
            charset = "!@#$%^&*-=+<>?/1234567890";
            while(isDefined(hud))
            {
                for(k = 0; k < 6; k++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                        string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                    hud setSafeText(string);
                    wait 0.04;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Code Waterfall":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                {
                    if(i % 2 == 0)
                        string += "^2" + charset[randomInt(charset.size)];
                    else
                        string += "^3" + charset[randomInt(charset.size)];
                }
                hud setSafeText(string);
                wait 0.05;
            }
        break;
        case "Encryption Spiral":
            while(isDefined(hud))
            {
                for(pass = 0; pass < text.size; pass++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(i == pass || i == text.size - 1 - pass)
                            string += "^6" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.3;
            }
        break;
        case "Glitch Decode":
            charset = "#$%&*?!@^";
            while(isDefined(hud))
            {
                for(i = 0; i < 5; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(randomInt(10) > 6)
                            string += "^1" + charset[randomInt(charset.size)];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
        break;
        case "Text Flood":
            preset = [
                "ACCESS DENIED", "TRACE FOUND", "0001X000", "DECRYPTING...", "???", "LOADING..."
            ];
            while(isDefined(hud))
            {
                for(i = 0; i < 6; i++)
                {
                    hud setSafeText("^1" + preset[randomInt(preset.size)]);
                    wait 0.1;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Terminal Flicker":
            while(isDefined(hud))
            {
                for(f = 0; f < 4; f++)
                {
                    hud setSafeText("^2" + text);
                    wait 0.04;
                    hud setSafeText("");
                    wait 0.03;
                }
                hud setSafeText("^7" + text);
                wait 0.4;
            }
        break;
        case "Encrypted Layers":
            charset = "$@#%&?!";
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    for(stage = 0; stage < 3; stage++)
                    {
                        string = "";
                        for(j = 0; j < text.size; j++)
                        {
                            if(j == i)
                                string += "^2" + charset[randomInt(charset.size)];
                            else if(j < i)
                                string += "^7" + text[j];
                            else
                                string += " ";
                        }
                        hud setSafeText(string);
                        wait 0.03;
                    }
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
        break;
        case "Quantum Flux":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    for(k = 0; k < 3; k++)
                    {
                        string = "";
                        for(j = 0; j < text.size; j++)
                        {
                            if(j == i)
                                string += "^" + randomIntRange(1, 7) + charset[randomInt(charset.size)];
                            else if(j < i)
                                string += "^7" + text[j];
                            else
                                string += " ";
                        }
                        hud setSafeText(string);
                        wait 0.03;
                    }
                }
                hud setSafeText("^7" + text);
                wait 0.6;
                hud setSafeText("");
                wait 0.4;
            }
        break;
        case "Neural Net":
            while(isDefined(hud))
            {
                for(pass = 0; pass < 3; pass++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if((i + pass) % 3 == 0)
                            string += "^2" + text[i];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.1;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
        break;
        case "System Reboot":
            while(isDefined(hud))
            {
                hud setSafeText("");
                wait 0.2;
                hud setSafeText("^1REBOOTING...");
                wait 0.5;
                hud setSafeText("^2" + text);
                wait 0.5;
                hud setSafeText("");
                wait 0.3;
            }
        break;
        case "Final Lock Break":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j < i)
                            string += "^2" + text[j];
                        else if(j == i)
                            string += "^1" + "#";
                        else
                            string += "^0" + "-";
                    }
                    hud setSafeText(string);
                    wait 0.06;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
        break;
        case "Deep Scan Flux":
            while(isDefined(hud))
            {
                // Forward
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^4" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.04;
                }
                // Backward
                for(i = text.size - 1; i >= 0; i--)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^4" + text[j];
                        else
                            string += "^7" + text[j];
                    }
                    hud setSafeText(string);
                    wait 0.04;
                }

                wait 0.6;
            }
        break;
        case "Chrono Scramble":
            charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            while(isDefined(hud))
            {
                for(pass = 0; pass < 3; pass++)
                {
                    string = "";
                    for(i = 0; i < text.size; i++)
                    {
                        if(randomInt(10) > 5)
                            string += "^5" + charset[randomInt(charset.size)];
                        else
                            string += "^7" + text[i];
                    }
                    hud setSafeText(string);
                    wait 0.04;
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
        break;
        case "Boot Sequence":
            lines = [
                "LOADING BIOS...",
                "INITIALIZING CORE MODULES...",
                "LINKING NODE...",
                "CHECKING SEC PROTOCOLS...",
                "DECRYPTING PAYLOAD...",
                "BOOT COMPLETE"
            ];

            for(i = 0; i < lines.size; i++)
            {
                hud setSafeText("^2" + lines[i]);
                wait 0.3;
            }

            hud setSafeText("^7" + text);
            wait 1.5;
        break;
        case "Signal Intercept":
            charset = "?!@&%#";
            while(isDefined(hud))
            {
                for(g = 0; g < 3; g++)
                {
                    noise = "";
                    for(i = 0; i < text.size; i++)
                        noise += "^1" + charset[randomInt(charset.size)];
                    hud setSafeText(noise);
                    wait 0.05;
                }

                reveal = "";
                for(i = 0; i < text.size; i++)
                {
                    reveal += "^2" + text[i];
                    hud setSafeText(reveal);
                    wait 0.03;
                }

                wait 0.6;
            }
        break;
        case "Data Cascade":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^3" + text[j];
                        else if(j < i)
                            string += "^7" + text[j];
                        else
                            string += " ";
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }
                wait 0.4;
            }
        break;
        case "Signal Jammer":
            charset = "#$@*&%";
            while(isDefined(hud))
            {
                for(i = 0; i < 6; i++)
                {
                    jammed = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(randomInt(10) > 5)
                            jammed += "^1" + charset[randomInt(charset.size)];
                        else
                            jammed += "^7" + text[j];
                    }
                    hud setSafeText(jammed);
                    wait 0.05;
                }
                hud setSafeText("^7" + text);
                wait 0.4;
            }
        break;
        case "Deep Dive Reveal":
            charset = "0123456789ABCDEF";
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    for(step = 0; step < 3; step++)
                    {
                        string = "";
                        for(j = 0; j < text.size; j++)
                        {
                            if(j < i)
                                string += "^7" + text[j];
                            else if(j == i)
                                string += "^2" + charset[randomInt(charset.size)];
                            else
                                string += " ";
                        }
                        hud setSafeText(string);
                        wait 0.04;
                    }
                }
                hud setSafeText("^7" + text);
                wait 0.5;
            }
            break;
            case "Encrypted Core":
            charset = "!@#%^&*";
            while(isDefined(hud))
            {
                string = "";
                for(i = 0; i < text.size; i++)
                    string += "^0" + charset[randomInt(charset.size)];

                hud setSafeText(string);
                wait 0.3;

                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j <= i)
                            string += "^7" + text[j];
                        else
                            string += "^0" + charset[randomInt(charset.size)];
                    }
                    hud setSafeText(string);
                    wait 0.05;
                }

                wait 0.4;
            }
            break;
            case "Synthetic Echo":
            while(isDefined(hud))
            {
                for(i = 0; i < text.size; i++)
                {
                    string = "";
                    for(j = 0; j < text.size; j++)
                    {
                        if(j == i)
                            string += "^5" + text[j] + text[j] + "^7" + text[j];
                        else
                            string += text[j];
                    }
                    hud setSafeText(string);
                    wait 0.07;
                }
                wait 0.4;
            }
        break;
        case "Typewriter Dissolve":
            if(!isDefined(text) || !isDefined(hud))
                return;

            while(isDefined(hud))  // LOOP begins
            {
                // Step 1: Typewriter Effect
                typed = "";
                for(i = 0; i < text.size; i++)
                {
                    typed += "^7" + text[i];
                    hud setSafeText(typed);
                    wait 0.08;
                }

                wait 0.5;  // Brief pause with full text visible

                // Step 2: Every-other-character dissolve
                textArray = [];
                for(i = 0; i < text.size; i++)
                    textArray[i] = text[i];

                for(i = 0; i < text.size; i += 2)
                {
                    textArray[i] = " ";
                    string = "";
                    for(j = 0; j < textArray.size; j++)
                        string += "^7" + textArray[j];

                    hud setSafeText(string);
                    wait 0.1;
                }

                wait 0.3;

                // Step 3: Remove remaining characters
                for(i = 1; i < text.size; i += 2)
                {
                    textArray[i] = " ";
                    string = "";
                    for(j = 0; j < textArray.size; j++)
                        string += "^7" + textArray[j];

                    hud setSafeText(string);
                    wait 0.1;
                }

                wait 0.5;
            }  // LOOP ends

        break;
        case "Typewriter Dissolve 2":
            if(!isDefined(text) || !isDefined(hud))
                return;

            while(isDefined(hud)) // LOOP begins
            {
                // Step 1: Typewriter Effect
                typed = "";
                for(i = 0; i < text.size; i++)
                {
                    typed += "^7" + text[i];
                    hud setSafeText(typed);
                    wait 0.08;
                }

                wait 0.5; // Brief pause with full text visible

                // Step 2: Random character dissolve
                textArray = [];
                for(i = 0; i < text.size; i++)
                    textArray[i] = text[i];

                // Create array of remaining indices
                remaining = [];
                for(i = 0; i < text.size; i++)
                    remaining[i] = i;

                // Randomly blank out characters one by one
                while(remaining.size > 0)
                {
                    randIndex = randomInt(remaining.size);
                    charIndex = remaining[randIndex];

                    textArray[charIndex] = " ";

                    // Rebuild HUD string
                    string = "";
                    for(j = 0; j < textArray.size; j++)
                        string += "^7" + textArray[j];

                    hud setSafeText(string);

                    // Manually remove the index from the array
                    for(k = randIndex; k < remaining.size - 1; k++)
                        remaining[k] = remaining[k + 1];

                    remaining[remaining.size - 1] = undefined;
                    charIndexremaining = remaining.size;
                    charIndexremaining--;

                    wait 0.1;
                }

                wait 0.5; // Small delay before looping
            } // LOOP ends

            break;
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