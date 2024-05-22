-----------------------------------
-- Area: Pashhow_Marshlands_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.PASHHOW_MARSHLANDS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7161, -- You can't fish here.
        CAMPAIGN_RESULTS_TALLIED      = 7621, -- Campaign results tallied.
        ALREADY_OBTAINED_TELE         = 7706, -- You already possess the gate crystal for this telepoint.
        VOIDWALKER_DESPAWN            = 8002, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8049, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8050, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8051, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8052, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8054, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8055, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8056, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8057, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 9086, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        SUGAAR    = GetFirstID('Sugaar'),
        NOMMO     = GetFirstID('Nommo'),
        KINEPIKWA = GetFirstID('Kinepikwa'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17146186, -- Globster
                17146185, -- Globster
                17146184, -- Globster
                17146183, -- Globster
                17146182, -- Ground Guzzler
                17146181, -- Ground Guzzler
                17146180, -- Ground Guzzler
                17146179, -- Ground Guzzler
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17146178, -- Lamprey Lord
                17146177, -- Shoggoth
            },

            [xi.keyItem.ORANGE_ABYSSITE] =
            {
                17146170, -- Blobdingnag
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17146169, -- Yilbegan
            }
        }
    },

    pet =
    {
        [17146170] = -- Blobdingnag
        {
            17146176, -- Septic Boils
            17146175, -- Septic Boils
            17146174, -- Septic Boils
            17146173, -- Septic Boils
            17146172, -- Septic Boils
            17146171, -- Septic Boils
        },
    },

    npc =
    {
        CAMPAIGN_NPC_OFFSET        = GetFirstID('Yuvalbaux_RK'), -- San, Bas, Win, Flag +4, CA
        INDESCRIPT_MARKINGS_OFFSET = GetFirstID('Indescript_Markings'),
    },
}

return zones[xi.zone.PASHHOW_MARSHLANDS_S]
