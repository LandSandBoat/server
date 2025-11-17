-----------------------------------
-- Area: Southern_San_dOria
-----------------------------------
zones = zones or {}

zones[xi.zone.SOUTHERN_SAN_DORIA] =
{
    text =
    {
        HOMEPOINT_SET                  = 24,    -- Home point set!
        ASSIST_CHANNEL                 = 6424,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED        = 6429,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_THE_ITEM         = 6431,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6433,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6435,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6436,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6438,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6439,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6440,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM                = 6441,  -- You obtain  <item>!
        NOTHING_OUT_OF_ORDINARY        = 6449,  -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6471,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6474,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6475,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6476,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6496,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST              = 6498,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO        = 6499,  -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET              = 6697,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT                  = 6813,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT       = 6827,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 6835,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 6842,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 6847,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 6848,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 6864,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                  = 7070,  -- Tallying conquest results...
        YOU_ACCEPT_THE_MISSION         = 7234,  -- You accept the mission.
        ORIGINAL_MISSION_OFFSET        = 7245,  -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        TRICK_OR_TREAT                 = 7393,  -- Trick or treat...
        THANK_YOU_TREAT                = 7394,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 7395,  -- Here, take this...
        IF_YOU_WEAR_THIS               = 7396,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 7397,  -- Thank you...
        NOKKHI_BAD_COUNT               = 7415,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE              = 7417,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM                = 7418,  -- I'm real sorry, but there's nothing I can do with those.
        EGG_HUNT_OFFSET                = 7424,  -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        YOU_CANNOT_ENTER_DYNAMIS       = 7452,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7454,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7464,  -- There is an unusual arrangement of branches here.
        NOBODY_ONE_WANTS_TO_PLAY       = 7780,  -- Ah, nobody wants to play games of chance these days.
        VARCHET_BET_LOST               = 7795,  -- You lose your bet of 5 gil.
        VARCHET_KEEP_PROMISE           = 7804,  -- As promised, I shall go and see about those woodchippers. Maybe we can play another game later.
        ROSEL_GREETINGS                = 7805,  -- Greetings!
        FFR_ROSEL                      = 7824,  -- Hrmm... Now, this is interesting! It pays to keep an eye on the competition. Thanks for letting me know!
        EXOROCHE_START                 = 7840,  -- You've some business with me? Sorry, but I'm busy.
        EXOROCHE_PLEASE_TELL           = 7843,  -- Please tell my son that I'll join him as soon as I'm done, so he's to stay right there.
        GO_TO_KING_RANPERRES           = 7891,  -- Go to King Ranperre's Tomb and bring back <item>. How, you ask? Use your head. Now begone!
        TO_GET_TO_KING_RANPERRES       = 7910,  -- To get to King Ranperre's Tomb, head out the Eastgate into East Ronfaure, then make your way south as far as you can go. You should find it before long.
        YOU_FIND_A_WELL                = 7918,  -- You find a well.
        DONT_NEED_MORE_WATER           = 7920,  -- You don't need any more water.
        I_THANK_YOU_ADVENTURER         = 7922,  -- I thank you, kind adventurer. His Majesty, the late king, thanks you, too.
        TAUMILA_DIALOG                 = 7997,  -- I am Taumila, the owner of this establishment. Talk to the lady behind the counter if you wish to make a purchase.
        LUSIANE_SHOP_DIALOG            = 7998,  -- Hello! Let Taumila's handle all your sundry needs!
        OSTALIE_SHOP_DIALOG            = 7999,  -- Welcome, customer. Please have a look.
        HELBORT_DIALOG                 = 8001,  -- Welcome, welcome! Either of my attendants will be happy to help you!
        HELBORT_ORDERS                 = 8013,  -- It's an urgent order, so go as soon as you can. Remember, give the order to the free trader Alexius in Jugner Forest.
        ASH_THADI_ENE_SHOP_DIALOG      = 8020,  -- Welcome to Helbort's Blades!
        EXOROCHE_DIALOG_OFFSET         = 8022,  -- Oh, the gleam! Such brilliance! Blades wrought by the master here are indeed a cut above. I must have one...
        NOTHING_TO_REPORT              = 8038,  -- Nothing to report!
        TRIAL_IS_DIFFICULT             = 8040,  -- The trial is difficult, but those who pass may become true knights. Good luck to you.
        MAKE_EXCELLENT_KNIGHT          = 8041,  -- I heard you did well. I am sure you'll make an excellent knight.
        DO_NOT_FRET                    = 8043,  -- You may not know what to do, but do not fret. You have all the time you need.
        YOUVE_DONE_WELL                = 8044,  -- You've done well. I knew you would from the moment I saw you.
        UNLOCK_PALADIN                 = 8047,  -- You can now become a paladin!
        AMAURA_DIALOG_COMEBACK         = 8054,  -- Come back when ye've got it all. I'll make a draught to cure the wickedest of colds, I will.
        AMAURA_DIALOG_DELIVER          = 8057,  -- Take that medicine over quick as you can now, dearie. Wouldn't want it to go bad.
        FFR_BLENDARE                   = 8131,  -- Wait! If I had magic, maybe I could keep my brother's hands off my sweets...
        RAMINEL_DELIVERY               = 8135,  -- Here's your delivery!
        RAMINEL_DELIVERIES             = 8137,  -- Sorry, I have deliveries to make!
        SHILAH_SHOP_DIALOG             = 8152,  -- Welcome, weary traveler. Make yourself at home!
        VALERIANO_SHOP_DIALOG          = 8170,  -- Oh, a fellow outsider! We are Troupe Valeriano. I am Valeriano, at your service!
        DAHJAL_NOT_BASTOK_CIT          = 8171,  -- Watch this.
        DAHJAL_BASTOK_CIT              = 8172,  -- I worry for Bastok... Our Hume leaders rely too much on technology.
        MOKOP_NOT_SANDY_CIT            = 8173,  -- To be honest, I'm not fond of San d'Orians. Tall and snooty but misers through and through! May their conquests fall flat!
        MOKOP_SANDY_CIT                = 8174,  -- What a huge city-witty! San d'Oria towers above the other nations! How can they possibly competaru?
        CHEH_WINDY_CIT                 = 8175,  -- The food arrround here's not bad, but our Windurstian chefs could do better. If they could only get hold of the same ingrrredients!
        CHEH_NOT_WINDY_CIT             = 8176,  -- Nobody tops my trrricks. Stand back if you value your ears and moustaches!
        NALTA_SANDY_CIT                = 8177,  -- San d'Oria owes its victories to the Elvaan.
        NALTA_NOT_SANDY_CIT            = 8178,  -- Shhh.
        FERDOULEMIONT_SHOP_DIALOG      = 8186,  -- Hello!
        WEST_GATE                      = 8205,  -- You stand before the Westgate. West Ronfaure lies beyond.
        CLETAE_DIALOG                  = 8238,  -- Why, hello. All our skins are guild-approved.
        KUEH_IGUNAHMORI_DIALOG         = 8239,  -- Good day! We have lots in stock today.
        SOBANE_DIALOG                  = 8258,  -- My name is Sobane, and I'm sharpening my knives.
        PAUNELIE_DIALOG                = 8348,  -- I'm sorry, can I help you?
        ITEM_DELIVERY_DIALOG           = 8448,  -- Parcels delivered to rooms anywhere in Vana'diel!
        PAUNELIE_SHOP_DIALOG           = 8451,  -- Like %?
        MACHIELLE_OPEN_DIALOG          = 8454,  -- Might I interest you in produce from Norvallen?
        CORUA_OPEN_DIALOG              = 8455,  -- Ronfaure produce for sale!
        PHAMELISE_OPEN_DIALOG          = 8456,  -- I've got fresh produce from Zulkheim!
        APAIREMANT_OPEN_DIALOG         = 8457,  -- Might you be interested in produce from Gustaberg
        RAIMBROYS_SHOP_DIALOG          = 8458,  -- Welcome to Raimbroy's Grocery!
        CARAUTIA_SHOP_DIALOG           = 8460,  -- Well, what sort of armor would you like?
        MACHIELLE_CLOSED_DIALOG        = 8461,  -- We want to sell produce from Norvallen, but the entire region is under foreign control!
        CORUA_CLOSED_DIALOG            = 8462,  -- We specialize in Ronfaure produce, but we cannot import from that region without a strong San d'Orian presence there.
        PHAMELISE_CLOSED_DIALOG        = 8463,  -- I'd be making a killing selling produce from Zulkheim, but the region's under foreign control!
        APAIREMANT_CLOSED_DIALOG       = 8464,  -- I'd love to import produce from Gustaberg, but the foreign powers in control there make me feel unsafe!
        POURETTE_OPEN_DIALOG           = 8465,  -- Derfland produce for sale!
        POURETTE_CLOSED_DIALOG         = 8466,  -- Listen, adventurer... I can't import from Derfland until the region knows San d'Orian power!
        CONQUEST                       = 8523,  -- You've earned conquest points!
        FLYER_ACCEPTED                 = 8868,  -- The flyer is accepted.
        FLYER_ALREADY                  = 8869,  -- This person already has a flyer.
        FFR_LOOKS_CURIOUSLY_BASE       = 8870,  -- Blendare looks over curiously for a moment.
        FFR_MAUGIE                     = 8872,  -- A magic shop, eh? Hmm... A little magic could go a long way for making a leisurely retirement! Ho ho ho!
        FFR_ADAUNEL                    = 8874,  -- A magic shop? Maybe I'll check it out one of these days. Could help with my work, even...
        FFR_LEUVERET                   = 8876,  -- A magic shop? That'd be a fine place to peddle my wares. I smell a profit! I'll be up to my gills in gil, I will!
        LUSIANE_THANK                  = 8919,  -- Thank you! My snoring will express gratitude mere words cannot! Here's something for you in return.
        IMPULSE_DRIVE_LEARNED          = 9356,  -- You have learned the weapon skill Impulse Drive!
        CLOUD_BAD_COUNT                = 10144, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE               = 10148, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                 = 10149, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CAPUCINE_SHOP_DIALOG           = 10350, -- Hello! You seem to be working very hard. I'm really thankful! But you needn't rush around so fast. Take your time! I can wait if it makes the job easier for you!
        CHOCOBO_FEEDING_SLEEP          = 10745, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY       = 10746, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG      = 10747, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM           = 11830, -- #: %
        TUTORIAL_NPC                   = 13556, -- Greetings and well met! Guardian of the Kingdom, Alaune, at your most humble service.
        YOU_WISH_TO_EXCHANGE_SPARKS    = 15410, -- You wish to exchange your sparks?
        DO_NOT_POSSESS_ENOUGH          = 15439, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS              = 15440, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED       = 15441, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY      = 15451, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        MAP_MARKER_TUTORIAL            = 15683, -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        YOU_HAVE_JOINED_UNITY          = 15991, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY     = 16067, -- ou have already changed Unities. Please wait until the next tabulation period.
        TEAR_IN_FABRIC_OF_SPACE        = 16528, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17719303] = 47, -- Machielle
            [17719304] = 50, -- Corua
            [17719305] = 48, -- Phamelise
            [17719306] = 46, -- Apairemant
            [17719493] = 49, -- Pourette
        },
        LUSIANE   = GetFirstID('Lusiane'),
        ARPETION  = GetFirstID('Arpetion'),
        CAMEREINE = GetFirstID('Camereine'),
        EMOUSSINE = GetFirstID('Emoussine'),
        MEUNEILLE = GetFirstID('Meuneille'),
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA]
