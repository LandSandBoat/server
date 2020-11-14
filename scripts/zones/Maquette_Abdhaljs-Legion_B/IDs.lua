-----------------------------------
-- Area: Maquette_Abdhaljs-Legion_B
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MAQUETTE_ABDHALJS_LEGION_B] =
{
    text =
    {
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.MAQUETTE_ABDHALJS_LEGION_B]
