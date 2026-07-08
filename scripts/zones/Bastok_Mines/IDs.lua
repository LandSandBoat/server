-----------------------------------
-- Area: Bastok_Mines
-----------------------------------
zones = zones or {}

zones[xi.zone.BASTOK_MINES] =
{
    text =
    {
        ASSIST_CHANNEL                 = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED        = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6397,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6398,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6399,  -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6430,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6433,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6434,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6435,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6455,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                  = 6502,  -- Home point set!
        YOU_ACCEPT_THE_MISSION         = 6531,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET        = 6536,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                  = 6604,  -- Tallying conquest results...
        MARIADOK_DIALOG                = 6763,  -- Your fate rides on the changing winds of Vana'diel. I can give you insight on the local weather.
        MOG_LOCKER_OFFSET              = 6876,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL            = 7088,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        IMAGE_SUPPORT                  = 7095,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        HEMEWMEW_DIALOG                = 7102,  -- Hello, [sir/ma'am]. I have been appointed by the Guildworkers' Union to manage the trading of manufactured crafts and the exchange of guild points.
        GUILD_TERMINATE_CONTRACT       = 7109,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 7117,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 7124,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 7129,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 7130,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 7146,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        REGIME_CANCELED                = 7311,  -- Current training regime canceled.
        HUNT_ACCEPTED                  = 7329,  -- Hunt accepted!
        USE_SCYLDS                     = 7330,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 7341,  -- You record your hunt.
        OBTAIN_SCYLDS                  = 7343,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 7347,  -- Hunt canceled.
        ITEM_DELIVERY_DIALOG           = 10477, -- Need something sent to a friend's house? Sending items to your own house? You've come to the right place!
        DETZO_RIVALS_DIALOG            = 10628, -- Can I borrow it for just a few seconds? I'll give it back, promise! I'll even give you a reward!
        FAUSTIN_CLOSED_DIALOG          = 10821, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Ronfaure, but it's not easy getting stuff from areas that aren't under Bastokan control.
        RODELLIEUX_CLOSED_DIALOG       = 10822, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Fauregandi, but it's not easy getting stuff from areas that aren't under Bastokan control.
        MILLE_CLOSED_DIALOG            = 10823, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Norvallen, but it's not easy getting stuff from areas that aren't under Bastokan control.
        TIBELDA_CLOSED_DIALOG          = 10824, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Valdeaunia, but it's not easy getting stuff from areas that aren't under Bastokan control.
        GALDEO_CLOSED_DIALOG           = 10825, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Li'Telor, but it's not easy getting stuff from areas that aren't under Bastokan control.
        TAMI_MY_HUSBAND                = 10827, -- My husband's name is Zelman. You'll find him in the Zeruhn Mines. He's a miner. All right, then, off you go!
        FISHING_MESSAGE_OFFSET         = 10842, -- You can't fish here.
        DEEGIS_SHOP_DIALOG             = 10943, -- The only things an adventurer needs are courage and a good suit of armor! Welcome to Deegis's Armour!
        ZEMEDARS_SHOP_DIALOG           = 10944, -- Everything in our store is top-grade and Galka-made! What're you lookin' for?
        BOYTZ_SHOP_DIALOG              = 10945, -- Welcome to Boytz's Knickknacks.
        GELZERIO_SHOP_DIALOG           = 10946, -- ...Yes?
        GRISELDA_SHOP_DIALOG           = 10947, -- Good of you to drop by the Bat's Lair Inn! Why don't you try some of our specialty plates?
        NEIGEPANCE_SHOP_DIALOG         = 10948, -- Hello there. A well-fed chocobo is a happy chocobo!
        FAUSTIN_OPEN_DIALOG            = 10949, -- Hello there! Might I interest you specialty goods from Ronfaure?
        MILLE_OPEN_DIALOG              = 10950, -- Hello there! Might I interest you specialty goods from Norvallen?
        RODELLIEUX_OPEN_DIALOG         = 10951, -- Hello there! Might I interest you specialty goods from Fauregandi?
        TIBELDA_OPEN_DIALOG            = 10952, -- Goods of all varieties, imported directly from the northern land of Valdeaunia!
        MAYMUNAH_SHOP_DIALOG           = 10953, -- Welcome to the Alchemists' Guild! Looking for something specific?
        ODOBA_SHOP_DIALOG              = 10954, -- Welcome to the Alchemists' Guild. How may I help you?
        CONQUEST                       = 11154, -- You've earned conquest points!
        GALDEO_OPEN_DIALOG             = 11514, -- Come! Take a look at all the wonderful goods from Li'Telor.
        AULAVIA_OPEN_DIALOG            = 11515, -- May I interest you in some specialty goods from Vollbow?
        AULAVIA_CLOSED_DIALOG          = 11516, -- I'm trying to start a business selling goods from Vollbow, but it's not easy getting stuff from areas that aren't under Bastokan control.
        EXTENDED_MISSION_OFFSET        = 11657, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        PROUDBEARD_SHOP_DIALOG         = 11685, -- Would you be interested in a nice suit of adventurer-issue armor? Be careful when you buy, though. We offer no refunds.
        TRICK_OR_TREAT                 = 11729, -- Trick or treat...
        THANK_YOU_TREAT                = 11730, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 11731, -- Here, take this...
        IF_YOU_WEAR_THIS               = 11732, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 11733, -- Thank you...
        GROUND_STRIKE_LEARNED          = 11755, -- You have learned the weapon skill Ground Strike!
        YOU_CANNOT_ENTER_DYNAMIS       = 11768, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11770, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 11781, -- There is an unusual arrangement of pebbles here.
        EGG_HUNT_OFFSET                = 11967, -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        THE_GATE_IS_LOCKED             = 12203, -- The gate is locked.
        EMALIVEULAUX_COP_NOT_COMPLETED = 12284, -- I'd like to start my own business someday, but I just haven't found anything that truly interests me.
        EMALIVEULAUX_OPEN_DIALOG       = 12285, -- Rare Tavnazian imports! Get them before they're gone!
        EMALIVEULAUX_CLOSED_DIALOG     = 12286, -- I'd love to sell you goods imported from the island of Tavnazia, but with the area under foreign control, I can't secure my trade routes...
        CHOCOBO_FEEDING_SLEEP          = 12866, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY       = 12867, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG      = 12868, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM           = 13960, -- #: %
        COMMON_SENSE_SURVIVAL          = 16065, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        TEAR_IN_FABRIC_OF_SPACE        = 16667, -- There appears to be a tear in the fabric of space...
        LINK_CONCIERGE_GOODBYE         = 16962, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LINK_CONCIERGE_ONE_PER_DAY     = 16966, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LINK_CONCIERGE_REGISTERED      = 17023, -- Your registration is officially complete.
        LINK_CONCIERGE_REGISTERED_2    = 17024, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LINK_CONCIERGE_LS_TAKEN        = 17025, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17735742] = 41, -- Faustin
            [17735744] = 43, -- Mille
            [17735747] = 42, -- Aulavia
            [17735795] = 40, -- Proud Beard
            [17735818] = 44, -- Emaliveulaux
        },
        EXPLORER_MOOGLE    = GetFirstID('Explorer_Moogle'),
        LELEROON_BLUE_DOOR = GetFirstID('Door_House'),
        AZETTE             = GetFirstID('Azette'),
        QUELLE             = GetFirstID('Quelle'),
        EULAPHE            = GetFirstID('Eulaphe'),
    },
}

return zones[xi.zone.BASTOK_MINES]
