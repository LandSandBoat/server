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
        DOOR_FIRMLY_SHUT              = 7265,  -- The door is firmly shut.
        ALL_G_ORBS_ENERGIZED          = 7268,  -- The six Mana Orbs have been successfully energized with magic!
        CHEST_UNLOCKED                = 7291,  -- You unlock the chest!
        CANNOT_ENTER_BATTLEFIELD      = 7352,  -- You cannot enter this battlefield with the key item: <keyitem> in your possession.
        PLAYER_OBTAINS_ITEM           = 8268,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8269,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8270,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8271,  -- You already possess that temporary item.
        NO_COMBINATION                = 8276,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10354, -- New training regime registered!
    },
    mob =
    {
        DESMODONT_PH                =
        {
            [17571868] = 17571870,
        },
        AH_PUCH_PH                  =
        {
            [17571893] = 17571903, -- -418, -1, 629
            [17571894] = 17571903, -- -419, -1, 570
            [17571895] = 17571903, -- -419, -1, 581
            [17571896] = 17571903, -- -418, -1, 590
            [17571897] = 17571903, -- -418, -1, 597
            [17571898] = 17571903, -- -417, -1, 640
            [17571899] = 17571903, -- -419, -1, 615
            [17571900] = 17571903, -- -417, -1, 661
        },
        BALLOON_NM_OFFSET          = 17572141,
        FULL_MOON_FOUNTAIN_OFFSET  = 17572197,
        JESTER_WHOD_BE_KING_OFFSET = 17572201,
        APPARATUS_ELEMENTAL        = 17572203,
        CUSTOM_CARDIAN_OFFSET      = 17572204, -- Goes up to 17572218
    },
    npc =
    {
        GATE_MAGICAL_GIZMO = 17572248,
        TREASURE_CHEST     = 17572290,
    },
}

return zones[xi.zone.OUTER_HORUTOTO_RUINS]
