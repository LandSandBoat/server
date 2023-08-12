-----------------------------------
-- Area: Walk of Echoes [P2]
-----------------------------------
zones = zones or {}

zones[xi.zone.WALK_OF_ECHOES_P2] =
{
    text =
    {
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WALK_OF_ECHOES_P2]
