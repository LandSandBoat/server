-----------------------------------
-- Area: Jugner_Forest
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.JUGNER_FOREST] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6416,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6426,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7079,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7160,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET        = 7712,  -- You can't fish here.
        DIG_THROW_AWAY                = 7725,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7727,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7793,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        LOGGING_IS_POSSIBLE_HERE      = 7905,  -- Logging is possible here if you have <item>.
        VOIDWALKER_OBTAIN_KI          = 7912,  -- Obtained key item: <keyitem>!
        CONQUEST                      = 8056,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM           = 8658,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8659,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8660,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8661,  -- You already possess that temporary item.
        NO_COMBINATION                = 8666,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 8697,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 8728,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10871, -- New training regime registered!
        DRAWN_UNWANTED_ATTENTION      = 11925, -- Your presence has drawn unwanted attention!
        SENSE_UNUSUAL_PRESENCE        = 11927, -- You sense an unusual presence in the area...
        DELIVER_TO_AMAURE             = 11929, -- You must deliver the <item> to Amaura in Southern San d'Oria.
        VOIDWALKER_NO_MOB             = 12089, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 12090, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 12091, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 12092, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 12094, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 12095, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 12096, -- The <keyitem> shatters into tiny fragments.
        COMMON_SENSE_SURVIVAL         = 13100, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        PANZER_PERCIVAL_PH =
        {
            [17203581] = 17203585, -- 535.504 -1.517 152.171 (southeast)
            [17203637] = 17203642, -- 239.541 -0.365 559.722 (northwest)
        },

        SUPPLESPINE_MUJWUJ_PH =
        {
            [17203437] = 17203475,
        },

        FRADUBIO_PH =
        {
            [17203447] = 17203448,
        },

        KING_ARTHRO          = 17203216,
        FRAELISSA            = 17203447,
        FRADUBIO             = 17203448,
        METEORMAULER         = 17203414,

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

        CERNUNNOS = 17203677,
    },

    npc =
    {
        OVERSEER_BASE = 17203848, -- Chaplion_RK in npc_list
        LOGGING =
        {
            17203864,
            17203865,
            17203866,
            17203867,
            17203868,
            17203869,
        },
    },
}

return zones[xi.zone.JUGNER_FOREST]
