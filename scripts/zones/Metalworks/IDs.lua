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
        YOU_ACCEPT_THE_MISSION      = 9,     -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET     = 14,    -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        ITEM_CANNOT_BE_OBTAINED     = 6438,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE  = 6442,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED               = 6444,  -- Obtained: <item>.
        GIL_OBTAINED                = 6445,  -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6447,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6448,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL         = 6449,  -- You do not have enough gil.
        ITEMS_OBTAINED              = 6453,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY     = 6458,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS         = 6483,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 6484,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 6485,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST           = 6507,  -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO     = 6508,  -- You are now able to call multiple alter egos.
        CONQUEST_BASE               = 6536,  -- Tallying conquest results...
        SMITHING_SUPPORT            = 6864,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT    = 6878,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT          = 6886,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE         = 6893,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                 = 6898,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP          = 6899,  -- You do not have enough guild points.
        GOOD_LUCK                   = 7451,  -- Good luck on your mission. Bastokers like to do things by the book, so stay out of trouble and follow their rules.
        MISSION_DIALOG_CID_TO_AYAME = 7578,  -- Give it to one of his Mythril Musketeers instead. Ayame and Naji should be on guard near the President's Office. Either one will do.
        ITS_LOCKED                  = 7989,  -- It's locked.
        VICIOUS_EYE_SHOP_DIALOG     = 8006,  -- Hi. This is where blacksmiths buy what they need.
        AMULYA_SHOP_DIALOG          = 8007,  -- Hello. Welcome to the Blacksmiths' Guild shop.
        OLAF_SHOP_DIALOG            = 8008,  -- We sell items in the Gunpowder Room, too. What do you need?
        NOGGA_SHOP_DIALOG           = 8009,  -- I've got some items you won't find elsewhere!
        TOMASA_SHOP_DIALOG          = 8010,  -- This is the Craftsmen's Eatery. Make room for the next customer when you're done, all right?
        FISHING_MESSAGE_OFFSET      = 8011,  -- You can't fish here.
        CONQUEST                    = 8212,  -- You've earned conquest points!
        GLAROCIQUET_DIALOG          = 8214,  -- I am , a Temple Knight. I am one of the guards charged with overseeing San d'Oria's conquest campaign.
        LEXUN_MARIXUN_DIALOG        = 8216,  -- I am , a War Warlock. I am one of the guards charged with overseeing Windurst's conquest campaign.
        EXTENDED_MISSION_OFFSET     = 8602,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        STEEL_CYCLONE_LEARNED       = 9020,  -- You have learned the weapon skill Steel Cyclone!
        DETONATOR_LEARNED           = 9045,  -- You have learned the weapon skill Detonator!
        TAKIYAH_CLOSED_DIALOG       = 9986,  -- Maybe someday I'll be able to sell goods from Qufim Island... Someday...
        TAKIYAH_OPEN_DIALOG         = 9987,  -- Hey, it's your lucky day! I've got a fresh batch of goods straight from the island of Qufim!
        CELEBRATORY_GOODS           = 10834, -- An assortment of celebratory goods is available for purchase.
        HOMEPOINT_SET               = 11022, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.METALWORKS]
