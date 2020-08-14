-----------------------------------
-- Area: Ceizak Battlegrounds (261)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CEIZAK_BATTLEGROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        HOMEPOINT_SET           = 7783, -- Home point set!
        UNCANNY_SENSATION       = 8025, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE         = 8026, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH         = 8027, -- You feel a mystical warmth welling up inside you!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CEIZAK_BATTLEGROUNDS]
