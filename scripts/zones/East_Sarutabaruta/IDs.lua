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
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7053, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7212, -- You can't fish here.
        DIG_THROW_AWAY           = 7225, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7227, -- You dig and you dig, but find nothing.
        SIGNPOST_OFFSET          = 7382, -- Southeast: South Tower, Horutoto Ruins Southwest: Windurst Woods
        TABY_CANATAHEY_DIALOG    = 7392, -- This is the entrrrance to Windurst. Please maintain orderrrly conduct while you'rrre in town.
        HEIH_PORHIAAP_DIALOG     = 7393, -- These grrrasslands make up East Sarutabaruta. Lately the number of monsters has drrramatically increased, causing us all sorts of trrrouble.
        SAMA_GOHJIMA_POSTDIALOG  = 7396, -- Were you able to find the laborrratory? There are many such hidden passages in the Horutoto Ruins.
        QUH_BERHUJA_DIALOG       = 7397, -- Hold on therrre! This ain't no place forrr adventurrrers to just wanderrr in and out of! Withdrrraw immediately!
        QUH_BERHUJA_STOLEN_ORBS  = 7399, -- Yowl! That was a close call, with those ferrral Carrrdians barrrging in therrre! Of course, I rrran away..for help, I mean..
        PORE_OHRE_DIALOG         = 7401, -- There are reports of evil Cardians attacking people to steal the Mana Orbs created at this tower. Yikey-wikey, is this job scary!?
        PORE_OHRE_STOLEN_ORBS    = 7443, -- If you're hearing back to town, then please go tell Minister Apururu at the Manustery about those feral Cardians stealing our Mana Orbs! Thanks, and be careful on your way homey-womey!
        PLAYER_OBTAINS_ITEM      = 7573, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7574, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7575, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7576, -- You already possess that temporary item.
        NO_COMBINATION           = 7581, -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9941, -- New training regime registered!
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
        CASKET_BASE = 17253005,
    },
}

return zones[xi.zone.EAST_SARUTABARUTA]
