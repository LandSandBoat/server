-----------------------------------
-- Area: Windurst_Walls
-----------------------------------
zones = zones or {}

zones[xi.zone.WINDURST_WALLS] =
{
    text =
    {
        CONQUEST_BASE                  = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED        = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6547,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6552,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6553,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6554,  -- You do not have enough gil.
        ITEMS_OBTAINED                 = 6558,  -- You obtain <number> <item>!
        ITEM_RETURNED                  = 6561,  -- The <item> is returned to you.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6585,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6588,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6589,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 6590,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 6610,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST              = 6612,  -- You learned Trust: <name>!
        HOMEPOINT_SET                  = 6650,  -- Home point set!
        YOU_ACCEPT_THE_MISSION         = 6743,  -- You have accepted the mission.
        MOG_LOCKER_OFFSET              = 6824,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        ITEM_DELIVERY_DIALOG           = 6991,  -- We can deliver goods to your residence or to the residences of your friends.
        FISHING_MESSAGE_OFFSET         = 7087,  -- You can't fish here.
        RECEIVE_BAYLD                  = 7185,  -- You receive <number> bayld!
        DOORS_SEALED_SHUT              = 7762,  -- The doors are firmly sealed shut.
        MOGHOUSE_EXIT                  = 8219,  -- You have learned your way through the back alleys of Windurst! Now you can exit to any area from your residence.
        RECEIVED_CONQUEST_POINTS       = 8447,  -- You received <number> conquest points!
        SCAVNIX_SHOP_DIALOG            = 8703,  -- <Pshoooooowaaaaa> I'm goood Goblin from underwooorld.  I find lotshhh of gooodieshhh.  You want try shhhome chipshhh? Cheap for yooou.
        RETRIBUTION_LEARNED            = 9091,  -- You have learned the weapon skill Retribution!
        YOU_CANNOT_ENTER_DYNAMIS       = 9114,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 9116,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 9128,  -- The strands of grass here have been tied together.
        IMPERIAL_STANDING_INCREASED    = 9649,  -- Your Imperial Standing has increased!
        EARNED_ALLIED_NOTES            = 9650,  -- You have earned <number> Allied Note[/s]!
        OBTAINED_GUILD_POINTS          = 9651,  -- Obtained: <number> guild points.
        TEAR_IN_FABRIC_OF_SPACE        = 10863, -- There appears to be a tear in the fabric of space...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.WINDURST_WALLS]
