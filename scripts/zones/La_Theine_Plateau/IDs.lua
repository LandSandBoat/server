-----------------------------------
-- Area: La_Theine_Plateau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.LA_THEINE_PLATEAU] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        ALREADY_OBTAINED_TELE         = 7219,  -- You already possess the gate crystal for this telepoint.
        FISHING_MESSAGE_OFFSET        = 7223,  -- You can't fish here.
        DIG_THROW_AWAY                = 7236,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7238,  -- You dig and you dig, but find nothing.
        RESCUE_DRILL                  = 7395,  -- Rescue drills in progress. Try to stay out of the way.
        FAURBELLANT_1                 = 7435,  -- Greetings. traveler. Sorry, I've little time to chat. I must focus on my prayer.
        FAURBELLANT_2                 = 7436,  -- Ah, the <item>! Thank you for making such a long journey to bring this! May the Gates of Paradise open to all.
        FAURBELLANT_3                 = 7437,  -- Please deliver that <item> to the high priest in the San d'Oria Cathedral.
        FAURBELLANT_4                 = 7438,  -- My thanks again for your services. May the Gates of Paradise open to all.
        UNLOCK_SUMMONER               = 7578,  -- You can now become a summoner.
        UNLOCK_CARBUNCLE              = 7579,  -- You can now summon Carbuncle.
        CANNOT_REMOVE_FRAG            = 7593,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7594,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7595,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7596,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7597,  -- It is an ancient Zilart monument.
        ITEMS_ITEMS_LA_LA             = 7742,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7748,  -- The Goblin slipped away when you were not looking...
        TELEPOINT_HAS_BEEN_SHATTERED  = 7758,  -- The telepoint has been shattered into a thousand pieces...
        BROKEN_EGG                    = 7829,  -- There is a broken egg on the ground here. Perhaps there is a nest in the boughs of this tree.
        CHOCOBO_TRACKS                = 7890,  -- There are chocobo tracks on the ground here.
        PLAYER_OBTAINS_ITEM           = 7909,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7910,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7911,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7912,  -- You already possess that temporary item.
        NO_COMBINATION                = 7917,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7948,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7979,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        MEMORIES_SEALED_OFF           = 8073,  -- A portion of your memories has been sealed off.
        REGIME_REGISTERED             = 10128, -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11301, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11302, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11303, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11304, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11306, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11307, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11308, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11309, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 12327, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 12329, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 12336, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TUMBLING_TRUFFLE_PH =
        {
            [17195256] = 17195259, -- 450.472 70.657 238.237
        },

        LUMBERING_LAMBERT_PH =
        {
            [17195143] = 17195317, -- -372 -16 -6
            [17195316] = 17195317, -- -117 -1 -136
            [17195317] = 17195318, -- Lumbering can't spawn if Bloodtear is up
        },

        BLOODTEAR_PH =
        {
            [17195143] = 17195318, -- -372 -16 -6
            [17195316] = 17195318, -- -117 -1 -136
            [17195317] = 17195318, -- -216 -8 -107
            [17195318] = 17195317, -- Bloodtear can't spawn if Lumbering is up
        },

        NIHNIKNOOVI = 17195475,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17195493, -- Prickly Sheep
                17195492, -- Prickly Sheep
                17195491, -- Prickly Sheep
                17195490, -- Prickly Sheep
                17195489,  -- Void Hare
                17195488,  -- Void Hare
                17195487,  -- Void Hare
                17195486,  -- Void Hare
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17195485,  -- Chesma
                17195484, -- Tammuz
            },

            [xi.keyItem.GREY_ABYSSITE] =
            {
                17195483  -- Dawon
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17195482  -- Yilbegan
            }
        }
    },

    npc =
    {
        FALLEN_EGG  = 17195583,
        RAINBOW     = 17195607,
    },
}

return zones[xi.zone.LA_THEINE_PLATEAU]
