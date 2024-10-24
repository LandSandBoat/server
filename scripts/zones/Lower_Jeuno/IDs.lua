-----------------------------------
-- Area: Lower_Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.LOWER_JEUNO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395,  -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6426,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6429,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6430,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6431,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6451,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6532,  -- Home point set!
        CONQUEST_BASE                 = 6557,  -- Tallying conquest results...
        MOG_LOCKER_OFFSET             = 6826,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET        = 6941,  -- You can't fish here.
        MYTHIC_LEARNED                = 7147,  -- You have learned the weapon skill [Nothing/King's Justice/Ascetic's Fury/Mystic Boon/Vidohunir/Death Blossom/Mandalic Stab/Atonement/Insurgency/Primal Rend/Mordant Rime/Trueflight/Tachi: Rana/Blade: Kamu/Drakesbane/Garland of Bliss/Expiacion/Leaden Salute/Stringing Pummel/Pyrrhic Kleos/Omniscience]!
        JUNK_SHOP_DIALOG              = 7148,  -- Hey, how ya doin'? We got the best junk in town.
        WAAG_DEEG_SHOP_DIALOG         = 7149,  -- Welcome to Waag-Deeg's Magic Shop.
        ORTHONS_GARMENT_SHOP_DIALOG   = 7150,  -- Welcome to Othon's Garments.
        YOSKOLO_SHOP_DIALOG           = 7151,  -- Welcome to the Merry Minstrel's Meadhouse. What'll it be?
        GEMS_BY_KSHAMA_SHOP_DIALOG    = 7152,  -- Here at Gems by Kshama, we aim to please.
        RHIMONNE_SHOP_DIALOG          = 7155,  -- Howdy! Thanks for visiting the Chocobo Shop!
        GUIDE_STONE                   = 7157,  -- Up: Upper Jeuno (facing San d'Oria) Down: Port Jeuno (facing Windurst)
        ALDO_DIALOG                   = 7162,  -- Hi. I'm Aldo, head of Tenshodo. We deal in things you can't buy anywhere else. Take your time and have a look around.
        LAMP_MSG_OFFSET               = 7266,  -- All the lamps are lit.
        ZAUKO_IS_RECRUITING           = 7274,  -- Zauko is recruiting an adventurer to light the lamps.
        CHOCOBO_DIALOG                = 7336,  -- Hmph.
        MERTAIRE_MALLIEBELL_LEFT      = 7417,  -- Ugh... Malliebell... This time she's left me forever...
        MERTAIRE_DEFAULT              = 7442,  -- Who are you? Leave me alone!
        ITS_LOCKED                    = 7604,  -- It's locked.
        PAWKRIX_SHOP_DIALOG           = 7652,  -- Hey, we're fixin' up some stew. Gobbie food's good food!
        AMALASANDA_SHOP_DIALOG        = 7700,  -- Welcome to the Tenshodo. You want something, we got it. We got all kinds of special merchandise you won't find anywhere else!
        AKAMAFULA_SHOP_DIALOG         = 7701,  -- We ain't cheap, but you get what you pay for! Take your time, have a look around, see if there's somethin' you like.
        INVENTORY_INCREASED           = 7799,  -- Your inventory capacity has increased.
        ITEM_DELIVERY_DIALOG          = 7800,  -- Now offering quick and easy delivery of packages to residences everywhere!
        MERTAIRE_RING                 = 8061,  -- So, what did you do with that ring? Maybe it's valuable. I'd ask a collector if I were you. Of course, he might just say it's worthless...
        CONQUEST                      = 8073,  -- You've earned conquest points!
        PARIKE_PORANKE_DIALOG         = 8971,  -- All these people running back and forth... There have to be a few that have munched down more mithkabobs than they can manage. (And if I don't hand in this report to the Orastery soon... Ulp!)
        PARIKE_PORANKE_1              = 8972,  -- Hey you! Belly bursting? Intestines inflating? Bladder bulging? I can tell by the notch on your belt that you've been overindulging yourself in culinary delights.
        PARIKE_PORANKE_2              = 8975,  -- I mean, this is a new era. If somebody wants to go around with their flabby-flubber hanging out of their cloaks, they should have every right to do so. If someone wants to walk around town with breath reeking of Kazham pines and roasted sleepshrooms, who am I to stop them?
        PARIKE_PORANKE_3              = 8976,  -- What? You want me to tend to your tummy trouble? No problem! And don't worry, this won't hurt at all! I'm only going to be flushing your bowels with thousands of tiny lightning bolts. It's all perfectly safe!
        PARIKE_PORANKE_4              = 8977,  -- Now stand still! You wouldn't want your pelvis to implode, would you? (Let's see... What were those magic words again...?)
        PARIKE_PORANKE_5              = 8978,  -- Ready? No? Well, too bad!
        PARIKE_PORANKE_6              = 8986,  -- 's digestive magic skill rises 0.1 points.
        PARIKE_PORANKE_7              = 8987,  -- 's digestive magic skill rises one level.
        PARIKE_PORANKE_8              = 8988,  -- Heh heh! I think I'm starting to get the hang of this spellcasting.
        PARIKE_PORANKE_9              = 8989,  -- Consider this a petite present from your pal Parike-Poranke!
        PARIKE_PORANKE_10             = 8993,  -- Wait a minute... Don't tell me you came to Parike-Poranke on an empty stomach! This is terrible! The minister will have my head!
        PARIKE_PORANKE_12             = 8995,  -- Phew! That was close... What were you thinking, crazy adventurer!?
        PARIKE_PORANKE_13             = 8998,  -- 's all in the name of science skill rises 0.1 points.
        PARIKE_PORANKE_14             = 8999,  -- 's all in the name of science skill rises one level.
        PARIKE_PORANKE_15             = 9000,  -- You know, I've learned a lot from my mist--er, I mean, less-than-successful attempts at weight-loss consulting.
        PARIKE_PORANKE_16             = 9001,  -- To show you my gratitude, let me try out this new spell I thought up yesterday while I was taking a nap!
        NO_KEY                        = 9923,  -- You do not have a usable key in your possession.
        RETRIEVE_DIALOG_ID            = 10203, -- You retrieve <item> from the porter moogle's care.
        WAYPOINT_EXAMINE              = 10364, -- An enigmatic contrivance hovers in silence...
        EXPENDED_KINETIC_UNITS        = 10367, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 10368, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 10369, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 10370, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 10371, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 10372, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 10373, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        NO_NEED_TO_HURRY              = 11021, -- Now, now... There's no need to be in such a hurry. Simply hear me out for a moment.
        CANT_CARRY_ANY_MORE           = 11065, -- Um... I'm sorry, but you can't carry any more. Would you like to exchange some for an orb or two?
        ALREADY_BEEN_USED_ORB         = 11066, -- This one has already been used. Perhaps I can offer you a free one to satiate your lust for treasures. Here you are--a freshly charged <item>.
        ALREADY_BEEN_USED_ITEM        = 11067, -- This one has already been used. I'll give you a freebie, okay? Here. <item>.
        THIS_ONE_HASNT_BEEN_USED      = 11068, -- Oh, this one hasn't been used yet. Nothing I can do with it.
    },
    mob =
    {
    },
    npc =
    {
        VHANA_EHGAKLYWHA  = GetFirstID('Vhana_Ehgaklywha'),
        STREETLAMP_OFFSET = GetFirstID('_l00'),
    },
}

return zones[xi.zone.LOWER_JEUNO]
