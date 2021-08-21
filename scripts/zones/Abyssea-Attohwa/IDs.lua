-----------------------------------
-- Area: Abyssea-Attohwa
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
zones = zones or {}

zones[xi.zone.ABYSSEA_ATTOHWA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL             = 6987, -- Obtained <number> cruor. (Total: <number>)
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        NO_VISITANT_STATUS      = 7296, -- You do not have visitant status. Please proceed to the nearest Conflux Surveyor to have it granted.
        EXITING_ABYSSEA_OFFSET  = 7231, -- Exiting in <number> [minute/minutes].
        EXITING_IN_MINUTES      = 7231, -- Exiting in <number> [minute/minutes].
        THOSE_WITHOUT_VISITANT  = 7232, -- Those without visitant status will be ejected from the area in <number> [minute/minutes]. To learn about this status, please consult a Conflux Surveyor.
        EXITING_IN_MIN_SEC      = 7233, -- Exiting in <number> [second/minute].
        EXITING_IN_MINS_SECS    = 7234, -- Exiting in <number> [seconds/minutes].
        EXITING_NOW             = 7235, -- Exiting now.
        NO_VISITANT_WARD        = 7237, -- You do not have visitant status. Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_SEARING_IN = 7238, -- Returning to the Searing Ward in <number> [second/seconds].
        RETURNING_TO_WARD       = 7239, -- Returning to the Searing Ward now.
        CRUOR_OBTAINED          = 7399, -- <name> obtained <number> cruor.
    },

    mob =
    {
    },

    npc =
    {
    },
}

return zones[xi.zone.ABYSSEA_ATTOHWA]
