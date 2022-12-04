-----------------------------------
-- Area: Port_Bastok
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.PORT_BASTOK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395,  -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6429,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6430,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6431,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6451,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6453,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6454,  -- You are now able to call multiple alter egos.
        HOMEPOINT_SET                 = 6517,  -- Home point set!
        CONQUEST_BASE                 = 6537,  -- Tallying conquest results...
        TENSHODO_SHOP_OPEN_DIALOG     = 6738,  -- Ah, one of our members. Welcome to the Tenshodo shop.
        MOG_LOCKER_OFFSET             = 6836,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL           = 7095,   -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        FISHING_MESSAGE_OFFSET        = 7098,  -- You can't fish here.
        POWHATAN_DIALOG_1             = 7286,  -- I'm sick and tired of entertaining guests.
        YOU_ACCEPT_THE_MISSION        = 7357,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 7362,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        RONAN_DIALOG_1                = 7472,  -- Do something! Isn't there anything you can do to make him come out of his shell?
        EVELYN_CLOSED_DIALOG          = 7591,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Gustaberg, but it's not easy getting stuff from areas that aren't under Bastokan control.
        ROSSWALD_CLOSED_DIALOG        = 7592,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Zulkheim, but it's not easy getting stuff from areas that aren't under Bastokan control.
        BELKA_CLOSED_DIALOG           = 7593,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Derfland, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VATTIAN_CLOSED_DIALOG         = 7594,  -- I'm trying to start a business selling goods from Kuzotz, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VALERIANO_SHOP_DIALOG         = 7596,  -- Welcome to the Troupe Valeriano. Valeriano, at your service! Have a laugh, then spend some cash! Treats and sweets from exotic lands!
        SAWYER_SHOP_DIALOG            = 7641,  -- Hi, there. For here or to go?
        MELLOA_SHOP_DIALOG            = 7642,  -- Welcome to the Steaming Sheep. Would you like something to drink?
        ARRIVING_PASSENGER_DIALOG     = 7643,  -- Hello. This concourse is for arriving passengers.
        DEPARTING_PASSENGER_DIALOG    = 7644,  -- Hello. This concourse is for departing passengers.
        EVELYN_OPEN_DIALOG            = 7645,  -- Hello! Might I interest you in some specialty goods from Gustaberg?
        GALVIN_SHOP_DIALOG            = 7646,  -- Welcome to Galvin's Travel Gear! We do our best to get the best for only the best!
        NUMA_SHOP_DIALOG              = 7647,  -- Hello, hello! Won't you buy something? I'll give you a rebate!
        BELKA_OPEN_DIALOG             = 7648,  -- Welcome. I've got goods from Derfland. Interested?
        ROSSWALD_OPEN_DIALOG          = 7649,  -- Hello, hello! Everything I have is imported directly from Zulkheim!
        ILITA_SHOP_DIALOG             = 7650,  -- Hello there. How about buying <item> to stay in touch with your friends?
        SUGANDHI_SHOP_DIALOG          = 7651,  -- Traveler! I am sure my wares will prove useful on your journey. Why don't you buy some?
        DENVIHR_SHOP_DIALOG           = 7652,  -- Ah, interested in my wares, are you? You can only buy these in Bastok, my friend.
        PAUJEAN_DIALOG_1              = 7663,  -- Where can you find them? If you're the kind of adventurer I think you are, you should have a pretty good idea. Just don't do anything I wouldn't...heh heh.
        MOGHOUSE_EXIT                 = 7961,  -- You have learned your way through the back alleys of Bastok! Now you can exit to any area from your residence.
        CONQUEST                      = 8017,  -- You've earned conquest points!
        VATTIAN_OPEN_DIALOG           = 8377,  -- Welcome to my humble establishment. I have a wide variety of specialty goods from Kuzotz.
        ZOBYQUHYO_OPEN_DIALOG         = 8378,  -- Hey therrre! I've got lots of wonderrrful goodies, fresh from the Elshimo Lowlands.
        ZOBYQUHYO_CLOSED_DIALOG       = 8379,  -- I'm trrrying to start a business selling goods from the Elshimo Lowlands, but it's not easy getting stuff from areas that aren't under Bastokan contrrrol.
        DHENTEVRYUKOH_OPEN_DIALOG     = 8380,  -- Welcome! Welcome! Take a wonderrr at these specialty goods from the Elshimo Uplands!
        DHENTEVRYUKOH_CLOSED_DIALOG   = 8381,  -- I'm trrrying to start a business selling goods from the Elshimo Uplands, but it's not easy transporting goods from areas that aren't under Bastokan contrrrol.
        UNLOCK_NINJA                  = 8444,  -- You can now become a ninja.
        EXTENDED_MISSION_OFFSET       = 8482,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TITAN_UNLOCKED                = 8549,  -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        BLABBIVIX_SHOP_DIALOG         = 8653,  -- <Pshooowaaaaa> I come from the underworld. These chipshhh, you knooow, are popular among us Goblinshhh. Use with heart of shhhtatue.
        NOKKHI_BAD_COUNT              = 8805,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE             = 8807,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM               = 8808,  -- I'm real sorry, but there's nothing I can do with those.
        ASURAN_FISTS_LEARNED          = 8824,  -- You have learned the weapon skill Asuran Fists!
        BAGNOBROK_CLOSED_DIALOG       = 9136,  -- Kbastok sis kweak! Smoblins yonly twant gstrong sfriends! Non sgoods mfrom Smovalpolos ytoday!
        BAGNOBROK_OPEN_DIALOG         = 9137,  -- Kbastok! Crepublic sis gstrong! Smoblins lsell sgoods oto gstrong sfriends!
        CLOUD_BAD_COUNT               = 9232,  -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE              = 9236,  -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                = 9237,  -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        OBTAINED_NUM_KEYITEMS         = 13064, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                = 13066, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
        STARLIGHT_DECORATIONS =
        {
            [17744128] = 17744128,  -- Starlight Celebration Fountain
            [17744129] = 17744129,  -- Starlight Celebration Fountain
            [17744130] = 17744130,  -- Starlight Celebration Planter
            [17744131] = 17744131,  -- Starlight Celebration Planter
            [17744132] = 17744132,  -- Starlight Celebration Planter
            [17744133] = 17744133,  -- Starlight Celebration Planter
            [17744134] = 17744134,  -- Starlight Celebration Planter
            [17744135] = 17744135,  -- Starlight Celebration Planter
            [17744136] = 17744136,  -- Starlight Celebration Planter
            [17744137] = 17744137,  -- Starlight Celebration Planter
            [17744138] = 17744138,  -- Starlight Celebration Planter
            [17744139] = 17744139,  -- Starlight Celebration Planter
            [17744140] = 17744140,  -- Starlight Celebration Planter
            [17744141] = 17744141,  -- Starlight Celebration Planter
            [17744142] = 17744142,  -- Starlight Celebration Planter
            [17744143] = 17744143,  -- Starlight Celebration Planter
            [17744144] = 17744144,  -- Starlight Celebration Planter
            [17744145] = 17744145,  -- Starlight Celebration Planter
            [17744146] = 17744146,  -- Starlight Celebration Planter
            [17744147] = 17744147,  -- Starlight Celebration Planter
            [17744148] = 17744148,  -- Starlight Celebration Planter
            [17744149] = 17744149,  -- Starlight Celebration Planter
            [17744150] = 17744150,  -- Starlight Celebration Planter
            [17744151] = 17744151,  -- Starlight Celebration Planter
            [17744152] = 17744152,  -- Starlight Celebration Planter
            [17744153] = 17744153,  -- Starlight Celebration Planter
            [17744154] = 17744154,  -- Starlight Celebration Planter
            [17744155] = 17744155,  -- Starlight Celebration Planter
            -- [17744156] = 17744156,  -- Klaas
        },

    },
}

return zones[xi.zone.PORT_BASTOK]
