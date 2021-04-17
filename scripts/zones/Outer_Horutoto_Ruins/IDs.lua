-----------------------------------
-- Area: Outer_Horutoto_Ruins
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.OUTER_HORUTOTO_RUINS] =
{
    text =
    {
        ORB_ALREADY_PLACED       = 0,     -- A dark Mana Orb is already placed here.
        CONQUEST_BASE            = 15,    -- Tallying conquest results...
        DEVICE_NOT_WORKING       = 188,   -- The device is not working.
        SYS_OVERLOAD             = 197,   -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE             = 202,   -- You lost the <item>.
        ITEM_CANNOT_BE_OBTAINED  = 6588,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6594,  -- Obtained: <item>.
        GIL_OBTAINED             = 6595,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6597,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6623,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7205, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7206, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7207, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED     = 7216,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        DOOR_FIRMLY_SHUT         = 7255,  -- The door is firmly shut.
        ALL_G_ORBS_ENERGIZED     = 7258,  -- The six Mana Orbs have been successfully energized with magic!
        CHEST_UNLOCKED           = 7281,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM      = 8258,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8259,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8260,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8261,  -- You already possess that temporary item.
        NO_COMBINATION           = 8266,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10344, -- New training regime registered!
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
        BALLOON_NM_OFFSET           = 17572141,
        FULL_MOON_FOUNTAIN_OFFSET   = 17572197,
        JESTER_WHO_D_BE_KING_OFFSET = 17572201,
        APPARATUS_ELEMENTAL         = 17572203,
    },
    npc =
    {
        CASKET_BASE        = 17572223,
        GATE_MAGICAL_GIZMO = 17572248,
        TREASURE_CHEST     = 17572290,
    },
}

return zones[xi.zone.OUTER_HORUTOTO_RUINS]
