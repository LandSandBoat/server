-----------------------------------
-- Area: East_Sarutabaruta
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EAST_SARUTABARUTA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7219, -- You can't fish here.
        DIG_THROW_AWAY                = 7232, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7234, -- You dig and you dig, but find nothing.
        SIGNPOST_OFFSET               = 7389, -- Southeast: South Tower, Horutoto Ruins Southwest: Windurst Woods
        TABY_CANATAHEY_DIALOG         = 7399, -- This is the entrrrance to Windurst. Please maintain orderrrly conduct while you'rrre in town.
        HEIH_PORHIAAP_DIALOG          = 7400, -- These grrrasslands make up East Sarutabaruta. Lately the number of monsters has drrramatically increased, causing us all sorts of trrrouble.
        SAMA_GOHJIMA_POSTDIALOG       = 7403, -- Were you able to find the laborrratory? There are many such hidden passages in the Horutoto Ruins.
        QUH_BERHUJA_DIALOG            = 7404, -- Hold on therrre! This ain't no place forrr adventurrrers to just wanderrr in and out of! Withdrrraw immediately!
        QUH_BERHUJA_STOLEN_ORBS       = 7406, -- Yowl! That was a close call, with those ferrral Carrrdians barrrging in therrre! Of courrrse, I rrran away...for help, I mean...
        PORE_OHRE_DIALOG              = 7408, -- There are reports of evil Cardians attacking people to steal the Mana Orbs created at this tower. Yikey-wikey, is this job scary!?
        PORE_OHRE_STOLEN_ORBS         = 7450, -- If you're heading back to town, then please go tell Minister Apururu at the Manustery about those feral Cardians stealing our Mana Orbs! Thanks, and be careful on your way homey-womey!
        GOLDFISH_NPC_DIALOGUE         = 7504, -- Step right up and test your skill at Grabbin' Goldfish!
        GOLDFISH_POINT_UPDATE         = 7551, -- Your point total is now <int>.
        PLAYER_OBTAINS_ITEM           = 7573, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7574, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7575, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7576, -- You already possess that temporary item.
        NO_COMBINATION                = 7581, -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7643, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9942, -- New training regime registered!
        SMILEBRINGER_START            = 11109, -- So, are you ready-steady? Beginner level training...GO! Come on, pump those legs like there's no tomorrow!
        SMILEHELPER_IDLE              = 11137, -- This is a checkpointaru for the Smilebringer Boot camp. To learny-wearn more, please speak with the smile sergeant posted by the town entrance.
        SMILEHELPER_CHECKPOINT_1      = 11131, -- Checkpoint <number> cleared, Elasped time: [minutes], [seconds]
        SMILEHELPER_CHECKPOINT_2      = 11132, -- Checkpoint <number> cleared! You gain the effect of Flee. Elasped time: [minutes], [seconds]
        SMILEHELPER_ALREADY_VISITED   = 11133, -- You have already cleared this checkpoint. Elapsed time: [minutes], [seconds]
        SMILEHELPER_POINTS_CLEARED    = 11135, -- All checkpoints cleared! Please report back to the smile sergeant in charge.
    },
    mob =
    {
        SHARP_EARED_ROPIPI_PH =
        {
            [17252507] = 17252489, -- 363.152 -16.705 -326.213
            [17252506] = 17252489, -- 303.282 -17.642 -415.870
            [17252487] = 17252489, -- 224.258 -17.858 -486.256
            [17252488] = 17252489, -- 227.825 -16.978 -317.467
        },
        SPINY_SPIPI_PH =
        {
            [17252656] = 17252657
        },
        DUKE_DECAPOD   = 17252725,
    },
    npc =
    {
        STARLIGHT_DECORATIONS =
        {
            [17253113] = 17253113,  -- Whispering Tortoise (Smilebringer Bootcamp Sergeant)
        },
        SMILE_HELPERS =
        {
            [17253114] = 17253114,  -- Smile Helper
            [17253115] = 17253115,  -- Smile Helper
            [17253116] = 17253116,  -- Smile Helper
            [17253117] = 17253117,  -- Smile Helper
            [17253118] = 17253118,  -- Smile Helper
            [17253119] = 17253119,  -- Smile Helper
            [17253120] = 17253120,  -- Smile Helper
            [17253121] = 17253121,  -- Smile Helper
            [17253122] = 17253122,  -- Smile Helper
            [17253123] = 17253123,  -- Smile Helper
        },
        GOLDFISH_NPC = 17253106, -- Sunbreeze Festival Goldfish NPC
    },
}

return zones[xi.zone.EAST_SARUTABARUTA]
