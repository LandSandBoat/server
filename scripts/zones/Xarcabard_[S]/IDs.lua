-----------------------------------
-- Area: Xarcabard_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.XARCABARD_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        VOIDWALKER_DESPAWN      = 8172, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB       = 8576, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR  = 8577, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT     = 8578, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB    = 8579, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1 = 8581, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2 = 8582, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI     = 8583, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI    = 8584, -- Obtained key item: <keyitem>!
        HOMEPOINT_SET           = 8756, -- Home point set!
    },
    mob =
    {
        GRAOULLY_PH =
        {
            [17338384] = 17338386,
        },
        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17338607, -- Gorehound
                17338606, -- Gorehound
                17338605, -- Gorehound
                17338604, -- Gorehound
                17338603, -- Gjenganger
                17338602, -- Gjenganger
                17338601, -- Gjenganger
                17338600, -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17338599, -- Erebus
                17338598, -- Feuerunke
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17338597, -- Lord Ruthven
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17338596, -- Yilbegan
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.XARCABARD_S]
