-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SOUTHERN_SAN_DORIA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MOG_LOCKER_OFFSET       = 7365, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7622, -- Current training regime canceled.
        HUNT_ACCEPTED           = 7640, -- Hunt accepted!
        USE_SCYLDS              = 7641, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7652, -- You record your hunt.
        OBTAIN_SCYLDS           = 7654, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7658, -- Hunt canceled.
        WYATT_DIALOG            = 11084, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11114, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11215, -- If'n ye have goods tae deliver, then Nembet be yer man!
        ALLIED_SIGIL            = 12916, -- You have received the Allied Sigil!
        RETRIEVE_DIALOG_ID      = 15579, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15653, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.SOUTHERN_SAN_DORIA_S]
