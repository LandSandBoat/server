-----------------------------------
-- Area: East_Ronfaure_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.EAST_RONFAURE_S] =
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
        LOGGING_IS_POSSIBLE_HERE      = 7158, -- Logging is possible here if you have <item>.
        CAMPAIGN_RESULTS_TALLIED      = 7366, -- Campaign results tallied.
        FISHING_MESSAGE_OFFSET        = 7742, -- You can't fish here.
        VOIDWALKER_DESPAWN            = 8004, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8051, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8052, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8053, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8054, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8056, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8057, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8058, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8059, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 8969, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        GOBLINTRAP_PH =
        {
            [17109295] = 17109296, -- 156 0 -438
        },

        SKOGS_FRU_PH =
        {
            [17109268] = 17109338,
            [17109306] = 17109338,
            [17109307] = 17109338,
            [17109308] = 17109338,
        },

        MYRADROSH    = 17109235,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17109393, -- Sunderclaw
                17109392, -- Sunderclaw
                17109391, -- Sunderclaw
                17109390, -- Sunderclaw
                17109389, -- Quagmire Pugil
                17109388, -- Quagmire Pugil
                17109387, -- Quagmire Pugil
                17109386, -- Quagmire Pugil
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17109385, -- Capricornus
                17109384, -- Yacumama
            },

            [xi.keyItem.BLUE_ABYSSITE] =
            {
                17109383, -- Krabkatoa
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17109382, -- Yilbegan
            }
        }
    },

    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Arlayse_RK'), -- San, Bas, Win, Flag +4, CA
        LOGGING             = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.EAST_RONFAURE_S]
