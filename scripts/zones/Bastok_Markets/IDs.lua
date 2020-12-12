-----------------------------------
-- Area: Bastok_Markets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BASTOK_MARKETS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE   = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                = 6388, -- Obtained: <item>.
        GIL_OBTAINED                 = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                 = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL          = 6393, -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS = 6424, -- You must wait another <number> [day/days] to perform that action.
        ITEMS_OBTAINED               = 6397, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS          = 6427, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 6428, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 6429, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET                = 6479, -- Home point set!
        YOU_ACCEPT_THE_MISSION       = 6508, -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET      = 6513, -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                = 6581, -- Tallying conquest results...
        MOG_LOCKER_OFFSET            = 6875, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GOLDSMITHING_SUPPORT         = 7080, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT     = 7094, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT           = 7102, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE          = 7109, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                  = 7114, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP           = 7115, -- You do not have enough guild points.
        FISHING_MESSAGE_OFFSET       = 7211, -- You can't fish here.
        SOMNPAEMN_CLOSED_DIALOG      = 7577, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Sarutabaruta, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        YAFAFA_CLOSED_DIALOG         = 7578, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Kolshushu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        OGGODETT_CLOSED_DIALOG       = 7579, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Aragoneu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        ITEM_DELIVERY_DIALOG         = 7666, -- Need something sent to a friend's house? Sending items to your own room? You've come to the right place!
        TEERTH_SHOP_DIALOG           = 7680, -- Welcome to the Goldsmiths' Guild shop. What can I do for you?
        VISALA_SHOP_DIALOG           = 7681, -- Welcome to the Goldsmiths' Guild shop. How may I help you?
        ZHIKKOM_SHOP_DIALOG          = 7682, -- Hello! Welcome to the only weaponry store in Bastok, the Dragon's Claws!
        CIQALA_SHOP_DIALOG           = 7683, -- A weapon is the most precious thing to an adventurer! Well, after his life, of course. Choose wisely.
        PERITRAGE_SHOP_DIALOG        = 7684, -- Hey! I've got just the thing for you!
        BRUNHILDE_SHOP_DIALOG        = 7685, -- Welcome to my store! You want armor, you want shields? I've got them all!
        CHARGINGCHOCOBO_SHOP_DIALOG  = 7686, -- Hello. What piece of armor are you missing?
        BALTHILDA_SHOP_DIALOG        = 7687, -- Feeling defenseless of late? Brunhilde's Armory has got you covered!
        MJOLL_SHOP_DIALOG            = 7688, -- Welcome. Have a look and compare! You'll never find better wares anywhere.
        OLWYN_SHOP_DIALOG            = 7689, -- Welcome to Mjoll's Goods! What can I do for you?
        ZAIRA_SHOP_DIALOG            = 7690, -- Greetings. What spell are you looking for?
        SORORO_SHOP_DIALOG           = 7691, -- Hello-mellow, welcome to Sororo's Scribe and Notary! Hmm? No, we sell magic spells! What did you think?
        HARMODIOS_SHOP_DIALOG        = 7692, -- Add music to your adventuring life! Welcome to Harmodios's.
        CARMELIDE_SHOP_DIALOG        = 7693, -- Ah, welcome, welcome! What might I interest you in?
        RAGHD_SHOP_DIALOG            = 7694, -- Give a smile to that special someone! Welcome to Carmelide's.
        HORTENSE_SHOP_DIALOG         = 7695, -- Hello there! We have instruments and music sheets at Harmodios's!
        OGGODETT_OPEN_DIALOG         = 7696, -- Hello there! Might I interest you in some specialty goods from Aragoneu?
        YAFAFA_OPEN_DIALOG           = 7697, -- Hello! I've got some goods from Kolshushu--interested?
        SOMNPAEMN_OPEN_DIALOG        = 7698, -- Welcome! I have goods straight from Sarutabaruta! What say you?
        CONQUEST                     = 7789, -- You've earned conquest points!
        EXTENDED_MISSION_OFFSET      = 8151, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TRICK_OR_TREAT               = 8274, -- Trick or treat...
        THANK_YOU_TREAT              = 8275, -- Thank you... And now for your treat...
        HERE_TAKE_THIS               = 8276, -- Here, take this...
        IF_YOU_WEAR_THIS             = 8277, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                    = 8278, -- Thank you...
        RETRIEVE_DIALOG_ID           = 12884, -- You retrieve <item> from the porter moogle's care.
        TURNING_IN_SPARKS            = 14205, -- Ohohoho... Turning in sparks, I see.
        NOT_ENOUGH_SPARKS            = 14230, -- You do not possess enough sparks of eminence to complete the transaction.
    },
    mob =
    {
    },
    npc =
    {
        AQUILLINA = 17739784,
        HALLOWEEN_SKINS =
        {
            [17739805] = 45, -- Olwyn
        },
    },
}

return zones[tpz.zone.BASTOK_MARKETS]
