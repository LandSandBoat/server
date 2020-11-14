-----------------------------------
-- Area: Talacca_Cove
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TALACCA_COVE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6388, -- Obtained: <item>.
        GIL_OBTAINED                 = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS          = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY      = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                 = 7001, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET       = 7049, -- You can't fish here.
        YOU_CAN_NOW_BECOME_A_CORSAIR = 7782, -- You can now become a corsair!
    },
    mob =
    {
        GESSHO = 17010725,
    },
    npc =
    {
    },
}

return zones[tpz.zone.TALACCA_COVE]
