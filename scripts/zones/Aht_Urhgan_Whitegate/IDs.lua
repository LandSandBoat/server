-----------------------------------
-- Area: Aht_Urhgan_Whitegate
-----------------------------------
zones = zones or {}

zones[xi.zone.AHT_URHGAN_WHITEGATE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 221,   -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINEDX      = 225,   -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 227,   -- Obtained: <item>.
        GIL_OBTAINED                  = 228,   -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 230,   -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 232,   -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 835,   -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 838,   -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 839,   -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 840,   -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 860,   -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS_ROV        = 884,   -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        UNABLE_TO_PROGRESS_ROV2       = 885,   -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the quest [Champion of the Dawn/A Forbidden Reunion].
        FISHING_MESSAGE_OFFSET        = 900,   -- You can't fish here.
        MOG_LOCKER_OFFSET             = 1244,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        HOMEPOINT_SET                 = 1385,  -- Home point set!
        IMAGE_SUPPORT_ACTIVE          = 1424,  -- You have to wait a bit longer before asking for synthesis image support again.
        IMAGE_SUPPORT                 = 1426,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GATE_IS_FIRMLY_CLOSED         = 1443,  -- The gate is firmly closed...
        REGIME_CANCELED               = 1485,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 1503,  -- Hunt accepted!
        USE_SCYLDS                    = 1504,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 1515,  -- You record your hunt.
        ITEM_OBTAINEDX                = 1516,  -- You obtain <item>!
        OBTAIN_SCYLDS                 = 1517,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 1521,  -- Hunt canceled.
        RUNIC_PORTAL                  = 4603,  -- You cannot use the runic portal without the Empire's authorization.
        IMPERIAL_AUTHORIZATION        = 4606,  -- Confirming Imperial authorization... You are authorized to use the runic portal.
        SUFFICIENT_IMPERIAL_STANDING  = 4611,  -- You do not possess sufficient Imperial Standing.
        CONFIRMING                    = 4612,  -- Confirming <assault>...
        RUNIC_DENIED_ASSAULT_OFFSET   = 4620,  -- You have not opened a path between the Chamber of Passage and the Azouph Isle staging point (Leujaoam Sanctum). Unable to use runic portal.
        UGRIHD_PURCHASE_DIALOGUE      = 4664,  -- Salaheem's Sentinels values your contribution to the success of the company. Please come again!
        HADAHDA_DIALOG                = 4934,  -- Hey, think you could help me out?
        MUSHAYRA_DIALOG               = 4983,  -- Sorry for all the trouble. Please ignore Hadahda the next time he asks you to do something.
        ASSAULT_COMPLETE              = 5671,  -- Congratulations. You have been awarded Assault Points for the successful completion of your mission.
        ASSAULT_FAILED                = 5672,  -- Your mission was not successful; however, the Empire recognizes your contribution and has awarded you Assault Points.
        AUTOMATON_RENAME              = 5849,  -- Your automaton has a new name.
        YOU_CAN_BECOME_PUP            = 5852,  -- You can now become a puppetmaster!
        PROMOTION_SERGEANT_MAJOR      = 6176,  -- <player> has been promoted to Sergeant Major!
        NYZUL_FAIL                    = 6193,  -- Your mission was not successful. I regret to inform you that the Imperial Army does not officially recognize your efforts within this Assault area.
        LANCE_CORPORAL                = 6683,  -- <player> has been promoted to Lance Corporal!
        BESIEGED_OFFSET               = 6834,  -- Your Imperial Standing has increased!
        PROMOTION_SERGEANT            = 7742,  -- <player> has been promoted to Sergeant!
        PAY_DIVINATION                = 8786,  -- ou pay 1000 gil for the divination.
        MEMBER_OF_SALAHEEMS_SENTINELS = 9264,  -- You are now a member of Salaheem's Sentinels.
        ACCESS_TO_A_MOG_LOCKER        = 9265,  -- ou now have access to a Mog Locker.
        GAVRIE_SHOP_DIALOG            = 9284,  -- Remember to take your medicine in small doses... Sometimes you can get a little too much of a good thing!
        MALFUD_SHOP_DIALOG            = 9285,  -- Welcome, welcome! Flavor your meals with Malfud's ingredients!
        RUBAHAH_SHOP_DIALOG           = 9286,  -- Flour! Flooour! Corn! Rice and beans! Get your rice and beans here! If you're looking for grain, you've come to the right place!
        MULNITH_SHOP_DIALOG           = 9287,  -- Drawn in by my shop's irresistible aroma, were you? How would you like some of the Near East's famous skewers to enjoy during your journeys?
        SALUHWA_SHOP_DIALOG           = 9288,  -- Looking for undentable shields? This shop's got the best of 'em! These are absolute must-haves for a mercenary's dangerous work!
        DWAGO_SHOP_DIALOG             = 9289,  -- Buy your goods here...or you'll regret it!
        KULHAMARIYO_SHOP_DIALOG       = 9290,  -- Some fish to savorrr while you enjoy the sights of Aht Urhgan?
        KHAFJHIFANM_SHOP_DIALOG       = 9291,  -- How about a souvenir for back home? There's nothing like dried dates to remind you of good times in Al Zahbi!
        HAGAKOFF_SHOP_DIALOG          = 9292,  -- Welcome! Fill all your destructive needs with my superb weaponry! No good mercenary goes without a good weapon!
        BAJAHB_SHOP_DIALOG            = 9293,  -- Good day! If you want to live long, you'll buy your armor here.
        MAZWEEN_SHOP_DIALOG           = 9294,  -- Magic scrolls! Get your magic scrolls here!
        FAYEEWAH_SHOP_DIALOG          = 9295,  -- Why not sit back a spell and enjoy the rich aroma and taste of a cup of chai?
        YAFAAF_SHOP_DIALOG            = 9296,  -- There's nothing like the mature taste and luxurious aroma of coffee... Would you like a cup?
        WAHNID_SHOP_DIALOG            = 9297,  -- All the fishing gear you'll ever need, here in one place!
        WAHRAGA_SHOP_DIALOG           = 9298,  -- Welcome to the Alchemists' Guild. We open ourselves to the hidden secrets of nature in order to create wonders. Are you looking to buy one of them?
        GATHWEEDA_SHOP_DIALOG         = 9299,  -- Only members of the Alchemists' Guild have the vision to create such fine products... Would you like to purchase something?
        ITEM_DELIVERY_DIALOG          = 9370,  -- You have something you want delivered?
        FIRST_LIEUTENANT              = 9564,  -- <player> has been promoted to First Lieutenant!
        AUTOMATON_VALOREDGE_UNLOCK    = 9611,  -- You obtain the Valoredge X-900 head and frame!
        AUTOMATON_SHARPSHOT_UNLOCK    = 9616,  -- You obtain the Sharpshot Z-500 head and frame!
        AUTOMATON_STORMWAKER_UNLOCK   = 9621,  -- You obtain the Stormwaker Y-700 head and frame!
        AUTOMATON_SOULSOOTHER_UNLOCK  = 9653,  -- You obtain the Soulsoother C-1000 head!
        AUTOMATON_SPIRITREAVER_UNLOCK = 9654,  -- You obtain the Spiritreaver M-400 head!
        AUTOMATON_ATTACHMENT_UNLOCK   = 9670,  -- You can now equip your automaton with <item>.
        SANCTION                      = 9823,  -- You have received the Empire's Sanction.
        ZASSHAL_DIALOG                = 11027, -- 'ang about. Looks like the permit you got was the last one I 'ad, so it might take me a bit o' time to scrounge up some more. 'ere, don't gimme that look. I'll be restocked before you know it.
        SECOND_LIEUTENANT             = 12053, -- <player> has been promoted to Second Lieutenant!
        PROMOTION_CHIEF_SERGEANT      = 12357, -- <player> has been promoted to Chief Sergeant!
        RETRIEVE_DIALOG_ID            = 13546, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 14337, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.AHT_URHGAN_WHITEGATE]
