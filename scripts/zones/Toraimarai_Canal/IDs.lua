-----------------------------------
-- Area: Toraimarai Canal (169)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TORAIMARAI_CANAL] =
{
    text =
    {
        SEALED_SHUT              = 3,     -- It's sealed shut with incredibly strong magic.
        ITEM_CANNOT_BE_OBTAINED  = 6428,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6434,  -- Obtained: <item>.
        GIL_OBTAINED             = 6435,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6437,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6463,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7045, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 7046, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 7047, -- In celebration of your most recent login no. <number>...
        GEOMAGNETRON_ATTUNED     = 7056,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE            = 7095,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7254,  -- You can't fish here.
        CHEST_UNLOCKED           = 7362,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM      = 7531,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7532,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7533,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7534,  -- You already possess that temporary item.
        NO_COMBINATION           = 7539,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9617,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 10665, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET            = 10693, -- Home point set!
    },
    mob =
    {
        CANAL_MOOCHER_PH =
        {
            [17469575] = 17469578,
            [17469576] = 17469578,
            [17469577] = 17469578,
        },
        KONJAC_PH =
        {
            [17469629] = 17469632,
            [17469630] = 17469632,
            [17469631] = 17469632,
        },
        MAGIC_SLUDGE      = 17469516,
        HINGE_OILS_OFFSET = 17469666,
        MIMIC             = 17469761,
    },
    npc =
    {
        TOME_OF_MAGIC_OFFSET = 17469828,
        TREASURE_COFFER      = 17469835,
        CASKET_BASE          = 17469772,
    },
}

return zones[tpz.zone.TORAIMARAI_CANAL]
