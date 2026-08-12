-----------------------------------
-- Area: Bastok_Markets_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.BASTOK_MARKETS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        ITEM_RETURNED_TO_CHAR         = 6407,  -- The <keyitem> is returned to you.
        REPORT_TO_CAIT_SITH           = 6997,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7073,  -- You can't fish here.
        GATE_IS_LOCKED                = 7220,  -- The gate is locked.
        BLINGBRIX_SHOP_DIALOG         = 7224,  -- Blingbrix good Gobbie from Boodlix's! Boodlix's Emporium help fighting fighters and maging mages. Gil okay, okay?
        MOG_LOCKER_OFFSET             = 7490,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED               = 7728,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7746,  -- Hunt accepted!
        USE_SCYLDS                    = 7747,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7758,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7760,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7764,  -- Hunt canceled.
        HOMEPOINT_SET                 = 10857, -- Home point set!
        KARLOTTE_DELIVERY_DIALOG      = 10891, -- I am here to help with all your parcel delivery needs.
        WELDON_DELIVERY_DIALOG        = 10892, -- Do you have something you wish to send?
        ARE_TAKEN_AWAY_FROM_CHAR      = 11556, -- The <keyitem> are taken away from <player>!
        CAMPAIGN_RESULTS_TALLIED      = 11776, -- Campaign results tallied.
        NOW_ALLIED_WITH               = 12051, -- You are now a member of the [/Knights of the Iron Ram/Republican Legion's Fourth Division/Cobra Unit]!
        ALLIED_SIGIL                  = 12380, -- You have received the Allied Sigil!
        SILKE_SHOP_DIALOG             = 12832, -- You wouldn't happen to be a fellow scholar, by any chance? The contents of these pages are beyond me, but perhaps you might glean something from them. They could be yours...for a nominal fee.
        KEVAN_TURN_IN                 = 13579, -- Just as we suspected. This contains a great deal of information that will prove vital to our cause. Hm, what's this? Not sure what to make of this... Doesn't seem to be terribly important. Here, why don't you hang onto it? See if you can't get some use out of it down the road.
        RETRIEVE_DIALOG_ID            = 14748, -- You retrieve <item> from the porter moogle's care.
        NOT_ENOUGH_NOTES              = 14773, -- You tryin' to cheat me? That's not nearly enough notes!
        COMMON_SENSE_SURVIVAL         = 14817, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Hostarfaux_TK'), -- San, Bas, Win, Flag +4, CA
        -- SHENNI              = GetFirstID('Shenni'),
    },
}

return zones[xi.zone.BASTOK_MARKETS_S]
