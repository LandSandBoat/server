-----------------------------------
-- Area: Southern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SOUTHERN_SAN_DORIA] =
{
    text =
    {
        HOMEPOINT_SET                  = 24, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED        = 6426, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6430, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6432, -- Obtained: <item>.
        GIL_OBTAINED                   = 6433, -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6435, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6436, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6437, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY        = 6446, -- There is nothing out of the ordinary here.
        YOU_LEARNED_TRUST              = 6495, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO        = 6496, -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET              = 6673, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        LEATHER_SUPPORT                = 6775, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT       = 6789, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 6797, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 6804, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 6809, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 6810, -- You do not have enough guild points.
        CONQUEST_BASE                  = 7032, -- Tallying conquest results...
        YOU_ACCEPT_THE_MISSION         = 7196, -- You accept the mission.
        ORIGINAL_MISSION_OFFSET        = 7207, -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        TRICK_OR_TREAT                 = 7355, -- Trick or treat...
        THANK_YOU_TREAT                = 7356, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 7357, -- Here, take this...
        IF_YOU_WEAR_THIS               = 7358, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 7359, -- Thank you...
        NOKKHI_BAD_COUNT               = 7377, -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE              = 7379, -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM                = 7380, -- I'm real sorry, but there's nothing I can do with those.
        YOU_CANNOT_ENTER_DYNAMIS       = 7414, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7416, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7426, -- There is an unusual arrangement of branches here.
        VARCHET_BET_LOST               = 7757, -- You lose your bet of 5 gil.
        VARCHET_KEEP_PROMISE           = 7766, -- As promised, I shall go and see about those woodchippers. Maybe we can play another game later.
        FFR_ROSEL                      = 7786, -- Hrmm... Now, this is interesting! It pays to keep an eye on the competition. Thanks for letting me know!
        LUSIANE_SHOP_DIALOG            = 7960, -- Hello! Let Taumila's handle all your sundry needs!
        OSTALIE_SHOP_DIALOG            = 7961, -- Welcome, customer. Please have a look.
        ASH_THADI_ENE_SHOP_DIALOG      = 7982, -- Welcome to Helbort's Blades!
        UNLOCK_PALADIN                 = 8009, -- You can now become a paladin!
        FFR_BLENDARE                   = 8093, -- Wait! If I had magic, maybe I could keep my brother's hands off my sweets...
        RAMINEL_DELIVERY               = 8097, -- Here's your delivery!
        RAMINEL_DELIVERIES             = 8099, -- Sorry, I have deliveries to make!
        SHILAH_SHOP_DIALOG             = 8114, -- Welcome, weary traveler. Make yourself at home!
        VALERIANO_SHOP_DIALOG          = 8132, -- Oh, a fellow outsider! We are Troupe Valeriano. I am Valeriano, at your service!
        FERDOULEMIONT_SHOP_DIALOG      = 8148, -- Hello!
        CLETAE_DIALOG                  = 8200, -- Why, hello. All our skins are guild-approved.
        KUEH_IGUNAHMORI_DIALOG         = 8201, -- Good day! We have lots in stock today.
        PAUNELIE_DIALOG                = 8309, -- I'm sorry, can I help you?
        PAUNELIE_SHOP_DIALOG           = 8314, -- These magic shells are full of mysteries...
        ITEM_DELIVERY_DIALOG           = 8409, -- Parcels delivered to rooms anywhere in Vana'diel!
        MACHIELLE_OPEN_DIALOG          = 8415, -- Might I interest you in produce from Norvallen?
        CORUA_OPEN_DIALOG              = 8416, -- Ronfaure produce for sale!
        PHAMELISE_OPEN_DIALOG          = 8417, -- I've got fresh produce from Zulkheim!
        APAIREMANT_OPEN_DIALOG         = 8418, -- Might you be interested in produce from Gustaberg
        AVELINE_SHOP_DIALOG            = 8419, -- Welcome to Raimbroy's Grocery!
        MIOGIQUE_SHOP_DIALOG           = 8420, -- Looking for something in particular?
        BENAIGE_SHOP_DIALOG            = 8420, -- Looking for something in particular?
        CARAUTIA_SHOP_DIALOG           = 8421, -- Well, what sort of armor would you like?
        MACHIELLE_CLOSED_DIALOG        = 8422, -- We want to sell produce from Norvallen, but the entire region is under foreign control!
        CORUA_CLOSED_DIALOG            = 8423, -- We specialize in Ronfaure produce, but we cannot import from that region without a strong San d'Orian presence there.
        PHAMELISE_CLOSED_DIALOG        = 8424, -- I'd be making a killing selling produce from Zulkheim, but the region's under foreign control!
        APAIREMANT_CLOSED_DIALOG       = 8425, -- I'd love to import produce from Gustaberg, but the foreign powers in control there make me feel unsafe!
        POURETTE_OPEN_DIALOG           = 8426, -- Derfland produce for sale!
        POURETTE_CLOSED_DIALOG         = 8427, -- Listen, adventurer... I can't import from Derfland until the region knows San d'Orian power!
        CONQUEST                       = 8484, -- You've earned conquest points!
        FLYER_ACCEPTED                 = 8829, -- The flyer is accepted.
        FLYER_ALREADY                  = 8830, -- This person already has a flyer.
        FFR_LOOKS_CURIOUSLY_BASE       = 8831, -- Blendare looks over curiously for a moment.
        FFR_MAUGIE                     = 8833, -- A magic shop, eh? Hmm... A little magic could go a long way for making a leisurely retirement! Ho ho ho!
        FFR_ADAUNEL                    = 8835, -- A magic shop? Maybe I'll check it out one of these days. Could help with my work, even...
        FFR_LEUVERET                   = 8837, -- A magic shop? That'd be a fine place to peddle my wares. I smell a profit! I'll be up to my gills in gil, I will!
        LUSIANE_THANK                  = 8880, -- Thank you! My snoring will express gratitude mere words cannot! Here's something for you in return.
        IMPULSE_DRIVE_LEARNED          = 9317, -- You have learned the weapon skill Impulse Drive!
        CLOUD_BAD_COUNT                = 10105, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE               = 10109, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                 = 10110, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CAPUCINE_SHOP_DIALOG           = 10311, -- Hello! You seem to be working very hard. I'm really thankful! But you needn't rush around so fast. Take your time! I can wait if it makes the job easier for you!
        TUTORIAL_NPC                   = 13517, -- Greetings and well met! Guardian of the Kingdom, Alaune, at your most humble service.
        TEAR_IN_FABRIC_OF_SPACE        = 16552, -- There appears to be a tear in the fabric of space...
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

return zones[tpz.zone.SOUTHERN_SAN_DORIA]
