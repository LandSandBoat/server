-----------------------------------
-- Area: Metalworks
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.METALWORKS] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION        = 9,     -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 14,    -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        ITEM_CANNOT_BE_OBTAINED       = 6439,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6443,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6445,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6446,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6448,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6449,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6450,  -- You do not have enough gil.
        ITEMS_OBTAINED                = 6454,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6459,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 6484,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6485,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6486,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6506,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6508,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6509,  -- You are now able to call multiple alter egos.
        CONQUEST_BASE                 = 6540,  -- Tallying conquest results...
        SMITHING_SUPPORT              = 6868,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 6882,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 6890,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 6897,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 6902,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 6903,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 6919,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GOOD_LUCK                     = 7455,  -- Good luck on your mission. Bastokers like to do things by the book, so stay out of trouble and follow their rules.
        MISSION_DIALOG_CID_TO_AYAME   = 7582,  -- Give it to one of his Mythril Musketeers instead. Ayame and Naji should be on guard near the President's Office. Either one will do.
        ITS_LOCKED                    = 7993,  -- It's locked.
        VICIOUS_EYE_SHOP_DIALOG       = 8010,  -- Hi. This is where blacksmiths buy what they need.
        AMULYA_SHOP_DIALOG            = 8011,  -- Hello. Welcome to the Blacksmiths' Guild shop.
        OLAF_SHOP_DIALOG              = 8012,  -- We sell items in the Gunpowder Room, too. What do you need?
        NOGGA_SHOP_DIALOG             = 8013,  -- I've got some items you won't find elsewhere!
        TOMASA_SHOP_DIALOG            = 8014,  -- This is the Craftsmen's Eatery. Make room for the next customer when you're done, all right?
        FISHING_MESSAGE_OFFSET        = 8015,  -- You can't fish here.
        CONQUEST                      = 8216,  -- You've earned conquest points!
        GLAROCIQUET_DIALOG            = 8218,  -- I am , a Temple Knight. I am one of the guards charged with overseeing San d'Oria's conquest campaign.
        LEXUN_MARIXUN_DIALOG          = 8220,  -- I am , a War Warlock. I am one of the guards charged with overseeing Windurst's conquest campaign.
        EXTENDED_MISSION_OFFSET       = 8606,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        STEEL_CYCLONE_LEARNED         = 9024,  -- You have learned the weapon skill Steel Cyclone!
        DETONATOR_LEARNED             = 9049,  -- You have learned the weapon skill Detonator!
        TAKIYAH_CLOSED_DIALOG         = 9990,  -- Maybe someday I'll be able to sell goods from Qufim Island... Someday...
        TAKIYAH_OPEN_DIALOG           = 9991,  -- Hey, it's your lucky day! I've got a fresh batch of goods straight from the island of Qufim!
        CELEBRATORY_GOODS             = 10838, -- An assortment of celebratory goods is available for purchase.
        HOMEPOINT_SET                 = 11026, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.METALWORKS]
