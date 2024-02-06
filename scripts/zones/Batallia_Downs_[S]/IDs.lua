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
        LYCOPODIUM_ENTRANCED          = 7068, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET        = 7081, -- You can't fish here.
        CAMPAIGN_RESULTS_TALLIED      = 7618, -- Campaign results tallied.
        NO_RESPONSE                   = 7703, -- There is no response...
        VOIDWALKER_DESPAWN            = 8267, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8314, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8315, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8316, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8317, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8319, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8320, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8321, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8322, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 9597, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        BURLIBIX_BRAWNBACK_PH =
        {
            [17121398] = 17121399,
            [17121402] = 17121399,
        },

        LA_VELUE_PH =
        {
            [17121554] = 17121576, -- -314.365 -18.745 -56.016
        },

        HABERGOASS_PH =
        {
            [17121602] = 17121603,
        },

        MENECHME = GetFirstID('Menechme'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17121722,  -- Lacus
                17121721,  -- Thunor
                17121720, -- Beorht
                17121719, -- Pruina
                17121718,  -- Puretos
                17121717,  -- Eorthe
                17121716, -- Deorc
                17121715, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17121714, -- Skuld
                17121713  -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17121712  -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17121711  -- Yilbegan
            }
        }
    },

    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Myllue_RK'), -- San, Bas, Win, Flag +4, CA
    },
}

return zones[xi.zone.BATALLIA_DOWNS_S]
