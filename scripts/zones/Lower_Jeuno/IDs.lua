-----------------------------------
-- Area: Lower_Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.LOWER_JEUNO] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400,  -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6431,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6434,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6435,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6436,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6456,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6541,  -- Home point set!
        CONQUEST_BASE                 = 6566,  -- Tallying conquest results...
        MOG_LOCKER_OFFSET             = 6835,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET        = 6950,  -- You can't fish here.
        MYTHIC_LEARNED                = 7157,  -- You have learned the weapon skill [Nothing/King's Justice/Ascetic's Fury/Mystic Boon/Vidohunir/Death Blossom/Mandalic Stab/Atonement/Insurgency/Primal Rend/Mordant Rime/Trueflight/Tachi: Rana/Blade: Kamu/Drakesbane/Garland of Bliss/Expiacion/Leaden Salute/Stringing Pummel/Pyrrhic Kleos/Omniscience]!
        JUNK_SHOP_DIALOG              = 7158,  -- Hey, how ya doin'? We got the best junk in town.
        WAAG_DEEG_SHOP_DIALOG         = 7159,  -- Welcome to Waag-Deeg's Magic Shop.
        ORTHONS_GARMENT_SHOP_DIALOG   = 7160,  -- Welcome to Othon's Garments.
        YOSKOLO_SHOP_DIALOG           = 7161,  -- Welcome to the Merry Minstrel's Meadhouse. What'll it be?
        GEMS_BY_KSHAMA_SHOP_DIALOG    = 7162,  -- Here at Gems by Kshama, we aim to please.
        RHIMONNE_SHOP_DIALOG          = 7165,  -- Howdy! Thanks for visiting the Chocobo Shop!
        GUIDE_STONE                   = 7167,  -- Up: Upper Jeuno (facing San d'Oria) Down: Port Jeuno (facing Windurst)
        ALDO_DIALOG                   = 7172,  -- Hi. I'm Aldo, head of Tenshodo. We deal in things you can't buy anywhere else. Take your time and have a look around.
        YOU_RETURN_THE                = 7253,  -- You return the <keyitem>.
        THE_LAMPS_WERE_LIT_BY         = 7271,  -- The lamps were lit by <player> today. If you happen to run across the person who took time out to bring light to our city, don't forget to say a word of thanks.
        VHANA_DEFAULT                 = 7272,  -- Sorry. I'm busy.
        YOU_LIGHT_THE_LAMP            = 7275,  -- You light the lamp.
        LAMP_MSG_OFFSET               = 7276,  -- All the lamps are lit.
        ZAUKO_IS_RECRUITING           = 7284,  -- Zauko is recruiting an adventurer to light the lamps.
        CHOCOBO_DIALOG                = 7346,  -- Hmph.
        LOVE_ROMANCE                  = 7426,  -- Love... Romance... It's all fake! Cursed women are like measles!
        MERTAIRE_MALLIEBELL_LEFT      = 7427,  -- Ugh... Malliebell... This time she's left me forever...
        MERTAIRE_DEFAULT              = 7452,  -- Who are you? Leave me alone!
        COULD_HE_BE                   = 7462,  -- Wait, could he be...? Naw, he couldn't be.
        ITS_LOCKED                    = 7614,  -- It's locked.
        PAWKRIX_SHOP_DIALOG           = 7662,  -- Hey, we're fixin' up some stew. Gobbie food's good food!
        PACKAGE_DELIVERED             = 7700,  -- You have completed your delivery of the <keyitem>.
        DAMANGED_PACKAGE_DELIVERED    = 7701,  -- Due to extensive damage, the <keyitem> are thrown away.
        AMALASANDA_SHOP_DIALOG        = 7710,  -- Welcome to the Tenshodo. You want something, we got it. We got all kinds of special merchandise you won't find anywhere else!
        AKAMAFULA_SHOP_DIALOG         = 7711,  -- We ain't cheap, but you get what you pay for! Take your time, have a look around, see if there's somethin' you like.
        DO_NOT_DISTURB                = 7767,  -- Do Not Disturb
        INVENTORY_INCREASED           = 7809,  -- Your inventory capacity has increased.
        ITEM_DELIVERY_DIALOG          = 7810,  -- Now offering quick and easy delivery of packages to residences everywhere!
        YIN_POCANAKHU_GET_LOST        = 8023,  -- Hey, what are you tryin' to pull? Get lost!
        MERTAIRE_RING                 = 8071,  -- So, what did you do with that ring? Maybe it's valuable. I'd ask a collector if I were you. Of course, he might just say it's worthless...
        CONQUEST                      = 8083,  -- You've earned conquest points!
        PAY_FAURSEL                   = 9587,  -- You pay Faursel <number> gil!
        NO_KEY                        = 9933,  -- You do not have a usable key in your possession.
        RETRIEVE_DIALOG_ID            = 10213, -- You retrieve <item> from the porter moogle's care.
        WAYPOINT_EXAMINE              = 10374, -- An enigmatic contrivance hovers in silence...
        EXPENDED_KINETIC_UNITS        = 10377, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 10378, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 10379, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 10380, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 10381, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 10382, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 10383, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
    },
    mob =
    {
    },
    npc =
    {
        VHANA_EHGAKLYWHA  = GetFirstID('Vhana_Ehgaklywha'),
        STREETLAMP_OFFSET = GetFirstID('_l00'),
        ZAUKO             = GetFirstID('Zauko'),
    },
}

return zones[xi.zone.LOWER_JEUNO]
