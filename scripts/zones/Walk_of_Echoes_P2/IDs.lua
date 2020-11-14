-----------------------------------
-- Area: Walk of Echoes [P2]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WALK_OF_ECHOES_P2] =
{
    text =
    {
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.WALK_OF_ECHOES_P2]
