-----------------------------------
-- Area: Altar_Room
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ALTAR_ROOM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6389, -- Obtained: <item>.
        GIL_OBTAINED                 = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS          = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        THE_MAGICITE_GLOWS_OMINOUSLY = 7103, -- The magicite glows ominously.
        CONQUEST_BASE                = 7104, -- Tallying conquest results...
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

return zones[xi.zone.ALTAR_ROOM]
