-----------------------------------
-- Area: Bastok_Markets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BASTOK_MARKETS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED      = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE   = 6387,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                 = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                 = 6393,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL          = 6394,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM              = 6395,  -- You obtain  <item>!
        ITEMS_OBTAINED               = 6398,  -- You obtain <number> <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS = 6425,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS          = 6428,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 6429,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 6430,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET                = 6483,  -- Home point set!
        YOU_ACCEPT_THE_MISSION       = 6512,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET      = 6517,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                = 6585,  -- Tallying conquest results...
        MOG_LOCKER_OFFSET            = 6879,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GOLDSMITHING_SUPPORT         = 7084,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT     = 7098,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT           = 7106,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE          = 7113,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                  = 7118,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP           = 7119,  -- You do not have enough guild points.
        FISHING_MESSAGE_OFFSET       = 7215,  -- You can't fish here.
        SOMNPAEMN_CLOSED_DIALOG      = 7581,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Sarutabaruta, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        YAFAFA_CLOSED_DIALOG         = 7582,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Kolshushu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        OGGODETT_CLOSED_DIALOG       = 7583,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Aragoneu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        ITEM_DELIVERY_DIALOG         = 7670,  -- Need something sent to a friend's house? Sending items to your own room? You've come to the right place!
        TEERTH_SHOP_DIALOG           = 7684,  -- Welcome to the Goldsmiths' Guild shop. What can I do for you?
        VISALA_SHOP_DIALOG           = 7685,  -- Welcome to the Goldsmiths' Guild shop. How may I help you?
        ZHIKKOM_SHOP_DIALOG          = 7686,  -- Hello! Welcome to the only weaponry store in Bastok, the Dragon's Claws!
        CIQALA_SHOP_DIALOG           = 7687,  -- A weapon is the most precious thing to an adventurer! Well, after his life, of course. Choose wisely.
        PERITRAGE_SHOP_DIALOG        = 7688,  -- Hey! I've got just the thing for you!
        BRUNHILDE_SHOP_DIALOG        = 7689,  -- Welcome to my store! You want armor, you want shields? I've got them all!
        CHARGINGCHOCOBO_SHOP_DIALOG  = 7690,  -- Hello. What piece of armor are you missing?
        BALTHILDA_SHOP_DIALOG        = 7691,  -- Feeling defenseless of late? Brunhilde's Armory has got you covered!
        MJOLL_SHOP_DIALOG            = 7692,  -- Welcome. Have a look and compare! You'll never find better wares anywhere.
        OLWYN_SHOP_DIALOG            = 7693,  -- Welcome to Mjoll's Goods! What can I do for you?
        ZAIRA_SHOP_DIALOG            = 7694,  -- Greetings. What spell are you looking for?
        SORORO_SHOP_DIALOG           = 7695,  -- Hello-mellow, welcome to Sororo's Scribe and Notary! Hmm? No, we sell magic spells! What did you think?
        HARMODIOS_SHOP_DIALOG        = 7696,  -- Add music to your adventuring life! Welcome to Harmodios's.
        CARMELIDE_SHOP_DIALOG        = 7697,  -- Ah, welcome, welcome! What might I interest you in?
        RAGHD_SHOP_DIALOG            = 7698,  -- Give a smile to that special someone! Welcome to Carmelide's.
        HORTENSE_SHOP_DIALOG         = 7699,  -- Hello there! We have instruments and music sheets at Harmodios's!
        OGGODETT_OPEN_DIALOG         = 7700,  -- Hello there! Might I interest you in some specialty goods from Aragoneu?
        YAFAFA_OPEN_DIALOG           = 7701,  -- Hello! I've got some goods from Kolshushu--interested?
        SOMNPAEMN_OPEN_DIALOG        = 7702,  -- Welcome! I have goods straight from Sarutabaruta! What say you?
        CONQUEST                     = 7793,  -- You've earned conquest points!
        EXTENDED_MISSION_OFFSET      = 8155,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TRICK_OR_TREAT               = 8278,  -- Trick or treat...
        THANK_YOU_TREAT              = 8279,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS               = 8280,  -- Here, take this...
        IF_YOU_WEAR_THIS             = 8281,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                    = 8282,  -- Thank you...
        RETRIEVE_DIALOG_ID           = 12888, -- You retrieve <item> from the porter moogle's care.
        TURNING_IN_SPARKS            = 14209, -- Ohohoho... Turning in sparks, I see.
        DO_NOT_POSSESS_ENOUGH        = 14233, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS            = 14234, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED     = 14235, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY    = 14245, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY        = 14548, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY   = 14624, -- ou have already changed Unities. Please wait until the next tabulation period.
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

return zones[xi.zone.BASTOK_MARKETS]
