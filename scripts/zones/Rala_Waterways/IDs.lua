-----------------------------------
-- Area: Rala_Waterways (258)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.RALA_WATERWAYS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6394, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED          = 7007, -- You have obtained <number> bayld!
        PERHAPS_THE_WISEST      = 8073, -- Perhaps the wisest approach would be to search for <keyitem> with which to open the decrepit sluice gate.
        NOTHING_HAPPENS         = 8423, -- Nothing happens.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.RALA_WATERWAYS]
