-----------------------------------
-- Area: La_Theine_Plateau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LA_THEINE_PLATEAU] =
{
    text =
    {
        NOTHING_HAPPENS              = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED      = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6388,  -- Obtained: <item>.
        GIL_OBTAINED                 = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6391,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET        = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS          = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                = 7049,  -- Tallying conquest results...
        ALREADY_OBTAINED_TELE        = 7208,  -- You already possess the gate crystal for this telepoint.
        FISHING_MESSAGE_OFFSET       = 7212,  -- You can't fish here.
        DIG_THROW_AWAY               = 7225,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                 = 7227,  -- You dig and you dig, but find nothing.
        RESCUE_DRILL                 = 7384,  -- Rescue drills in progress. Try to stay out of the way.
        FAURBELLANT_1                = 7424,  -- Greetings. traveler. Sorry, I've little time to chat. I must focus on my prayer.
        FAURBELLANT_2                = 7425,  -- Ah, the <item>! Thank you for making such a long journey to bring this! May the Gates of Paradise open to all.
        FAURBELLANT_3                = 7426,  -- Please deliver that <item> to the high priest in the San d'Oria Cathedral.
        FAURBELLANT_4                = 7427,  -- My thanks again for your services. May the Gates of Paradise open to all.
        UNLOCK_SUMMONER              = 7586,  -- You can now become a summoner.
        UNLOCK_CARBUNCLE             = 7587,  -- You can now summon Carbuncle.
        CANNOT_REMOVE_FRAG           = 7601,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG        = 7602,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS       = 7603,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS              = 7604,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT              = 7605,  -- It is an ancient Zilart monument.
        ITEMS_ITEMS_LA_LA            = 7750,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY          = 7756,  -- The Goblin slipped away when you were not looking...
        TELEPOINT_HAS_BEEN_SHATTERED = 7766,  -- The telepoint has been shattered into a thousand pieces...
        BROKEN_EGG                   = 7837,  -- There is a broken egg on the ground here. Perhaps there is a nest in the boughs of this tree.
        CHOCOBO_TRACKS               = 7898,  -- There are chocobo tracks on the ground here.
        PLAYER_OBTAINS_ITEM          = 7917,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM        = 7918,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM     = 7919,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP         = 7920,  -- You already possess that temporary item.
        NO_COMBINATION               = 7925,  -- You were unable to enter a combination.
        REGIME_REGISTERED            = 10136, -- New training regime registered!
        COMMON_SENSE_SURVIVAL        = 12344, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        NIHNIKNOOVI    = 17195475,
    },
    npc =
    {
        FALLEN_EGG  = 17195582,
        CASKET_BASE = 17195583,
        RAINBOW     = 17195606,
    },
}

return zones[tpz.zone.LA_THEINE_PLATEAU]
