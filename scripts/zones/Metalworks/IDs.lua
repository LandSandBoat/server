-----------------------------------
-- Area: Metalworks
-----------------------------------
zones = zones or {}

zones[xi.zone.METALWORKS] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION        = 9,     -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 14,    -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        ITEM_CANNOT_BE_OBTAINED       = 6441,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6445,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6449,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6450,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6452,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6453,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6454,  -- You do not have enough gil.
        ITEMS_OBTAINED                = 6458,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6463,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 6488,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6489,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6490,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6510,  -- Your party is unable to participate because certain members' levels are restricted.
        YOU_LEARNED_TRUST             = 6512,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO       = 6513,  -- You are now able to call multiple alter egos.
        CONQUEST_BASE                 = 6555,  -- Tallying conquest results...
        IMAGE_SUPPORT                 = 6883,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 6897,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 6905,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 6912,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 6917,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 6918,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 6934,  -- You have successfully renounced your status as a [craftsman/artisan/adept] of the [Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GOOD_LUCK                     = 7470,  -- Good luck on your mission. Bastokers like to do things by the book, so stay out of trouble and follow their rules.
        MISSION_DIALOG_CID_TO_AYAME   = 7597,  -- Give it to one of his Mythril Musketeers instead. Ayame and Naji should be on guard near the President's Office. Either one will do.
        ITS_LOCKED                    = 8008,  -- It's locked.
        VICIOUS_EYE_SHOP_DIALOG       = 8025,  -- Hi. This is where blacksmiths buy what they need.
        AMULYA_SHOP_DIALOG            = 8026,  -- Hello. Welcome to the Blacksmiths' Guild shop.
        OLAF_SHOP_DIALOG              = 8027,  -- We sell items in the Gunpowder Room, too. What do you need?
        NOGGA_SHOP_DIALOG             = 8028,  -- I've got some items you won't find elsewhere!
        TOMASA_SHOP_DIALOG            = 8029,  -- This is the Craftsmen's Eatery. Make room for the next customer when you're done, all right?
        FISHING_MESSAGE_OFFSET        = 8030,  -- You can't fish here.
        CONQUEST                      = 8232,  -- You've earned conquest points!
        GLAROCIQUET_DIALOG            = 8234,  -- I am <name>, a Temple Knight. I am one of the guards charged with overseeing San d'Oria's conquest campaign.
        LEXUN_MARIXUN_DIALOG          = 8236,  -- I am <name>, a War Warlock. I am one of the guards charged with overseeing Windurst's conquest campaign.
        INVALID_ENSIGNIAS             = 8354,  -- Your invalid ensignias have been disposed of.
        EXTENDED_MISSION_OFFSET       = 8622,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        STEEL_CYCLONE_LEARNED         = 9040,  -- You have learned the weapon skill Steel Cyclone!
        DETONATOR_LEARNED             = 9065,  -- You have learned the weapon skill Detonator!
        TAKIYAH_CLOSED_DIALOG         = 10006, -- Maybe someday I'll be able to sell goods from Qufim Island... Someday...
        TAKIYAH_OPEN_DIALOG           = 10007, -- Hey, it's your lucky day! I've got a fresh batch of goods straight from the island of Qufim!
        CELEBRATORY_GOODS             = 10854, -- An assortment of celebratory goods is available for purchase.
        HOMEPOINT_SET                 = 11042, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.METALWORKS]
