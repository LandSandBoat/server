-----------------------------------
-- Area: AlTaieu
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ALTAIEU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        QUASILUMIN_01           = 7365, -- This is Al'Taieu. The celestial capital overflowing with the blessings of Altana.
        NOTHING_OF_INTEREST     = 7475, -- There is nothing of interest here.
        OMINOUS_SHADOW          = 7476, -- An ominous shadow falls over you...
        AMULET_SHATTERED        = 7497, -- The <item> held by <name> has shattered...
        LIGHT_STOLEN            = 7498, -- The <item> was stolen by Nag'molada...
        RETURN_AMULET_TO_PRISHE = 7523, -- You return the <item> to Prishe.
        HOMEPOINT_SET           = 7564, -- Home point set!
    },
    mob =
    {
        EUVHIS_WHITE         = 16912811,
        EUVHIS_RED           = 16912817,
        EUVHIS_BLACK         = 16912823,
        AERNS_TOWER_SOUTH_1  = 16912829,
        AERNS_TOWER_SOUTH_2  = 16912830,
        AERNS_TOWER_SOUTH_3  = 16912831,
        AERNS_TOWER_WEST_1   = 16912832,
        AERNS_TOWER_WEST_2   = 16912833,
        AERNS_TOWER_WEST_3   = 16912834,
        AERNS_TOWER_EAST_1   = 16912835,
        AERNS_TOWER_EAST_2   = 16912836,
        AERNS_TOWER_EAST_3   = 16912837,
        JAILER_OF_HOPE       = 16912838,
        JAILER_OF_JUSTICE    = 16912839,
        JAILER_OF_PRUDENCE_1 = 16912846,
        JAILER_OF_PRUDENCE_2 = 16912847,
        JAILER_OF_LOVE       = 16912848,
        ABSOLUTE_VIRTUE      = 16912876,
    },
    npc =
    {
        AURORAL_UPDRAFT_OFFSET    = 16912902,
        SWIRLING_VORTEX_OFFSET    = 16912908,
        DIMENSIONAL_PORTAL_OFFSET = 16912910,
    },
}

return zones[tpz.zone.ALTAIEU]
