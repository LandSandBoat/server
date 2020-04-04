-----------------------------------
-- Area: Metalworks
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.METALWORKS] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION      = 9, -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET     = 14, -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        ITEM_CANNOT_BE_OBTAINED     = 6437, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE  = 6441, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED               = 6443, -- Obtained: <item>.
        GIL_OBTAINED                = 6444, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6446, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6447, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL         = 6448, -- You do not have enough gil.
        ITEMS_OBTAINED              = 6452, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY     = 6457, -- There is nothing out of the ordinary here.
        YOU_LEARNED_TRUST           = 6506, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO     = 6507, -- You are now able to call multiple alter egos.
        CONQUEST_BASE               = 6532, -- Tallying conquest results...
        SMITHING_SUPPORT            = 6860, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT    = 6874, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT          = 6882, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE         = 6889, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                 = 6894, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP          = 6895, -- You do not have enough guild points.
        GOOD_LUCK                   = 7447, -- Good luck on your mission. Bastokers like to do things by the book, so stay out of trouble and follow their rules.
        MISSION_DIALOG_CID_TO_AYAME = 7574, -- Give it to one of his Mythril Musketeers instead. Ayame and Naji should be on guard near the President's Office. Either one will do.
        ITS_LOCKED                  = 7985, -- It's locked.
        VICIOUS_EYE_SHOP_DIALOG     = 8002, -- Hi. This is where blacksmiths buy what they need.
        AMULYA_SHOP_DIALOG          = 8003, -- Hello. Welcome to the Blacksmiths' Guild shop.
        OLAF_SHOP_DIALOG            = 8004, -- We sell items in the Gunpowder Room, too. What do you need?
        NOGGA_SHOP_DIALOG           = 8005, -- I've got some items you won't find elsewhere!
        TOMASA_SHOP_DIALOG          = 8006, -- This is the Craftsmen's Eatery. Make room for the next customer when you're done, all right?
        FISHING_MESSAGE_OFFSET      = 8007, -- You can't fish here.
        CONQUEST                    = 8208, -- You've earned conquest points!
        GLAROCIQUET_DIALOG          = 8210, -- I am , a Temple Knight. I am one of the guards charged with overseeing San d'Oria's conquest campaign.
        LEXUN_MARIXUN_DIALOG        = 8212, -- I am , a War Warlock. I am one of the guards charged with overseeing Windurst's conquest campaign.
        EXTENDED_MISSION_OFFSET     = 8598, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        STEEL_CYCLONE_LEARNED       = 9009, -- You have learned the weapon skill Steel Cyclone!
        DETONATOR_LEARNED           = 9034, -- You have learned the weapon skill Detonator!
        TAKIYAH_CLOSED_DIALOG       = 9968, -- Maybe someday I'll be able to sell goods from Qufim Island... Someday...
        TAKIYAH_OPEN_DIALOG         = 9969, -- Hey, it's your lucky day! I've got a fresh batch of goods straight from the island of Qufim!
        CELEBRATORY_GOODS           = 10816, -- An assortment of celebratory goods is available for purchase.
        HOMEPOINT_SET               = 11004, -- Home point set!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.METALWORKS]
