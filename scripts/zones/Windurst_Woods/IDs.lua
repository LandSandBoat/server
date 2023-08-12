-----------------------------------
-- Area: Windurst_Woods
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WOODS] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_THE_ITEM        = 6545,  -- You cannot obtain the item. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6553,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6554,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM               = 6555,  -- You obtain  <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6585,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6588,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6589,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6590,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6610,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6612,  -- You learned Trust: <name>!
        HOMEPOINT_SET                 = 6649,  -- Home point set!
        YOU_ACCEPT_THE_MISSION        = 6742,  -- You have accepted the mission.
        ITEM_DELIVERY_DIALOG          = 6838,  -- We can deliver goods to your residence or to the residences of your friends.
        MAP_MARKER_TUTORIAL           = 6929,  -- The map will open when you select Map from the main menu. Choose Markers and scroll to the right to check the location.
        MOG_LOCKER_OFFSET             = 7014,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET        = 7126,  -- You can't fish here.
        IMAGE_SUPPORT                 = 7230,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7244,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7252,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7259,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7264,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7265,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7281,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        VALERIANO_SHOP_DIALOG         = 7575,  -- Halfling philosophers and heroine beauties, welcome to the Troupe Valeriano show! And how gorgeous and green this fair town is!
        RAKOHBUUMA_OPEN_DIALOG        = 7672,  -- To expel those who would subvert the law and order of Windurst Woods... To protect the Mithra populace from all manner of threats and dangers... That is the job of us guards.
        RETTO_MARUTTO_DIALOG          = 7988,  -- Allo-allo! If you're after boneworking materials, then make sure you buy them herey in Windurst! We're the cheapest in the whole wide worldy!
        SHIH_TAYUUN_DIALOG            = 7990,  -- Oh, that Retto-Marutto... If he keeps carrying on while speaking to the customers, he'll get in trouble with the guildmaster again!
        KUZAH_HPIROHPON_DIALOG        = 7999,  -- Sew...I mean...So, want to get your paws on the top-quality materials as used in the Weaverrrs' Guild?
        MERIRI_DIALOG                 = 8001,  -- If you're interested in buying some works of art from our Weavers' Guild, then you've come to the right placey-wacey.
        PERIH_VASHAI_DIALOG           = 8287,  -- You can now become a ranger!
        QUESSE_SHOP_DIALOG            = 8541,  -- Welcome to the Windurst Chocobo Stables.
        MONONCHAA_SHOP_DIALOG         = 8542,  -- Huh...? If you be wanting anything therrre, [mister/missy], then hurry up and decide, then get the heck out of herrre!
        MANYNY_SHOP_DIALOG            = 8543,  -- Are you in urgent needy-weedy of anything? I have a variety of thingy-wingies you may be interested in.
        WIJETIREN_SHOP_DIALOG         = 8548,  -- From humble Mithran cold medicines to the legendary Windurstian ambrrrosia of immortality, we have it all...
        NHOBI_ZALKIA_OPEN_DIALOG      = 8551,  -- Psst... Interested in some rrreal hot property? From lucky chocobo digs to bargain goods that fell off the back of an airship...all my stuff is a rrreal steal!
        NHOBI_ZALKIA_CLOSED_DIALOG    = 8552,  -- You're interested in some cheap shopping, rrright? I'm real sorry. I'm not doing business rrright now.
        NYALABICCIO_OPEN_DIALOG       = 8553,  -- Ladies and gentlemen, kittens and cubs! Do we have the sale that you've been waiting forrr!
        NYALABICCIO_CLOSED_DIALOG     = 8554,  -- Sorry, but our shop is closed rrright now. Why don't you go to Gustaberg and help the situation out therrre?
        BIN_STEJIHNA_OPEN_DIALOG      = 8555,  -- Why don't you buy something from me? You won't regrrret it! I've got all sorts of goods from the Zulkheim region!
        BIN_STEJIHNA_CLOSED_DIALOG    = 8556,  -- I'm taking a brrreak from  the saleswoman gig to give dirrrections.  So...through this arrrch is the residential  area.
        TARAIHIPERUNHI_OPEN_DIALOG    = 8557,  -- Ooh...do I have some great merchandise for you! Man...these are once-in-a-lifetime offers, so get them while you can.
        TARAIHIPERUNHI_CLOSED_DIALOG  = 8558,  -- <pant> I am but a poor  merchant. Mate, but you just wait! Strife...one day I'll live the high life. Hey, that's my dream, anyway...
        CATALIA_DIALOG                = 8589,  -- While we cannot break our promise to the Windurstians, to ensure justice is served, we would secretly like you to take two shields off of the Yagudo who you meet en route.
        FORINE_DIALOG                 = 8590,  -- Act according to our convictions while fulfilling our promise with the Tarutaru. This is indeed a fitting course for us, the people of glorious San d'Oria.
        CONQUEST                      = 8958,  -- You've earned conquest points!
        APURURU_DIALOG                = 9521,  -- There's no way Semih Lafihna will just hand it over for no good reason. Maybe if you try talking with Kupipi...
        EMPYREAL_ARROW_LEARNED        = 9755,  -- You have learned the weapon skill Empyreal Arrow!
        TRICK_OR_TREAT                = 9766,  -- Trick or treat...
        THANK_YOU_TREAT               = 9767,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 9768,  -- Here, take this...
        IF_YOU_WEAR_THIS              = 9769,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 9770,  -- Thank you...
        NOKKHI_BAD_COUNT              = 9788,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE             = 9790,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM               = 9791,  -- I'm real sorry, but there's nothing I can do with those.
        EGG_HUNT_OFFSET               = 9797,  -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        MILLEROVIEUNET_OPEN_DIALOG    = 10016, -- Please have a look at these wonderful products from Qufim Island! You won't regret it!
        MILLEROVIEUNET_CLOSED_DIALOG  = 10017, -- Now that I've finally learned the language here, I'd like to start my own business. If I could only find a supplier...
        CLOUD_BAD_COUNT               = 10142, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE              = 10146, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                = 10147, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CHOCOBO_FEEDING_SLEEP         = 10631, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY      = 10632, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG     = 10633, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM          = 11716, -- #: %
        TRRRADE_IN_SPARKS             = 13860, -- You want to trrrade in sparks, do you?
        DO_NOT_POSSESS_ENOUGH         = 13879, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS             = 13880, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED      = 13881, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY     = 13891, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY         = 14410, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY    = 14486, -- ou have already changed Unities. Please wait until the next tabulation period.
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17764400] = 55, -- Meriri
            [17764401] = 54, -- Kuzah Hpirohpon
            [17764462] = 58, -- Taraihi-Perunhi
            [17764464] = 56, -- Nhobi Zalkia
            [17764465] = 57, -- Millerovieunet
        },
    },
}

return zones[xi.zone.WINDURST_WOODS]
