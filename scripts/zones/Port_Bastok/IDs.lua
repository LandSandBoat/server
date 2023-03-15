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
        MAP_MARKER_TUTORIAL           = 7109,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        FISHING_MESSAGE_OFFSET        = 7112,  -- You can't fish here.
        POWHATAN_DIALOG_1             = 7300,  -- I'm sick and tired of entertaining guests.
        YOU_ACCEPT_THE_MISSION        = 7371,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 7376,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        RONAN_DIALOG_1                = 7486,  -- Do something! Isn't there anything you can do to make him come out of his shell?
        EVELYN_CLOSED_DIALOG          = 7605,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Gustaberg, but it's not easy getting stuff from areas that aren't under Bastokan control.
        ROSSWALD_CLOSED_DIALOG        = 7606,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Zulkheim, but it's not easy getting stuff from areas that aren't under Bastokan control.
        BELKA_CLOSED_DIALOG           = 7607,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Derfland, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VATTIAN_CLOSED_DIALOG         = 7608,  -- I'm trying to start a business selling goods from Kuzotz, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VALERIANO_SHOP_DIALOG         = 7610,  -- Welcome to the Troupe Valeriano. Valeriano, at your service! Have a laugh, then spend some cash! Treats and sweets from exotic lands!
        SAWYER_SHOP_DIALOG            = 7655,  -- Hi, there. For here or to go?
        MELLOA_SHOP_DIALOG            = 7656,  -- Welcome to the Steaming Sheep. Would you like something to drink?
        ARRIVING_PASSENGER_DIALOG     = 7657,  -- Hello. This concourse is for arriving passengers.
        DEPARTING_PASSENGER_DIALOG    = 7658,  -- Hello. This concourse is for departing passengers.
        EVELYN_OPEN_DIALOG            = 7659,  -- Hello! Might I interest you in some specialty goods from Gustaberg?
        GALVIN_SHOP_DIALOG            = 7660,  -- Welcome to Galvin's Travel Gear! We do our best to get the best for only the best!
        NUMA_SHOP_DIALOG              = 7661,  -- Hello, hello! Won't you buy something? I'll give you a rebate!
        BELKA_OPEN_DIALOG             = 7662,  -- Welcome. I've got goods from Derfland. Interested?
        ROSSWALD_OPEN_DIALOG          = 7663,  -- Hello, hello! Everything I have is imported directly from Zulkheim!
        ILITA_SHOP_DIALOG             = 7664,  -- Hello there. How about buying <item> to stay in touch with your friends?
        SUGANDHI_SHOP_DIALOG          = 7665,  -- Traveler! I am sure my wares will prove useful on your journey. Why don't you buy some?
        DENVIHR_SHOP_DIALOG           = 7666,  -- Ah, interested in my wares, are you? You can only buy these in Bastok, my friend.
        PAUJEAN_DIALOG_1              = 7677,  -- Where can you find them? If you're the kind of adventurer I think you are, you should have a pretty good idea. Just don't do anything I wouldn't...heh heh.
        MOGHOUSE_EXIT                 = 7975,  -- You have learned your way through the back alleys of Bastok! Now you can exit to any area from your residence.
        CONQUEST                      = 8031,  -- You've earned conquest points!
        VATTIAN_OPEN_DIALOG           = 8391,  -- Welcome to my humble establishment. I have a wide variety of specialty goods from Kuzotz.
        ZOBYQUHYO_OPEN_DIALOG         = 8392,  -- Hey therrre! I've got lots of wonderrrful goodies, fresh from the Elshimo Lowlands.
        ZOBYQUHYO_CLOSED_DIALOG       = 8393,  -- I'm trrrying to start a business selling goods from the Elshimo Lowlands, but it's not easy getting stuff from areas that aren't under Bastokan contrrrol.
        DHENTEVRYUKOH_OPEN_DIALOG     = 8394,  -- Welcome! Welcome! Take a wonderrr at these specialty goods from the Elshimo Uplands!
        DHENTEVRYUKOH_CLOSED_DIALOG   = 8395,  -- I'm trrrying to start a business selling goods from the Elshimo Uplands, but it's not easy transporting goods from areas that aren't under Bastokan contrrrol.
        UNLOCK_NINJA                  = 8458,  -- You can now become a ninja.
        EXTENDED_MISSION_OFFSET       = 8496,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TITAN_UNLOCKED                = 8563,  -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        BLABBIVIX_SHOP_DIALOG         = 8667,  -- <Pshooowaaaaa> I come from the underworld. These chipshhh, you knooow, are popular among us Goblinshhh. Use with heart of shhhtatue.
        NOKKHI_BAD_COUNT              = 8819,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE             = 8821,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM               = 8822,  -- I'm real sorry, but there's nothing I can do with those.
        ASURAN_FISTS_LEARNED          = 8838,  -- You have learned the weapon skill Asuran Fists!
        BAGNOBROK_CLOSED_DIALOG       = 9150,  -- Kbastok sis kweak! Smoblins yonly twant gstrong sfriends! Non sgoods mfrom Smovalpolos ytoday!
        BAGNOBROK_OPEN_DIALOG         = 9151,  -- Kbastok! Crepublic sis gstrong! Smoblins lsell sgoods oto gstrong sfriends!
        CLOUD_BAD_COUNT               = 9246,  -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE              = 9250,  -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                = 9251,  -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        OBTAINED_NUM_KEYITEMS         = 13078, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                = 13080, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.PORT_BASTOK]
