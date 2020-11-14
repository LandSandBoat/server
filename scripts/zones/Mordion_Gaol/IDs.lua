-----------------------------------
-- Area: Mordion_Gaol
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MORDION_GAOL] =
{
    text =
    {
        CONQUEST_BASE           = 0, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6547, -- Obtained: <item>.
        GIL_OBTAINED            = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6550, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7158, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7159, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7160, -- In celebration of your most recent login no. <number>...
        NO_ESCAPE               = 7208, -- Any attempt at escape is futile!
        PROHIBITED_ACTIVITIES   = 7224, -- Your character has been jailed due to prohibited activities. Your account will soon be suspended due to this violation.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.MORDION_GAOL]
