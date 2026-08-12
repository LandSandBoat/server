-----------------------------------
-- Area: Port_Bastok
-----------------------------------
zones = zones or {}

zones[xi.zone.PORT_BASTOK] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ASSIST_CHANNEL                = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400,  -- You do not have enough gil.
        ITEM_RETURNED                 = 6407,  -- The <item> is returned to you.
        CARRIED_OVER_POINTS           = 6434,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6435,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6436,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6456,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6458,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6459,  -- You are now able to call multiple alter egos.
        HOMEPOINT_SET                 = 6530,  -- Home point set!
        CONQUEST_BASE                 = 6550,  -- Tallying conquest results...
        TENSHODO_SHOP_OPEN_DIALOG     = 6751,  -- Ah, one of our members. Welcome to the Tenshodo shop.
        MOG_LOCKER_OFFSET             = 6849,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL           = 7122,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        FISHING_MESSAGE_OFFSET        = 7125,  -- You can't fish here.
        RECEIVE_BAYLD                 = 7223,  -- You receive <number> bayld!
        POWHATAN_DIALOG_1             = 7314,  -- I'm sick and tired of entertaining guests.
        YOU_ACCEPT_THE_MISSION        = 7385,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 7390,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        RONAN_DIALOG_1                = 7500,  -- Do something! Isn't there anything you can do to make him come out of his shell?
        EVELYN_CLOSED_DIALOG          = 7619,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Gustaberg, but it's not easy getting stuff from areas that aren't under Bastokan control.
        ROSSWALD_CLOSED_DIALOG        = 7620,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Zulkheim, but it's not easy getting stuff from areas that aren't under Bastokan control.
        BELKA_CLOSED_DIALOG           = 7621,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Derfland, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VATTIAN_CLOSED_DIALOG         = 7622,  -- I'm trying to start a business selling goods from Kuzotz, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VALERIANO_SHOP_DIALOG         = 7624,  -- Welcome to the Troupe Valeriano. Valeriano, at your service! Have a laugh, then spend some cash! Treats and sweets from exotic lands!
        DAHJAL_BASTOK_CIT             = 7625,  -- You guys must've worked real hard. Bastok is a much nicer place now than when I left it. I wish I could go back to bashing monsters again, like in the old days.
        DAHJAL_NOT_BASTOK_CIT         = 7626,  -- How do you like Bastok? It's my hometown, you know! Sure, there are still some...unsightly elements, but it's still the best city in the world!
        MOKOP_BASTOK_CIT              = 7627,  -- The music store here sells really good instruments! Shh, don't tell the boss...but I'm gonna-wanna sneak off and go there later.
        MOKOP_NOT_BASTOK_CIT          = 7628,  -- There are plenty of bards around, but I'm the best harpist in Vana'diel. You don't believe me? Then stay awhile and listen.
        CHEH_WINDY_CIT                = 7629,  -- The food here's terrrible! C'mon, Windurrrstians, work harder! I miss Windurstian cuisine!
        CHEH_NOT_WINDY_CIT            = 7630,  -- Like to see my new knife trrrick? Good, but keep your distance if you value your various extremities and bodily protrusions!
        NALTA_SANDY_CIT               = 7631,  -- This place...is tiring...
        NALTA_NOT_SANDY_CIT           = 7632,  -- ... (I'm a mime.)
        SAWYER_SHOP_DIALOG            = 7669,  -- Hi, there. For here or to go?
        MELLOA_SHOP_DIALOG            = 7670,  -- Welcome to the Steaming Sheep. Would you like something to drink?
        ARRIVING_PASSENGER_DIALOG     = 7671,  -- Hello. This concourse is for arriving passengers.
        DEPARTING_PASSENGER_DIALOG    = 7672,  -- Hello. This concourse is for departing passengers.
        EVELYN_OPEN_DIALOG            = 7673,  -- Hello! Might I interest you in some specialty goods from Gustaberg?
        GALVIN_SHOP_DIALOG            = 7674,  -- Welcome to Galvin's Travel Gear! We do our best to get the best for only the best!
        NUMA_SHOP_DIALOG              = 7675,  -- Hello, hello! Won't you buy something? I'll give you a rebate!
        BELKA_OPEN_DIALOG             = 7676,  -- Welcome. I've got goods from Derfland. Interested?
        ROSSWALD_OPEN_DIALOG          = 7677,  -- Hello, hello! Everything I have is imported directly from Zulkheim!
        ILITA_SHOP_DIALOG             = 7678,  -- Hello there. How about buying <item> to stay in touch with your friends?
        SUGANDHI_SHOP_DIALOG          = 7679,  -- Traveler! I am sure my wares will prove useful on your journey. Why don't you buy some?
        DENVIHR_SHOP_DIALOG           = 7680,  -- Ah, interested in my wares, are you? You can only buy these in Bastok, my friend.
        PAUJEAN_DIALOG_1              = 7691,  -- Where can you find them? If you're the kind of adventurer I think you are, you should have a pretty good idea. Just don't do anything I wouldn't...heh heh.
        MOGHOUSE_EXIT                 = 7989,  -- You have learned your way through the back alleys of Bastok! Now you can exit to any area from your residence.
        CONQUEST                      = 8045,  -- You've earned conquest points!
        RECEIVED_CONQUEST_POINTS      = 8169,  -- You received <number> conquest points!
        VATTIAN_OPEN_DIALOG           = 8405,  -- Welcome to my humble establishment. I have a wide variety of specialty goods from Kuzotz.
        ZOBYQUHYO_OPEN_DIALOG         = 8406,  -- Hey therrre! I've got lots of wonderrrful goodies, fresh from the Elshimo Lowlands.
        ZOBYQUHYO_CLOSED_DIALOG       = 8407,  -- I'm trrrying to start a business selling goods from the Elshimo Lowlands, but it's not easy getting stuff from areas that aren't under Bastokan contrrrol.
        DHENTEVRYUKOH_OPEN_DIALOG     = 8408,  -- Welcome! Welcome! Take a wonderrr at these specialty goods from the Elshimo Uplands!
        DHENTEVRYUKOH_CLOSED_DIALOG   = 8409,  -- I'm trrrying to start a business selling goods from the Elshimo Uplands, but it's not easy transporting goods from areas that aren't under Bastokan contrrrol.
        UNLOCK_NINJA                  = 8472,  -- You can now become a ninja.
        EXTENDED_MISSION_OFFSET       = 8510,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TITAN_UNLOCKED                = 8580,  -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        BLABBIVIX_SHOP_DIALOG         = 8687,  -- <Pshooowaaaaa> I come from the underworld. These chipshhh, you knooow, are popular among us Goblinshhh. Use with heart of shhhtatue.
        NOKKHI_BAD_COUNT              = 8839,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE             = 8841,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM               = 8842,  -- I'm real sorry, but there's nothing I can do with those.
        ASURAN_FISTS_LEARNED          = 8858,  -- You have learned the weapon skill Asuran Fists!
        SUSPICIOUS_CHARACTERS         = 8887,  -- It's my job to look out for suspicious characters coming in on the airships.
        BAGNOBROK_CLOSED_DIALOG       = 9170,  -- Kbastok sis kweak! Smoblins yonly twant gstrong sfriends! Non sgoods mfrom Smovalpolos ytoday!
        BAGNOBROK_OPEN_DIALOG         = 9171,  -- Kbastok! Crepublic sis gstrong! Smoblins lsell sgoods oto gstrong sfriends!
        CLOUD_BAD_COUNT               = 9266,  -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE              = 9270,  -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                = 9271,  -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        IMPERIAL_STANDING_INCREASED   = 12712, -- Your Imperial Standing has increased!
        EARNED_ALLIED_NOTES           = 12713, -- You have earned <number> Allied Note[/s]!
        OBTAINED_GUILD_POINTS         = 12714, -- Obtained: <number> guild points.
        OBTAINED_NUM_KEYITEMS         = 13108, -- Obtained key item: <number> <keyitem>!
        NOT_ACQUAINTED                = 13110, -- I'm sorry, but I don't believe we're acquainted. Please leave me be.
        UNABLE_RACE_CHANGE            = 14216, -- You were unable to use the specified appearance for your character.
    },
    mob =
    {
    },
    npc =
    {
        DRAWBRIDGE_1 = GetFirstID('_6ke'),
        DRAWBRIDGE_2 = GetFirstID('_6ks'),
        DRAWBRIDGE_3 = GetFirstID('_6kt'),
    },
}

return zones[xi.zone.PORT_BASTOK]
