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
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        CANNOT_OBTAIN_THE_ITEM        = 6386,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6395,  -- You do not have enough gil.
        YOU_OBTAIN_ITEM               = 6396,  -- You obtain  <item>!
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        YOU_MUST_WAIT_ANOTHER_N_DAYS  = 6426,  -- You must wait another <number> [day/days] to perform that action.
        CARRIED_OVER_POINTS           = 6429,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6430,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6431,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6451,  -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6490,  -- Home point set!
        YOU_ACCEPT_THE_MISSION        = 6519,  -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET       = 6524,  -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE                 = 6592,  -- Tallying conquest results...
        MOG_LOCKER_OFFSET             = 6886,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        MAP_MARKER_TUTORIAL           = 7084,  -- Selecting Map from the main menu opens the map of the area in which you currently reside. Select Markers and press the right arrow key to see all the markers placed on your map.
        GOLDSMITHING_SUPPORT          = 7091,  -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT      = 7105,  -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT            = 7113,  -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE           = 7120,  -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                   = 7125,  -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP            = 7126,  -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN            = 7139,  -- Renounce your rank at which guild? None. Carpenters'. Blacksmiths'. Goldsmiths'. Weavers'. Tanners'. Boneworkers'. Alchemists'. Culinarians'.
        FISHING_MESSAGE_OFFSET        = 7222,  -- You can't fish here.
        SOMNPAEMN_CLOSED_DIALOG       = 7588,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Sarutabaruta, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        YAFAFA_CLOSED_DIALOG          = 7589,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Kolshushu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        OGGODETT_CLOSED_DIALOG        = 7590,  -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Aragoneu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        ITEM_DELIVERY_DIALOG          = 7677,  -- Need something sent to a friend's house? Sending items to your own room? You've come to the right place!
        TEERTH_SHOP_DIALOG            = 7691,  -- Welcome to the Goldsmiths' Guild shop. What can I do for you?
        VISALA_SHOP_DIALOG            = 7692,  -- Welcome to the Goldsmiths' Guild shop. How may I help you?
        ZHIKKOM_SHOP_DIALOG           = 7693,  -- Hello! Welcome to the only weaponry store in Bastok, the Dragon's Claws!
        CIQALA_SHOP_DIALOG            = 7694,  -- A weapon is the most precious thing to an adventurer! Well, after his life, of course. Choose wisely.
        PERITRAGE_SHOP_DIALOG         = 7695,  -- Hey! I've got just the thing for you!
        BRUNHILDE_SHOP_DIALOG         = 7696,  -- Welcome to my store! You want armor, you want shields? I've got them all!
        CHARGINGCHOCOBO_SHOP_DIALOG   = 7697,  -- Hello. What piece of armor are you missing?
        BALTHILDA_SHOP_DIALOG         = 7698,  -- Feeling defenseless of late? Brunhilde's Armory has got you covered!
        MJOLL_SHOP_DIALOG             = 7699,  -- Welcome. Have a look and compare! You'll never find better wares anywhere.
        OLWYN_SHOP_DIALOG             = 7700,  -- Welcome to Mjoll's Goods! What can I do for you?
        ZAIRA_SHOP_DIALOG             = 7701,  -- Greetings. What spell are you looking for?
        SORORO_SHOP_DIALOG            = 7702,  -- Hello-mellow, welcome to Sororo's Scribe and Notary! Hmm? No, we sell magic spells! What did you think?
        HARMODIOS_SHOP_DIALOG         = 7703,  -- Add music to your adventuring life! Welcome to Harmodios's.
        CARMELIDE_SHOP_DIALOG         = 7704,  -- Ah, welcome, welcome! What might I interest you in?
        RAGHD_SHOP_DIALOG             = 7705,  -- Give a smile to that special someone! Welcome to Carmelide's.
        HORTENSE_SHOP_DIALOG          = 7706,  -- Hello there! We have instruments and music sheets at Harmodios's!
        OGGODETT_OPEN_DIALOG          = 7707,  -- Hello there! Might I interest you in some specialty goods from Aragoneu?
        YAFAFA_OPEN_DIALOG            = 7708,  -- Hello! I've got some goods from Kolshushu--interested?
        SOMNPAEMN_OPEN_DIALOG         = 7709,  -- Welcome! I have goods straight from Sarutabaruta! What say you?
        CONQUEST                      = 7800,  -- You've earned conquest points!
        EXTENDED_MISSION_OFFSET       = 8162,  -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TRICK_OR_TREAT                = 8285,  -- Trick or treat...
        THANK_YOU_TREAT               = 8286,  -- Thank you... And now for your treat...
        HERE_TAKE_THIS                = 8287,  -- Here, take this...
        IF_YOU_WEAR_THIS              = 8288,  -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                     = 8289,  -- Thank you...
        RETRIEVE_DIALOG_ID            = 12895, -- You retrieve <item> from the porter moogle's care.
        TURNING_IN_SPARKS             = 14220, -- Ohohoho... Turning in sparks, I see.
        DO_NOT_POSSESS_ENOUGH         = 14244, -- You do not possess enough <item> to complete the transaction.
        NOT_ENOUGH_SPARKS             = 14245, -- You do not possess enough sparks of eminence to complete the transaction.
        MAX_SPARKS_LIMIT_REACHED      = 14246, -- You have reached the maximum number of sparks that you can exchange this week (<number>). Your ability to purchase skill books and equipment will be restricted until next week.
        YOU_NOW_HAVE_AMT_CURRENCY     = 14256, -- You now have <number> [sparks of eminence/conquest points/points of imperial standing/Allied Notes/bayld/Fields of Valor points/assault points (Leujaoam)/assault points (Mamool Ja Training Grounds)/assault points (Lebros Cavern)/assault points (Periqia)/assault points (Ilrusi Atoll)/cruor/kinetic units/obsidian fragments/mweya plasm corpuscles/ballista points/Unity accolades/pinches of Escha silt/resistance credits].
        YOU_HAVE_JOINED_UNITY         = 14559, -- ou have joined [Pieuje's/Ayame's/Invincible Shield's/Apururu's/Maat's/Aldo's/Jakoh Wahcondalo's/Naja Salaheem's/Flaviria's/Yoran-Oran's/Sylvie's] Unity!
        HAVE_ALREADY_CHANGED_UNITY    = 14635, -- ou have already changed Unities. Please wait until the next tabulation period.
        MERRYMAKER_TRADE              = 13964, -- Yum-yums for me? Gobbies remember...till our tummies go rumble-rumble again.
        MERRYMAKER_BLECH              = 13967, -- Blech. What this yucky thing? It make me want upgut food. Take it away.
        MERRYMAKER_TOY                = 13956, -- Happy toy, happy toy, where be me happy toy?
        MERRYMAKER_TOY2               = 13957, -- Ev'ry girl, ev'ry boy, ev'rybody, happy toy! Me nose holes smell the joy, the joy from happy toy! Where cooould iiit beee?
        MERRYMAKER_WAHH               = 15640, -- Waaah! It you! You give yum-yums for me tum-tum. Good [boy, girl]!
        MERRYMAKER_GIVE               = 15641, -- Not for us, not for me? I give it back. Now you happy? Happy toy, happy toy, where be me happy toy?
        MERRYMAKER_NO                 = 15642, -- No no no no no! Go away! Nose holes busy sniff for happy toy!
        MERRYMAKER_FRIEND             = 15644, -- You have friend you do? We gobbies have friend too.
        MERRYMAKER_NPC_RETURNED       = 14002, -- I see you've returned. Mmm...that's good news indeed. Thank you for the kindess you've shown me and my friend.
        MERRYMAKER_DEFAULT            = 13962, -- ...
    },
    mob =
    {
    },
    npc =
    {
        AQUILLINA = GetFirstID("Aquillina"),

        HALLOWEEN_SKINS =
        {
            [17739805] = 45, -- Olwyn
        },
        STARLIGHT_DECORATIONS =
        {
            [17740161] = 17740161,  -- Starlight Celebration Center Fountain
            [17740162] = 17740162,  -- Starlight Celebration Planter
            [17740163] = 17740163,  -- Starlight Celebration Planter
            [17740164] = 17740164,  -- Starlight Celebration Planter
            [17740165] = 17740165,  -- Starlight Celebration Planter
            [17740166] = 17740166,  -- Starlight Celebration Planter
            [17740167] = 17740167,  -- Starlight Celebration Planter
            [17740168] = 17740168,  -- Starlight Celebration Planter
            [17740169] = 17740169,  -- Starlight Celebration Planter
            [17740170] = 17740170,  -- Starlight Celebration Planter
            [17740171] = 17740171,  -- Starlight Celebration Planter
            [17740172] = 17740172,  -- Starlight Celebration Planter
            [17740173] = 17740173,  -- Starlight Celebration Planter
            [17740174] = 17740174,  -- Starlight Celebration Planter
            [17740175] = 17740175,  -- Starlight Celebration Planter
            [17740176] = 17740176,  -- Starlight Celebration Planter
            [17740177] = 17740177,  -- Starlight Celebration Planter
            [17740178] = 17740178,  -- Starlight Celebration Planter
            [17740179] = 17740179,  -- Starlight Celebration Planter
            [17740180] = 17740180,  -- Starlight Celebration Planter
            [17740181] = 17740181,  -- Starlight Celebration Planter
            [17740182] = 17740182,  -- Starlight Celebration Planter
            [17740183] = 17740183,  -- Starlight Celebration Planter
            [17740184] = 17740184,  -- Token Moogle
            [17740185] = 17740185,  -- Event Moogle
            [17739906] = 17739906,  -- Goblin Merrymaker
            [17739907] = 17739907,  -- Goblin Merrymaker
            [17739908] = 17739908,  -- Goblin Merrymaker
            [17739909] = 17739909,  -- Goblin Merrymaker
            [17739910] = 17739910,  -- Goblin Merrymaker
            [17739911] = 17739911,  -- Goblin Merrymaker
            [17739912] = 17739912,  -- Goblin Merrymaker
            [17739913] = 17739913,  -- Goblin Merrymaker
            [17739914] = 17739914,  -- Goblin Merrymaker
            [17739915] = 17739915,  -- Goblin Merrymaker
        },

    },
}

return zones[xi.zone.BASTOK_MARKETS]
