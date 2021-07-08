-----------------------------------
-- Area: Maquette_Abdhaljs-Legion_B (287)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MAQUETTE_ABDHALJS_LEGION_B] =
{
    text =
    {
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
    },
    mob =
    {
        17952867,
    },
    npc =
    {
    },
}

return zones[xi.zone.MAQUETTE_ABDHALJS_LEGION_B]
