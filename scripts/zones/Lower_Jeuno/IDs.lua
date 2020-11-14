-----------------------------------
-- Area: Lower_Jeuno
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LOWER_JEUNO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6393, -- You do not have enough gil.
        HOMEPOINT_SET           = 6517, -- Home point set!
        CONQUEST_BASE           = 6542, -- Tallying conquest results...
        MOG_LOCKER_OFFSET       = 6811, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET  = 6926, -- You can't fish here.
        MYTHIC_LEARNED          = 7132, -- You have learned the weapon skill [Nothing/King's Justice/Ascetic's Fury/Mystic Boon/Vidohunir/Death Blossom/Mandalic Stab/Atonement/Insurgency/Primal Rend/Mordant Rime/Trueflight/Tachi: Rana/Blade: Kamu/Drakesbane/Garland of Bliss/Expiacion/Leaden Salute/Stringing Pummel/Pyrrhic Kleos/Omniscience]!
        STINKNIX_SHOP_DIALOG    = 7133, -- Hey, how ya doin'? We got the best junk in town.
        CREEPSTIX_SHOP_DIALOG   = 7133, -- Hey, how ya doin'? We got the best junk in town.
        SUSU_SHOP_DIALOG        = 7134, -- Welcome to Waag-Deeg's Magic Shop.
        TAZA_SHOP_DIALOG        = 7134, -- Welcome to Waag-Deeg's Magic Shop.
        HASIM_SHOP_DIALOG       = 7134, -- Welcome to Waag-Deeg's Magic Shop.
        CHETAK_SHOP_DIALOG      = 7135, -- Welcome to Othon's Garments.
        CHENOKIH_SHOP_DIALOG    = 7135, -- Welcome to Othon's Garments.
        YOSKOLO_SHOP_DIALOG     = 7136, -- Welcome to the Merry Minstrel's Meadhouse. What'll it be?
        ADELFLETE_SHOP_DIALOG   = 7137, -- Here at Gems by Kshama, we aim to please.
        MOREFIE_SHOP_DIALOG     = 7137, -- Here at Gems by Kshama, we aim to please.
        MATOAKA_SHOP_DIALOG     = 7137, -- Here at Gems by Kshama, we aim to please.
        RHIMONNE_SHOP_DIALOG    = 7140, -- Howdy! Thanks for visiting the Chocobo Shop!
        GUIDE_STONE             = 7142, -- Up: Upper Jeuno (facing San d'Oria) Down: Port Jeuno (facing Windurst)
        ALDO_DIALOG             = 7147, -- Hi. I'm Aldo, head of Tenshodo. We deal in things you can't buy anywhere else. Take your time and have a look around.
        LAMP_MSG_OFFSET         = 7251, -- All the lamps are lit.
        ZAUKO_IS_RECRUITING     = 7259, -- Zauko is recruiting an adventurer to light the lamps.
        CHOCOBO_DIALOG          = 7321, -- Hmph.
        MERTAIRE_DEFAULT        = 7427, -- Who are you? Leave me alone!
        ITS_LOCKED              = 7589, -- It's locked.
        PAWKRIX_SHOP_DIALOG     = 7637, -- Hey, we're fixin' up some stew. Gobbie food's good food!
        AMALASANDA_SHOP_DIALOG  = 7685, -- Welcome to the Tenshodo. You want something, we got it. We got all kinds of special merchandise you won't find anywhere else!
        AKAMAFULA_SHOP_DIALOG   = 7686, -- We ain't cheap, but you get what you pay for! Take your time, have a look around, see if there's somethin' you like.
        INVENTORY_INCREASED     = 7784, -- Your inventory capacity has increased.
        ITEM_DELIVERY_DIALOG    = 7785, -- Now offering quick and easy delivery of packages to residences everywhere!
        MERTAIRE_RING           = 8046, -- So, what did you do with that ring? Maybe it's valuable. I'd ask a collector if I were you. Of course, he might just say it's worthless...
        CONQUEST                = 8058, -- You've earned conquest points!
        PARIKE_PORANKE_DIALOG   = 8956, -- All these people running back and forth... There have to be a few that have munched down more mithkabobs than they can manage. (And if I don't hand in this report to the Orastery soon... Ulp!)
        PARIKE_PORANKE_1        = 8957, -- Hey you! Belly bursting? Intestines inflating? Bladder bulging? I can tell by the notch on your belt that you've been overindulging yourself in culinary delights.
        PARIKE_PORANKE_2        = 8960, -- I mean, this is a new era. If somebody wants to go around with their flabby-flubber hanging out of their cloaks, they should have every right to do so. If someone wants to walk around town with breath reeking of Kazham pines and roasted sleepshrooms, who am I to stop them?
        PARIKE_PORANKE_3        = 8961, -- What? You want me to tend to your tummy trouble? No problem! And don't worry, this won't hurt at all! I'm only going to be flushing your bowels with thousands of tiny lightning bolts. It's all perfectly safe!
        PARIKE_PORANKE_4        = 8962, -- Now stand still! You wouldn't want your pelvis to implode, would you? (Let's see... What were those magic words again...?)
        PARIKE_PORANKE_5        = 8963, -- Ready? No? Well, too bad!
        PARIKE_PORANKE_6        = 8971, -- 's digestive magic skill rises 0.1 points.
        PARIKE_PORANKE_7        = 8972, -- 's digestive magic skill rises one level.
        PARIKE_PORANKE_8        = 8973, -- Heh heh! I think I'm starting to get the hang of this spellcasting.
        PARIKE_PORANKE_9        = 8974, -- Consider this a petite present from your pal Parike-Poranke!
        PARIKE_PORANKE_10       = 8978, -- Wait a minute... Don't tell me you came to Parike-Poranke on an empty stomach! This is terrible! The minister will have my head!
        PARIKE_PORANKE_12       = 8980, -- Phew! That was close... What were you thinking, crazy adventurer!?
        PARIKE_PORANKE_13       = 8983, -- 's all in the name of science skill rises 0.1 points.
        PARIKE_PORANKE_14       = 8984, -- 's all in the name of science skill rises one level.
        PARIKE_PORANKE_15       = 8985, -- You know, I've learned a lot from my mist--er, I mean, less-than-successful attempts at weight-loss consulting.
        PARIKE_PORANKE_16       = 8986, -- To show you my gratitude, let me try out this new spell I thought up yesterday while I was taking a nap!
        NO_KEY                  = 9908, -- You do not have a usable key in your possession.
        RETRIEVE_DIALOG_ID      = 10188, -- You retrieve <item> from the porter moogle's care.
        WAYPOINT_EXAMINE        = 10347, -- An enigmatic contrivance hovers in silence...
    },
    mob =
    {
    },
    npc =
    {
        VHANA_EHGAKLYWHA  = 17780880,
        STREETLAMP_OFFSET = 17780881,
    },
}

return zones[tpz.zone.LOWER_JEUNO]
