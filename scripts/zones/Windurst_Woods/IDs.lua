-----------------------------------
-- Area: Windurst_Woods
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WOODS] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ASSIST_CHANNEL                = 6539,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6544,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_THE_ITEM        = 6546,  -- You cannot obtain the item. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6550,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6551,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6553,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6554,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6555,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM               = 6556,  -- You obtain  <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6586,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6589,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6590,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6591,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6611,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6613,  -- You learned Trust: <name>!
        HOMEPOINT_SET                 = 6657,  -- Home point set!
        YOU_ACCEPT_THE_MISSION        = 6750,  -- You have accepted the mission.
        ITEM_DELIVERY_DIALOG          = 6846,  -- We can deliver goods to your residence or to the residences of your friends.
        MAP_MARKER_TUTORIAL           = 6937,  -- The map will open when you select Map from the main menu. Choose Markers and scroll to the right to check the location.
        MOG_LOCKER_OFFSET             = 7022,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET        = 7134,  -- You can't fish here.
        IMAGE_SUPPORT                 = 7238,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7252,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7260,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7267,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7272,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7273,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7289,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        VALERIANO_SHOP_DIALOG         = 7583,  -- Halfling philosophers and heroine beauties, welcome to the Troupe Valeriano show! And how gorgeous and green this fair town is!
        DAHJAL_BASTOK_CIT             = 7585,  -- Surprising that Bastok, with its mighty Galkan warriors, could end up playing second fiddle to such a happy-go-lucky country as this. I'm looking forward to seeing you guys take the lead again.
        DAHJAL_NOT_BASTOK_CIT         = 7586,  -- Watch it! Keep back from the flames! These ain't magical illusions, you know! Real flames burn people!
        MOKOP_WINDY_CIT               = 7587,  -- Oh, I left you behind Only to return to you, oh Windurst! So rich, your glory sends me blind, Lo, praise the Star Sibyl, oh Windurst!
        MOKOP_NOT_WINDY_CIT           = 7588,  -- Windurst is the besty! You can forget about the resty! The air, so fair, has a different smell! It improves my tone, can't you tell?
        CHEH_WINDY_CIT                = 7589,  -- It's so verrrdant here and the food is delicious. I can hardly breathe in those other countries. Keep up the good work so I can stay here longerrr!
        CHEH_NOT_WINDY_CIT            = 7590,  -- Want to see my new knife trrrick? But keep your distance, if you value your ears and moustaches as they arrre!
        NALTA_SANDY_CIT               = 7591,  -- There are...so many...bugs here... This country...is...frightening...
        NALTA_NOT_SANDY_CIT           = 7592,  -- ...Please...enjoy...
        RAKOHBUUMA_OPEN_DIALOG        = 7680,  -- To expel those who would subvert the law and order of Windurst Woods... To protect the Mithra populace from all manner of threats and dangers... That is the job of us guards.
        RETTO_MARUTTO_DIALOG          = 7996,  -- Allo-allo! If you're after boneworking materials, then make sure you buy them herey in Windurst! We're the cheapest in the whole wide worldy!
        SHIH_TAYUUN_DIALOG            = 7998,  -- Oh, that Retto-Marutto... If he keeps carrying on while speaking to the customers, he'll get in trouble with the guildmaster again!
        KUZAH_HPIROHPON_DIALOG        = 8007,  -- Sew...I mean...So, want to get your paws on the top-quality materials as used in the Weaverrrs' Guild?
        MERIRI_DIALOG                 = 8009,  -- If you're interested in buying some works of art from our Weavers' Guild, then you've come to the right placey-wacey.
        PERIH_VASHAI_DIALOG           = 8295,  -- You can now become a ranger!
        QUESSE_SHOP_DIALOG            = 8549,  -- Welcome to the Windurst Chocobo Stables.
        MONONCHAA_SHOP_DIALOG         = 8550,  -- Huh...? If you be wanting anything therrre, [mister/missy], then hurry up and decide, then get the heck out of herrre!
        MANYNY_SHOP_DIALOG            = 8551,  -- Are you in urgent needy-weedy of anything? I have a variety of thingy-wingies you may be interested in.
        WIJETIREN_SHOP_DIALOG         = 8556,  -- From humble Mithran cold medicines to the legendary Windurstian ambrrrosia of immortality, we have it all...
        NHOBI_ZALKIA_OPEN_DIALOG      = 8559,  -- Psst... Interested in some rrreal hot property? From lucky chocobo digs to bargain goods that fell off the back of an airship...all my stuff is a rrreal steal!
        NHOBI_ZALKIA_CLOSED_DIALOG    = 8560,  -- You're interested in some cheap shopping, rrright? I'm real sorry. I'm not doing business rrright now.
        NYALABICCIO_OPEN_DIALOG       = 8561,  -- Ladies and gentlemen, kittens and cubs! Do we have the sale that you've been waiting forrr!
        NYALABICCIO_CLOSED_DIALOG     = 8562,  -- Sorry, but our shop is closed rrright now. Why don't you go to Gustaberg and help the situation out therrre?
        BIN_STEJIHNA_OPEN_DIALOG      = 8563,  -- Why don't you buy something from me? You won't regrrret it! I've got all sorts of goods from the Zulkheim region!
        BIN_STEJIHNA_CLOSED_DIALOG    = 8564,  -- I'm taking a brrreak from  the saleswoman gig to give dirrrections.  So...through this arrrch is the residential  area.
        TARAIHIPERUNHI_OPEN_DIALOG    = 8565,  -- Ooh...do I have some great merchandise for you! Man...these are once-in-a-lifetime offers, so get them while you can.
        TARAIHIPERUNHI_CLOSED_DIALOG  = 8566,  -- <pant> I am but a poor  merchant. Mate, but you just wait! Strife...one day I'll live the high life. Hey, that's my dream, anyway...
        CATALIA_DIALOG                = 8597,  -- While we cannot break our promise to the Windurstians, to ensure justice is served, we would secretly like you to take two shields off of the Yagudo who you meet en route.
        FORINE_DIALOG                 = 8598,  -- Act according to our convictions while fulfilling our promise with the Tarutaru. This is indeed a fitting course for us, the people of glorious San d'Oria.
        CONQUEST                      = 8966,  -- You've earned conquest points!
        APURURU_DIALOG                = 9529,  -- There's no way Semih Lafihna will just hand it over for no good reason. Maybe if you try talking with Kupipi...
        EMPYREAL_ARROW_LEARNED        = 9763,  -- You have learned the weapon skill Empyreal Arrow!
        TRICK_OR_TREAT                = 9774,  -- Trick or treat...
        THANK_YOU_TREAT               = 9775,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 9776,  -- Here, take this...
        IF_YOU_WEAR_THIS              = 9777,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 9778,  -- Thank you...
        NOKKHI_BAD_COUNT              = 9796,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE             = 9798,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM               = 9799,  -- I'm real sorry, but there's nothing I can do with those.
        EGG_HUNT_OFFSET               = 9805,  -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        MILLEROVIEUNET_OPEN_DIALOG    = 10024, -- Please have a look at these wonderful products from Qufim Island! You won't regret it!
        MILLEROVIEUNET_CLOSED_DIALOG  = 10025, -- Now that I've finally learned the language here, I'd like to start my own business. If I could only find a supplier...
        CLOUD_BAD_COUNT               = 10150, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE              = 10154, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                = 10155, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CHOCOBO_FEEDING_SLEEP         = 10642, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY      = 10643, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG     = 10644, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM          = 11727, -- #: %
        TRRRADE_IN_SPARKS             = 13871, -- You want to trrrade in sparks, do you?
        DO_NOT_POSSESS_ENOUGH         = 13890, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS             = 13891, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED      = 13892, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY     = 13902, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY         = 14422, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY    = 14498, -- ou have already changed Unities. Please wait until the next tabulation period.
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
        AMIMI   = GetFirstID('Amimi'),
        SARIALE = GetFirstID('Sariale'),
        ORLAINE = GetFirstID('Orlaine'),
    },
}

return zones[xi.zone.WINDURST_WOODS]
