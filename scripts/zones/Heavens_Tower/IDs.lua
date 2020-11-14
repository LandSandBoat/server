-----------------------------------
-- Area: Heavens_Tower
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.HEAVENS_TOWER] =
{
    text =
    {
        STAIRWAY_LOCKED         = 554, -- The door to the Starway Stairway is locked tight.
        STAIRWAY_ONLY_CITIZENS  = 555, -- The door to the Starway Stairway is locked tight, and only citizens of Windurst can open it.
        CONQUEST_BASE           = 582, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED = 7123, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 7129, -- Obtained: <item>.
        GIL_OBTAINED            = 7130, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 7132, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 7134, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6586, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 6587, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 6588, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET  = 7366, -- You can't fish here.
        CELEBRATORY_GOODS       = 9099, -- An assortment of celebratory goods is available for purchase.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.HEAVENS_TOWER]
