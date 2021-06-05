-----------------------------------
-- Area: Sauromugue_Champaign_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
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
        COMMON_SENSE_SURVIVAL   = 10056, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB       = 8663, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR  = 8664, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT     = 8665, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB    = 8666, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN      = 8667, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1 = 8668, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2 = 8669, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI     = 8670, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI    = 8671, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        BALAM_QUITZ_PH =
        {
            [17178778] = 17178803, -- 481.509 24.184 98.264
        },
        COQUECIGRUE = 17178689,
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17178932,  -- Lacus
                17178931,  -- Thunor
                17178930, -- Beorht
                17178929, -- Pruina
                17178928,  -- Puretos
                17178927,  -- Eorthe
                17178926, -- Deorc
                17178925, -- Aither
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17178924, -- Skuld
                17178923  -- Urd
            },
            [xi.keyItem.YELLOW_ABYSSITE] = {
                17178922  -- Verthandi
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17178921  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S]
