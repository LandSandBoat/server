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
        MOG_LOCKER_OFFSET              = 6686,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        LEATHER_SUPPORT                = 6788,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT       = 6802,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 6810,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 6817,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 6822,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 6823,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 6839,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                  = 7045,  -- Tallying conquest results...
        YOU_ACCEPT_THE_MISSION         = 7209,  -- You accept the mission.
        ORIGINAL_MISSION_OFFSET        = 7220,  -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        TRICK_OR_TREAT                 = 7368,  -- Trick or treat...
        THANK_YOU_TREAT                = 7369,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 7370,  -- Here, take this...
        IF_YOU_WEAR_THIS               = 7371,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 7372,  -- Thank you...
        NOKKHI_BAD_COUNT               = 7390,  -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE              = 7392,  -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM                = 7393,  -- I'm real sorry, but there's nothing I can do with those.
        YOU_CANNOT_ENTER_DYNAMIS       = 7427,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7429,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7439,  -- There is an unusual arrangement of branches here.
        VARCHET_BET_LOST               = 7770,  -- You lose your bet of 5 gil.
        VARCHET_KEEP_PROMISE           = 7779,  -- As promised, I shall go and see about those woodchippers. Maybe we can play another game later.
        ROSEL_GREETINGS                = 7780,  -- Greetings!
        FFR_ROSEL                      = 7799,  -- Hrmm... Now, this is interesting! It pays to keep an eye on the competition. Thanks for letting me know!
        EXOROCHE_PLEASE_TELL           = 7818,  -- Please tell my son that I'll join him as soon as I'm done, so he's to stay right there.
        LUSIANE_SHOP_DIALOG            = 7973,  -- Hello! Let Taumila's handle all your sundry needs!
        OSTALIE_SHOP_DIALOG            = 7974,  -- Welcome, customer. Please have a look.
        ASH_THADI_ENE_SHOP_DIALOG      = 7995,  -- Welcome to Helbort's Blades!
        UNLOCK_PALADIN                 = 8022,  -- You can now become a paladin!
        AMAURA_DIALOG_COMEBACK         = 8029,  -- Come back when ye've got it all. I'll make a draught to cure the wickedest of colds, I will.
        AMAURA_DIALOG_DELIVER          = 8032,  -- Take that medicine over quick as you can now, dearie. Wouldn't want it to go bad.
        FFR_BLENDARE                   = 8106,  -- Wait! If I had magic, maybe I could keep my brother's hands off my sweets...
        RAMINEL_DELIVERY               = 8110,  -- Here's your delivery!
        RAMINEL_DELIVERIES             = 8112,  -- Sorry, I have deliveries to make!
        SHILAH_SHOP_DIALOG             = 8127,  -- Welcome, weary traveler. Make yourself at home!
        VALERIANO_SHOP_DIALOG          = 8145,  -- Oh, a fellow outsider! We are Troupe Valeriano. I am Valeriano, at your service!
        FERDOULEMIONT_SHOP_DIALOG      = 8161,  -- Hello!
        CLETAE_DIALOG                  = 8213,  -- Why, hello. All our skins are guild-approved.
        KUEH_IGUNAHMORI_DIALOG         = 8214,  -- Good day! We have lots in stock today.
        SOBANE_DIALOG                  = 8232,  -- My name is Sobane, and I'm sharpening my knives.
        PAUNELIE_DIALOG                = 8322,  -- I'm sorry, can I help you?
        PAUNELIE_SHOP_DIALOG           = 8327,  -- These magic shells are full of mysteries...
        ITEM_DELIVERY_DIALOG           = 8422,  -- Parcels delivered to rooms anywhere in Vana'diel!
        MACHIELLE_OPEN_DIALOG          = 8428,  -- Might I interest you in produce from Norvallen?
        CORUA_OPEN_DIALOG              = 8429,  -- Ronfaure produce for sale!
        PHAMELISE_OPEN_DIALOG          = 8430,  -- I've got fresh produce from Zulkheim!
        APAIREMANT_OPEN_DIALOG         = 8431,  -- Might you be interested in produce from Gustaberg
        RAIMBROYS_SHOP_DIALOG          = 8432,  -- Welcome to Raimbroy's Grocery!
        CARAUTIA_SHOP_DIALOG           = 8434,  -- Well, what sort of armor would you like?
        MACHIELLE_CLOSED_DIALOG        = 8435,  -- We want to sell produce from Norvallen, but the entire region is under foreign control!
        CORUA_CLOSED_DIALOG            = 8436,  -- We specialize in Ronfaure produce, but we cannot import from that region without a strong San d'Orian presence there.
        PHAMELISE_CLOSED_DIALOG        = 8437,  -- I'd be making a killing selling produce from Zulkheim, but the region's under foreign control!
        APAIREMANT_CLOSED_DIALOG       = 8438,  -- I'd love to import produce from Gustaberg, but the foreign powers in control there make me feel unsafe!
        POURETTE_OPEN_DIALOG           = 8439,  -- Derfland produce for sale!
        POURETTE_CLOSED_DIALOG         = 8440,  -- Listen, adventurer... I can't import from Derfland until the region knows San d'Orian power!
        CONQUEST                       = 8497,  -- You've earned conquest points!
        FLYER_ACCEPTED                 = 8842,  -- The flyer is accepted.
        FLYER_ALREADY                  = 8843,  -- This person already has a flyer.
        FFR_LOOKS_CURIOUSLY_BASE       = 8844,  -- Blendare looks over curiously for a moment.
        FFR_MAUGIE                     = 8846,  -- A magic shop, eh? Hmm... A little magic could go a long way for making a leisurely retirement! Ho ho ho!
        FFR_ADAUNEL                    = 8848,  -- A magic shop? Maybe I'll check it out one of these days. Could help with my work, even...
        FFR_LEUVERET                   = 8850,  -- A magic shop? That'd be a fine place to peddle my wares. I smell a profit! I'll be up to my gills in gil, I will!
        LUSIANE_THANK                  = 8893,  -- Thank you! My snoring will express gratitude mere words cannot! Here's something for you in return.
        IMPULSE_DRIVE_LEARNED          = 9330,  -- You have learned the weapon skill Impulse Drive!
        CLOUD_BAD_COUNT                = 10118, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE               = 10122, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                 = 10123, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CAPUCINE_SHOP_DIALOG           = 10324, -- Hello! You seem to be working very hard. I'm really thankful! But you needn't rush around so fast. Take your time! I can wait if it makes the job easier for you!
        CHOCOBO_FEEDING_SLEEP          = 10719, -- Your chocobo is sleeping soundly. You cannot feed it now.
        CHOCOBO_FEEDING_RUN_AWAY       = 10720, -- Your chocobo has run away. You cannot feed it now.
        CHOCOBO_FEEDING_STILL_EGG      = 10721, -- You cannot feed a chocobo that has not hatched yet.
        CHOCOBO_FEEDING_ITEM           = 11804, -- #: %
        TUTORIAL_NPC                   = 13530, -- Greetings and well met! Guardian of the Kingdom, Alaune, at your most humble service.
        YOU_WISH_TO_EXCHANGE_SPARKS    = 15384, -- You wish to exchange your sparks?
        DO_NOT_POSSESS_ENOUGH          = 15413, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS              = 15414, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED       = 15415, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY      = 15425, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY          = 15965, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY     = 16041, -- ou have already changed Unities. Please wait until the next tabulation period.
        TEAR_IN_FABRIC_OF_SPACE        = 16502, -- There appears to be a tear in the fabric of space...
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
        LUSIANE  = 17719350,
        ARPETION = 17719409,
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA]
