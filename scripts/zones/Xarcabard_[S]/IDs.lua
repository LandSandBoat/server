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
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET           = 8749, -- Home point set!
        VOIDWALKER_NO_MOB       = 8569, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR  = 8570, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT     = 8571, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB    = 8572, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN      = 8573, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1 = 8574, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2 = 8575, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI     = 8576, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI    = 8577, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        GRAOULLY_PH =
        {
            [17338384] = 17338386,
        },
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17338607, -- Gorehound
                17338606, -- Gorehound
                17338605, -- Gorehound
                17338604, -- Gorehound
                17338603, -- Gjenganger
                17338602, -- Gjenganger
                17338601, -- Gjenganger
                17338600, -- Gjenganger
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17338599, -- Erebus
                17338598  -- Feuerunke
            },
            [xi.keyItem.PURPLE_ABYSSITE] = {
                17338597  -- Lord Ruthven
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17338596  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[xi.zone.XARCABARD_S]
