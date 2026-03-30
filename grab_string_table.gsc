/*
*	 Infinity Loader :: The Best GSC IDE!
*
*	 Project : Developer Kit
*	 Author : SoundlessEcho
*	 Game : Project Bundle
*	 Description : ["Effect Name", "Model Name", "Weapon Name", "Killstreaks Name", "Perk Name"];
*	 Date : 3/30/2026 3:43:39 AM
*
*/

/*
Add GetTableString("Load Array") to init() function
GetTableString("Load Array"); // Clear Array, Load Array
Note some games like BO3 does not load array at init() so i added it to onSpawn
// BO3 wait until i spawn
            #ifdef BO3
            GetTableString("Effect Name");
            GetTableString("Weapon Name");
            GetTableString("Killstreaks Name");
            #endif

How I call it

if(isDefined(level.GetModel) && level.GetModel.size)
for(af = 0; af < level.GetModel.size; af++)
self Option( level.GetModel[af] );
else
self Option("No Models Found");

if(isDefined(level.GetEffect) && level.GetEffect.size)
for(af = 0; af < level.GetEffect.size; af++)
self Option( level.GetEffect[af] );
else
self Option("No Effect Found");

if(isDefined(level.GetWeaponid) && level.GetWeaponid.size)
for(af = 0; af < level.GetWeaponid.size; af++)
if(level.GetWeaponid[af] != "" || level.GetWeaponid[af] != "_mp")
self Option( level.GetWeaponid[af] );
else
self Option("No Weapon Found");

if(isDefined(level.GetKillstreaksArray) && level.GetKillstreaksArray.size)
for(af = 0; af < level.GetKillstreaksArray.size; af++)
self Option( level.GetKillstreaksArray[af] );
else
self Option("No killstreaks Found");

if(isDefined(level.GetPerkArray) && level.GetPerkArray.size)
for(af = 0; af < level.GetPerkArray.size; af++)
self Option( level.GetPerkArray[af] );
else
self Option("No Perk Found");
*/

GetTableString(command)
{
    switch(command)
    {
        case "Clear Array":
        level.GetEffect = [];
        level.GetModel = [];
        level.GetWeaponid = [];
        level.GetKillstreaksArray = [];
        level.GetPerkArray = [];
        break;
        
        case "Effect Name":
        level.GetEffect = [];
        GetEffects_Name = ["Add Missing Effect"]; // optional starting value add any effect that are missing

        //  Define blacklist (FX names to skip)
        excluded_fx = ["","add_name_to_excluded_fx","fx_betty_friendly_light","fx_betty_enemy_light","perk_machine_location","perk_machine_light_green","perk_machine_light_red","perk_machine_light_yellow","zapper_fx","zapper_wall","fx_zm_asylum_water_leak","powerLight","step_wood","step_water","step_sand","step_rock","step_plaster","step_paper","step_mud","step_metal","step_grass","step_gravel","step_foliage","step_dirt","step_concrete","step_cloth","step_carpet","step_brick","step_asphalt","building_dust","box_light_flare","animscript_gibtrail_fx","upgrade_aquired","def_explosion","fall_dust","rise_dust","rise_dust_water","tesla_head_light","edge_fog","fx_zombie_bar_break_lite","fx_zombie_bar_break","poltergeist","lght_marker_flare"];

        #ifdef WW2
        if(isDefined(level.var_611))
        effects_name = GetArrayKeys(level.var_611);
        else
        effects_name = [];
        #else
        if(isDefined(level._effect))
        effects_name = GetArrayKeys(level._effect);
        else
        effects_name = [];
        #endif
        
        for(Table = 0; Table < effects_name.size; Table++)
        {
            #ifdef WW2
            current_fx = effects_name[Table];
            //current_fx = level.var_611[effects_name[Table]];
            #else
            current_fx = effects_name[Table];
            //current_fx = level._effect[effects_name[Table]];
            #endif
            //  Skip if empty or blacklisted
            if(IsInArray(excluded_fx, current_fx))
            continue;
            //  Add to array
            GetEffects_Name[GetEffects_Name.size] = current_fx;
            addToArray(GetEffects_Name, current_fx);
        }
        level.GetEffect = removeDuplicates(GetEffects_Name);
        break;

        case "Model Name":
        level.GetModel = [];
        GetModels_Name = ["defaultactor", "defaultvehicle"]; // optional starting value add any effect that are missing

        //  Define blacklist (FX names to skip)
        excluded = ["","add_name_to_exclude"];
        
        object_name = GetEntArray("script_model", "classname");
        
        for(Table = 0; Table < object_name.size; Table++)
        {
            current = object_name[Table].model;
            //  Skip if empty or blacklisted
            if(IsInArray(excluded, current))
            continue;
            //  Add to array
            GetModels_Name[GetModels_Name.size] = current;
            addToArray(GetModels_Name, current);
        }
        level.GetModel = removeDuplicates(GetModels_Name);
        break;

        case "Weapon Name":
        level.GetWeaponid = [];
        #ifdef WW2 || MWR || IW || AW || BO3 || BO2 || GHOSTS || MW3
        #ifdef WW2 && ZM limit = 75; #endif
        #ifdef WW2 && MP 
        weapon_list = ["m1garand_mp", "m1garand_loot0_mp", "m1garand_loot1_mp", "m1garand_loot2_mp", "m1garand_loot3_mp", "svt40_mp", "svt40_loot0_mp", "svt40_loot1_mp", "svt40_loot2_mp", "svt40_loot3_mp", "stg44_mp", "stg44_loot0_mp", "stg44_loot1_mp", "stg44_loot2_mp", "stg44_loot3_mp", "fg42_mp", "fg42_loot0_mp", "fg42_loot1_mp", "fg42_loot2_mp", "fg42_loot3_mp", "bar_mp", "bar_loot0_mp", "bar_loot1_mp", "bar_loot2_mp", "bar_loot3_mp", "winchester1897_mp", "winchester1897_loot0_mp", "winchester1897_loot1_mp", "winchester1897_loot2_mp", "winchester1897_loot3_mp", "m30_mp", "m30_loot0_mp", "m30_loot1_mp", "m30_loot2_mp", "m30_loot3_mp", "model21_mp", "model21_loot0_mp", "model21_loot1_mp", "model21_loot2_mp", "model21_loot3_mp", "greasegun_mp", "greasegun_loot0_mp", "greasegun_loot1_mp", "greasegun_loot2_mp", "greasegun_loot3_mp", "kar98_mp", "kar98_loot0_mp", "kar98_loot1_mp", "kar98_loot2_mp", "kar98_loot3_mp", "leeenfield_mp", "leeenfield_loot0_mp", "leeenfield_loot1_mp", "leeenfield_loot2_mp", "leeenfield_loot3_mp", "luger_mp", "luger_loot0_mp", "luger_loot1_mp", "luger_loot2_mp", "luger_loot3_mp", "m1911_mp", "m1911_loot0_mp", "m1911_loot1_mp", "m1911_loot2_mp", "m1911_loot3_mp", "m1941_mp", "m1941_loot0_mp", "m1941_loot1_mp", "m1941_loot2_mp", "m1941_loot3_mp", "m1a1_mp", "m1a1_loot0_mp", "m1a1_loot1_mp", "m1a1_loot2_mp", "m1a1_loot3_mp", "m712_mp", "m712_loot0_mp", "m712_loot1_mp", "m712_loot2_mp", "m712_loot3_mp", "mp40_mp", "mp40_loot0_mp", "mp40_loot1_mp", "mp40_loot2_mp", "mp40_loot3_mp", "ppsh41_mp", "ppsh41_loot0_mp", "ppsh41_loot1_mp", "ppsh41_loot2_mp", "ppsh41_loot3_mp", "thompson_mp", "thompson_loot0_mp", "thompson_loot1_mp", "thompson_loot2_mp", "thompson_loot3_mp", "type100_mp", "type100_loot0_mp", "type100_loot1_mp", "type100_loot2_mp", "type100_loot3_mp", "bren_mp", "bren_loot0_mp", "bren_loot1_mp", "bren_loot2_mp", "bren_loot3_mp", "karabin_mp", "karabin_loot0_mp", "karabin_loot1_mp", "karabin_loot2_mp", "karabin_loot3_mp", "lewis_mp", "lewis_loot0_mp", "lewis_loot1_mp", "lewis_loot2_mp", "lewis_loot3_mp", "mg15_mp", "mg15_loot0_mp", "mg15_loot1_mp", "mg15_loot2_mp", "mg15_loot3_mp", "mg42_mp", "mg42_loot0_mp", "mg42_loot1_mp", "mg42_loot2_mp", "mg42_loot3_mp", "mp28_mp", "mp28_loot0_mp", "mp28_loot1_mp", "mp28_loot2_mp", "mp28_loot3_mp", "springfield_mp", "springfield_loot0_mp", "springfield_loot1_mp", "springfield_loot2_mp", "springfield_loot3_mp", "walther_mp", "walther_loot0_mp", "walther_loot1_mp", "walther_loot2_mp", "walther_loot3_mp", "sten_mp", "sten_loot0_mp", "sten_loot1_mp", "sten_loot2_mp", "sten_loot3_mp", "g43_mp", "g43_loot0_mp", "g43_loot1_mp", "g43_loot2_mp", "g43_loot3_mp", "breda30_mp", "breda30_loot0_mp", "breda30_loot1_mp", "breda30_loot2_mp", "breda30_loot3_mp", "volk_mp", "volk_loot0_mp", "volk_loot1_mp", "volk_loot2_mp", "volk_loot3_mp", "beretta_mp", "beretta_loot0_mp", "beretta_loot1_mp", "beretta_loot2_mp", "beretta_loot3_mp", "p38_mp", "p38_loot0_mp", "p38_loot1_mp", "p38_loot2_mp", "p38_loot3_mp", "reich_mp", "reich_loot0_mp", "reich_loot1_mp", "reich_loot2_mp", "reich_loot3_mp", "enfieldno2_mp", "enfieldno2_loot0_mp", "enfieldno2_loot1_mp", "enfieldno2_loot2_mp", "enfieldno2_loot3_mp", "mas38_mp", "mas38_loot0_mp", "mas38_loot1_mp", "mas38_loot2_mp", "mas38_loot3_mp", "mg81_mp", "mg81_loot0_mp", "mg81_loot1_mp", "mg81_loot2_mp", "mg81_loot3_mp", "type5_mp", "type5_loot0_mp", "type5_loot1_mp", "type5_loot2_mp", "type5_loot3_mp", "sterling_mp", "sterling_loot0_mp", "sterling_loot1_mp", "sterling_loot2_mp", "sterling_loot3_mp", "m1935_mp", "m1935_loot0_mp", "m1935_loot1_mp", "m1935_loot2_mp", "m1935_loot3_mp", "m2carbine_mp", "m2carbine_loot0_mp", "m2carbine_loot1_mp", "m2carbine_loot2_mp", "m2carbine_loot3_mp", "arisaka_mp", "arisaka_loot0_mp", "arisaka_loot1_mp", "arisaka_loot2_mp", "arisaka_loot3_mp", "leveraction_mp", "leveraction_loot0_mp", "leveraction_loot1_mp", "leveraction_loot2_mp", "leveraction_loot3_mp", "m1919_mp", "m1919_loot0_mp", "m1919_loot1_mp", "m1919_loot2_mp", "m1919_loot3_mp", "nambu_mp", "nambu_loot0_mp", "nambu_loot1_mp", "nambu_loot2_mp", "nambu_loot3_mp", "blunderbuss_mp", "blunderbuss_loot0_mp", "blunderbuss_loot1_mp", "blunderbuss_loot2_mp", "blunderbuss_loot3_mp", "ptrs41_mp", "ptrs41_loot0_mp", "ptrs41_loot1_mp", "ptrs41_loot2_mp", "ptrs41_loot3_mp", "zk383_mp", "zk383_loot0_mp", "zk383_loot1_mp", "zk383_loot2_mp", "zk383_loot3_mp", "delisle_mp", "delisle_loot0_mp", "delisle_loot1_mp", "delisle_loot2_mp", "delisle_loot3_mp", "avs36_mp", "avs36_loot0_mp", "avs36_loot1_mp", "avs36_loot2_mp", "avs36_loot3_mp", "federov_mp", "federov_loot0_mp", "federov_loot1_mp", "federov_loot2_mp", "federov_loot3_mp", "mosin_mp", "mosin_loot0_mp", "mosin_loot1_mp", "mosin_loot2_mp", "mosin_loot3_mp", "ribeyrolles_mp", "ribeyrolles_loot0_mp", "ribeyrolles_loot1_mp", "ribeyrolles_loot2_mp", "ribeyrolles_loot3_mp", "shovel_mp", "shovel_loot0_mp", "shovel_loot1_mp", "shovel_loot2_mp", "shovel_loot3_mp", "axe_mp", "axe_loot0_mp","baseballbat_mp", "baseballbat_loot0_mp","combatknife_mp", "combatknife_loot0_mp","trenchknife_mp", "trenchknife_loot0_mp", "teslagunmtx_mp", "teslagun_war_regular_mp", "teslagun_war_moon_mp", "flamethrower_mp", "flamethrower_german_mp", "flamethrower_grenadier_mp", "flamethrower_german_grenadier_mp", "riotshield_mp", "sword_mp", "war_sword_mp", "search_dstry_bomb_mp", "search_dstry_bomb_defuse_mp"];
        limit = weapon_list.size; 
        #endif
        #ifdef MWR limit = 300; #endif
        #ifdef IW && MP limit = 62; #endif
        #ifdef IW && ZM limit = 62; #endif
        #ifdef AW && ZM limit = level.magicboxweapons.size; #endif
        #ifdef AW && MP limit = 500; #endif
        #ifdef BO3 && ZM limit = level.zombie_weapons.size; weapon_list = GetArrayKeys(level.zombie_weapons);#endif
        #ifdef BO3 && MP limit = 500; #endif
        #ifdef BO2 && ZM limit = level.zombie_weapons.size; weapon_list = GetArrayKeys(level.zombie_weapons);#endif
        #ifdef BO2 && MP limit = 66; #endif
        #ifdef GHOSTS && EX limit = 300;#endif
        #ifdef GHOSTS && MP limit = 200; #endif
        #ifdef MW3 && MP limit = 83; #endif
        #else
        limit = 0;
        #endif
        for( Table = 0; Table < limit; Table++)
        {
            #ifdef WW2 || MWR || IW || AW || BO3 || BO2 || GHOSTS || MW3
            #ifdef WW2 && ZM level.GetWeaponid[level.GetWeaponid.size] = ReturnWeaponString(tablelookupbyrow("mp/zombieWeaponKitTable.csv", Table, 0)); #endif
            #ifdef WW2 && MP level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table]; #endif
            #ifdef MWR level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("mp/furniturekits/base.csv", Table, 0) + "_a#none_f#base"; #endif
            #ifdef IW && MP level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("mp/statstable.csv", Table, 4) + "_mp"; #endif
            #ifdef IW && ZM level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("mp/statstable.csv", Table, 4) + "_zmr"; #endif
            #ifdef AW && MP level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("mp/statstable.csv", Table, 4) + "_mp"; #endif
            #ifdef AW && ZM level.GetWeaponid[level.GetWeaponid.size] = level.magicboxweapons[Table]["fullName"]; #endif
            #ifdef BO3 && MP level.GetWeaponid[level.GetWeaponid.size] = tablelookup("gamedata/stats/mp/mp_statstable.csv", 0, Table, 4); #endif
            #ifdef BO3 && ZM level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table].name; #endif
            #ifdef BO2 && MP level.GetWeaponid[level.GetWeaponid.size] = tablelookup("mp/statstable.csv", 0, Table, 4) + "_mp"; #endif
            #ifdef BO2 && ZM level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table]; #endif
            #ifdef GHOSTS && MP if (isSubStr(tablelookupbyrow("mp/statstable.csv", Table, 4), "iw6_")) level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("mp/statstable.csv", Table, 4) + "_mp"; #endif
            #ifdef GHOSTS && EX if (isSubStr(tablelookup("mp/alien/mode_string_tables/alien_statstable.csv", Table, 4), "iw6_")) level.GetWeaponid[level.GetWeaponid.size] = tablelookup("mp/alien/mode_string_tables/alien_statstable.csv", 0, Table, 4) + "_mp"; #endif
            #ifdef MW3 && MP level.GetWeaponid[level.GetWeaponid.size] = tablelookup("mp/statsTable.csv", 0, Table, 4) + "_mp"; #endif
            #else
            level.GetWeaponid[level.GetWeaponid.size] = undefined;
            #endif
        }
        #ifdef IW || AW || BO3 || BO2
        #ifdef IW && ZM limit_v2 = 21; #endif
        #ifdef AW && ZM limit_v2 = level.weaponnamemap.size; weapon_list = GetArrayKeys(level.weaponnamemap); #endif
        #ifdef AW && MP limit_v2 = 0; #endif
        #ifdef BO3 && ZM limit_v2 = level.zombie_weapons_upgraded.size; weapon_list = GetArrayKeys(level.zombie_weapons_upgraded); #endif
        #ifdef BO3 && MP limit_v2 = 0; #endif
        #ifdef BO2 && ZM limit_v2 = level.zombie_weapons_upgraded.size; weapon_list = GetArrayKeys(level.zombie_weapons_upgraded); #endif
        #ifdef BO2 && MP limit_v2 = 0; #endif
        #else
        limit_v2 = 0;
        #endif
        for( Table = 0; Table < limit_v2; Table++)
        {
            #ifdef IW || AW || BO3 || BO2
            #ifdef IW && ZM level.GetWeaponid[level.GetWeaponid.size] = tablelookupbyrow("cp/zombies/mode_string_tables/zombies_statstable.csv", Table, 4) + "_zmr"; #endif
            #ifdef AW && ZM level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table]; #endif
            #ifdef BO3 && ZM level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table].name; #endif
            #ifdef BO2 && ZM level.GetWeaponid[level.GetWeaponid.size] = weapon_list[Table]; #endif
            #ifdef BO2 && MP level.GetWeaponid[level.GetWeaponid.size] = undefined; #endif
            #else
            level.GetWeaponid[level.GetWeaponid.size] = undefined;
            #endif
        }
        
        // Add your missing weapons, exclude weapons, and remove duplicates weapons
        #ifdef IW || WW2 || GHOSTS
        #ifdef IW && MP 
        AddMissingWeapons = ["defaultweapon_mp"];
        AddExcludeWeapons = [];
        #endif
        #ifdef IW && ZM 
        AddExcludeWeapons = ["_zmr","e4_zmr"];
        AddMissingWeapons = ["defaultweapon_zmr"]; 
        #endif
        #ifdef WW2 && ZM 
        AddMissingWeapons = ["defaultweapon_zm", "teslagun_zm"];
        AddExcludeWeapons = [];
        #endif
        #ifdef WW2 && MP 
        AddMissingWeapons = [];
        AddExcludeWeapons = [];
        #endif
        #ifdef GHOSTS && EX 
        AddMissingWeapons = ["aliensoflam_mp", "alienbomb_mp", "alienaxe_mp"];
        AddExcludeWeapons = ["_mp", "aliensoflam_mp_mp", "alienbomb_mp_mp", "alienaxe_mp_mp", "specialty_null_mp"];
        #endif
        #ifdef GHOSTS && MP 
        AddMissingWeapons = [];
        AddExcludeWeapons = [];
        #endif
        #else
        AddMissingWeapons = ["defaultweapon_mp"];
        AddExcludeWeapons = [];
        #endif
        level.GetWeaponid = RemoveDuplicatesArray(level.GetWeaponid);
        level.GetWeaponid = ExcludeFromArray(level.GetWeaponid, AddExcludeWeapons);
        level.GetWeaponid = AddMissingToArray(level.GetWeaponid, AddMissingWeapons);
        break;

        case "Killstreaks Name":
        level.GetKillstreaksArray = [];
        #ifdef BO3 && MP || WW2 && MP || BO2 && MP || GHOSTS && MP || MW3 && MP || IW && MP || AW || MWR && MP
        #ifdef BO3 limit = level.killstreaks.size; killstreaks = GetArrayKeys(level.killstreaks); #endif
        #ifdef WW2 limit = 300; #endif
        #ifdef BO2 limit = 500; #endif
        #ifdef GHOSTS limit = 200; #endif
        #ifdef MW3 limit = 31; #endif
        #ifdef IW limit = 50; #endif
        #ifdef AW limit = 300; #endif
        #ifdef MWR limit = 4; #endif
        #else
        limit = 0;
        #endif
        for( Table = 0; Table < limit; Table++)
        {
            #ifdef BO3 && MP || WW2 && MP || BO2 && MP || GHOSTS && MP || MW3 && MP || IW && MP || AW || MWR && MP
            #ifdef BO3 if (!isSubStr(killstreaks[Table], "inventory_")) level.GetKillstreaksArray[level.GetKillstreaksArray.size] = killstreaks[Table]; #endif
            #ifdef WW2 level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookupbyrow("mp/killstreakTable.csv", Table, 1); #endif
            #ifdef BO2 if (isSubStr(tablelookup("mp/statstable.csv", 0, Table, 4), "killstreak_")) level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookup("mp/statstable.csv", 0, Table, 4); #endif
            #ifdef GHOSTS && MP level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookupbyrow("mp/killstreakTable.csv", Table, 1); #endif
            #ifdef MW3 && MP level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookup("mp/killstreakTable.csv", 0, Table, 1); #endif
            #ifdef IW && MP level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookup("mp/killstreakTable.csv", 0, Table, 1); #endif
            #ifdef AW if(!isSubStr(tablelookup("mp/killstreakTable.csv", 0, Table, 1), "mp_") && !isSubStr(tablelookup("mp/killstreakTable.csv", 0, Table, 1), "zm_")) level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookup("mp/killstreakTable.csv", 0, Table, 1); #endif
            #ifdef MWR && MP level.GetKillstreaksArray[level.GetKillstreaksArray.size] = tablelookup("mp/killstreakTable.csv", 0, Table, 1); #endif
            #else
            level.GetKillstreaksArray[level.GetKillstreaksArray.size] = undefined;
            #endif
        }
        
        // Add your missing name, exclude name, and remove duplicates name
        #ifdef BO3 && MP || BO2 && MP || MW3 && MP || MWR && MP
        #ifdef BO3 
        AddMissing = [];
        AddExclude = ["helicopter_gunner_assistant"];
        #endif
        #ifdef BO2
        AddMissing = ["supplydrop_mp", "missile_drone_mp", "minigun_mp", "m32_mp", "ai_tank_drop_mp"];
        AddExclude = ["killstreak_supply_drop", "killstreak_minigun", "killstreak_m32", "killstreak_ai_tank_drop", "killstreak_missile_drone", "killstreak_helicopter_player_firstperson", "killstreak_null"];
        #endif
        #ifdef MW3 
        AddMissing = [];
        AddExclude = ["none"];
        #endif
        #ifdef MWR 
        AddMissing = [];
        AddExclude = ["none"];
        #endif
        #else
        AddMissing = [];
        AddExclude = [];
        #endif
        level.GetKillstreaksArray = RemoveDuplicatesArray(level.GetKillstreaksArray);
        level.GetKillstreaksArray = AddMissingToArray(level.GetKillstreaksArray, AddMissing);
        level.GetKillstreaksArray = ExcludeFromArray(level.GetKillstreaksArray, AddExclude);
        break;

        case "Perk Name":
        level.GetPerkArray = [];
        #ifdef WW2 || BO2 || GHOSTS || MW3 || IW
        #ifdef WW2 && MP limit = 200; #endif
        #ifdef BO2 && MP
        perk_list = ["specialty_additionalprimaryweapon", "specialty_armorpiercing", "specialty_armorvest", "specialty_bulletaccuracy", "specialty_bulletdamage", "specialty_bulletflinch", "specialty_bulletpenetration", "specialty_deadshot", "specialty_delayexplosive", "specialty_detectexplosive", "specialty_disarmexplosive", "specialty_earnmoremomentum", "specialty_explosivedamage", "specialty_extraammo", "specialty_fallheight", "specialty_fastads", "specialty_fastequipmentuse", "specialty_fastladderclimb", "specialty_fastmantle", "specialty_fastmeleerecovery", "specialty_fastreload", "specialty_fasttoss", "specialty_fastweaponswitch", "specialty_finalstand", "specialty_fireproof", "specialty_flakjacket", "specialty_flashprotection", "specialty_gpsjammer", "specialty_grenadepulldeath", "specialty_healthregen", "specialty_holdbreath", "specialty_immunecounteruav", "specialty_immuneemp", "specialty_immunemms", "specialty_immunenvthermal", "specialty_immunerangefinder", "specialty_killstreak", "specialty_longersprint", "specialty_loudenemies", "specialty_marksman", "specialty_movefaster", "specialty_nomotionsensor", "specialty_noname", "specialty_nottargetedbyairsupport", "specialty_nokillstreakreticle", "specialty_nottargettedbysentry", "specialty_pin_back", "specialty_pistoldeath", "specialty_proximityprotection", "specialty_quickrevive", "specialty_quieter", "specialty_reconnaissance", "specialty_rof", "specialty_scavenger", "specialty_showenemyequipment", "specialty_stunprotection", "specialty_shellshock", "specialty_sprintrecovery", "specialty_showonradar", "specialty_stalker", "specialty_twogrenades", "specialty_twoprimaries", "specialty_unlimitedsprint"];
        limit = perk_list.size; 
        #endif
        #ifdef BO2 && ZM limit = 0; #endif
        #ifdef GHOSTS && MP limit = 200; #endif
        #ifdef GHOSTS && EX limit = 0; #endif
        #ifdef MW3 && MP limit = 90; #endif
        #ifdef IW limit = 100; #endif
        #else
        limit = 0;
        #endif
        for( Table = 0; Table < limit; Table++)
        {
            #ifdef WW2 || BO2 || GHOSTS || MW3 || IW
            #ifdef WW2 && MP if (isSubStr(tablelookupbyrow("mp/perktable.csv", Table, 1), "specialty_")) level.GetPerkArray[level.GetPerkArray.size] = tablelookupbyrow("mp/perktable.csv", Table, 1); #endif
            #ifdef BO2 && MP level.GetPerkArray[level.GetPerkArray.size] = perk_list[Table]; #endif
            #ifdef GHOSTS && MP if (isSubStr(tablelookupbyrow("mp/perktable.csv", Table, 1), "specialty_")) level.GetPerkArray[level.GetPerkArray.size] = tablelookupbyrow("mp/perktable.csv", Table, 1); #endif
            #ifdef MW3 && MP || IW if (isSubStr(tablelookup("mp/perktable.csv", 0, Table, 1), "specialty_")) level.GetPerkArray[level.GetPerkArray.size] = tablelookup("mp/perktable.csv", 0, Table, 1); #endif
            #else
            level.GetPerkArray[level.GetPerkArray.size] = undefined;
            #endif
        }
        
        // Add your missing name, exclude name, and remove duplicates name
        #ifdef WW2
        #ifdef WW2 
        AddMissing = [];
        AddExclude = [];
        #endif
        #else
        AddMissing = [];
        AddExclude = [];
        #endif
        level.GetPerkArray = RemoveDuplicatesArray(level.GetPerkArray);
        level.GetPerkArray = AddMissingToArray(level.GetPerkArray, AddMissing);
        level.GetPerkArray = ExcludeFromArray(level.GetPerkArray, AddExclude);
        break;

        default:
        Table_List = ["Effect Name", "Model Name", "Weapon Name", "Killstreaks Name", "Perk Name"];
        for(Table = 0; Table < Table_List.size; Table++)
        {
            GetTableString(Table_List[Table]);
        }
        break;
    }
}

//Built_in_function.gsc
RemoveDuplicatesArray(array)
{
    unique = [];
    for (i = 0; i < array.size; i++)
    {
        val = array[i];
        // skip undefined or empty if you prefer:
        // if (!isDefined(val) || val == "") continue;

        found = false;
        for (j = 0; j < unique.size; j++)
        {
            if (unique[j] == val)
            {
                found = true;
                break;
            }
        }
        if (!found)
            unique[unique.size] = val;
    }
    return unique;
}

AddMissingToArray(targetArray, inputArray)
{
    for(i = 0; i < inputArray.size; i++)
    {
        val = inputArray[i];
        if (!isDefined(val) || val == "")
            continue;

        exists = false;
        for(j = 0; j < targetArray.size; j++)
        {
            if (targetArray[j] == val)
            {
                exists = true;
                break;
            }
        }

        if (!exists)
            targetArray[targetArray.size] = val;
    }

    return targetArray;
}

ExcludeFromArray(targetArray, excludeArray)
{
    filteredArray = [];

    for(i = 0; i < targetArray.size; i++)
    {
        val = targetArray[i];
        shouldRemove = false;

        for(j = 0; j < excludeArray.size; j++)
        {
            if (val == excludeArray[j])
            {
                shouldRemove = true;
                break;
            }
        }

        if (!shouldRemove)
            filteredArray[filteredArray.size] = val;
    }

    return filteredArray;
}

isInArray( array, text )
{
    if(!isArray(array) || !isDefined(text))
        return false;

    text += ""; //force to be a string
    foreach(item in array) {
        item += ""; //force to be a string
        if(item == text)
            return true;
    }

    return false;
}

addToArray(array, item)
{
    if(isdefined(item))
    {
        if(!isinarray(array, item))
        {
            array[array.size] = item;
        }
    }
}

#ifdef MW2 || WAW || MW1
IsArray( array, text )
{
    for(e=0;e<array.size;e++)
    if( array[e] == text )
    return true;
    return false;        
}
#endif

ReturnWeaponString(string)
{
    result = "";
    i = 0;
    #ifdef ZM command = "ZM"; #endif
    #ifdef MP command = "MP"; #endif
    #ifdef EX command = "EX"; #endif
    switch(command)
    {
        case "ZM":
        while(i < string.size)
        {
            if(i + 2 < string.size && string[i] == "_" && string[i+1] == "m" && string[i+2] == "p")
            {
                result += "_zm";
                i += 3; // Skip over "_mp"
            }
            else
            {
                result += string[i];
                i++;
            }
        }
        return result;
        break;

        case "MP":
        while(i < string.size)
        {
            if(i + 2 < string.size && string[i] == "_" && string[i+1] == "m" && string[i+2] == "p")
            {
                result += "_zm";
                i += 3; // Skip over "_mp"
            }
            else
            {
                result += string[i];
                i++;
            }
        }
        return result;
        break;

        default:
        return string;
        break;
    }
}