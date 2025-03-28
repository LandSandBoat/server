-----------------------------------
-- Area: Bastok_Markets_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.BASTOK_MARKETS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068,  -- You can't fish here.
        BLINGBRIX_SHOP_DIALOG         = 7218,  -- Blingbrix good Gobbie from Boodlix's! Boodlix's Emporium help fighting fighters and maging mages. Gil okay, okay?
        MOG_LOCKER_OFFSET             = 7484,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED               = 7722,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7740,  -- Hunt accepted!
        USE_SCYLDS                    = 7741,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7752,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7754,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7758,  -- Hunt canceled.
        HOMEPOINT_SET                 = 10851, -- Home point set!
        KARLOTTE_DELIVERY_DIALOG      = 10885, -- I am here to help with all your parcel delivery needs.
        WELDON_DELIVERY_DIALOG        = 10886, -- Do you have something you wish to send?
        CAMPAIGN_RESULTS_TALLIED      = 11770, -- Campaign results tallied.
        ALLIED_SIGIL                  = 12374, -- You have received the Allied Sigil!
        SILKE_SHOP_DIALOG             = 12826, -- You wouldn't happen to be a fellow scholar, by any chance? The contents of these pages are beyond me, but perhaps you might glean something from them. They could be yours...for a nominal fee.
        KEVAN_TURN_IN                 = 13573, -- Just as we suspected. This contains a great deal of information that will prove vital to our cause. Hm, what's this? Not sure what to make of this... Doesn't seem to be terribly important. Here, why don't you hang onto it? See if you can't get some use out of it down the road.
        RETRIEVE_DIALOG_ID            = 14742, -- You retrieve <item> from the porter moogle's care.
        NOT_ENOUGH_NOTES              = 14767, -- You tryin' to cheat me? That's not nearly enough notes!
        COMMON_SENSE_SURVIVAL         = 14811, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Hostarfaux_TK'), -- San, Bas, Win, Flag +4, CA
        SHENNI              = GetFirstID('Shenni'),
    },
}

return zones[xi.zone.BASTOK_MARKETS_S]
