-----------------------------------
-- Area: Bastok_Mines
-----------------------------------
zones = zones or {}

zones[xi.zone.BASTOK_MINES] =
{
    text =
    {
        ASSIST_CHANNEL                 = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED        = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6389,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6394,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6395,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6396,  -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6427,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6430,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6431,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6432,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6452,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                  = 6498,  -- Home point set!
        YOU_ACCEPT_THE_MISSION         = 6527,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET        = 6532,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                  = 6600,  -- Tallying conquest results...
        MARIADOK_DIALOG                = 6759,  -- Your fate rides on the changing winds of Vana'diel. I can give you insight on the local weather.
        MOG_LOCKER_OFFSET              = 6872,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL            = 7084,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        IMAGE_SUPPORT                  = 7091,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        HEMEWMEW_DIALOG                = 7098,  -- Hello, [sir/ma'am]. I have been appointed by the Guildworkers' Union to manage the trading of manufactured crafts and the exchange of guild points.
        GUILD_TERMINATE_CONTRACT       = 7105,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 7113,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 7120,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 7125,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 7126,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 7142,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        REGIME_CANCELED                = 7307,  -- Current training regime canceled.
        HUNT_ACCEPTED                  = 7325,  -- Hunt accepted!
        USE_SCYLDS                     = 7326,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                  = 7337,  -- You record your hunt.
        OBTAIN_SCYLDS                  = 7339,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                  = 7343,  -- Hunt canceled.
        ITEM_DELIVERY_DIALOG           = 10473, -- Need something sent to a friend's house? Sending items to your own house? You've come to the right place!
        DETZO_RIVALS_DIALOG            = 10624, -- Can I borrow it for just a few seconds? I'll give it back, promise! I'll even give you a reward!
        FAUSTIN_CLOSED_DIALOG          = 10817, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Ronfaure, but it's not easy getting stuff from areas that aren't under Bastokan control.
        RODELLIEUX_CLOSED_DIALOG       = 10818, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Fauregandi, but it's not easy getting stuff from areas that aren't under Bastokan control.
        MILLE_CLOSED_DIALOG            = 10819, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Norvallen, but it's not easy getting stuff from areas that aren't under Bastokan control.
        TIBELDA_CLOSED_DIALOG          = 10820, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Valdeaunia, but it's not easy getting stuff from areas that aren't under Bastokan control.
        GALDEO_CLOSED_DIALOG           = 10821, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Li'Telor, but it's not easy getting stuff from areas that aren't under Bastokan control.
        TAMI_MY_HUSBAND                = 10823, -- My husband's name is Zelman. You'll find him in the Zeruhn Mines. He's a miner. All right, then, off you go!
        FISHING_MESSAGE_OFFSET         = 10838, -- You can't fish here.
        DEEGIS_SHOP_DIALOG             = 10938, -- The only things an adventurer needs are courage and a good suit of armor! Welcome to Deegis's Armour!
        ZEMEDARS_SHOP_DIALOG           = 10939, -- Everything in our store is top-grade and Galka-made! What're you lookin' for?
        BOYTZ_SHOP_DIALOG              = 10940, -- Welcome to Boytz's Knickknacks.
        GELZERIO_SHOP_DIALOG           = 10941, -- ...Yes?
        GRISELDA_SHOP_DIALOG           = 10942, -- Good of you to drop by the Bat's Lair Inn! Why don't you try some of our specialty plates?
        NEIGEPANCE_SHOP_DIALOG         = 10943, -- Hello there. A well-fed chocobo is a happy chocobo!
        FAUSTIN_OPEN_DIALOG            = 10944, -- Hello there! Might I interest you specialty goods from Ronfaure?
        MILLE_OPEN_DIALOG              = 10945, -- Hello there! Might I interest you specialty goods from Norvallen?
        RODELLIEUX_OPEN_DIALOG         = 10946, -- Hello there! Might I interest you specialty goods from Fauregandi?
        TIBELDA_OPEN_DIALOG            = 10947, -- Goods of all varieties, imported directly from the northern land of Valdeaunia!
        MAYMUNAH_SHOP_DIALOG           = 10948, -- Welcome to the Alchemists' Guild! Looking for something specific?
        ODOBA_SHOP_DIALOG              = 10949, -- Welcome to the Alchemists' Guild. How may I help you?
        CONQUEST                       = 11149, -- You've earned conquest points!
        GALDEO_OPEN_DIALOG             = 11509, -- Come! Take a look at all the wonderful goods from Li'Telor.
        AULAVIA_OPEN_DIALOG            = 11510, -- May I interest you in some specialty goods from Vollbow?
        AULAVIA_CLOSED_DIALOG          = 11511, -- I'm trying to start a business selling goods from Vollbow, but it's not easy getting stuff from areas that aren't under Bastokan control.
        EXTENDED_MISSION_OFFSET        = 11652, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        PROUDBEARD_SHOP_DIALOG         = 11680, -- Would you be interested in a nice suit of adventurer-issue armor? Be careful when you buy, though. We offer no refunds.
        TRICK_OR_TREAT                 = 11724, -- Trick or treat...
        THANK_YOU_TREAT                = 11725, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 11726, -- Here, take this...
        IF_YOU_WEAR_THIS               = 11727, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 11728, -- Thank you...
        GROUND_STRIKE_LEARNED          = 11750, -- You have learned the weapon skill Ground Strike!
        YOU_CANNOT_ENTER_DYNAMIS       = 11763, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 11765, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 11776, -- There is an unusual arrangement of pebbles here.
        EGG_HUNT_OFFSET                = 11962, -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        THE_GATE_IS_LOCKED             = 12198, -- The gate is locked.
        EMALIVEULAUX_COP_NOT_COMPLETED = 12279, -- I'd like to start my own business someday, but I just haven't found anything that truly interests me.
        EMALIVEULAUX_OPEN_DIALOG       = 12280, -- Rare Tavnazian imports! Get them before they're gone!
        EMALIVEULAUX_CLOSED_DIALOG     = 12281, -- I'd love to sell you goods imported from the island of Tavnazia, but with the area under foreign control, I can't secure my trade routes...
        CHOCOBO_FEEDING_SLEEP          = 12861, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY       = 12862, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG      = 12863, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM           = 13946, -- #: %
        COMMON_SENSE_SURVIVAL          = 16051, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        TEAR_IN_FABRIC_OF_SPACE        = 16652, -- There appears to be a tear in the fabric of space...
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
