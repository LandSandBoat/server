-----------------------------------
-- Area: Meriphataud_Mountains_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MERIPHATAUD_MOUNTAINS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6403, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        ALREADY_OBTAINED_TELE   = 7592, -- You already possess the gate crystal for this telepoint.
        COMMON_SENSE_SURVIVAL   = 8941, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB       = 7908, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR  = 7909, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT     = 7910, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB    = 7911, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN      = 7912, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1 = 7913, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2 = 7914, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI     = 7915, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI    = 7916, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        CENTIPEDAL_CENTRUROIDES_PH =
        {
            [17174708] = 17174709,
        },
        BLOODLAPPER = 17174889,
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17174917, -- Raker bee
                17174916, -- Raker bee
                17174915, -- Raker bee
                17174914, -- Raker bee
                17174913,  -- Rummager beetle
                17174912,  -- Rummager beetle
                17174911,  -- Rummager beetle
                17174910,  -- Rummager beetle
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17174909,  -- Jyeshtha
                17174908, -- Farruca Fly
            },
            [xi.keyItem.BROWN_ABYSSITE] = {
                17174907  -- Orcus
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17174906  -- Yilbegan
            }
        }
    },
    npc =
    {
        INDESCRIPT_MARKINGS = 17175342,
    },
}

return zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
