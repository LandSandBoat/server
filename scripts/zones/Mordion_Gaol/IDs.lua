-----------------------------------
-- Area: Mordion_Gaol
-----------------------------------
zones = zones or {}

zones[xi.zone.MORDION_GAOL] =
{
    text =
    {
        CONQUEST_BASE                 = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6544, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6550, -- Obtained: <item>.
        GIL_OBTAINED                  = 6551, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6553, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7161, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7162, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7163, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7183, -- Your party is unable to participate because certain members' levels are restricted.
        NO_ESCAPE                     = 7223, -- Any attempt at escape is futile!
        PROHIBITED_ACTIVITIES         = 7239, -- Your character has been jailed due to prohibited activities. Your account will soon be suspended due to this violation.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.MORDION_GAOL]
