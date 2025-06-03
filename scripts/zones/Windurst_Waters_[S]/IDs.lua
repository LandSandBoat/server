-----------------------------------
-- Area: Windurst_Waters_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WATERS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6396,  -- You do not have enough gil.
        ITEMS_OBTAINED                = 6400,  -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068,  -- You can't fish here.
        PELFTRIX_SHOP_DIALOG          = 7219,  -- Boodlix's Emporium open for business! Boodlix's gots whats you wants, at the price yous likes! It's okay, we takes yours gils, too!
        MOG_LOCKER_OFFSET             = 7484,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED               = 7754,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7772,  -- Hunt accepted!
        USE_SCYLDS                    = 7773,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7784,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7786,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7790,  -- Hunt canceled.
        HOMEPOINT_SET                 = 10885, -- Home point set!
        YASSI_POSSI_DIALOG            = 10905, -- Swifty-wifty and safey-wafey parcel delivery! Is there something you need to send?
        EZURAROMAZURA_SHOP_DIALOG     = 10906, -- A potent spelly-well or two can be the key to survival in this time of war. But can you mastaru my magic, or will it master you?
        DOOR_ACOLYTE_HOSTEL_LOCKED    = 11348, -- The door appears to be locked...
        MIKHE_ARYOHCHA_DIALOG         = 12485, -- Do you like the headpiece? I made it from my firrrst victim. I wear it to let everrryone know what happens when they cross Mikhe Aryohcha!
        LUTETE_DIALOG                 = 12487, -- <Yaaawn>... Mastering these Near Eastern magics can be quite taxing. If I had a choice, I'd rather be back in bed, relaxing...
        CAMPAIGN_RESULTS_TALLIED      = 12573, -- Campaign results tallied.
        ALLIED_SIGIL                  = 12931, -- You have received the Allied Sigil!
        POGIGI_TURN_IN                = 13425, -- Just as we suspected. This contains a great deal of information that will prove vital to our cause. Hm, what's this? Not sure what to make of this... Doesn't seem to be terribly important. Here, why don't you hang onto it? See if you can't get some use out of it down the road.
        RETRIEVE_DIALOG_ID            = 15002, -- You retrieve <item> from the porter moogle's care.
        NOT_ENOUGH_NOTES              = 15027, -- You tryin' to cheat me? That's not nearly enough notes!
        COMMON_SENSE_SURVIVAL         = 15063, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Dynause_TK'), -- San, Bas, Win, Flag +4, CA
        SHUVO               = 17163024,
    },
}

return zones[xi.zone.WINDURST_WATERS_S]
