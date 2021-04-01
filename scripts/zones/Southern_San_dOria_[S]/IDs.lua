-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.SOUTHERN_SAN_DORIA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MOG_LOCKER_OFFSET       = 7366, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7623, -- Current training regime canceled.
        HUNT_ACCEPTED           = 7641, -- Hunt accepted!
        USE_SCYLDS              = 7642, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7653, -- You record your hunt.
        OBTAIN_SCYLDS           = 7655, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7659, -- Hunt canceled.
        WYATT_DIALOG            = 11085, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11115, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11216, -- If'n ye have goods tae deliver, then Nembet be yer man!
        ALLIED_SIGIL            = 12917, -- You have received the Allied Sigil!
        RETRIEVE_DIALOG_ID      = 15580, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15654, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[ xi.zone.SOUTHERN_SAN_DORIA_S]
