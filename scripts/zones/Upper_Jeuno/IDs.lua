-----------------------------------
-- Area: Upper_Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.UPPER_JEUNO] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED          = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6552,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6553,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL              = 6554,  -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY          = 6563,  -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS     = 6585,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS              = 6588,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6589,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 6590,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 6610,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                    = 6687,  -- Home point set!
        MOG_LOCKER_OFFSET                = 6805,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GLYKE_SHOP_DIALOG                = 6988,  -- Can I help you?
        MEJUONE_SHOP_DIALOG              = 6989,  -- Welcome to the Chocobo Shop.
        VIETTES_SHOP_DIALOG              = 6990,  -- Welcome to Viette's Finest Weapons.
        DURABLE_SHIELDS_SHOP_DIALOG      = 6991,  -- Welcome to Durable Shields.
        MP_SHOP_DIALOG                   = 6992,  -- Welcome to M & P's Market.
        GUIDE_STONE                      = 6993,  -- Up: Ru'Lude Gardens Down: Lower Jeuno (facing Bastok)
        IT_READS_STAFF_ONLY              = 6995,  -- It reads, Staff Only.
        LEILLAINE_SHOP_DIALOG            = 7018,  -- Hello. Are you feeling all right?
        YOU_CAN_NOW_BECOME_A_BEASTMASTER = 7198,  -- You can now become a beastmaster.
        CONQUEST                         = 7754,  -- You've earned conquest points!
        ITEM_DELIVERY_DIALOG             = 8087,  -- Delivering goods to residences everywhere!
        DECIMATION_LEARNED               = 8210,  -- You have learned the weapon skill Decimation!
        LEND_PRISHE_AMULET               = 8347,  -- You lend the <item> to Prishe.
        YOU_OBTAIN_ITEM                  = 11191, -- You obtain <item>!
        UNLOCK_DANCER                    = 11841, -- You can now become a dancer!
    },
    mob =
    {
    },
    npc =
    {
        MAPITOTO = 17776896,
    },
}

return zones[xi.zone.UPPER_JEUNO]
