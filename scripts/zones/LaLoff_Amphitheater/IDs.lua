-----------------------------------
-- Area: LaLoff_Amphitheater
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LALOFF_AMPHITHEATER] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE           = 7049, -- Tallying conquest results...
    },
    mob =
    {
    },
    npc =
    {
        ENTRANCE_OFFSET = 17514791, -- used by scripts/globals/bcnm.lua
    },
}

return zones[tpz.zone.LALOFF_AMPHITHEATER]
