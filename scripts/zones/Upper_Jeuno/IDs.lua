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
        ITEM_CANNOT_BE_OBTAINED          = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6547, -- Obtained: <item>.
        GIL_OBTAINED                     = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6550, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6551, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL              = 6552, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY          = 6561, -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS     = 6583, -- You must wait another ≺number≻ [day/days] to perform that action.
        HOMEPOINT_SET                    = 6676, -- Home point set!
        MOG_LOCKER_OFFSET                = 6789, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GLYKE_SHOP_DIALOG                = 6972, -- Can I help you?
        MEJUONE_SHOP_DIALOG              = 6973, -- Welcome to the Chocobo Shop.
        COUMUNA_SHOP_DIALOG              = 6974, -- Welcome to Viette's Finest Weapons.
        ANTONIA_SHOP_DIALOG              = 6974, -- Welcome to Viette's Finest Weapons.
        KHECHALAHKO_SHOP_DIALOG          = 6975, -- Welcome to Durable Shields.
        DEADLYMINNOW_SHOP_DIALOG         = 6975, -- Welcome to Durable Shields.
        MP_SHOP_DIALOG                   = 6976, -- Welcome to M & P's Market.
        GUIDE_STONE                      = 6977, -- Up: Ru'Lude Gardens Down: Lower Jeuno (facing Bastok)
        LEILLAINE_SHOP_DIALOG            = 7002, -- Hello. Are you feeling all right?
        YOU_CAN_NOW_BECOME_A_BEASTMASTER = 7182, -- You can now become a beastmaster.
        CONQUEST                         = 7738, -- You've earned conquest points!
        KIRISOMANRISO_DIALOG             = 8071, -- Delivering goods to residences everywhere!
        ITEM_DELIVERY_DIALOG             = 8071, -- Delivering goods to residences everywhere!
        DECIMATION_LEARNED               = 8194, -- You have learned the weapon skill Decimation!
        UNLOCK_DANCER                    = 11825, -- You can now become a dancer!
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
