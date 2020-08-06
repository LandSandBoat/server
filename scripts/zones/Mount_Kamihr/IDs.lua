-----------------------------------
-- Area: Mount_Kamihr
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MOUNT_KAMIHR] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED          = 6397, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.MOUNT_KAMIHR]
