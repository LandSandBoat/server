-----------------------------------
-- Area: Attohwa_Chasm
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ATTOHWA_CHASM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6393, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET   = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7053, -- Tallying conquest results...
        MINING_IS_POSSIBLE_HERE = 7212, -- Mining is possible here if you have <item>.
        GASPONIA_POISON         = 7332, -- The poison of the Gasponia has begun to spread through your body.
        OCCASIONAL_LUMPS        = 7347, -- Occasionally lumps arise in the ground here, then settle down again. It seems that there is something beneath the earth.
        HOMEPOINT_SET           = 8234, -- Home point set!
    },
    mob =
    {
        AMBUSHER_ANTLION_PH =
        {
            [16806171] = 16806249, -- -433.309 -4.3 113.841
        },
        CITIPATI_PH         =
        {
            [16806155] = 16806162, -- -328.973 -12.876 67.481
            [16806158] = 16806162, -- -398.931 -4.536 79.640
            [16806161] = 16806162, -- -381.284 -9.233 40.054
        },
        LIOUMERE            = 16806031,
        TIAMAT              = 16806227,
        FEELER_ANTLION      = 16806242,
    },
    npc =
    {
        MIASMA_OFFSET   = 16806304, -- _071 in npc_list
        GASPONIA_OFFSET = 16806327, -- _07n in npc_list
        EXCAVATION =
        {
            16806374,
            16806370,
            16806371,
            16806372,
            16806373,
            16806374,
        },
    },
}

return zones[xi.zone.ATTOHWA_CHASM]
