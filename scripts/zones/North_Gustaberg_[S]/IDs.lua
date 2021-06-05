-----------------------------------
-- Area: North_Gustaberg_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NORTH_GUSTABERG_S] =
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
        LYCOPODIUM_ENTRANCED    = 7057, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET  = 7356, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE = 7545, -- Mining is possible here if you have <item>.
        COMMON_SENSE_SURVIVAL   = 9077, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB       = 8177, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR  = 8178, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT     = 8179, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB    = 8180, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN      = 8181, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1 = 8182, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2 = 8183, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI     = 8184, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI    = 8185, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        ANKABUT_PH =
        {
            [17137701] = 17137705, -- 656.399 -11.580 507.091
        },
        GLOOMANITA_PH =
        {
            [17137820] = 17137821, -- -19.961 0.5 623.989
        },
        VOIDWALKER  =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17138086, -- Globster
                17138085, -- Globster
                17138084, -- Globster
                17138083, -- Globster
                17138082,  -- Ground Guzzler
                17138081,  -- Ground Guzzler
                17138080,  -- Ground Guzzler
                17138079,  -- Ground Guzzler
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17138078, -- Lamprey Lord
                17138077,  -- Shoggoth
            },
            [xi.keyItem.ORANGE_ABYSSITE] = {
                17138070  -- Blobdingnag
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17138069  -- Yilbegan
            }
        }
    },
    pet =
    {
        [17138070] = -- Blobdingnag
        {
            17138076,-- Septic Boils
            17138075,-- Septic Boils
            17138074,-- Septic Boils
            17138073,-- Septic Boils
            17138072,-- Septic Boils
            17138071,-- Septic Boils
        },
    },
    npc =
    {
        MINING =
        {
            17138511,
            17138512,
            17138513,
            17138514,
            17138515,
            17138516,
        },
    },
}

return zones[xi.zone.NORTH_GUSTABERG_S]
