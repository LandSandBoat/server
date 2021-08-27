-----------------------------------
-- Area: Manaclipper
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MANACLIPPER] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7053, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET  = 7223, -- You can't fish here.
        KHOTS_CHALAHKO_OFFSET   = 7396, -- Ahhh... Isn't it grrreat out here on the open sea!?
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.MANACLIPPER]
