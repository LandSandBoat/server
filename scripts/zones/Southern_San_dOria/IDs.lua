-----------------------------------
-- Area: Southern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SOUTHERN_SAN_DORIA] =
{
    text =
    {
        HOMEPOINT_SET                  = 24,    -- Home point set!
        ITEM_CANNOT_BE_OBTAINED        = 6428,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        DEFAULT_CANNOT_BE_OBTAINED     = 6430,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6432,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6434,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6435,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6437,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6438,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6439,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM                = 6440,  -- You obtain  <item>!
        NOTHING_OUT_OF_ORDINARY        = 6448,  -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6470,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6473,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6474,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6475,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6495,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST              = 6497,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO        = 6498,  -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET              = 6689,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        LEATHER_SUPPORT                = 6791,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT       = 6805,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 6813,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 6820,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 6825,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 6826,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 6842,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                  = 7048,  -- Tallying conquest results...
        YOU_ACCEPT_THE_MISSION         = 7212,  -- You accept the mission.
        ORIGINAL_MISSION_OFFSET        = 7223,  -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        TRICK_OR_TREAT                 = 7371,  -- Trick or treat...
        THANK_YOU_TREAT                = 7372,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 7373,  -- Here, take this...
        IF_YOU_WEAR_THIS               = 7374,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 7375,  -- Thank you...
        NOKKHI_BAD_COUNT               = 7393,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE              = 7395,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM                = 7396,  -- I'm real sorry, but there's nothing I can do with those.
        YOU_CANNOT_ENTER_DYNAMIS       = 7430,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7432,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7442,  -- There is an unusual arrangement of branches here.
        VARCHET_BET_LOST               = 7773,  -- You lose your bet of 5 gil.
        VARCHET_KEEP_PROMISE           = 7782,  -- As promised, I shall go and see about those woodchippers. Maybe we can play another game later.
        ROSEL_GREETINGS                = 7783,  -- Greetings!
        FFR_ROSEL                      = 7802,  -- Hrmm... Now, this is interesting! It pays to keep an eye on the competition. Thanks for letting me know!
        EXOROCHE_PLEASE_TELL           = 7821,  -- Please tell my son that I'll join him as soon as I'm done, so he's to stay right there.
        RAIMBROY_DIALOG                = 7841,  -- Greetings, and welcome to Raimbroy's Grocery. If you'd like to make a purchase, talk to someone at the counter upstairs.
        TAUMILA_DEFAULT                = 7975,  -- I am Taumila, the owner of this establishment. Talk to the lady behind the counter if you wish to make a purchase.
        LUSIANE_SHOP_DIALOG            = 7976,  -- Hello! Let Taumila's handle all your sundry needs!
        OSTALIE_SHOP_DIALOG            = 7977,  -- Welcome, customer. Please have a look.
        ASH_THADI_ENE_SHOP_DIALOG      = 7998,  -- Welcome to Helbort's Blades!
        NOTHING_TO_REPORT              = 8016,  -- Nothing to report!
        UNLOCK_PALADIN                 = 8025,  -- You can now become a paladin!
        AMAURA_DIALOG_COMEBACK         = 8032,  -- Come back when ye've got it all. I'll make a draught to cure the wickedest of colds, I will.
        AMAURA_DIALOG_DELIVER          = 8035,  -- Take that medicine over quick as you can now, dearie. Wouldn't want it to go bad.
        FFR_BLENDARE                   = 8109,  -- Wait! If I had magic, maybe I could keep my brother's hands off my sweets...
        RAMINEL_DELIVERY               = 8113,  -- Here's your delivery!
        RAMINEL_DELIVERIES             = 8115,  -- Sorry, I have deliveries to make!
        SHILAH_SHOP_DIALOG             = 8130,  -- Welcome, weary traveler. Make yourself at home!
        VALERIANO_SHOP_DIALOG          = 8148,  -- Oh, a fellow outsider! We are Troupe Valeriano. I am Valeriano, at your service!
        FERDOULEMIONT_SHOP_DIALOG      = 8164,  -- Hello!
        MALECHARISANT_DIALOG           = 8183,  -- You stand before the Westgate. West Ronfaure lies beyond.
        CLETAE_DIALOG                  = 8216,  -- Why, hello. All our skins are guild-approved.
        KUEH_IGUNAHMORI_DIALOG         = 8217,  -- Good day! We have lots in stock today.
        SOBANE_DIALOG                  = 8235,  -- My name is Sobane, and I'm sharpening my knives.
        PAUNELIE_DIALOG                = 8325,  -- I'm sorry, can I help you?
        PAUNELIE_SHOP_DIALOG           = 8330,  -- These magic shells are full of mysteries...
        ITEM_DELIVERY_DIALOG           = 8425,  -- Parcels delivered to rooms anywhere in Vana'diel!
        MACHIELLE_OPEN_DIALOG          = 8431,  -- Might I interest you in produce from Norvallen?
        CORUA_OPEN_DIALOG              = 8432,  -- Ronfaure produce for sale!
        PHAMELISE_OPEN_DIALOG          = 8433,  -- I've got fresh produce from Zulkheim!
        APAIREMANT_OPEN_DIALOG         = 8434,  -- Might you be interested in produce from Gustaberg
        RAIMBROYS_SHOP_DIALOG          = 8435,  -- Welcome to Raimbroy's Grocery!
        BENAIGE_SHOP_DIALOG            = 8436,  -- Looking for something in particular?
        CARAUTIA_SHOP_DIALOG           = 8437,  -- Well, what sort of armor would you like?
        MACHIELLE_CLOSED_DIALOG        = 8438,  -- We want to sell produce from Norvallen, but the entire region is under foreign control!
        CORUA_CLOSED_DIALOG            = 8439,  -- We specialize in Ronfaure produce, but we cannot import from that region without a strong San d'Orian presence there.
        PHAMELISE_CLOSED_DIALOG        = 8440,  -- I'd be making a killing selling produce from Zulkheim, but the region's under foreign control!
        APAIREMANT_CLOSED_DIALOG       = 8441,  -- I'd love to import produce from Gustaberg, but the foreign powers in control there make me feel unsafe!
        POURETTE_OPEN_DIALOG           = 8442,  -- Derfland produce for sale!
        POURETTE_CLOSED_DIALOG         = 8443,  -- Listen, adventurer... I can't import from Derfland until the region knows San d'Orian power!
        CONQUEST                       = 8500,  -- You've earned conquest points!
        FLYER_ACCEPTED                 = 8845,  -- The flyer is accepted.
        FLYER_ALREADY                  = 8846,  -- This person already has a flyer.
        FFR_LOOKS_CURIOUSLY_BASE       = 8847,  -- Blendare looks over curiously for a moment.
        FFR_MAUGIE                     = 8849,  -- A magic shop, eh? Hmm... A little magic could go a long way for making a leisurely retirement! Ho ho ho!
        FFR_ADAUNEL                    = 8851,  -- A magic shop? Maybe I'll check it out one of these days. Could help with my work, even...
        FFR_LEUVERET                   = 8853,  -- A magic shop? That'd be a fine place to peddle my wares. I smell a profit! I'll be up to my gills in gil, I will!
        LUSIANE_THANK                  = 8896,  -- Thank you! My snoring will express gratitude mere words cannot! Here's something for you in return.
        IMPULSE_DRIVE_LEARNED          = 9333,  -- You have learned the weapon skill Impulse Drive!
        CLOUD_BAD_COUNT                = 10121, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE               = 10125, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                 = 10126, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CAPUCINE_SHOP_DIALOG           = 10327, -- Hello! You seem to be working very hard. I'm really thankful! But you needn't rush around so fast. Take your time! I can wait if it makes the job easier for you!
        CHOCOBO_FEEDING_SLEEP          = 10722, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY       = 10723, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG      = 10724, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM           = 11807, -- #: %
        TUTORIAL_NPC                   = 13533, -- Greetings and well met! Guardian of the Kingdom, Alaune, at your most humble service.
        YOU_WISH_TO_EXCHANGE_SPARKS    = 15387, -- You wish to exchange your sparks?
        DO_NOT_POSSESS_ENOUGH          = 15416, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS              = 15417, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED       = 15418, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY      = 15428, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        MAP_MARKER_TUTORIAL            = 15660, -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        YOU_HAVE_JOINED_UNITY          = 15968, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY     = 16044, -- ou have already changed Unities. Please wait until the next tabulation period.
        TEAR_IN_FABRIC_OF_SPACE        = 16505, -- There appears to be a tear in the fabric of space...
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
        STARLIGHT_DECORATIONS =
        {
            [17719896] = 17719896,  -- Starlight Celebration Tree
            [17719897] = 17719897,  -- Starlight Celebration Tree
            [17719898] = 17719898,  -- Starlight Celebration Tree
            [17719899] = 17719899,  -- Starlight Celebration Tree
            [17719900] = 17719900,  -- Starlight Celebration Tree
            [17719901] = 17719901,  -- Starlight Celebration Tree
            [17719902] = 17719902,  -- Starlight Celebration Tree
            [17719903] = 17719903,  -- Starlight Celebration Tree
            [17719904] = 17719904,  -- Starlight Celebration Tree
            [17719905] = 17719905,  -- Starlight Celebration Tree
            [17719906] = 17719906,  -- Starlight Celebration Tree
            [17719607] = 17719607,  -- Starlight Celebration Tree
            [17719908] = 17719908,  -- Starlight Celebration Tree
            [17719909] = 17719909,  -- Starlight Celebration Tree
            [17719910] = 17719910,  -- Starlight Celebration Tree
            [17719911] = 17719911,  -- Starlight Celebration Tree
            [17719912] = 17719912,  -- Starlight Celebration Tree
            [17719913] = 17719913,  -- Starlight Celebration Tree
            [17719914] = 17719914,  -- Starlight Celebration Tree
            [17719915] = 17719915,  -- Starlight Celebration Tree
            [17719916] = 17719916,  -- Starlight Celebration Tree
            [17719917] = 17719917,  -- Starlight Celebration Tree
            [17719918] = 17719918,  -- Starlight Celebration Tree
            [17719919] = 17719919,  -- Starlight Celebration Tree
            [17719920] = 17719920,  -- Starlight Celebration Tree
            [17719921] = 17719921,  -- Starlight Celebration Tree
            [17719922] = 17719922,  -- Starlight Celebration Tree
            [17719923] = 17719923,  -- Starlight Celebration Tree
            [17719924] = 17719924,  -- Starlight Celebration Tree
            [17719925] = 17719925,  -- Starlight Celebration Tree
            [17719926] = 17719926,  -- Starlight Celebration Tree
            -- [17719929] = 17719929,  -- Estiliphire
            [17719927] = 17719927,  -- Event Moogle
            [17719928] = 17719928,  -- Token Moogle (Token Redemption)
        },
        LUSIANE  = 17719350,
        ARPETION = 17719409,
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA]
