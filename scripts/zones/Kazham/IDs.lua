-----------------------------------
-- Area: Kazham
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.KAZHAM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED              = 6389,  -- Obtained: <item>.
        GIL_OBTAINED               = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS        = 6428,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 6429,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 6430,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET              = 6486,  -- Home point set!
        CONQUEST_BASE              = 6506,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET     = 6665,  -- You can't fish here.
        REGIME_CANCELED            = 6826,  -- Current training regime canceled.
        HUNT_ACCEPTED              = 6844,  -- Hunt accepted!
        USE_SCYLDS                 = 6845,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED              = 6856,  -- You record your hunt.
        OBTAIN_SCYLDS              = 6858,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED              = 6862,  -- Hunt canceled.
        ITEM_DELIVERY_DIALOG       = 9965,  -- We can deliver packages to Mog Houses anywhere in Vana'diel.
        PAHYALOLOHOIV_SHOP_DIALOG  = 10027, -- Nothing in this world is crrreated good or evil. However, evil can arrrise when something exists in a place where it did not originally belong.
        TOJIMUMOSULAH_SHOP_DIALOG  = 10029, -- Things meant to live will live. Things meant to die will die when their time has come. However, this does not mean you should cease your strrruggle for life.
        GHEMISENTERILO_SHOP_DIALOG = 10051, -- Can you really get everything that you want on the mainland?
        NUHCELODENKI_SHOP_DIALOG   = 10053, -- When you die, you can't take anything with you, but what fun is life if you don't have anything to live it up with?
        KHIFORYUHKOWA_SHOP_DIALOG  = 10054, -- Sometimes a strrrange Hume comes from the south to buy stuff. I wonder what he's doing down there...
        TAHNPOSBEI_SHOP_DIALOG     = 10055, -- You don't want to get whipped by those Tonberries, do you? Well, have I got the equipment forrr you!
        IFRIT_UNLOCKED             = 10524, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG        = 10592, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        MAMERIE_SHOP_DIALOG        = 10616, -- Is there something you require?
        EVISCERATION_LEARNED       = 10653, -- You have learned the weapon skill Evisceration!
        RETRIEVE_DIALOG_ID         = 11003, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL      = 11861, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.KAZHAM]
