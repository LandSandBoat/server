-----------------------------------
-- Area: Xarcabard_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.XARCABARD_S] =
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
        VOIDWALKER_DESPAWN            = 8175, -- The monster fades before your eyes, a look of disappointment on its face.
        NO_RESPONSE                   = 8222, -- There is no response...
        REQUIRED_TO_DELIVER           = 8258, -- You are required to deliver word of Operation Snowstorm's commencement to the Windurstian and Bastokan forces. First, make your way to the Federation encampment.
        HELP_FEDERATION_PREPARE       = 8259, -- You must help the Federation prepare for the operation. Head to the underground passage without delay!
        FEDERATION_COMPLETE           = 8260, -- The Federation's preparations are now complete. Next, make your way to the Republic encampment.
        HELP_REPUBLIC_PREPARE         = 8261, -- You must help the Republic prepare for the operation. Head to the underground passage without delay!
        COMPLETED_TASKS               = 8262, -- You have completed your tasks with both Windurst and Bastok. Report back to the San d'Orian encampment.
        JOIN_ALLIED_FORCE             = 8263, -- Join the Allied strike force in their storming of Castle Zvahl!
        BASTOKAN_OFFICER_GONE         = 8267, -- The Bastokan officer in charge is nowhere to be seen. Perhaps you should return later.
        VOIDWALKER_NO_MOB             = 8579, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8580, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8581, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8582, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8584, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8585, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8586, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8587, -- Obtained key item: <keyitem>!
        GATHERED_DAWNDROPS_LIGHT      = 8754, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8755, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
        HOMEPOINT_SET                 = 8759, -- Home point set!
    },
    mob =
    {
        GRAOULLY_PH =
        {
            [17338384] = 17338386,
        },
        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17338607, -- Gorehound
                17338606, -- Gorehound
                17338605, -- Gorehound
                17338604, -- Gorehound
                17338603, -- Gjenganger
                17338602, -- Gjenganger
                17338601, -- Gjenganger
                17338600, -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17338599, -- Erebus
                17338598, -- Feuerunke
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17338597, -- Lord Ruthven
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17338596, -- Yilbegan
            }
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.XARCABARD_S]
