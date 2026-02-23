-----------------------------------
-- Area: Beaucedine_Glacier_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.BEAUCEDINE_GLACIER_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405, -- There is nothing out of the ordinary here.
        NOW_IS_NOT_THE_TIME           = 6407, -- Now is not the time for that!
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        NONDESCRIPT_MASS              = 7771, -- A nondescript mass squirms hypnotically beneath the rock.
        REMAINS_OF_COOKFIRE           = 7795, -- You see the charred remains of a cookfire.
        UNWANTED_ATTENTION            = 8596, -- Your presence has drawn unwanted attention!
        UNUSUAL_PRESENCE              = 8598, -- You sense an unusual presence in the area...
        NO_RESPONSE                   = 8600, -- There is no response...
        VOIDWALKER_DESPAWN            = 8623, -- The monster fades before your eyes, a look of disappointment on its face.
        GREETINGS_TRAVELER            = 8627, -- Greetings, fair traveler. My people would entreat thy assistance, and offer rich reward in return. Thou shouldst speak with my sister Callisto, who abides in Grauberg's Witchfire Glen.
        VOIDWALKER_NO_MOB             = 8674, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 8675, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 8676, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 8677, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 8679, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 8680, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 8681, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 8682, -- Obtained key item: <keyitem>!
        GATHERED_DAWNDROPS_LIGHT      = 8702, -- The gathered dawndrops unleash a brilliant light, melding together to form <keyitem>!
        RETRACED_ALL_JUNCTIONS        = 8703, -- You have retraced all junctions of eventualities. Hasten back to where Cait Sith and Lilisette await.
        COMMON_SENSE_SURVIVAL         = 8707, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        GRANDGOULE         = GetFirstID('GrandGoule'),
        ORCISH_BLOODLETTER = GetFirstID('Orcish_Bloodletter'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17334561, -- Gorehound
                17334560, -- Gorehound
                17334559, -- Gorehound
                17334558, -- Gorehound
                17334557, -- Gjenganger
                17334556, -- Gjenganger
                17334555, -- Gjenganger
                17334554, -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17334555, -- Erebus
                17334556, -- Feuerunke
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17334557  -- Lord Ruthven
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17334558, -- Yilbegan
            },
        }
    },

    npc =
    {
    },
}

return zones[xi.zone.BEAUCEDINE_GLACIER_S]
