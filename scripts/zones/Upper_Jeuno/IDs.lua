-----------------------------------
-- Area: Upper_Jeuno
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.UPPER_JEUNO] =
{
    text =
    {
        CONQUEST_BASE                    = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED          = 6542, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6548, -- Obtained: <item>.
        GIL_OBTAINED                     = 6549, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6551, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6552, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL              = 6553, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY          = 6562, -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS     = 6584, -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS              = 6587, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 6588, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 6589, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET                    = 6677, -- Home point set!
        MOG_LOCKER_OFFSET                = 6795, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GLYKE_SHOP_DIALOG                = 6978, -- Can I help you?
        MEJUONE_SHOP_DIALOG              = 6979, -- Welcome to the Chocobo Shop.
        COUMUNA_SHOP_DIALOG              = 6980, -- Welcome to Viette's Finest Weapons.
        ANTONIA_SHOP_DIALOG              = 6980, -- Welcome to Viette's Finest Weapons.
        KHECHALAHKO_SHOP_DIALOG          = 6981, -- Welcome to Durable Shields.
        DEADLYMINNOW_SHOP_DIALOG         = 6981, -- Welcome to Durable Shields.
        MP_SHOP_DIALOG                   = 6982, -- Welcome to M & P's Market.
        GUIDE_STONE                      = 6983, -- Up: Ru'Lude Gardens Down: Lower Jeuno (facing Bastok)
        LEILLAINE_SHOP_DIALOG            = 7008, -- Hello. Are you feeling all right?
        YOU_CAN_NOW_BECOME_A_BEASTMASTER = 7188, -- You can now become a beastmaster.
        CONQUEST                         = 7744, -- You've earned conquest points!
        KIRISOMANRISO_DIALOG             = 8077, -- Delivering goods to residences everywhere!
        ITEM_DELIVERY_DIALOG             = 8077, -- Delivering goods to residences everywhere!
        DECIMATION_LEARNED               = 8200, -- You have learned the weapon skill Decimation!
        LEND_PRISHE_AMULET               = 8337, -- You lend the <item> to Prishe.
        UNLOCK_DANCER                    = 11831, -- You can now become a dancer!
    },
    mob =
    {
    },
    npc =
    {
        MAPITOTO = 17776895,
    },
}

return zones[tpz.zone.UPPER_JEUNO]
