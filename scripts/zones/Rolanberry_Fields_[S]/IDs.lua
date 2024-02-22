-----------------------------------
-- Area: Rolanberry_Fields_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.ROLANBERRY_FIELDS_S] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7047, -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        FISHING_MESSAGE_OFFSET        = 7081, -- You can't fish here.
        CAMPAIGN_RESULTS_TALLIED      = 7618, -- Campaign results tallied.
        VOIDWALKER_DESPAWN            = 7993, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8048, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8049, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8050, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8051, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8053, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8054, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8055, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8056, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 9263, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DELICIEUSE_DELPHINE_PH =
        {
            [17150279] = 17150280, -- -484.535 -23.756 -467.462
        },

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17150346,  -- Lacus
                17150345,  -- Thunor
                17150344, -- Beorht
                17150343, -- Pruina
                17150342,  -- Puretos
                17150341,  -- Eorthe
                17150340, -- Deorc
                17150339, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17150338, -- Skuld
                17150337, -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17150336, -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17150335,  -- Yilbegan
            }
        }
    },

    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Hedioste_RK'), -- San, Bas, Win, Flag +4, CA
    },
}

return zones[xi.zone.ROLANBERRY_FIELDS_S]
