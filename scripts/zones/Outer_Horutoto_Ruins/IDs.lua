-----------------------------------
-- Area: Outer_Horutoto_Ruins
-----------------------------------
zones = zones or {}

zones[xi.zone.OUTER_HORUTOTO_RUINS] =
{
    text =
    {
        ORB_ALREADY_PLACED            = 0,     -- A dark Mana Orb is already placed here.
        GUARDIAN_BLOCKING_WAY         = 14,    -- A GUARDIAN IS BLOCKING YOUR WAY!
        CONQUEST_BASE                 = 15,    -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 188,   -- The device is not working.
        SYS_OVERLOAD                  = 197,   -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 202,   -- You lost the <item>.
        ITEM_CANNOT_BE_OBTAINED       = 6590,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6596,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6597,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6599,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6610,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6625,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7207,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7208,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7209,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7218,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7229,  -- Your party is unable to participate because certain members' levels are restricted.
        DOOR_FIRMLY_SHUT              = 7274,  -- The door is firmly shut.
        ALL_G_ORBS_ENERGIZED          = 7277,  -- The six Mana Orbs have been successfully energized with magic!
        CHEST_UNLOCKED                = 7300,  -- You unlock the chest!
        IF_HAD_ORBS                   = 7358,  -- You sense that if you had <keyitem>, <keyitem>, <keyitem>, or <keyitem>, something might happen.
        CANNOT_ENTER_BATTLEFIELD      = 7361,  -- You cannot enter this battlefield with the key item: <keyitem> in your possession.
        MUST_WAIT_LONGER              = 7362,  -- It appears you must wait longer to commence the battle.
        COMMENCING_EXPERIMENT         = 7363,  -- CoMM-eN-cInGEx-PE-rI-MeNt.
        INITIATING_TRANSMISSION       = 7364,  -- Da-TAcO-LLeC-TiOnCOmP-LETe! INi-TiAT-iNGTRAnS-miSS-IOnTOPRo-FeSS-oR...
        VENTURED_TOO_FAR              = 7365,  -- You have ventured too far from the field of battle. The Confrontation will automatically disengage if you do not return.
        CONFRONTATION_DISENGAGED      = 7366,  -- You have ventured too far from the field of battle. The Confrontation has been disengaged.
        RETURNED_TO_BATTLE            = 7367,  -- You have returned to the field of battle.
        YOU_HAVE_X_MINUTES_LEFT       = 7368,  -- You have <number> [minute/minutes] (Earth time) to complete the battle.
        YOU_HAVE_ONLY_X_SECONDS_LEFT  = 7370,  -- You have only <number> [second/seconds] (Earth time) remaining.
        CONFRONTATION_TIME_UP         = 7371,  -- Your time for this Confrontation is up...
        PLAYER_OBTAINS_ITEM           = 8277,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8278,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8279,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8280,  -- You already possess that temporary item.
        NO_COMBINATION                = 8285,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10363, -- New training regime registered!
    },

    mob =
    {
        AH_PUCH                    = GetFirstID('Ah_Puch'),
        APPARATUS_ELEMENTAL        = GetFirstID('Thunder_Elemental'),
        CUSTOM_CARDIAN_OFFSET      = GetFirstID('Custom_Cardian'),
        BALLOON_NM_OFFSET          = GetTableOfIDs('Balloon')[2], -- TODO: NM Needs audit. This only uses 2 of the NMs
        DESMODONT                  = GetFirstID('Desmodont'),
        FULL_MOON_FOUNTAIN_OFFSET  = GetFirstID('Jack_of_Cups'),
        JESTER_WHOD_BE_KING_OFFSET = GetFirstID('Queen_of_Swords'),
    },
    npc =
    {
        GATE_MAGICAL_GIZMO = GetFirstID('_5e9'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.OUTER_HORUTOTO_RUINS]
