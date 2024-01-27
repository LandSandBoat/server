-----------------------------------
-- Area: Sauromugue_Champaign_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7047,  -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        DOOR_FIRMLY_SEALED            = 7727,  -- The door is firmly sealed.
        SURRENDER_CEREMONY_HASTE      = 8475,  -- The surrender ceremony is about to commence underground. Make haste before all is lost!
        VOIDWALKER_DESPAWN            = 8487,  -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB             = 8674,  -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8675,  -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8676,  -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8677,  -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8679,  -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8680,  -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8681,  -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8682,  -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 10069, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BALAM_QUITZ_PH =
        {
            [17178778] = 17178803, -- 481.509 24.184 98.264
        },

        COQUECIGRUE = 17178689,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17178932,  -- Lacus
                17178931,  -- Thunor
                17178930, -- Beorht
                17178929, -- Pruina
                17178928,  -- Puretos
                17178927,  -- Eorthe
                17178926, -- Deorc
                17178925, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17178924, -- Skuld
                17178923, -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17178922, -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17178921, -- Yilbegan
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S]
