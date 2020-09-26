-----------------------------------
-- Area: Altar_Room
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ALTAR_ROOM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6388, -- Obtained: <item>.
        GIL_OBTAINED                 = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6391, -- Obtained key item: <keyitem>.
        THE_MAGICITE_GLOWS_OMINOUSLY = 7102, -- The magicite glows ominously.
        CONQUEST_BASE                = 7103, -- Tallying conquest results...
    },
    mob =
    {
        YAGUDO_AVATAR                = 17399809,
        YAGUDOS_ELEMENTAL            = 17399810,
        YAGUDOS_AVATAR               = 17399811,
        LAA_YAKU_THE_AUSTERE         = 17399812,
        DUU_MASA_THE_ONECUT          = 17399813,
        FEE_JUGE_THE_RAMFIST         = 17399814,
        POO_YOZO_THE_BABBLER         = 17399815,
        KEE_TAW_THE_NIGHTINGALE      = 17399816,
        GOO_PAKE_THE_BLOODHOUND      = 17399817,
    },
    npc =
    {
    },
}

return zones[tpz.zone.ALTAR_ROOM]
