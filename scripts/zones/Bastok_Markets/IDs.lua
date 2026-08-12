-----------------------------------
-- Area: Bastok_Markets
-----------------------------------
zones = zones or {}

zones[xi.zone.BASTOK_MARKETS] =
{
    text =
    {
        ASSIST_CHANNEL                = 6380,  -- You will be able to use the Assist Channel until #/#/# at #:# (JST).
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_THE_ITEM        = 6389,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6391,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6400,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM               = 6401,  -- You obtain % %!
        ITEMS_OBTAINED                = 6404,  -- You obtain <number> <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6431,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6434,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6435,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6436,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6456,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6503,  -- Home point set!
        YOU_ACCEPT_THE_MISSION        = 6532,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 6537,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                 = 6605,  -- Tallying conquest results...
        MOG_LOCKER_OFFSET             = 6899,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL           = 7111,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        IMAGE_SUPPORT                 = 7118,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7132,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7140,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7147,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7152,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7153,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7166,  -- Renounce your rank at which guild? None. Carpenters'. Blacksmiths'. Goldsmiths'. Weavers'. Tanners'. Boneworkers'. Alchemists'. Culinarians'.
        FISHING_MESSAGE_OFFSET        = 7249,  -- You can't fish here.
        SOMNPAEMN_CLOSED_DIALOG       = 7616,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Sarutabaruta, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        YAFAFA_CLOSED_DIALOG          = 7617,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Kolshushu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        OGGODETT_CLOSED_DIALOG        = 7618,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Aragoneu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        ITEM_DELIVERY_DIALOG          = 7705,  -- Need something sent to a friend's house? Sending items to your own room? You've come to the right place!
        TEERTH_SHOP_DIALOG            = 7719,  -- Welcome to the Goldsmiths' Guild shop. What can I do for you?
        VISALA_SHOP_DIALOG            = 7720,  -- Welcome to the Goldsmiths' Guild shop. How may I help you?
        ZHIKKOM_SHOP_DIALOG           = 7721,  -- Hello! Welcome to the only weaponry store in Bastok, the Dragon's Claws!
        CIQALA_SHOP_DIALOG            = 7722,  -- A weapon is the most precious thing to an adventurer! Well, after his life, of course. Choose wisely.
        PERITRAGE_SHOP_DIALOG         = 7723,  -- Hey! I've got just the thing for you!
        BRUNHILDE_SHOP_DIALOG         = 7724,  -- Welcome to my store! You want armor, you want shields? I've got them all!
        CHARGINGCHOCOBO_SHOP_DIALOG   = 7725,  -- Hello. What piece of armor are you missing?
        BALTHILDA_SHOP_DIALOG         = 7726,  -- Feeling defenseless of late? Brunhilde's Armory has got you covered!
        MJOLL_SHOP_DIALOG             = 7727,  -- Welcome. Have a look and compare! You'll never find better wares anywhere.
        OLWYN_SHOP_DIALOG             = 7728,  -- Welcome to Mjoll's Goods! What can I do for you?
        ZAIRA_SHOP_DIALOG             = 7729,  -- Greetings. What spell are you looking for?
        SORORO_SHOP_DIALOG            = 7730,  -- Hello-mellow, welcome to Sororo's Scribe and Notary! Hmm? No, we sell magic spells! What did you think?
        HARMODIOS_SHOP_DIALOG         = 7731,  -- Add music to your adventuring life! Welcome to Harmodios's.
        CARMELIDE_SHOP_DIALOG         = 7732,  -- Ah, welcome, welcome! What might I interest you in?
        RAGHD_SHOP_DIALOG             = 7733,  -- Give a smile to that special someone! Welcome to Carmelide's.
        HORTENSE_SHOP_DIALOG          = 7734,  -- Hello there! We have instruments and music sheets at Harmodios's!
        OGGODETT_OPEN_DIALOG          = 7735,  -- Hello there! Might I interest you in some specialty goods from Aragoneu?
        YAFAFA_OPEN_DIALOG            = 7736,  -- Hello! I've got some goods from Kolshushu--interested?
        SOMNPAEMN_OPEN_DIALOG         = 7737,  -- Welcome! I have goods straight from Sarutabaruta! What say you?
        CONQUEST                      = 7828,  -- You've earned conquest points!
        EXTENDED_MISSION_OFFSET       = 8190,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TRICK_OR_TREAT                = 8313,  -- Trick or treat...
        THANK_YOU_TREAT               = 8314,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 8315,  -- Here, take this...
        IF_YOU_WEAR_THIS              = 8316,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 8317,  -- Thank you...
        EGG_HUNT_OFFSET               = 8324,  -- Egg-cellent! Here's your prize, kupo! Now if only somebody would bring me a super combo... Oh, egg-scuse me! Forget I said that, kupo!
        RETRIEVE_DIALOG_ID            = 13022, -- You retrieve <item> from the porter moogle's care.
        TURNING_IN_SPARKS             = 14347, -- Ohohoho... Turning in sparks, I see.
        DO_NOT_POSSESS_ENOUGH         = 14371, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS             = 14372, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED      = 14373, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY     = 14383, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY         = 14687, -- You have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY    = 14763, -- You have already changed Unities. Please wait until the next tabulation period.
    },
    mob =
    {
    },
    npc =
    {
        AQUILLINA = GetFirstID('Aquillina'),

        HALLOWEEN_SKINS =
        {
            [17739805] = 45, -- Olwyn
        },
    },
}

return zones[xi.zone.BASTOK_MARKETS]
