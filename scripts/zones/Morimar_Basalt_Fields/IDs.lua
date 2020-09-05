-----------------------------------
-- Area: Morimar_Basalt_Fields
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MORIMAR_BASALT_FIELDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        HOMEPOINT_SET           = 8163, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.MORIMAR_BASALT_FIELDS]
