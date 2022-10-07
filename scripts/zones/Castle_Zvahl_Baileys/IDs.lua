-----------------------------------
-- Area: Castle_Zvahl_Baileys
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
zones = zones or {}

zones[xi.zone.CASTLE_ZVAHL_BAILEYS] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549, -- Obtained: <item>.
        GIL_OBTAINED                  = 6550, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6563, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6564, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6578, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182, -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7234, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL         = 7609, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        MARQUIS_SABNOCK_PH =
        {
            [17436879] = 17436881,
            [17436882] = 17436881,
        },

        LIKHO            = DYNAMIC_LOOKUP,
        MARQUIS_ALLOCEN  = DYNAMIC_LOOKUP,
        MARQUIS_AMON     = DYNAMIC_LOOKUP,
        DUKE_HABORYM     = DYNAMIC_LOOKUP,
        GRAND_DUKE_BATYM = DYNAMIC_LOOKUP,
        DARK_SPARK       = DYNAMIC_LOOKUP,
        MIMIC            = DYNAMIC_LOOKUP,
    },

    npc =
    {
        TORCH_OFFSET    = 17436984,
        TREASURE_CHEST  = DYNAMIC_LOOKUP,
        TREASURE_COFFER = DYNAMIC_LOOKUP,
    },
}

return zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
