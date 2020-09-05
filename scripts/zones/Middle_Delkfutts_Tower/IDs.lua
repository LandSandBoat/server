-----------------------------------
-- Area: Middle_Delkfutts_Tower
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MIDDLE_DELKFUTTS_TOWER] =
{
    text =
    {
        CONQUEST_BASE            = 4,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED  = 6545, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6551, -- Obtained: <item>.
        GIL_OBTAINED             = 6552, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6554, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6565, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING      = 6566, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET    = 6580, -- I'm ready. I suppose.
        FISHING_MESSAGE_OFFSET   = 7212, -- You can't fish here.
        CHEST_UNLOCKED           = 7320, -- You unlock the chest!
        PLAYER_OBTAINS_ITEM      = 7368, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7369, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7370, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7371, -- You already possess that temporary item.
        NO_COMBINATION           = 7376, -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9454, -- New training regime registered!
    },
    mob =
    {
        EURYTOS_PH               =
        {
            [17420316] = 17420324, -- 27 -47 101
            [17420321] = 17420324, -- 11 -47 99
        },
        POLYBOTES_PH             =
        {
            [17420378] = 17420382, -- -59.370 -64.105 17.313
            [17420381] = 17420382, -- -48.936 -64.114 8.575
            [17420383] = 17420382, -- -42.392 -63.535 -0.946
            [17420384] = 17420382, -- -31, -63.713 -3
        },
        RHOITOS_PH               =
        {
            [17420412] = 17420417, -- 70 -80.094 80
            [17420418] = 17420417, -- 81.445 -79.977 71.427
            [17420419] = 17420417, -- 77.924 -80.084 70.787
            [17420420] = 17420417, -- 75 -79.823 89
        },
        OPHION_PH                =
        {
            [17420513] = 17420529, -- -453 -95.529 -1
            [17420518] = 17420592, -- -409.937 -95.772 48.785
            [17420527] = 17420592, -- -384 -95.529 14
        },
        RHOIKOS_PH               =
        {
            [17420554] = 17420555, -- -402 -111.924 46
            [17420566] = 17420555, -- -389.084 -111.532 35.374
        },
        OGYGOS_PH                =
        {
            [17420593] = 17420592, -- -503 -127.715 24
        },
        BLADE_OF_EVIL_MOB_OFFSET = 17420629,
    },
    npc =
    {
        CASKET_BASE    = 17420640,
        TREASURE_CHEST = 17420676,
    },
}

return zones[tpz.zone.MIDDLE_DELKFUTTS_TOWER]
