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
        ITEM_CANNOT_BE_OBTAINED       = 6589,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6595,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6596,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6598,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6624,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7206,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7207,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7208,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7217,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7228,  -- Your party is unable to participate because certain members' levels are restricted.
        DOOR_FIRMLY_SHUT              = 7269,  -- The door is firmly shut.
        ALL_G_ORBS_ENERGIZED          = 7272,  -- The six Mana Orbs have been successfully energized with magic!
        CHEST_UNLOCKED                = 7295,  -- You unlock the chest!
        CANNOT_ENTER_BATTLEFIELD      = 7356,  -- You cannot enter this battlefield with the key item: <keyitem> in your possession.
        PLAYER_OBTAINS_ITEM           = 8272,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8273,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8274,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8275,  -- You already possess that temporary item.
        NO_COMBINATION                = 8280,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10358, -- New training regime registered!
    },
    mob =
    {
        DESMODONT                  = GetFirstID('Desmodont'),
        AH_PUCH                    = GetFirstID('Ah_Puch'),
        BALLOON_NM_OFFSET          = GetTableOfIDs('Balloon')[2], -- TODO: NM Needs audit. This only uses 2 of the NMs
        FULL_MOON_FOUNTAIN_OFFSET  = GetFirstID('Jack_of_Cups'),
        JESTER_WHOD_BE_KING_OFFSET = GetFirstID('Queen_of_Swords'),
        APPARATUS_ELEMENTAL        = GetFirstID('Thunder_Elemental'),
        CUSTOM_CARDIAN_OFFSET      = GetFirstID('Custom_Cardian'),
    },
    npc =
    {
        GATE_MAGICAL_GIZMO = GetFirstID('_5e9'),
        TREASURE_CHEST     = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.OUTER_HORUTOTO_RUINS]
