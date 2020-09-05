-----------------------------------
-- Area: Dynamis-Windurst_[D]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_WINDURST_D] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED          = 6397, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        CONQUEST_BASE           = 7049, -- Tallying conquest results...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.DYNAMIS_WINDURST_D]
