-----------------------------------
-- Area: Castle_Zvahl_Baileys
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CASTLE_ZVAHL_BAILEYS] =
{
    text =
    {
        CONQUEST_BASE           = 0, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6547, -- Obtained: <item>.
        GIL_OBTAINED            = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6550, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6561, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING     = 6562, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET   = 6576, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7158, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7059, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7060, -- In celebration of your most recent login no. <number>...
        CHEST_UNLOCKED          = 7223, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL   = 7598, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MARQUIS_SABNOCK_PH =
        {
            [17436879] = 17436881,
            [17436882] = 17436881,
        },
        LIKHO            = 17436714,
        MARQUIS_ALLOCEN  = 17436913,
        MARQUIS_AMON     = 17436918,
        DUKE_HABORYM     = 17436923,
        GRAND_DUKE_BATYM = 17436927,
        DARK_SPARK       = 17436964,
        MIMIC            = 17436965,
    },
    npc =
    {
        TORCH_OFFSET    = 17436984,
        TREASURE_CHEST  = 17436997,
        TREASURE_COFFER = 17436998,
    },
}

return zones[tpz.zone.CASTLE_ZVAHL_BAILEYS]
