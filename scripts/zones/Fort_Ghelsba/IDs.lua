-----------------------------------
-- Area: Fort_Ghelsba
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.FORT_GHELSBA] =
{
    text =
    {
        CONQUEST_BASE           = 0, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6547, -- Obtained: <item>.
        GIL_OBTAINED            = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6550, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6576, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7158, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7159, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7160, -- In celebration of your most recent login no. <number>...
        CHEST_UNLOCKED          = 7355, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL   = 7363, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HUNDREDSCAR_HAJWAJ_PH =
        {
            [17354823] = 17354828,
        },
        ORCISH_PANZER = 17354894,
    },
    npc =
    {
        TREASURE_CHEST = 17355012,
    },
}

return zones[tpz.zone.FORT_GHELSBA]
