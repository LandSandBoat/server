-----------------------------------
-- Area: Upper_Jeuno
-----------------------------------
zones = zones or {}

zones[xi.zone.UPPER_JEUNO] =
{
    text =
    {
        CONQUEST_BASE                    = 0,     -- Tallying conquest results...
        ASSIST_CHANNEL                   = 6539,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED          = 6545,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6553,  -- Obtained: <item>.
        GIL_OBTAINED                     = 6554,  -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6556,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6557,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL              = 6558,  -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY          = 6567,  -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS     = 6589,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS              = 6592,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6593,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 6594,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 6614,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                    = 6699,  -- Home point set!
        MOG_LOCKER_OFFSET                = 6817,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GLYKE_SHOP_DIALOG                = 7000,  -- Can I help you?
        MEJUONE_SHOP_DIALOG              = 7001,  -- Welcome to the Chocobo Shop.
        VIETTES_SHOP_DIALOG              = 7002,  -- Welcome to Viette's Finest Weapons.
        DURABLE_SHIELDS_SHOP_DIALOG      = 7003,  -- Welcome to Durable Shields.
        MP_SHOP_DIALOG                   = 7004,  -- Welcome to M & P's Market.
        GUIDE_STONE                      = 7005,  -- Up: Ru'Lude Gardens Down: Lower Jeuno (facing Bastok)
        IT_READS_STAFF_ONLY              = 7007,  -- It reads, Staff Only.
        ITS_LOCKED                       = 7008,  -- It's locked.
        LEILLAINE_SHOP_DIALOG            = 7030,  -- Hello. Are you feeling all right?
        YOU_CAN_NOW_BECOME_A_BEASTMASTER = 7210,  -- You can now become a beastmaster.
        NO_ONES_HOME                     = 7213,  -- Looks like no one's home.
        WASTING_YOUR_TIME                = 7452,  -- Hah! You're wasting your time!
        YOU_ARE_GIVEN_THREE_SPRIGS       = 7737,  -- You are given three sprigs of <item>.
        CONQUEST                         = 7766,  -- You've earned conquest points!
        ITEM_DELIVERY_DIALOG             = 8099,  -- Delivering goods to residences everywhere!
        DECIMATION_LEARNED               = 8222,  -- You have learned the weapon skill Decimation!
        LEND_PRISHE_AMULET               = 8359,  -- You lend the <item> to Prishe.
        YOU_OBTAIN_ITEM                  = 11203, -- You obtain <item>!
        UNLOCK_DANCER                    = 11862, -- You can now become a dancer!
    },
    mob =
    {
    },
    npc =
    {
        MAPITOTO = GetFirstID('Mapitoto'),
    },
}

return zones[xi.zone.UPPER_JEUNO]
