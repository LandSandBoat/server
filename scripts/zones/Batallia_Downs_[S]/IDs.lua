-----------------------------------
-- Area: Batallia_Downs_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.BATALLIA_DOWNS_S] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7047, -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        LYCOPODIUM_ENTRANCED          = 7067, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET        = 7080, -- You can't fish here.
        NO_RESPONSE                   = 7702, -- There is no response...
        VOIDWALKER_DESPAWN            = 8266, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8313, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8314, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8315, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8316, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8318, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8319, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8320, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8321, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 9596, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        BURLIBIX_BRAWNBACK_PH =
        {
            [17121398] = GetFirstID("Burlibix_Brawnback"),
            [17121402] = GetFirstID("Burlibix_Brawnback"),
        },

        LA_VELUE_PH =
        {
            [17121554] = GetFirstID("La_Velue"), -- -314.365 -18.745 -56.016
        },

        HABERGOASS_PH =
        {
            [17121602] = GetFirstID("Habergoass"),
        },

        MENECHME = GetFirstID("Menechme"),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                GetFirstID("Lacus"),
                GetFirstID("Thunor"),
                GetFirstID("Beorht"),
                GetFirstID("Pruina"),
                GetFirstID("Puretos"),
                GetFirstID("Eorthe"),
                GetFirstID("Deorc"),
                GetFirstID("Aither"),
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                GetFirstID("Skuld"),
                GetFirstID("Urd")
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                GetFirstID("Verthandi")
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                GetFirstID("Yilbegan")
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.BATALLIA_DOWNS_S]
