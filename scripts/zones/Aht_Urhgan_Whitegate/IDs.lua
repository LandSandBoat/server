-----------------------------------
-- Area: Aht_Urhgan_Whitegate
-----------------------------------
zones = zones or {}

zones[xi.zone.AHT_URHGAN_WHITEGATE] =
{
    text =
    {
        ASSIST_CHANNEL                = 217,   -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 222,   -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINEDX      = 226,   -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 228,   -- Obtained: <item>.
        GIL_OBTAINED                  = 229,   -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 231,   -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 233,   -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 836,   -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 839,   -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 840,   -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 841,   -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 861,   -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 863,   -- You learned Trust: <name>!
        UNABLE_TO_PROGRESS_ROV        = 885,   -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        UNABLE_TO_PROGRESS_ROV2       = 886,   -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the quest [Champion of the Dawn/A Forbidden Reunion].
        FISHING_MESSAGE_OFFSET        = 901,   -- You can't fish here.
        MOG_LOCKER_OFFSET             = 1245,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        HOMEPOINT_SET                 = 1386,  -- Home point set!
        IMAGE_SUPPORT_ACTIVE          = 1425,  -- You have to wait a bit longer before asking for synthesis image support again.
        IMAGE_SUPPORT                 = 1427,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GATE_IS_FIRMLY_CLOSED         = 1444,  -- The gate is firmly closed...
        REGIME_CANCELED               = 1486,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 1504,  -- Hunt accepted!
        USE_SCYLDS                    = 1505,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 1516,  -- You record your hunt.
        ITEM_OBTAINEDX                = 1517,  -- You obtain <item>!
        OBTAIN_SCYLDS                 = 1518,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 1522,  -- Hunt canceled.
        RUNIC_PORTAL                  = 4604,  -- You cannot use the runic portal without the Empire's authorization.
        IMPERIAL_AUTHORIZATION        = 4607,  -- Confirming Imperial authorization... You are authorized to use the runic portal.
        SUFFICIENT_IMPERIAL_STANDING  = 4612,  -- You do not possess sufficient Imperial Standing.
        CONFIRMING                    = 4613,  -- Confirming <assault>...
        RUNIC_DENIED_ASSAULT_OFFSET   = 4621,  -- You have not opened a path between the Chamber of Passage and the Azouph Isle staging point (Leujaoam Sanctum). Unable to use runic portal.
        UGRIHD_PURCHASE_DIALOGUE      = 4665,  -- Salaheem's Sentinels values your contribution to the success of the company. Please come again!
        HADAHDA_DIALOG                = 4935,  -- Hey, think you could help me out?
        MUSHAYRA_DIALOG               = 4984,  -- Sorry for all the trouble. Please ignore Hadahda the next time he asks you to do something.
        ASSAULT_COMPLETE              = 5672,  -- Congratulations. You have been awarded Assault Points for the successful completion of your mission.
        ASSAULT_FAILED                = 5673,  -- Your mission was not successful; however, the Empire recognizes your contribution and has awarded you Assault Points.
        AUTOMATON_RENAME              = 5850,  -- Your automaton has a new name.
        YOU_CAN_BECOME_PUP            = 5853,  -- You can now become a puppetmaster!
        YOU_LOST_YOUR_ANIMATOR        = 5871,  -- What? You lost your <item>? Well... I suppose I can provide you with a spare if you pay me 10000 gil.
        YOU_BETTER_NOT_LOSE_IT_AGAIN  = 5872,  -- You better not lose it again.
        PROMOTION_SERGEANT_MAJOR      = 6177,  -- <player> has been promoted to Sergeant Major!
        NYZUL_FAIL                    = 6194,  -- Your mission was not successful. I regret to inform you that the Imperial Army does not officially recognize your efforts within this Assault area.
        LANCE_CORPORAL                = 6684,  -- <player> has been promoted to Lance Corporal!
        BESIEGED_OFFSET               = 6835,  -- Your Imperial Standing has increased!
        PROMOTION_SERGEANT            = 7743,  -- <player> has been promoted to Sergeant!
        PAY_DIVINATION                = 8787,  -- ou pay 1000 gil for the divination.
        MEMBER_OF_SALAHEEMS_SENTINELS = 9265,  -- You are now a member of Salaheem's Sentinels.
        ACCESS_TO_A_MOG_LOCKER        = 9266,  -- ou now have access to a Mog Locker.
        GAVRIE_SHOP_DIALOG            = 9285,  -- Remember to take your medicine in small doses... Sometimes you can get a little too much of a good thing!
        MALFUD_SHOP_DIALOG            = 9286,  -- Welcome, welcome! Flavor your meals with Malfud's ingredients!
        RUBAHAH_SHOP_DIALOG           = 9287,  -- Flour! Flooour! Corn! Rice and beans! Get your rice and beans here! If you're looking for grain, you've come to the right place!
        MULNITH_SHOP_DIALOG           = 9288,  -- Drawn in by my shop's irresistible aroma, were you? How would you like some of the Near East's famous skewers to enjoy during your journeys?
        SALUHWA_SHOP_DIALOG           = 9289,  -- Looking for undentable shields? This shop's got the best of 'em! These are absolute must-haves for a mercenary's dangerous work!
        DWAGO_SHOP_DIALOG             = 9290,  -- Buy your goods here...or you'll regret it!
        KULHAMARIYO_SHOP_DIALOG       = 9291,  -- Some fish to savorrr while you enjoy the sights of Aht Urhgan?
        KHAFJHIFANM_SHOP_DIALOG       = 9292,  -- How about a souvenir for back home? There's nothing like dried dates to remind you of good times in Al Zahbi!
        HAGAKOFF_SHOP_DIALOG          = 9293,  -- Welcome! Fill all your destructive needs with my superb weaponry! No good mercenary goes without a good weapon!
        BAJAHB_SHOP_DIALOG            = 9294,  -- Good day! If you want to live long, you'll buy your armor here.
        MAZWEEN_SHOP_DIALOG           = 9295,  -- Magic scrolls! Get your magic scrolls here!
        FAYEEWAH_SHOP_DIALOG          = 9296,  -- Why not sit back a spell and enjoy the rich aroma and taste of a cup of chai?
        YAFAAF_SHOP_DIALOG            = 9297,  -- There's nothing like the mature taste and luxurious aroma of coffee... Would you like a cup?
        WAHNID_SHOP_DIALOG            = 9298,  -- All the fishing gear you'll ever need, here in one place!
        WAHRAGA_SHOP_DIALOG           = 9299,  -- Welcome to the Alchemists' Guild. We open ourselves to the hidden secrets of nature in order to create wonders. Are you looking to buy one of them?
        GATHWEEDA_SHOP_DIALOG         = 9300,  -- Only members of the Alchemists' Guild have the vision to create such fine products... Would you like to purchase something?
        ITEM_DELIVERY_DIALOG          = 9371,  -- You have something you want delivered?
        FIRST_LIEUTENANT              = 9565,  -- <player> has been promoted to First Lieutenant!
        AUTOMATON_VALOREDGE_UNLOCK    = 9612,  -- You obtain the Valoredge X-900 head and frame!
        AUTOMATON_SHARPSHOT_UNLOCK    = 9617,  -- You obtain the Sharpshot Z-500 head and frame!
        AUTOMATON_STORMWAKER_UNLOCK   = 9622,  -- You obtain the Stormwaker Y-700 head and frame!
        AUTOMATON_SOULSOOTHER_UNLOCK  = 9654,  -- You obtain the Soulsoother C-1000 head!
        AUTOMATON_SPIRITREAVER_UNLOCK = 9655,  -- You obtain the Spiritreaver M-400 head!
        AUTOMATON_ATTACHMENT_UNLOCK   = 9671,  -- You can now equip your automaton with <item>.
        SANCTION                      = 9824,  -- You have received the Empire's Sanction.
        ZASSHAL_DIALOG                = 11038, -- 'ang about. Looks like the permit you got was the last one I 'ad, so it might take me a bit o' time to scrounge up some more. 'ere, don't gimme that look. I'll be restocked before you know it.
        SECOND_LIEUTENANT             = 12064, -- <player> has been promoted to Second Lieutenant!
        PROMOTION_CHIEF_SERGEANT      = 12368, -- <player> has been promoted to Chief Sergeant!
        ALEXANDER_UNLOCKED            = 12397, -- You have gained the ability to summon Alexander!
        HOPES_REST                    = 13148, -- Our hopes rest upon your able shoulders, noble adventurer.
        ALREADY_IN_POSSESSION         = 13154, -- Oh, it seems you are already in possession of one. In that case, you will not be requiring another.
        APPRECIATE_MORE               = 13155, -- I appreciate you bringing me more <item>. However, I'm afraid I can only accept up to <number> for each <number> [day/days]. After all, we need to travel light.
        SINGLE_TALLY                  = 13185, -- A single tally seal is proof positive of your prowess as an adventurer. You shan't be requiring another.
        MASTER_FORBID                 = 13186, -- Ah, please forgive me. My master, Sanraku, whom I respect and revere, has forbidden me from engaging in conversation, as it will disrupt my attunement with nature.
        RETRIEVE_DIALOG_ID            = 13557, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 14349, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        SANRAKU = GetFirstID('Sanraku'),
    },
}

return zones[xi.zone.AHT_URHGAN_WHITEGATE]
