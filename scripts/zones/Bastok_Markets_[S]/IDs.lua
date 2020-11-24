-----------------------------------
-- Area: Bastok_Markets_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BASTOK_MARKETS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET   = 7049, -- You can't fish here.
        BLINGBRIX_SHOP_DIALOG    = 7199, -- Blingbrix good Gobbie from Boodlix's! Boodlix's Emporium help fighting fighters and maging mages. Gil okay, okay?
        MOG_LOCKER_OFFSET        = 7465, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED          = 7703, -- Current training regime canceled.
        HUNT_ACCEPTED            = 7721, -- Hunt accepted!
        USE_SCYLDS               = 7722, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 7733, -- You record your hunt.
        OBTAIN_SCYLDS            = 7735, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 7739, -- Hunt canceled.
        HOMEPOINT_SET            = 10832, -- Home point set!
        KARLOTTE_DELIVERY_DIALOG = 10866, -- I am here to help with all your parcel delivery needs.
        WELDON_DELIVERY_DIALOG   = 10867, -- Do you have something you wish to send?
        ALLIED_SIGIL             = 12355, -- You have received the Allied Sigil!
        SILKE_SHOP_DIALOG        = 12807, -- You wouldn't happen to be a fellow scholar, by any chance? The contents of these pages are beyond me, but perhaps you might glean something from them. They could be yours...for a nominal fee.
        RETRIEVE_DIALOG_ID       = 14719, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 14788, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.BASTOK_MARKETS_S]
