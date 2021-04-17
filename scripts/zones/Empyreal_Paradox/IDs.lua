-----------------------------------
-- Area: Empyreal_Paradox
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EMPYREAL_PARADOX] =
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
        CONQUEST_BASE           = 7421, -- Tallying conquest results...
        PRISHE_TEXT             = 7686, -- You're about to learn how strong the will to live makes us!
        SELHTEUS_TEXT           = 7699, -- The...Emptiness... Is this...how it was meant...to be...?
        PROMATHIA_TEXT          = 7702, -- Give thyself to the apathy within...
        QM_TEXT                 = 7800, -- The air before you appears warped and distorted...
    },
    mob =
    {
        PROMATHIA_OFFSET = 16924673,
    },
    npc =
    {
    },
}

return zones[xi.zone.EMPYREAL_PARADOX]
