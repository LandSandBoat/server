-----------------------------------
-- Area: Windurst_Waters_[S]
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WATERS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400,  -- You do not have enough gil.
        ITEMS_OBTAINED                = 6404,  -- You obtain <number> <item>!
        REPORT_TO_CAIT_SITH           = 6997,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7073,  -- You can't fish here.
        PELFTRIX_SHOP_DIALOG          = 7225,  -- Boodlix's Emporium open for business! Boodlix's gots whats you wants, at the price yous likes! It's okay, we takes yours gils, too!
        MOG_LOCKER_OFFSET             = 7490,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED               = 7760,  -- Current training regime canceled.
        HUNT_ACCEPTED                 = 7778,  -- Hunt accepted!
        USE_SCYLDS                    = 7779,  -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED                 = 7790,  -- You record your hunt.
        OBTAIN_SCYLDS                 = 7792,  -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED                 = 7796,  -- Hunt canceled.
        HOMEPOINT_SET                 = 10891, -- Home point set!
        YASSI_POSSI_DIALOG            = 10911, -- Swifty-wifty and safey-wafey parcel delivery! Is there something you need to send?
        EZURAROMAZURA_SHOP_DIALOG     = 10912, -- A potent spelly-well or two can be the key to survival in this time of war. But can you mastaru my magic, or will it master you?
        DOOR_ACOLYTE_HOSTEL_LOCKED    = 11354, -- The door appears to be locked...
        NOW_ALLIED_WITH               = 11773, -- You are now a member of the [/Knights of the Iron Ram/Republican Legion's Fourth Division/Cobra Unit]!
        MIKHE_ARYOHCHA_DIALOG         = 12491, -- Do you like the headpiece? I made it from my firrrst victim. I wear it to let everrryone know what happens when they cross Mikhe Aryohcha!
        LUTETE_DIALOG                 = 12493, -- <Yaaawn>... Mastering these Near Eastern magics can be quite taxing. If I had a choice, I'd rather be back in bed, relaxing...
        CAMPAIGN_RESULTS_TALLIED      = 12579, -- Campaign results tallied.
        ALLIED_SIGIL                  = 12937, -- You have received the Allied Sigil!
        POGIGI_TURN_IN                = 13431, -- Just as we suspected. This contains a great deal of information that will prove vital to our cause. Hm, what's this? Not sure what to make of this... Doesn't seem to be terribly important. Here, why don't you hang onto it? See if you can't get some use out of it down the road.
        RETRIEVE_DIALOG_ID            = 15008, -- You retrieve <item> from the porter moogle's care.
        NOT_ENOUGH_NOTES              = 15033, -- You tryin' to cheat me? That's not nearly enough notes!
        COMMON_SENSE_SURVIVAL         = 15069, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
        CAMPAIGN_NPC_OFFSET = GetFirstID('Dynause_TK'), -- San, Bas, Win, Flag +4, CA
        -- SHUVO               = GetFirstID('Shuvo'),
    },
}

return zones[xi.zone.WINDURST_WATERS_S]
