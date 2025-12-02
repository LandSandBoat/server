-----------------------------------
-- Area: Kazham
-----------------------------------
zones = zones or {}

zones[xi.zone.KAZHAM] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6430,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6431,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6432,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6452,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6498,  -- Home point set!
        CONQUEST_BASE                 = 6518,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 6677,  -- You can't fish here.
        REGIME_CANCELED               = 6838,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 6856,  -- Hunt accepted!
        USE_SCYLDS                    = 6857,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 6868,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 6870,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 6874,  -- Hunt canceled.
        ITEM_DELIVERY_DIALOG          = 9977,  -- We can deliver packages to Mog Houses anywhere in Vana'diel.
        NOT_ENOUGH_GIL                = 9993,  -- You don't have enough gil.
        PAHYALOLOHOIV_SHOP_DIALOG     = 10039, -- Nothing in this world is crrreated good or evil. However, evil can arrrise when something exists in a place where it did not originally belong.
        TOJIMUMOSULAH_SHOP_DIALOG     = 10041, -- Things meant to live will live. Things meant to die will die when their time has come. However, this does not mean you should cease your strrruggle for life.
        GHEMISENTERILO_SHOP_DIALOG    = 10063, -- Can you really get everything that you want on the mainland?
        NUHCELODENKI_SHOP_DIALOG      = 10065, -- When you die, you can't take anything with you, but what fun is life if you don't have anything to live it up with?
        KHIFORYUHKOWA_SHOP_DIALOG     = 10066, -- Sometimes a strrrange Hume comes from the south to buy stuff. I wonder what he's doing down there...
        TAHNPOSBEI_SHOP_DIALOG        = 10067, -- You don't want to get whipped by those Tonberries, do you? Well, have I got the equipment forrr you!
        OPO_OPO                       = 10395, -- Opo-opo!
        IFRIT_UNLOCKED                = 10539, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG           = 10610, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        MAMERIE_SHOP_DIALOG           = 10634, -- Is there something you require?
        EVISCERATION_LEARNED          = 10671, -- You have learned the weapon skill Evisceration!
        SUSPICIOUS_CHARACTERS         = 10690, -- It's my job to look out for suspicious characters coming in on the airships.
        RETRIEVE_DIALOG_ID            = 11021, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL         = 11879, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        MAGRIFFON = GetFirstID('Magriffon'),
        TIELLEQUE = GetFirstID('Tielleque'),
    },
}

return zones[xi.zone.KAZHAM]
