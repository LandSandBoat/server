-----------------------------------
-- Area: Bastok_Markets_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BASTOK_MARKETS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389,  -- Obtained: <item>.
        GIL_OBTAINED             = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS      = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET   = 7053,  -- You can't fish here.
        BLINGBRIX_SHOP_DIALOG    = 7203,  -- Blingbrix good Gobbie from Boodlix's! Boodlix's Emporium help fighting fighters and maging mages. Gil okay, okay?
        MOG_LOCKER_OFFSET        = 7469,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED          = 7707,  -- Current training regime canceled.
        HUNT_ACCEPTED            = 7725,  -- Hunt accepted!
        USE_SCYLDS               = 7726,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 7737,  -- You record your hunt.
        OBTAIN_SCYLDS            = 7739,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 7743,  -- Hunt canceled.
        HOMEPOINT_SET            = 10836, -- Home point set!
        KARLOTTE_DELIVERY_DIALOG = 10870, -- I am here to help with all your parcel delivery needs.
        WELDON_DELIVERY_DIALOG   = 10871, -- Do you have something you wish to send?
        ALLIED_SIGIL             = 12359, -- You have received the Allied Sigil!
        SILKE_SHOP_DIALOG        = 12811, -- You wouldn't happen to be a fellow scholar, by any chance? The contents of these pages are beyond me, but perhaps you might glean something from them. They could be yours...for a nominal fee.
        RETRIEVE_DIALOG_ID       = 14723, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 14792, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.BASTOK_MARKETS_S]
