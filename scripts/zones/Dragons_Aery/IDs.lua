-----------------------------------
-- Area: Dragons_Aery
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.DRAGONS_AERY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389, -- Obtained: <item>.
        GIL_OBTAINED               = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6398, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET     = 7053, -- You can't fish here.
        CONQUEST_BASE              = 7155, -- Tallying conquest results...
        COMMON_SENSE_SURVIVAL      = 7499, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        FAFNIR  = 17408018,
        NIDHOGG = 17408019,
    },
    npc =
    {
        FAFNIR_QM = 17408033,
    },
}

return zones[xi.zone.DRAGONS_AERY]
