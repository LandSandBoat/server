-----------------------------------
-- Area: The Eldieme Necropolis (195)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.THE_ELDIEME_NECROPOLIS] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED          = 6542,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6548,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6549,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6551,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY          = 6562,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING              = 6563,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET            = 6577,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS              = 7159, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7160, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7161, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED             = 7170,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        DEVICE_NOT_WORKING               = 7319,  -- The device is not working.
        SYS_OVERLOAD                     = 7328,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                     = 7333,  -- You lost the <item>.
        NOTHING_HAPPENED                 = 7343,  -- Nothing happened...
        RETURN_RIBBON_TO_HER             = 7356,  -- You can hear a voice from somewhere. (...return...ribbon to...her...)
        THE_BRAZIER_IS_LIT               = 7370,  -- The brazier is lit.
        REFUSE_TO_LIGHT                  = 7371,  -- Unexpectedly, the <item> refuses to light.
        LANTERN_GOES_OUT                 = 7372,  -- For some strange reason, the light of the <item> goes out...
        THE_LIGHT_DIMLY                  = 7373,  -- The <item> lights dimly. It doesn't look like this will be effective yet.
        THE_LIGHT_HAS_INTENSIFIED        = 7374,  -- The light of the <item> has intensified.
        THE_LIGHT_IS_FULLY_LIT           = 7375,  -- The <item> is fully lit!
        SOLID_STONE                      = 7383,  -- This door is made of solid stone.
        CHEST_UNLOCKED                   = 7403,  -- You unlock the chest!
        SPIRIT_INCENSE_EMITS_PUTRID_ODOR = 7413,  -- The <item> emits a putrid odor and burns up. Your attempt this time has failed...
        SARCOPHAGUS_CANNOT_BE_OPENED     = 7430,  -- It is a stone sarcophagus with the lid sealed tight. It cannot be opened.
        SEEMS_TO_BE_THE_END              = 7558,  -- That seems to be the end of it.
        GIRL_BACK_TO_JEUNO               = 7570,  -- I'll take the little girl back to Jeuno. Take care.
        NOT_TIME_TO_SEARCH               = 7582,  -- Now doesn't seem to be the time to search here.
        PLAYER_OBTAINS_ITEM              = 7589,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM            = 7590,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM         = 7591,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP             = 7592,  -- You already possess that temporary item.
        NO_COMBINATION                   = 7597,  -- You were unable to enter a combination.
        REGIME_REGISTERED                = 9675,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL            = 11629, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        CWN_CYRFF_PH  =
        {
            [17576050] = 17576054, -- -375.862 0.542 382.17
            [17576051] = 17576054, -- -399.941 0.027 379.055
            [17576052] = 17576054, -- -384.019 0.509 384.26
            [17576053] = 17576054, -- -376.974 0.586 343.750
        },
        LICH_C_MAGNUS       = 17575937,
        YUM_KIMIL           = 17576264,
        STURM               = 17576267,
        TAIFUN              = 17576268,
        TROMBE              = 17576269,
        MIMIC               = 17576270,
        APPARATUS_ELEMENTAL = 17576271,
        NAMORODO            = 17576272,
    },
    npc =
    {
        CASKET_BASE        = 17576280,
        GATE_OFFSET        = 17576306,
        BRAZIER_OFFSET     = 17576343,
        TREASURE_CHEST     = 17576356,
        TREASURE_COFFER    = 17576357,
        SARCOPHAGUS_OFFSET = 17576394,
    },
}

return zones[ xi.zone.THE_ELDIEME_NECROPOLIS]
