-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SOUTHERN_SAN_DORIA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389,  -- Obtained: <item>.
        GIL_OBTAINED            = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MOG_LOCKER_OFFSET       = 7369,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7626,  -- Current training regime canceled.
        HUNT_ACCEPTED           = 7644,  -- Hunt accepted!
        USE_SCYLDS              = 7645,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7656,  -- You record your hunt.
        OBTAIN_SCYLDS           = 7658,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7662,  -- Hunt canceled.
        WYATT_DIALOG            = 11088, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11118, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11219, -- If'n ye have goods tae deliver, then Nembet be yer man!
        ALLIED_SIGIL            = 12920, -- You have received the Allied Sigil!
        DOOR_IS_FIRMLY_LOCKED   = 13546, -- The door is firmly locked...
        RETRIEVE_DIALOG_ID      = 15583, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15657, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.SOUTHERN_SAN_DORIA_S]
