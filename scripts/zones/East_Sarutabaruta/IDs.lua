-----------------------------------
-- Area: East_Sarutabaruta
-----------------------------------
zones = zones or {}

zones[xi.zone.EAST_SARUTABARUTA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6423, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7231, -- You can't fish here.
        DIG_THROW_AWAY                = 7244, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7246, -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7321, -- It appears your chocobo found this item with ease.
        SIGNPOST_OFFSET               = 7402, -- Southeast: South Tower, Horutoto Ruins Southwest: Windurst Woods
        TABY_CANATAHEY_DIALOG         = 7412, -- This is the entrrrance to Windurst. Please maintain orderrrly conduct while you'rrre in town.
        HEIH_PORHIAAP_DIALOG          = 7413, -- These grrrasslands make up East Sarutabaruta. Lately the number of monsters has drrramatically increased, causing us all sorts of trrrouble.
        SAMA_GOHJIMA_POSTDIALOG       = 7416, -- Were you able to find the laborrratory? There are many such hidden passages in the Horutoto Ruins.
        QUH_BERHUJA_DIALOG            = 7417, -- Hold on therrre! This ain't no place forrr adventurrrers to just wanderrr in and out of! Withdrrraw immediately!
        QUH_BERHUJA_STOLEN_ORBS       = 7419, -- Yowl! That was a close call, with those ferrral Carrrdians barrrging in therrre! Of courrrse, I rrran away...for help, I mean...
        PORE_OHRE_DIALOG              = 7421, -- There are reports of evil Cardians attacking people to steal the Mana Orbs created at this tower. Yikey-wikey, is this job scary!?
        PORE_OHRE_STOLEN_ORBS         = 7463, -- If you're heading back to town, then please go tell Minister Apururu at the Manustery about those feral Cardians stealing our Mana Orbs! Thanks, and be careful on your way homey-womey!
        PLAYER_OBTAINS_ITEM           = 7577, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7578, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7579, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7580, -- You already possess that temporary item.
        NO_COMBINATION                = 7585, -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7647, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        TIME_ELAPSED                  = 7729, -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        REGIME_REGISTERED             = 9947, -- New training regime registered!
    },
    mob =
    {
        SHARP_EARED_ROPIPI = GetFirstID('Sharp-Eared_Ropipi'),
        SPINY_SPIPI        = GetFirstID('Spiny_Spipi'),
        DUKE_DECAPOD       = GetFirstID('Duke_Decapod'),
    },
    npc =
    {
    },
}

return zones[xi.zone.EAST_SARUTABARUTA]
