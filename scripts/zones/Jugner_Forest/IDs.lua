-----------------------------------
-- Area: Jugner_Forest
-----------------------------------
zones = zones or {}

zones[xi.zone.JUGNER_FOREST] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6407,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6413,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6414,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6416,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6417,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6427,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6442,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7024,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7025,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7026,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7046,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7091,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7172,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET        = 7724,  -- You can't fish here.
        DIG_THROW_AWAY                = 7737,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7739,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7805,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7814,  -- It appears your chocobo found this item with ease.
        SIGNPOST_NEW                  = 7897,  -- The signpost looks as good as new!
        ALEXIUS_ORDERS                = 7908,  -- Take that <keyitem> back and hand it to the master at the weapons shop. Got it?
        LOGGING_IS_POSSIBLE_HERE      = 7918,  -- Logging is possible here if you have <item>.
        VOIDWALKER_OBTAIN_KI          = 7925,  -- Obtained key item: <keyitem>!
        DUG_UP                        = 8029,  -- Something was dug up here...
        UNABLE_TO_INVESTIGATE         = 8030,  -- For some reason, you are unable to investigate this spot. There is a preternatural force at work here...
        SENSE_OF_FOREBODING           = 8031,  -- A sense of foreboding fills the air...
        CONQUEST                      = 8069,  -- You've earned conquest points!
        GARRISON_BASE                 = 8437,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        TIME_ELAPSED                  = 8496,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 8660,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8661,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8662,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8663,  -- You already possess that temporary item.
        NO_COMBINATION                = 8668,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 8699,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 8730,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10873, -- New training regime registered!
        DRAWN_UNWANTED_ATTENTION      = 11927, -- Your presence has drawn unwanted attention!
        SENSE_UNUSUAL_PRESENCE        = 11929, -- You sense an unusual presence in the area...
        DELIVER_TO_AMAURE             = 11931, -- You must deliver the <item> to Amaura in Southern San d'Oria.
        VOIDWALKER_NO_MOB             = 12091, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 12092, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 12093, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 12094, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 12096, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 12097, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 12098, -- The <keyitem> shatters into tiny fragments.
        COMMON_SENSE_SURVIVAL         = 13102, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        CERNUNNOS          = GetFirstID('Cernunnos'),
        FRAELISSA          = GetFirstID('Fraelissa'),
        FRADUBIO           = GetFirstID('Fradubio'),
        GIOLLEMITTE        = GetFirstID('Giollemitte_B_Feroun'),
        KING_ARTHRO        = GetFirstID('King_Arthro'),
        METEORMAULER       = GetFirstID('Meteormauler_Zhagtegg'),
        PANZER_PERCIVAL    = GetTableOfIDs('Panzer_Percival'), -- 2 NMs
        SUPPLESPINE_MUJWUJ = GetFirstID('Supplespine_Mujwuj'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17203695, -- Sunderclaw
                17203694, -- Sunderclaw
                17203693, -- Sunderclaw
                17203692, -- Sunderclaw
                17203691, -- Quagmire Pugil
                17203690, -- Quagmire Pugil
                17203689, -- Quagmire Pugil
                17203688, -- Quagmire Pugil
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17203687, -- Capricornus
                17203686, -- Yacumama
            },

            [xi.keyItem.BLUE_ABYSSITE] =
            {
                17203685, -- Krabkatoa
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17203684, -- Yilbegan
            }
        },

    },

    npc =
    {
        OVERSEER_BASE = GetFirstID('Chaplion_RK'),
        LOGGING       = GetTableOfIDs('Logging_Point'),
        SIGNPOST      = GetTableOfIDs('Signpost'),
        TIMELYVISITQM = GetFirstID('qm1'),
    },
}

return zones[xi.zone.JUGNER_FOREST]
