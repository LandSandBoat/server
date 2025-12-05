-----------------------------------
-- Functions for Shop system
-----------------------------------
require('scripts/globals/conquest')
-----------------------------------
xi = xi or {}
xi.shop = xi.shop or {}
-----------------------------------
local marketsID    = zones[xi.zone.BASTOK_MARKETS]
local metalworksID = zones[xi.zone.METALWORKS]
local minesID      = zones[xi.zone.BASTOK_MINES]
local northSandyID = zones[xi.zone.NORTHERN_SAN_DORIA]
local portBastokID = zones[xi.zone.PORT_BASTOK]
local portSandyID  = zones[xi.zone.PORT_SAN_DORIA]
local portWindyID  = zones[xi.zone.PORT_WINDURST]
local southSandyID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local watersID     = zones[xi.zone.WINDURST_WATERS]
local woodsID      = zones[xi.zone.WINDURST_WOODS]

-- send general shop dialog to player
-- stock cuts off after 16 items. if you add more, extras will not display
-- stock is of form { itemId1, price1, itemId2, price2, ... }
-- log is a fame area from xi.fameArea
xi.shop.general = function(player, stock, log)
    local priceMultiplier = 1

    if log then
        priceMultiplier = (1 + (0.20 * (9 - player:getFameLevel(log)) / 8)) * xi.settings.main.SHOP_PRICE
    else
        log = -1
    end

    player:createShop(#stock, log)

    for _, stockItem in ipairs(stock) do
        player:addShopItem(stockItem[1], math.floor(stockItem[2] * priceMultiplier))
    end

    player:sendMenu(xi.menuType.SHOP)
end

-- send general guild shop dialog to player (Added on June 2014 QoL)
-- stock is of form { { itemId, price, guildRank }, ... }
-- log is default set to -1 as it's needed as part of createShop()
xi.shop.generalGuild = function(player, stock, guildSkillId)
    local log = -1

    if stock == nil then
        player:printToPlayer(string.format(
            '[GUILD SHOP] No stock table for guild skill id %s.',
            tostring(guildSkillId)
        ))
        return
    end

    player:createShop(#stock, log)

    for idx, stockItem in ipairs(stock) do
        local itemId = stockItem[1]
        local price  = stockItem[2]
        local rank   = stockItem[3]

        if type(itemId) ~= 'number' or type(price) ~= 'number' or type(rank) ~= 'number' then
            -- This will print into your map-server console/log
            printf(
                '[GUILD SHOP] Bad stock entry #%d for guild skill %s: item=%s price=%s rank=%s',
                idx,
                tostring(guildSkillId),
                tostring(itemId),
                tostring(price),
                tostring(rank)
            )
        else
            player:addShopItem(itemId, price, guildSkillId, rank)
        end
    end

    player:sendMenu(xi.menuType.SHOP)
end


-- send curio vendor moogle shop shop dialog to player
-- stock is of form { itemId1, price1, keyItemRequired, ... }
-- log is default set to -1 as it's needed as part of createShop()
xi.shop.curioVendorMoogle = function(player, stock)
    local log = -1

    player:createShop(#stock / 3, log)

    for _, stockItem in ipairs(stock) do
        if player:hasKeyItem(stockItem[3]) then
            player:addShopItem(stockItem[1], stockItem[2])
        end
    end

    player:sendMenu(xi.menuType.SHOP)
end

-----------------------------------
-- option IDs for Curio Vendor Moogle Menu
-----------------------------------
xi.shop.curio =
{
    ['medicine']        = 1,
    ['ammunition']      = 2,
    ['ninjutsuTools']   = 3,
    ['foodStuffs']      = 4,
    ['scrolls']         = 5,
    ['keys']            = 6,
    -- keyitems not implemented yet
}

-- send nation shop dialog to player
-- stock cuts off after 16 items. if you add more, extras will not display
-- stock is of form { itemId1, price1, place1, itemId2, price2, place2, ... }
--     where place is what place the nation must be in for item to be stocked
-- nation is a xi.nation ID from scripts/enum/nation.lua
xi.shop.nation = function(player, stock, nation)
    local rank     = GetNationRank(nation)
    local newStock = {}
    for _, stockItem in ipairs(stock) do
        if
            (stockItem[3] == 1 and player:getNation() == nation and rank == 1) or
            (stockItem[3] == 2 and rank <= 2) or
            (stockItem[3] == 3)
        then
            table.insert(newStock, { stockItem[1], stockItem[2] })
        end
    end

    xi.shop.general(player, newStock, nation)
end

-- send outpost shop dialog to player
xi.shop.outpost = function(player)
    local stock =
    {
        { xi.item.ANTIDOTE,             316 },
        { xi.item.FLASK_OF_ECHO_DROPS,  800 },
        { xi.item.ETHER,               4832 },
        { xi.item.FLASK_OF_EYE_DROPS,  2595 },
        { xi.item.POTION,               910 },
    }
    xi.shop.general(player, stock)
end

-- send celebratory chest shop dialog to player
xi.shop.celebratory = function(player)
    local stock =
    {
        { xi.item.CRACKER,                 30 },
        { xi.item.TWINKLE_SHOWER,          30 },
        { xi.item.POPSTAR,                 60 },
        { xi.item.BRILLIANT_SNOW,          60 },
        { xi.item.OUKA_RANMAN,             30 },
        { xi.item.LITTLE_COMET,            30 },
        { xi.item.POPPER,                 650 },
        { xi.item.WEDDING_BELL,          1000 },
        { xi.item.SERENE_SERINETTE,      6000 },
        { xi.item.JOYOUS_SERINETTE,      6000 },
        { xi.item.BOTTLE_OF_GRAPE_JUICE, 1116 },
        { xi.item.INFERNO_CRYSTAL,       3000 },
        { xi.item.TERRA_CRYSTAL,         3000 },
        { xi.item.TORRENT_CRYSTAL,       3000 },
        { xi.item.CYCLONE_CRYSTAL,       3000 },
        { xi.item.GLACIER_CRYSTAL,       3000 },
		{ xi.item.PLASMA_CRYSTAL,        3000 },
        { xi.item.AURORA_CRYSTAL,        3000 },
        { xi.item.TWILIGHT_CRYSTAL,      3000 },

    }
    xi.shop.general(player, stock)
end

-- stock for guild vendors that are open 24/8
xi.shop.generalGuildStock =
{
    [xi.skill.COOKING] =
    {
        { xi.item.CHUNK_OF_ROCK_SALT,             16, xi.craftRank.AMATEUR    },
        { xi.item.FLASK_OF_DISTILLED_WATER,       12, xi.craftRank.AMATEUR    },
        { xi.item.LIZARD_EGG,                    100, xi.craftRank.AMATEUR    },
        { xi.item.SARUTA_ORANGE,                  32, xi.craftRank.AMATEUR    },
        { xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,     76, xi.craftRank.AMATEUR    },
        { xi.item.JAR_OF_MISO,                  2500, xi.craftRank.AMATEUR    },
        { xi.item.JAR_OF_SOY_SAUCE,             2500, xi.craftRank.AMATEUR    },
        { xi.item.HANDFUL_OF_DRIED_BONITO,      2500, xi.craftRank.AMATEUR    },
        { xi.item.BAG_OF_SAN_DORIAN_FLOUR,        60, xi.craftRank.RECRUIT    },
        { xi.item.POT_OF_MAPLE_SUGAR,             40, xi.craftRank.RECRUIT    },
        { xi.item.FAERIE_APPLE,                   44, xi.craftRank.RECRUIT    },
        { xi.item.JUG_OF_SELBINA_MILK,            60, xi.craftRank.RECRUIT    },
        { xi.item.POT_OF_HONEY,                  200, xi.craftRank.RECRUIT    },
        { xi.item.KAZHAM_PINEAPPLE,               60, xi.craftRank.INITIATE   },
        { xi.item.LA_THEINE_CABBAGE,              24, xi.craftRank.INITIATE   },
        { xi.item.BAG_OF_RYE_FLOUR,               40, xi.craftRank.INITIATE   },
        { xi.item.THUNDERMELON,                  325, xi.craftRank.NOVICE     },
        { xi.item.WATERMELON,                    200, xi.craftRank.NOVICE     },
        { xi.item.STICK_OF_SELBINA_BUTTER,        60, xi.craftRank.NOVICE     },
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,        60, xi.craftRank.APPRENTICE },
        { xi.item.BLOCK_OF_GELATIN,              900, xi.craftRank.APPRENTICE },
        { xi.item.SERVING_OF_SPAGHETTI,         3000, xi.craftRank.JOURNEYMAN },
        { xi.item.JAR_OF_GROUND_WASABI,         2595, xi.craftRank.JOURNEYMAN },
        { xi.item.PIECE_OF_PIE_DOUGH,           1600, xi.craftRank.CRAFTSMAN  },
        { xi.item.PIECE_OF_PIZZA_DOUGH,         3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.AZUKI_BEAN,                    600, xi.craftRank.CRAFTSMAN  },
        -- kits																     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.COOKING_KIT_5,                 148, xi.craftRank.AMATEUR    }, -- 74g 	(Pebble Soup)
        { xi.item.COOKING_KIT_10,                100, xi.craftRank.AMATEUR    }, -- 50g	(Orange Juice)
        { xi.item.COOKING_KIT_15,                 80, xi.craftRank.RECRUIT    }, -- 40g	(Slice of Bluetail x4)
        { xi.item.COOKING_KIT_20,                152, xi.craftRank.RECRUIT    }, -- 76g	(Apple Juice)
        { xi.item.COOKING_KIT_25,                512, xi.craftRank.INITIATE   }, -- 256g	(Vegetable Soup)
        { xi.item.COOKING_KIT_30,                194, xi.craftRank.INITIATE   }, -- 97g	(Pineapple Juice)
        { xi.item.COOKING_KIT_35,                240, xi.craftRank.NOVICE     }, -- 120g	(Meatball x12)
        { xi.item.COOKING_KIT_40,                440, xi.craftRank.NOVICE     }, -- 220g 	(Melon Juice)
        { xi.item.COOKING_KIT_45,                698, xi.craftRank.APPRENTICE }, -- 349g	(Menemen)
        { xi.item.COOKING_KIT_50,                616, xi.craftRank.APPRENTICE }, -- 308g	(Apple Pie x4)
		{ xi.item.COOKING_KIT_55,                336, xi.craftRank.JOURNEYMAN }, -- 168g	(Beaugreen Saute)
		{ xi.item.COOKING_KIT_60,                996, xi.craftRank.JOURNEYMAN }, -- 498g	(Green Quiche)
		{ xi.item.COOKING_KIT_65,               1820, xi.craftRank.CRAFTSMAN  }, -- 910g	(Ratatouille)
        { xi.item.COOKING_KIT_70,                384, xi.craftRank.CRAFTSMAN  }, -- 192g	(San d'Orian tea)
        { xi.item.COOKING_KIT_75,               5838, xi.craftRank.ARTISAN    }, -- 2919g	(Celerity Salad)
        { xi.item.COOKING_KIT_80,               2870, xi.craftRank.ARTISAN    }, -- 1435g	(Shallops Tropicale)
        { xi.item.COOKING_KIT_85,               1412, xi.craftRank.ADEPT      }, -- 706g	(Yellow Curry)
        { xi.item.COOKING_KIT_90,               1320, xi.craftRank.ADEPT      }, -- 660g	(Vampire Juice)
        { xi.item.COOKING_KIT_95,               1578, xi.craftRank.VETERAN    }, -- 789g	(Dragon Steak)
	},

    [xi.skill.CLOTHCRAFT] =
    {
        { xi.item.SPINDLE,                        75, xi.craftRank.AMATEUR    },
        { xi.item.SPOOL_OF_ZEPHYR_THREAD,         75, xi.craftRank.AMATEUR    },
        { xi.item.CLUMP_OF_MOKO_GRASS,            20, xi.craftRank.AMATEUR    },
        { xi.item.BALL_OF_SARUTA_COTTON,         500, xi.craftRank.RECRUIT    },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,       200, xi.craftRank.RECRUIT    },
        { xi.item.SPOOL_OF_LINEN_THREAD,         150, xi.craftRank.INITIATE   },
        { xi.item.SPOOL_OF_WOOL_THREAD,         2800, xi.craftRank.NOVICE     },
        { xi.item.CLUMP_OF_MOHBWA_GRASS,         800, xi.craftRank.APPRENTICE },
        { xi.item.SPOOL_OF_SILK_THREAD,         1500, xi.craftRank.APPRENTICE },
        { xi.item.CLUMP_OF_KARAKUL_WOOL,        1400, xi.craftRank.JOURNEYMAN },
        { xi.item.SPOOL_OF_GOLD_THREAD,        14500, xi.craftRank.CRAFTSMAN  },
        -- kits									   						         -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.CLOTHCRAFT_KIT_5,              140, xi.craftRank.AMATEUR    }, -- 70g	(Headgear)
        { xi.item.CLOTHCRAFT_KIT_10,             238, xi.craftRank.AMATEUR    }, -- 119g	(Doublet)
        { xi.item.CLOTHCRAFT_KIT_15,             124, xi.craftRank.RECRUIT    }, -- 62g	(Red Grass Thread)
        { xi.item.CLOTHCRAFT_KIT_20,             764, xi.craftRank.RECRUIT    }, -- 382g	(Cotton Headband)
        { xi.item.CLOTHCRAFT_KIT_25,             630, xi.craftRank.INITIATE   }, -- 315g	(Bracers)
        { xi.item.CLOTHCRAFT_KIT_30,             600, xi.craftRank.INITIATE   }, -- 300g	(Fisherman's Tunica)
        { xi.item.CLOTHCRAFT_KIT_35,            1200, xi.craftRank.NOVICE     }, -- 600g	(Wool Thread)
        { xi.item.CLOTHCRAFT_KIT_40,            2352, xi.craftRank.NOVICE     }, -- 1176g	(Shadow Roll x3)
        { xi.item.CLOTHCRAFT_KIT_45,            8468, xi.craftRank.APPRENTICE }, -- 4234g	(Wool Cap)
        { xi.item.CLOTHCRAFT_KIT_50,            1122, xi.craftRank.APPRENTICE }, -- 561g	(Velvet Cloth)
		{ xi.item.CLOTHCRAFT_KIT_55,            1214, xi.craftRank.JOURNEYMAN }, -- 607g	(Mohbwa Scarf)
		{ xi.item.CLOTHCRAFT_KIT_60,            5440, xi.craftRank.JOURNEYMAN }, -- 2720g	(Black Mitts)
		{ xi.item.CLOTHCRAFT_KIT_64,            2584, xi.craftRank.CRAFTSMAN  }, -- 1292g	(White Cape)
        { xi.item.CLOTHCRAFT_KIT_70,            4408, xi.craftRank.CRAFTSMAN  }, -- 2204g	(Gold Obi) 
        { xi.item.CLOTHCRAFT_KIT_75,            8794, xi.craftRank.ARTISAN    }, -- 4397g	(Tabin Bracers)
        { xi.item.CLOTHCRAFT_KIT_80,            5964, xi.craftRank.ARTISAN    }, -- 2982g	(Brocade Obi)
        { xi.item.CLOTHCRAFT_KIT_85,            7820, xi.craftRank.ADEPT      }, -- 3910g	(Rainbow Headband)
        { xi.item.CLOTHCRAFT_KIT_90,            7680, xi.craftRank.ADEPT      }, -- 3840g	(Rainbow Obi)
        { xi.item.CLOTHCRAFT_KIT_95,            7200, xi.craftRank.VETERAN    }, -- 3600g	(Tarutaru Sash)
	},

    [xi.skill.GOLDSMITHING] =
    {
        { xi.item.WORKSHOP_ANVIL,                 75, xi.craftRank.AMATEUR    },
        { xi.item.MANDREL,                        75, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_ZINC_ORE,             200, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_COPPER_ORE,            12, xi.craftRank.AMATEUR    },
        { xi.item.BRASS_NUGGET,                   40, xi.craftRank.RECRUIT    },
        { xi.item.BRASS_SHEET,                   300, xi.craftRank.RECRUIT    },
        { xi.item.CHUNK_OF_SILVER_ORE,           450, xi.craftRank.RECRUIT    },
        { xi.item.SILVER_NUGGET,                 200, xi.craftRank.INITIATE   },
        { xi.item.TOURMALINE,                   1863, xi.craftRank.INITIATE   },
        { xi.item.SARDONYX,                     1863, xi.craftRank.INITIATE   },
        { xi.item.CLEAR_TOPAZ,                  1863, xi.craftRank.INITIATE   },
        { xi.item.AMETHYST,                     1863, xi.craftRank.INITIATE   },
        { xi.item.LAPIS_LAZULI,                 1863, xi.craftRank.INITIATE   },
        { xi.item.AMBER_STONE,                  1863, xi.craftRank.INITIATE   },
        { xi.item.ONYX,                         1863, xi.craftRank.INITIATE   },
        { xi.item.LIGHT_OPAL,                   1863, xi.craftRank.INITIATE   },
        { xi.item.SILVER_CHAIN,                23000, xi.craftRank.NOVICE     },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,         2000, xi.craftRank.NOVICE     },
        { xi.item.CHUNK_OF_GOLD_ORE,            3000, xi.craftRank.APPRENTICE },
        { xi.item.MYTHRIL_SHEET,               12000, xi.craftRank.APPRENTICE },
        { xi.item.PERIDOT,                      8000, xi.craftRank.APPRENTICE },
        { xi.item.GARNET,                       8000, xi.craftRank.APPRENTICE },
        { xi.item.GOSHENITE,                    8000, xi.craftRank.APPRENTICE },
        { xi.item.AMETRINE,                     8000, xi.craftRank.APPRENTICE },
        { xi.item.TURQUOISE,                    8000, xi.craftRank.APPRENTICE },
        { xi.item.SPHENE,                       8000, xi.craftRank.APPRENTICE },
        { xi.item.BLACK_PEARL,                 12000, xi.craftRank.APPRENTICE },
        { xi.item.PEARL,                       11000, xi.craftRank.APPRENTICE },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,        5000, xi.craftRank.APPRENTICE },
        { xi.item.GOLD_SHEET,                  32000, xi.craftRank.JOURNEYMAN },
        { xi.item.GOLD_CHAIN,                  58000, xi.craftRank.JOURNEYMAN },
        { xi.item.CHUNK_OF_PLATINUM_ORE,        6000, xi.craftRank.CRAFTSMAN  },
        -- kits 									  						     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.GOLDSMITHING_KIT_5,             38, xi.craftRank.AMATEUR    }, -- 19g 	(Copper Ring)
        { xi.item.GOLDSMITHING_KIT_10,            96, xi.craftRank.AMATEUR    }, -- 48g 	(Brass Ingot)
        { xi.item.GOLDSMITHING_KIT_15,           280, xi.craftRank.RECRUIT    }, -- 140g 	(Brass Zaghnal)
        { xi.item.GOLDSMITHING_KIT_20,           700, xi.craftRank.RECRUIT    }, -- 350g   (Silver Ingot)
        { xi.item.GOLDSMITHING_KIT_25,           714, xi.craftRank.INITIATE   }, -- 357g   (Silver Belt)
        { xi.item.GOLDSMITHING_KIT_30,          1508, xi.craftRank.INITIATE   }, -- 754g	(Brass Finger Gauntlets)
        { xi.item.GOLDSMITHING_KIT_35,          1222, xi.craftRank.NOVICE     }, -- 611g	(Tigereye Ring)
        { xi.item.GOLDSMITHING_KIT_40,          2500, xi.craftRank.NOVICE     }, -- 1250g	(Mythril Ingot)
        { xi.item.GOLDSMITHING_KIT_45,          2506, xi.craftRank.APPRENTICE }, -- 1253g	(Peridot Earring)
        { xi.item.GOLDSMITHING_KIT_50,          1644, xi.craftRank.APPRENTICE }, -- 822g	(Aluminum Sheet)
		{ xi.item.GOLDSMITHING_KIT_55,          5908, xi.craftRank.JOURNEYMAN }, -- 2954g	(Heater Shield)
		{ xi.item.GOLDSMITHING_KIT_60,          7094, xi.craftRank.JOURNEYMAN }, -- 3547g	(Mythril Cuisses)
		{ xi.item.GOLDSMITHING_KIT_65,          3962, xi.craftRank.CRAFTSMAN  }, -- 1981g	(Moon Earring)
        { xi.item.GOLDSMITHING_KIT_70,          7118, xi.craftRank.CRAFTSMAN  }, -- 3559g	(Gold Bangles)
        { xi.item.GOLDSMITHING_KIT_75,          6500, xi.craftRank.ARTISAN    }, -- 3250g	(Ashura)
        { xi.item.GOLDSMITHING_KIT_80,          8160, xi.craftRank.ARTISAN    }, -- 4080g	(Gold Buckler)
        { xi.item.GOLDSMITHING_KIT_85,          9582, xi.craftRank.ADEPT      }, -- 4791g	(Platinum Bangles)
        { xi.item.GOLDSMITHING_KIT_90,          7560, xi.craftRank.ADEPT      }, -- 3780g	(Jeweled Collar)
        { xi.item.GOLDSMITHING_KIT_94,          4037, xi.craftRank.VETERAN    }, -- 0g		(Phrygian ring) Price of all items average. 38+96+280+700.../19=4037g.
	},

    [xi.skill.WOODWORKING] =
    {
        { xi.item.SPOOL_OF_BUNDLING_TWINE,       100, xi.craftRank.AMATEUR    },
        { xi.item.ARROWWOOD_LOG,                  25, xi.craftRank.AMATEUR    },
        { xi.item.LAUAN_LOG,                      50, xi.craftRank.AMATEUR    },
        { xi.item.MAPLE_LOG,                      70, xi.craftRank.AMATEUR    },
        { xi.item.HOLLY_LOG,                     800, xi.craftRank.RECRUIT    },
        { xi.item.WILLOW_LOG,                   1600, xi.craftRank.RECRUIT    },
        { xi.item.WALNUT_LOG,                   1300, xi.craftRank.RECRUIT    },
        { xi.item.YEW_LOG,                       500, xi.craftRank.INITIATE   },
        { xi.item.ELM_LOG,                      3800, xi.craftRank.INITIATE   },
        { xi.item.CHESTNUT_LOG,                 3400, xi.craftRank.INITIATE   },
        { xi.item.DOGWOOD_LOG,                  2000, xi.craftRank.NOVICE     },
        { xi.item.OAK_LOG,                      4000, xi.craftRank.NOVICE     },
        { xi.item.ROSEWOOD_LOG,                 4500, xi.craftRank.APPRENTICE },
        { xi.item.MAHOGANY_LOG,                 4500, xi.craftRank.JOURNEYMAN },
        { xi.item.EBONY_LOG,                    5000, xi.craftRank.CRAFTSMAN  },
        { xi.item.FEYWEALD_LOG,                 5500, xi.craftRank.CRAFTSMAN  },
        -- kits 															     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.WOODWORKING_KIT_5,             112, xi.craftRank.AMATEUR    }, -- 56g		(Padded Box)
        { xi.item.WOODWORKING_KIT_10,             32, xi.craftRank.AMATEUR    }, -- 16g		(Ash Staff)
        { xi.item.WOODWORKING_KIT_15,            274, xi.craftRank.RECRUIT    }, -- 137g 	(Bamboo Fishing Rod)
        { xi.item.WOODWORKING_KIT_20,            440, xi.craftRank.RECRUIT    }, -- 220g	(Piccolo)
        { xi.item.WOODWORKING_KIT_25,            492, xi.craftRank.INITIATE   }, -- 246g	(Tarutaru Stool)
        { xi.item.WOODWORKING_KIT_30,            198, xi.craftRank.INITIATE   }, -- 99g		(Silver Arrow x33)
        { xi.item.WOODWORKING_KIT_35,            660, xi.craftRank.NOVICE     }, -- 330g	(Black Bolt x33)
        { xi.item.WOODWORKING_KIT_40,           1280, xi.craftRank.NOVICE     }, -- 640g	(Bahut)
        { xi.item.WOODWORKING_KIT_45,           1960, xi.craftRank.APPRENTICE }, -- 980g	(Rosewood Lumber)
        { xi.item.WOODWORKING_KIT_50,            462, xi.craftRank.APPRENTICE }, -- 231g	(Sleep Arrow x33)
		{ xi.item.WOODWORKING_KIT_55,            570, xi.craftRank.JOURNEYMAN }, -- 285g	(Fastwater Fishing Rod)
		{ xi.item.WOODWORKING_KIT_60,           4064, xi.craftRank.JOURNEYMAN }, -- 2032g	(Pot of White Viola)
		{ xi.item.WOODWORKING_KIT_65,           1756, xi.craftRank.CRAFTSMAN  }, -- 878g	(Tarutaru Fishing Rod)
        { xi.item.WOODWORKING_KIT_71,           7118, xi.craftRank.CRAFTSMAN  }, -- 4753g	(Ebony Harp)
        { xi.item.WOODWORKING_KIT_74,           2160, xi.craftRank.ARTISAN    }, -- 1080g	(Hume Fishing Rod)
        { xi.item.WOODWORKING_KIT_81,           6400, xi.craftRank.ARTISAN    }, -- 3200g	(Cabinet)
        { xi.item.WOODWORKING_KIT_84,          12924, xi.craftRank.ADEPT      }, -- 6462g	(Numinous Shield)
        { xi.item.WOODWORKING_KIT_90,      	   14000, xi.craftRank.ADEPT      }, -- 7000g	(Mythic Harp)
        { xi.item.WOODWORKING_KIT_94,       	2889, xi.craftRank.VETERAN    }, -- 0g		(Sasah Wand) Price of all items average. 112+32+274+440.../19=2889g.
    },

    [xi.skill.ALCHEMY] =
    {
        { xi.item.TRITURATOR,                     75, xi.craftRank.AMATEUR    },
        { xi.item.BEEHIVE_CHIP,                   40, xi.craftRank.AMATEUR    },
        { xi.item.VIAL_OF_MERCURY,              1700, xi.craftRank.AMATEUR    },
        { xi.item.BLOCK_OF_ANIMAL_GLUE,          300, xi.craftRank.RECRUIT    },
        { xi.item.PINCH_OF_POISON_DUST,          320, xi.craftRank.RECRUIT    },
        { xi.item.VIAL_OF_SLIME_OIL,            1500, xi.craftRank.INITIATE   },
        { xi.item.PINCH_OF_BOMB_ASH,             515, xi.craftRank.INITIATE   },
        { xi.item.BOTTLE_OF_AHRIMAN_TEARS,       200, xi.craftRank.INITIATE   },
        { xi.item.LOOP_OF_GLASS_FIBER,          1200, xi.craftRank.NOVICE     },
        { xi.item.JAR_OF_FIRESAND,              5000, xi.craftRank.NOVICE     },
        { xi.item.FLASH_OF_VITRIOL,              700, xi.craftRank.APPRENTICE },
        { xi.item.BOTTLE_OF_SIEGLINDE_PUTTY,    4000, xi.craftRank.APPRENTICE },
        { xi.item.DRYAD_ROOT,                   1800, xi.craftRank.APPRENTICE },
        { xi.item.LOOP_OF_CARBON_FIBER,         1900, xi.craftRank.JOURNEYMAN },
        { xi.item.HECTEYES_EYE,                 2100, xi.craftRank.JOURNEYMAN },
        { xi.item.JAR_OF_TOAD_OIL,              3600, xi.craftRank.JOURNEYMAN },
        { xi.item.CERMET_CHUNK,                 5000, xi.craftRank.CRAFTSMAN  },
        { xi.item.PINCH_OF_VENOM_DUST,          1035, xi.craftRank.CRAFTSMAN  },
		-- kits 															     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.ALCHEMY_KIT_5,         	     160, xi.craftRank.AMATEUR    }, -- 80g  	(Black Ink x2)
        { xi.item.ALCHEMY_KIT_10,         	     160, xi.craftRank.AMATEUR    }, -- 80g	 	(Deodorizer)
        { xi.item.ALCHEMY_KIT_15,               1386, xi.craftRank.RECRUIT    }, -- 693g	(Cracker)
        { xi.item.ALCHEMY_KIT_20,               2260, xi.craftRank.RECRUIT    }, -- 1130g	(Hushed Baghnakhs)
        { xi.item.ALCHEMY_KIT_25,                640, xi.craftRank.INITIATE   }, -- 320g	(Poison Baselard)
        { xi.item.ALCHEMY_KIT_30,                872, xi.craftRank.INITIATE   }, -- 436g	(Sieglinde Putty)
        { xi.item.ALCHEMY_KIT_35,               4308, xi.craftRank.NOVICE     }, -- 2154g	(Poison Baghnakhs)
        { xi.item.ALCHEMY_KIT_40,               1280, xi.craftRank.NOVICE     }, -- 640g	(Firesand x2)
        { xi.item.ALCHEMY_KIT_45,               1164, xi.craftRank.APPRENTICE }, -- 582g	(Carbon Fiber x3)		
        { xi.item.ALCHEMY_KIT_50,               1208, xi.craftRank.APPRENTICE }, -- 604g	(Ether)
		{ xi.item.ALCHEMY_KIT_55,               2400, xi.craftRank.JOURNEYMAN }, -- 1200g	(Yoto)
		{ xi.item.ALCHEMY_KIT_60,                492, xi.craftRank.JOURNEYMAN }, -- 246g	(Hi-Potion)
		{ xi.item.ALCHEMY_KIT_65,               5338, xi.craftRank.CRAFTSMAN  }, -- 2669g	(Melt Baselard)
        { xi.item.ALCHEMY_KIT_70,              20756, xi.craftRank.CRAFTSMAN  }, -- 10378g	(Saber)
        { xi.item.ALCHEMY_KIT_75,              14580, xi.craftRank.ARTISAN    }, -- 7290g	(Venom Kukri)
        { xi.item.ALCHEMY_KIT_80,              16900, xi.craftRank.ARTISAN    }, -- 8450g	(Stun Knife)
        { xi.item.ALCHEMY_KIT_85,              15200, xi.craftRank.ADEPT      }, -- 7600g	(Bloody Rapier)
        { xi.item.ALCHEMY_KIT_90,              11878, xi.craftRank.ADEPT      }, -- 5939g	(Bloody Lance)
        { xi.item.ALCHEMY_KIT_95,               1578, xi.craftRank.VETERAN    }, -- 789g	(Max-Potion)
    },

    [xi.skill.BONECRAFT] =
    {
        { xi.item.SHAGREEN_FILE,                  75, xi.craftRank.AMATEUR    },
        { xi.item.BONE_CHIP,                     150, xi.craftRank.AMATEUR    },
        { xi.item.HANDFUL_OF_FISH_SCALES,         96, xi.craftRank.AMATEUR    },
        { xi.item.CHICKEN_BONE,                 1500, xi.craftRank.RECRUIT    },
        { xi.item.GIANT_FEMUR,                  1400, xi.craftRank.RECRUIT    },
        { xi.item.BEETLE_SHELL,                  500, xi.craftRank.INITIATE   },
        { xi.item.BEETLE_JAW,                   1000, xi.craftRank.INITIATE   },
        { xi.item.RAM_HORN,                     1800, xi.craftRank.NOVICE     },
        { xi.item.BLACK_TIGER_FANG,             2000, xi.craftRank.NOVICE     },
        { xi.item.CRAB_SHELL,                   2500, xi.craftRank.APPRENTICE },
        { xi.item.TURTLE_SHELL,                 6000, xi.craftRank.JOURNEYMAN },
        { xi.item.SCORPION_CLAW,                2400, xi.craftRank.JOURNEYMAN },
        { xi.item.BUGARD_TUSK,                  4000, xi.craftRank.JOURNEYMAN },
        { xi.item.SCORPION_SHELL,               3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.MARID_TUSK,                   4500, xi.craftRank.CRAFTSMAN  },
        -- kits 															     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.BONECRAFT_KIT_5,         	     112, xi.craftRank.AMATEUR    }, -- 56g		(Shell Powder)
        { xi.item.BONECRAFT_KIT_10,         	  24, xi.craftRank.AMATEUR    }, -- 12g		(Bone Arrowheads x6)
        { xi.item.BONECRAFT_KIT_15,             1272, xi.craftRank.RECRUIT    }, -- 636g	(Fang Necklace)
        { xi.item.BONECRAFT_KIT_20,              410, xi.craftRank.RECRUIT    }, -- 205g	(Bone Axe)
        { xi.item.BONECRAFT_KIT_25,             1178, xi.craftRank.INITIATE   }, -- 589g	(Beetle Ring)
        { xi.item.BONECRAFT_KIT_30,             2468, xi.craftRank.INITIATE   }, -- 1234g	(Beetle Mask)
        { xi.item.BONECRAFT_KIT_35,             1230, xi.craftRank.NOVICE     }, -- 615g	(Turtle Shield)
        { xi.item.BONECRAFT_KIT_40,             1566, xi.craftRank.NOVICE     }, -- 783g	(Bone Cudgel)
        { xi.item.BONECRAFT_KIT_45,             2072, xi.craftRank.APPRENTICE }, -- 1036g	(Carapace Mask)		
        { xi.item.BONECRAFT_KIT_50,             2244, xi.craftRank.APPRENTICE }, -- 1122g	(Bone Rod)
		{ xi.item.BONECRAFT_KIT_55,             3500, xi.craftRank.JOURNEYMAN }, -- 1750g	(Tortoise Earring)	
		{ xi.item.BONECRAFT_KIT_60,              900, xi.craftRank.JOURNEYMAN }, -- 450g	(Scorpion Ring)
		{ xi.item.BONECRAFT_KIT_65,              430, xi.craftRank.CRAFTSMAN  }, -- 215g	(Ladybug Ring)
        { xi.item.BONECRAFT_KIT_70,             2306, xi.craftRank.CRAFTSMAN  }, -- 1153g	(Demon's Ring)
        { xi.item.BONECRAFT_KIT_75,             5256, xi.craftRank.ARTISAN    }, -- 2628g	(Ladybug Earring)
        { xi.item.BONECRAFT_KIT_80,             8608, xi.craftRank.ARTISAN    }, -- 4304g	(Coral Ring)
        { xi.item.BONECRAFT_KIT_85,             1500, xi.craftRank.ADEPT      }, -- 750g	(Hellish Bugle)
        { xi.item.BONECRAFT_KIT_90,             7816, xi.craftRank.ADEPT      }, -- 3908g	(Dragon Claws)
        { xi.item.BONECRAFT_KIT_95,            27582, xi.craftRank.VETERAN    }, -- 13791g	(Carapace Breastplate)
    },

    [xi.skill.LEATHERCRAFT] =
    {
        { xi.item.TANNING_VAT,                    75, xi.craftRank.AMATEUR    },
        { xi.item.SHEEPSKIN,                     100, xi.craftRank.AMATEUR    },
        { xi.item.RABBIT_HIDE,                    80, xi.craftRank.AMATEUR    },
        { xi.item.LIZARD_SKIN,                   600, xi.craftRank.RECRUIT    },
        { xi.item.KARAKUL_SKIN,                  600, xi.craftRank.RECRUIT    },
        { xi.item.WOLF_HIDE,                     600, xi.craftRank.RECRUIT    },
        { xi.item.DHALMEL_HIDE,                 2400, xi.craftRank.INITIATE   },
        { xi.item.BUGARD_SKIN,                  2500, xi.craftRank.INITIATE   },
        { xi.item.RAM_SKIN,                     1500, xi.craftRank.NOVICE     },
        { xi.item.BUFFALO_HIDE,                16000, xi.craftRank.APPRENTICE },
        { xi.item.RAPTOR_SKIN,                  3000, xi.craftRank.JOURNEYMAN },
        { xi.item.CATOBLEPAS_HIDE,              2500, xi.craftRank.JOURNEYMAN },
        { xi.item.SMILODON_HIDE,                3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.COCKATRICE_SKIN,              3000, xi.craftRank.CRAFTSMAN  },
        -- kits 															     -- Return on Craft (Profits:) Test Complete! Prices ajusted.
		{ xi.item.LEATHERCRAFT_KIT_5,         	 104, xi.craftRank.AMATEUR    }, -- 52g 	(Leather Bandana)
        { xi.item.LEATHERCRAFT_KIT_10,         	 184, xi.craftRank.AMATEUR    }, -- 92g		(Leather Vest)
        { xi.item.LEATHERCRAFT_KIT_15,           354, xi.craftRank.RECRUIT    }, -- 177g	(Lizard Helm)
        { xi.item.LEATHERCRAFT_KIT_20,           360, xi.craftRank.RECRUIT    }, -- 180g	(Fisherman's Boots)
        { xi.item.LEATHERCRAFT_KIT_25,           672, xi.craftRank.INITIATE   }, -- 336g	(Warrior's Belt)
        { xi.item.LEATHERCRAFT_KIT_30,          3360, xi.craftRank.INITIATE   }, -- 1680g	(Studded Trousers)
        { xi.item.LEATHERCRAFT_KIT_35,          1208, xi.craftRank.NOVICE     }, -- 604g	(Ram Leather)
        { xi.item.LEATHERCRAFT_KIT_40,          1330, xi.craftRank.NOVICE     }, -- 665g	(Field Boots)
        { xi.item.LEATHERCRAFT_KIT_45,          3360, xi.craftRank.APPRENTICE }, -- 1680g	(Cuir Trousers)	
        { xi.item.LEATHERCRAFT_KIT_50,          2560, xi.craftRank.APPRENTICE }, -- 1280g	(Leather Shield)
		{ xi.item.LEATHERCRAFT_KIT_55,          7200, xi.craftRank.JOURNEYMAN }, -- 3600g	(Raptor Gloves)	
		{ xi.item.LEATHERCRAFT_KIT_60,          1570, xi.craftRank.JOURNEYMAN }, -- 785g	(Hard Leather Ring)
		{ xi.item.LEATHERCRAFT_KIT_66,          7766, xi.craftRank.CRAFTSMAN  }, -- 3883g	(Battle Boots)
        { xi.item.LEATHERCRAFT_KIT_70,         15790, xi.craftRank.CRAFTSMAN  }, -- 7895g	(Behemoth Mantle)
        { xi.item.LEATHERCRAFT_KIT_75,          2500, xi.craftRank.ARTISAN    }, -- 1250g	(Tiger Mantle)
        { xi.item.LEATHERCRAFT_KIT_79,          4132, xi.craftRank.ARTISAN    }, -- 2066g	(Marid Mantle)
        { xi.item.LEATHERCRAFT_KIT_85,          4304, xi.craftRank.ADEPT      }, -- 2152g	(Coeurl Mantle)
        { xi.item.LEATHERCRAFT_KIT_90,          8688, xi.craftRank.ADEPT      }, -- 4344g	(Koenigs Belt)
        { xi.item.LEATHERCRAFT_KIT_95,         15526, xi.craftRank.VETERAN    }, -- 7763g	(Peiste Mantle)
    },

    [xi.skill.SMITHING] =
    {
        { xi.item.WORKSHOP_ANVIL,                 75, xi.craftRank.AMATEUR    },
        { xi.item.MANDREL,                        75, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_COPPER_ORE,            12, xi.craftRank.AMATEUR    },
        { xi.item.BRONZE_NUGGET,                  70, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_TIN_ORE,               60, xi.craftRank.RECRUIT    },
        { xi.item.BRONZE_SHEET,                  120, xi.craftRank.RECRUIT    },
        { xi.item.CHUNK_OF_IRON_ORE,             900, xi.craftRank.RECRUIT    },
        { xi.item.CHUNK_OF_KOPPARNICKEL_ORE,     800, xi.craftRank.INITIATE   },
        { xi.item.IRON_NUGGET,                   500, xi.craftRank.INITIATE   },
        { xi.item.IRON_SHEET,                   6000, xi.craftRank.INITIATE   },
        { xi.item.STEEL_SHEET,                 10000, xi.craftRank.NOVICE     },
        { xi.item.STEEL_INGOT,                  6000, xi.craftRank.APPRENTICE },
        { xi.item.LUMP_OF_TAMA_HAGANE,         12000, xi.craftRank.APPRENTICE },
        { xi.item.DARKSTEEL_NUGGET,             2700, xi.craftRank.JOURNEYMAN },
        { xi.item.CHUNK_OF_DARKSTEEL_ORE,       7000, xi.craftRank.JOURNEYMAN },
        { xi.item.STEEL_NUGGET,                  800, xi.craftRank.JOURNEYMAN },
        { xi.item.DARKSTEEL_SHEET,             28000, xi.craftRank.JOURNEYMAN },
        { xi.item.CHUNK_OF_SWAMP_ORE,           5000, xi.craftRank.CRAFTSMAN  },
        -- kits 															     -- Return on Craft (Profits:) In progress...
		{ xi.item.SMITHING_KIT_5,         	     104, xi.craftRank.AMATEUR    }, -- 
        { xi.item.SMITHING_KIT_10,         	     184, xi.craftRank.AMATEUR    }, -- 
        { xi.item.SMITHING_KIT_15,               354, xi.craftRank.RECRUIT    }, -- 
        { xi.item.SMITHING_KIT_20,               360, xi.craftRank.RECRUIT    }, -- 
        { xi.item.SMITHING_KIT_25,               672, xi.craftRank.INITIATE   }, -- 
        { xi.item.SMITHING_KIT_30,              3360, xi.craftRank.INITIATE   }, -- 
        { xi.item.SMITHING_KIT_35,              1208, xi.craftRank.NOVICE     }, -- 
        { xi.item.SMITHING_KIT_40,              1330, xi.craftRank.NOVICE     }, -- 
        { xi.item.SMITHING_KIT_45,              3360, xi.craftRank.APPRENTICE }, -- 
        { xi.item.SMITHING_KIT_50,              2560, xi.craftRank.APPRENTICE }, -- 
		{ xi.item.SMITHING_KIT_55,              7200, xi.craftRank.JOURNEYMAN }, -- 
		{ xi.item.SMITHING_KIT_60,              1570, xi.craftRank.JOURNEYMAN }, -- 
		{ xi.item.SMITHING_KIT_65,              7766, xi.craftRank.CRAFTSMAN  }, -- 
        { xi.item.SMITHING_KIT_70,             15790, xi.craftRank.CRAFTSMAN  }, -- 
        { xi.item.SMITHING_KIT_76,              2500, xi.craftRank.ARTISAN    }, -- 
        { xi.item.SMITHING_KIT_80,              4132, xi.craftRank.ARTISAN    }, -- 
        { xi.item.SMITHING_KIT_84,              4304, xi.craftRank.ADEPT      }, -- 
        { xi.item.SMITHING_KIT_91,              8688, xi.craftRank.ADEPT      }, -- 
        { xi.item.SMITHING_KIT_94,             15526, xi.craftRank.VETERAN    }, -- 
    },
}

xi.shop.curioVendorMoogleStock =
{
    [xi.shop.curio.medicine] =
    {
        { xi.item.POTION,                  300, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.HI_POTION,               600, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.X_POTION,               1200, xi.ki.RHAPSODY_IN_CRIMSON },
     -- { xi.item.ETHER,                   650, xi.ki.RHAPSODY_IN_WHITE   }, -- Removed by SE June 2021
        { xi.item.HI_ETHER,               1300, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.SUPER_ETHER,            3000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.ELIXIR,                15000, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.ANTIDOTE,                300, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.FLASK_OF_EYE_DROPS,     1000, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.FLASK_OF_ECHO_DROPS,     700, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.BOTTLE_OF_MULSUM,        500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.PINCH_OF_PRISM_POWDER,   500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.POT_OF_SILENT_OIL,       500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.FLASK_OF_DEODORIZER,     250, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.RERAISER,               1000, xi.ki.RHAPSODY_IN_AZURE   },
    },

    [xi.shop.curio.ammunition] =
    {
        { xi.item.STONE_QUIVER,           400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BONE_QUIVER,            680, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.IRON_QUIVER,           1200, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BEETLE_QUIVER,         1350, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SILVER_QUIVER,         2040, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.HORN_QUIVER,           2340, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SLEEP_QUIVER,          3150, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.SCORPION_QUIVER,       3500, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.DEMON_QUIVER,          7000, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.KABURA_QUIVER,         8800, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.ANTLION_QUIVER,        9900, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.BRONZE_BOLT_QUIVER,     400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BLIND_BOLT_QUIVER,      800, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.ACID_BOLT_QUIVER,      1250, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SLEEP_BOLT_QUIVER,     1500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BLOODY_BOLT_QUIVER,    2100, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.VENOM_BOLT_QUIVER,     2100, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.HOLY_BOLT_QUIVER,      2400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.MYTHRIL_BOLT_QUIVER,   3500, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.DARKSTEEL_BOLT_QUIVER, 5580, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.DARKLING_BOLT_QUIVER,  9460, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.FUSION_BOLT_QUIVER,    9790, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.BRONZE_BULLET_POUCH,    400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BULLET_POUCH,          1920, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SPARTAN_BULLET_POUCH,  2400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.IRON_BULLET_POUCH,     4800, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.SILVER_BULLET_POUCH,   4800, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.CORSAIR_BULLET_POUCH,  7100, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.STEEL_BULLET_POUCH,    7600, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.DWEOMER_BULLET_POUCH,  9680, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.OBERON_BULLET_POUCH,   9900, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.SHURIKEN_POUCH,        1400, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.JUJI_SHURIKEN_POUCH,   2280, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.MANJI_SHURIKEN_POUCH,  4640, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.FUMA_SHURIKEN_POUCH,   7000, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.IGA_SHURIKEN_POUCH,    9900, xi.ki.RHAPSODY_IN_CRIMSON },
    },

    [xi.shop.curio.ninjutsuTools] =
    {
        { xi.item.TOOLBAG_UCHITAKE,        3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_TSURARA,         3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_KAWAHORI_OGI,    3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_MAKIBISHI,       3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_HIRAISHIN,       3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_MIZU_DEPPO,      3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_SHIHEI,          5000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_JUSATSU,         5000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_KAGINAWA,        5000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_SAIRUI_RAN,      5000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_KODOKU,          5000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_SHINOBI_TABI,    3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_SANJAKU_TENUGUI, 3000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.TOOLBAG_SOSHI,           5000, xi.ki.RHAPSODY_IN_CRIMSON },
    },
    [xi.shop.curio.foodStuffs] =
    {
        { xi.item.JUG_OF_SELBINA_MILK,         60, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.FLASK_OF_ORANGE_AU_LAIT,    100, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.JUG_OF_ULEGUERAND_MILK,     100, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.FLASK_OF_APPLE_AU_LAIT,     300, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.FLASK_OF_PEAR_AU_LAIT,      600, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.BOTTLE_OF_ORANGE_JUICE,     200, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1100, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.BOTTLE_OF_YAGUDO_DRINK,    2000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.RICE_BALL,                  160, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.STRIP_OF_MEAT_JERKY,        120, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SLICE_OF_GRILLED_HARE,      184, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.MEAT_MITHKABOB,             720, xi.ki.RHAPSODY_IN_UMBER   },
     -- { xi.item.BOILED_CRAB,                550, xi.ki.RHAPSODY_IN_WHITE   }, -- Removed by SE June 2021
        { xi.item.FISH_MITHKABOB,            1080, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.COEURL_SUB,                1500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.ROAST_PIPIRA,               900, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.SLICE_OF_ANCHOVY_PIZZA,     500, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.SLICE_OF_PEPPERONI_PIZZA,   400, xi.ki.RHAPSODY_IN_UMBER   },
        { xi.item.POT_AUF_FEU,               3500, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.JACK_O_LANTERN,            1000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.PLATE_OF_BREAM_SUSHI,      5000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.PLATE_OF_DORADO_SUSHI,     4000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.PLATE_OF_CRAB_SUSHI,       1500, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.CHOCOLATE_CREPE,            500, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.BUTTER_CREPE,              1000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.APPLE_PIE,                  320, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.MELON_PIE,                  800, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.PUMPKIN_PIE,               1200, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.ROAST_MUSHROOM,             344, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.ACORN_COOKIE,                24, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.GINGER_COOKIE,               12, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.SUGAR_RUSK,                1000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.CHOCOLATE_RUSK,            2000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.CHERRY_MACARON,            1000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.COFFEE_MACARON,            2000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.SALTENA,                   1000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.ELSHENA,                   2000, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.MONTAGNA,                  2500, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.STUFFED_PITARU,            1000, xi.ki.RHAPSODY_IN_WHITE   },
        { xi.item.POULTRY_PITARU,            2000, xi.ki.RHAPSODY_IN_AZURE   },
        { xi.item.SEAFOOD_PITARU,            2500, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.PIECE_OF_SHIROMOCHI,       3000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.PIECE_OF_KUSAMOCHI,        3000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.PIECE_OF_AKAMOCHI,         3000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.BEEF_STEWPOT,             15000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.SERVING_OF_ZARU_SOBA,     15000, xi.ki.RHAPSODY_IN_CRIMSON },
        { xi.item.SPICY_CRACKER,              450, xi.ki.RHAPSODY_IN_CRIMSON },
    },

    [xi.shop.curio.scrolls] =
    {
        { xi.item.SCROLL_OF_INSTANT_WARP,      500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.SCROLL_OF_INSTANT_RERAISE,   500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.SCROLL_OF_INSTANT_RETRACE,   500, xi.ki.RHAPSODY_IN_AZURE },
        { xi.item.SCROLL_OF_INSTANT_PROTECT,   500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.SCROLL_OF_INSTANT_SHELL,     500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.SCROLL_OF_INSTANT_STONESKIN, 500, xi.ki.RHAPSODY_IN_UMBER },
    },

    [xi.shop.curio.keys] =
    {
        { xi.item.GHELSBA_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.PALBOROUGH_CHEST_KEY,  2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.GIDDEUS_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.RANPERRE_CHEST_KEY,    2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.DANGRUF_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.HORUTOTO_CHEST_KEY,    2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.ORDELLE_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.GUSGEN_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.SHAKHRAMI_CHEST_KEY,   2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.DAVOI_CHEST_KEY,       2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.BEADEAUX_CHEST_KEY,    2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.OZTROJA_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.DELKFUTT_CHEST_KEY,    2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.FEIYIN_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.ZVAHL_CHEST_KEY,       2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.ELDIEME_CHEST_KEY,     2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.NEST_CHEST_KEY,        2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.GARLAIGE_CHEST_KEY,    2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.BEADEAUX_COFFER_KEY,   5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.DAVOI_COFFER_KEY,      5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.OZTROJA_COFFER_KEY,    5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.NEST_COFFER_KEY,       5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.ELDIEME_COFFER_KEY,    5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.GARLAIGE_COFFER_KEY,   5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.ZVAHL_COFFER_KEY,      5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.UGGALEPIH_COFFER_KEY,  5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.RANCOR_DEN_COFFER_KEY, 5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.KUFTAL_COFFER_KEY,     5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.BOYAHDA_COFFER_KEY,    5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.CAULDRON_COFFER_KEY,   5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.QUICKSAND_COFFER_KEY,  5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.GROTTO_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.ONZOZO_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.TORAIMARI_COFFER_KEY,  5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.GROTTO_COFFER_KEY,     5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.GROTTO_COFFER_KEY,     5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.VELUGANNON_COFFER_KEY, 5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.SACRARIUM_CHEST_KEY,   2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.OLDTON_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
        { xi.item.NEWTON_COFFER_KEY,     5000, xi.ki.RHAPSODY_IN_UMBER },
        { xi.item.PSOXJA_CHEST_KEY,      2500, xi.ki.RHAPSODY_IN_WHITE },
    },
}

-----------------------------------
-- Regional Vendors
-----------------------------------
local regionParam =
{
    REGION           = 1,
    NATION           = 2,
    FAME_AREA        = 3,
    TEXT_OPEN        = 4,
    TEXT_CLOSED      = 5,
    TEXT_UNAVAILABLE = 6,
}

local regionalVendorTable =
{
    ['Antonian'   ] = { xi.region.ARAGONEU, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.ANTONIAN_OPEN_DIALOG, northSandyID.text.ANTONIAN_CLOSED_DIALOG, 0 },
    ['Oggodett'   ] = { xi.region.ARAGONEU, xi.nation.BASTOK,   xi.fameArea.BASTOK,   marketsID.text.OGGODETT_OPEN_DIALOG,    marketsID.text.OGGODETT_CLOSED_DIALOG,    0 },
    ['Maqu_Molpih'] = { xi.region.ARAGONEU, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.MAQUMOLPIH_OPEN_DIALOG,   watersID.text.MAQUMOLPIH_CLOSED_DIALOG,   0 },

    ['Pourette'       ] = { xi.region.DERFLAND, xi.nation.SANDORIA, xi.fameArea.SANDORIA, southSandyID.text.POURETTE_OPEN_DIALOG,  southSandyID.text.POURETTE_CLOSED_DIALOG,  0 },
    ['Belka'          ] = { xi.region.DERFLAND, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.BELKA_OPEN_DIALOG,     portBastokID.text.BELKA_CLOSED_DIALOG,     0 },
    ['Taraihi-Perunhi'] = { xi.region.DERFLAND, xi.nation.WINDURST, xi.fameArea.WINDURST, woodsID.text.TARAIHIPERUNHI_OPEN_DIALOG, woodsID.text.TARAIHIPERUNHI_CLOSED_DIALOG, 0 },

    ['Nimia'     ] = { xi.region.ELSHIMO_LOWLANDS, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.NIMIA_OPEN_DIALOG,      portSandyID.text.NIMIA_CLOSED_DIALOG,      0 },
    ['Zoby_Quhyo'] = { xi.region.ELSHIMO_LOWLANDS, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.ZOBYQUHYO_OPEN_DIALOG, portBastokID.text.ZOBYQUHYO_CLOSED_DIALOG, 0 },
    ['Fomina'    ] = { xi.region.ELSHIMO_LOWLANDS, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.FOMINA_OPEN_DIALOG,        watersID.text.FOMINA_CLOSED_DIALOG,        0 },

    ['Bonmaurieut'      ] = { xi.region.ELSHIMO_UPLANDS, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.BONMAURIEUT_OPEN_DIALOG,      portSandyID.text.BONMAURIEUT_CLOSED_DIALOG,      0 },
    ['Dhen_Tevryukoh'   ] = { xi.region.ELSHIMO_UPLANDS, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.DHENTEVRYUKOH_OPEN_DIALOG,   portBastokID.text.DHENTEVRYUKOH_CLOSED_DIALOG,   0 },
    ['Sattsuh_Ahkanpari'] = { xi.region.ELSHIMO_UPLANDS, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.SATTSUHAHKANPARI_OPEN_DIALOG, portWindyID.text.SATTSUHAHKANPARI_CLOSED_DIALOG, 0 },

    ['Vichuel'           ] = { xi.region.FAUREGANDI, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.VICHUEL_OPEN_DIALOG,          northSandyID.text.VICHUEL_CLOSED_DIALOG,          0 },
    ['Rodellieux'        ] = { xi.region.FAUREGANDI, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.RODELLIEUX_OPEN_DIALOG,            minesID.text.RODELLIEUX_CLOSED_DIALOG,            0 },
    ['Sheia_Pohrichamaha'] = { xi.region.FAUREGANDI, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.SHEIAPOHRICHAMAHA_OPEN_DIALOG, portWindyID.text.SHEIAPOHRICHAMAHA_CLOSED_DIALOG, 0 },

    ['Apairemant'  ] = { xi.region.GUSTABERG, xi.nation.SANDORIA, xi.fameArea.SANDORIA, southSandyID.text.APAIREMANT_OPEN_DIALOG, southSandyID.text.APAIREMANT_CLOSED_DIALOG, 0 },
    ['Evelyn'      ] = { xi.region.GUSTABERG, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.EVELYN_OPEN_DIALOG,     portBastokID.text.EVELYN_CLOSED_DIALOG,     0 },
    ['Nya_Labiccio'] = { xi.region.GUSTABERG, xi.nation.WINDURST, xi.fameArea.WINDURST, woodsID.text.NYALABICCIO_OPEN_DIALOG,     woodsID.text.NYALABICCIO_CLOSED_DIALOG,     0 },

    ['Fiva'    ] = { xi.region.KOLSHUSHU, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.FIVA_OPEN_DIALOG,  portSandyID.text.FIVA_CLOSED_DIALOG,  0 },
    ['Yafafa'  ] = { xi.region.KOLSHUSHU, xi.nation.BASTOK,   xi.fameArea.BASTOK,   marketsID.text.YAFAFA_OPEN_DIALOG,  marketsID.text.YAFAFA_CLOSED_DIALOG,  0 },
    ['Ahyeekih'] = { xi.region.KOLSHUSHU, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.AHYEEKIH_OPEN_DIALOG, watersID.text.AHYEEKIH_CLOSED_DIALOG, 0 },

    ['Patolle'     ] = { xi.region.KUZOTZ, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.PATOLLE_OPEN_DIALOG,  portSandyID.text.PATOLLE_CLOSED_DIALOG,  0 },
    ['Vattian'     ] = { xi.region.KUZOTZ, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.VATTIAN_OPEN_DIALOG, portBastokID.text.VATTIAN_CLOSED_DIALOG, 0 },
    ['Nhobi_Zalkia'] = { xi.region.KUZOTZ, xi.nation.WINDURST, xi.fameArea.WINDURST, woodsID.text.NHOBI_ZALKIA_OPEN_DIALOG, woodsID.text.NHOBI_ZALKIA_CLOSED_DIALOG, 0 },

    ['Attarena'] = { xi.region.LITELOR, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.ATTARENA_OPEN_DIALOG, northSandyID.text.ATTARENA_CLOSED_DIALOG, 0 },
    ['Galdeo'  ] = { xi.region.LITELOR, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.GALDEO_OPEN_DIALOG,        minesID.text.GALDEO_CLOSED_DIALOG,        0 },
    ['Otete'   ] = { xi.region.LITELOR, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.OTETE_OPEN_DIALOG,        watersID.text.OTETE_CLOSED_DIALOG,        0 },

    ['Vendavoq' ] = { xi.region.MOVALPOLOS, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.VENDAVOQ_OPEN_DIALOG,   portSandyID.text.VENDAVOQ_CLOSED_DIALOG,   0 },
    ['Bagnobrok'] = { xi.region.MOVALPOLOS, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.BAGNOBROK_OPEN_DIALOG, portBastokID.text.BAGNOBROK_CLOSED_DIALOG, 0 },
    ['Prestapiq'] = { xi.region.MOVALPOLOS, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.PRESTAPIQ_OPEN_DIALOG,     watersID.text.PRESTAPIQ_CLOSED_DIALOG,     0 },

    ['Machielle'    ] = { xi.region.NORVALLEN, xi.nation.SANDORIA, xi.fameArea.SANDORIA, southSandyID.text.MACHIELLE_OPEN_DIALOG,   southSandyID.text.MACHIELLE_CLOSED_DIALOG,   0 },
    ['Mille'        ] = { xi.region.NORVALLEN, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.MILLE_OPEN_DIALOG,            minesID.text.MILLE_CLOSED_DIALOG,            0 },
    ['Posso_Ruhbini'] = { xi.region.NORVALLEN, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.POSSORUHBINI_OPEN_DIALOG, portWindyID.text.POSSORUHBINI_CLOSED_DIALOG, 0 },

    ['Eugballion'    ] = { xi.region.QUFIMISLAND, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.EUGBALLION_OPEN_DIALOG, northSandyID.text.EUGBALLION_CLOSED_DIALOG, 0 },
    ['Takiyah'       ] = { xi.region.QUFIMISLAND, xi.nation.BASTOK,   xi.fameArea.BASTOK,   metalworksID.text.TAKIYAH_OPEN_DIALOG,    metalworksID.text.TAKIYAH_CLOSED_DIALOG,    0 },
    ['Millerovieunet'] = { xi.region.QUFIMISLAND, xi.nation.WINDURST, xi.fameArea.WINDURST, woodsID.text.MILLEROVIEUNET_OPEN_DIALOG,  woodsID.text.MILLEROVIEUNET_CLOSED_DIALOG,  0 },

    ['Corua'   ] = { xi.region.RONFAURE, xi.nation.SANDORIA, xi.fameArea.SANDORIA, southSandyID.text.CORUA_OPEN_DIALOG, southSandyID.text.CORUA_CLOSED_DIALOG, 0 },
    ['Faustin' ] = { xi.region.RONFAURE, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.FAUSTIN_OPEN_DIALOG,    minesID.text.FAUSTIN_CLOSED_DIALOG,    0 },
    ['Jourille'] = { xi.region.RONFAURE, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.JOURILLE_OPEN_DIALOG,  watersID.text.JOURILLE_CLOSED_DIALOG,  0 },

    ['Milva'      ] = { xi.region.SARUTABARUTA, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.MILVA_OPEN_DIALOG,   portSandyID.text.MILVA_CLOSED_DIALOG,   0 },
    ['Somn-Paemn' ] = { xi.region.SARUTABARUTA, xi.nation.BASTOK,   xi.fameArea.BASTOK,   marketsID.text.SOMNPAEMN_OPEN_DIALOG, marketsID.text.SOMNPAEMN_CLOSED_DIALOG, 0 },
    ['Baehu-Faehu'] = { xi.region.SARUTABARUTA, xi.nation.WINDURST, xi.fameArea.WINDURST, watersID.text.BAEHUFAEHU_OPEN_DIALOG, watersID.text.BAEHUFAEHU_CLOSED_DIALOG, 0 },

    ['Deguerendars'] = { xi.region.TAVNAZIANARCH, xi.nation.SANDORIA, xi.fameArea.SANDORIA, portSandyID.text.DEGUERENDARS_OPEN_DIALOG, portSandyID.text.DEGUERENDARS_CLOSED_DIALOG, portSandyID.text.DEGUERENDARS_COP_NOT_COMPLETED },
    ['Emaliveulaux'] = { xi.region.TAVNAZIANARCH, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.EMALIVEULAUX_OPEN_DIALOG,     minesID.text.EMALIVEULAUX_CLOSED_DIALOG,     minesID.text.EMALIVEULAUX_COP_NOT_COMPLETED     },
    ['Alizabe'     ] = { xi.region.TAVNAZIANARCH, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.ALIZABE_OPEN_DIALOG,      portWindyID.text.ALIZABE_CLOSED_DIALOG,      portWindyID.text.ALIZABE_COP_NOT_COMPLETED      },

    ['Palguevion'] = { xi.region.VALDEAUNIA, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.PALGUEVION_OPEN_DIALOG, northSandyID.text.PALGUEVION_CLOSED_DIALOG, 0 },
    ['Tibelda'   ] = { xi.region.VALDEAUNIA, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.TIBELDA_OPEN_DIALOG,         minesID.text.TIBELDA_CLOSED_DIALOG,         0 },
    ['Zoreen'    ] = { xi.region.VALDEAUNIA, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.ZOREEN_OPEN_DIALOG,      portWindyID.text.ZOREEN_CLOSED_DIALOG,      0 },

    ['Millechuca'] = { xi.region.VOLLBOW, xi.nation.SANDORIA, xi.fameArea.SANDORIA, northSandyID.text.MILLECHUCA_OPEN_DIALOG, northSandyID.text.MILLECHUCA_CLOSED_DIALOG, 0 },
    ['Aulavia'   ] = { xi.region.VOLLBOW, xi.nation.BASTOK,   xi.fameArea.BASTOK,   minesID.text.AULAVIA_OPEN_DIALOG,         minesID.text.AULAVIA_CLOSED_DIALOG,         0 },
    ['Lebondur'  ] = { xi.region.VOLLBOW, xi.nation.WINDURST, xi.fameArea.WINDURST, portWindyID.text.LEBONDUR_OPEN_DIALOG,    portWindyID.text.LEBONDUR_CLOSED_DIALOG,    0 },

    ['Phamelise'   ] = { xi.region.ZULKHEIM, xi.nation.SANDORIA, xi.fameArea.SANDORIA, southSandyID.text.PHAMELISE_OPEN_DIALOG, southSandyID.text.PHAMELISE_CLOSED_DIALOG, 0 },
    ['Rosswald'    ] = { xi.region.ZULKHEIM, xi.nation.BASTOK,   xi.fameArea.BASTOK,   portBastokID.text.ROSSWALD_OPEN_DIALOG,  portBastokID.text.ROSSWALD_CLOSED_DIALOG,  0 },
    ['Bin_Stejihna'] = { xi.region.ZULKHEIM, xi.nation.WINDURST, xi.fameArea.WINDURST, woodsID.text.BIN_STEJIHNA_OPEN_DIALOG,   woodsID.text.BIN_STEJIHNA_CLOSED_DIALOG,   0 },
}

local regionalStockTable =
{
    [xi.region.ARAGONEU] =
    {
        { xi.item.BAG_OF_HORO_FLOUR,           41 },
        { xi.item.EAR_OF_MILLIONCORN,          49 },
        { xi.item.EAR_OF_ROASTED_CORN,        128 },
        { xi.item.YAGUDO_FEATHER,              41 },
        { xi.item.HANDFUL_OF_SUNFLOWER_SEEDS, 104 },
    },
    [xi.region.DERFLAND] =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,   70 },
        { xi.item.GINGER_ROOT,             161 },
        { xi.item.FLASK_OF_OLIVE_OIL,       16 },
        { xi.item.WIJNRUIT,                124 },
        { xi.item.DERFLAND_PEAR,           145 },
        { xi.item.OLIVE_FLOWER,           1872 },
    },
    [xi.region.ELSHIMO_LOWLANDS] =
    {
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,   62 },
        { xi.item.KAZHAM_PINEAPPLE,          62 },
        { xi.item.MITHRAN_TOMATO,            41 },
        { xi.item.PINCH_OF_BLACK_PEPPER,    265 },
        { xi.item.OGRE_PUMPKIN,              99 },
        { xi.item.KUKURU_BEAN,              124 },
        { xi.item.PHALAENOPSIS,            1872 },
    },
    [xi.region.ELSHIMO_UPLANDS] =
    {
        { xi.item.BUNCH_OF_PAMAMAS,         84 },
        { xi.item.STICK_OF_CINNAMON,       273 },
        { xi.item.PIECE_OF_RATTAN_LUMBER,  168 },
        { xi.item.CATTLEYA,               1890 },
    },
    [xi.region.FAUREGANDI] =
    {
        { xi.item.MAPLE_LOG,            63 },
        { xi.item.FAERIE_APPLE,         46 },
        { xi.item.CLUMP_OF_BEAUGREENS, 105 },
    },
    [xi.region.GUSTABERG] =
    {
        { xi.item.PINCH_OF_SULFUR,  803 },
        { xi.item.POPOTO,            50 },
        { xi.item.BAG_OF_RYE_FLOUR,  42 },
        { xi.item.EGGPLANT,          46 },
    },
    [xi.region.KOLSHUSHU] =
    {
        { xi.item.BULB_OF_MHAURA_GARLIC,      84 },
        { xi.item.YAGUDO_CHERRY,              46 },
        { xi.item.SLICE_OF_DHALMEL_MEAT,     252 },
        { xi.item.BUNCH_OF_BUBURIMU_GRAPES,  210 },
        { xi.item.CASABLANCA,               1890 },
    },
    [xi.region.KUZOTZ] =
    {
        { xi.item.THUNDERMELON,   341 },
        { xi.item.CACTUAR_NEEDLE, 976 },
        { xi.item.WATERMELON,     210 },
    },
    [xi.region.LITELOR] =
    {
        { xi.item.HANDFUL_OF_BAY_LEAVES,  135 },
        { xi.item.FLASK_OF_HOLY_WATER,   3016 },
    },
    [xi.region.MOVALPOLOS] =
    {
        { xi.item.BOTTLE_OF_MOVALPOLOS_WATER,  840 },
        { xi.item.CHUNK_OF_COPPER_ORE,          12 },
        { xi.item.DANCESHROOM,                4704 },
        { xi.item.CORAL_FUNGUS,                792 },
        { xi.item.CHUNK_OF_KOPPARNICKEL_ORE,   840 },
    },
    [xi.region.NORVALLEN] =
    {
        { xi.item.ARROWWOOD_LOG,         20 },
        { xi.item.POT_OF_CRYING_MUSTARD, 29 },
        { xi.item.POD_OF_BLUE_PEAS,      29 },
        { xi.item.ASH_LOG,               99 },
    },
    [xi.region.QUFIMISLAND] =
    {
        { xi.item.MAGIC_POT_SHARD, 4704 },
    },
    [xi.region.RONFAURE] =
    {
        { xi.item.SAN_DORIAN_CARROT,           33, },
        { xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,  79, },
        { xi.item.RONFAURE_CHESTNUT,          124, },
        { xi.item.BAG_OF_SAN_DORIAN_FLOUR,     62, },
    },
    [xi.region.SARUTABARUTA] =
    {
        { xi.item.RARAB_TAIL,                      24 },
        { xi.item.LAUAN_LOG,                       37 },
        { xi.item.POPOTO,                          49 },
        { xi.item.SARUTA_ORANGE,                   33 },
        { xi.item.CLUMP_OF_WINDURSTIAN_TEA_LEAVES, 20 },
    },
    [xi.region.TAVNAZIANARCH] =
    {
        { xi.item.SPRIG_OF_APPLE_MINT,         331 },
        { xi.item.JAR_OF_GROUND_WASABI,       2724 },
        { xi.item.LUFAISE_FLY,                 113 },
        { xi.item.SPRIG_OF_MISAREAUX_PARSLEY,  331 },
        { xi.item.BUNCH_OF_HABANERO_PEPPERS,  1050 },
    },
    [xi.region.VALDEAUNIA] =
    {
        { xi.item.SPRIG_OF_SAGE, 192 },
        { xi.item.FROST_TURNIP,   33 },
    },
    [xi.region.VOLLBOW] =
    {
        { xi.item.CHUNK_OF_ROCK_SALT,       16 },
        { xi.item.HANDFUL_OF_FISH_SCALES,   99 },
        { xi.item.CHAMOMILE,               135 },
        { xi.item.SWEET_WILLIAM,          1872 },
    },
    [xi.region.ZULKHEIM] =
    {
        { xi.item.SLICE_OF_GIANT_SHEEP_MEAT,   50 },
        { xi.item.PINCH_OF_DRIED_MARJORAM,     50 },
        { xi.item.BAG_OF_SAN_DORIAN_FLOUR,     63 },
        { xi.item.BAG_OF_RYE_FLOUR,            42 },
        { xi.item.BAG_OF_SEMOLINA,           2100 },
        { xi.item.LA_THEINE_CABBAGE,           25 },
        { xi.item.JUG_OF_SELBINA_MILK,         63 },
    },
}

xi.shop.handleRegionalShop = function(player, npc)
    local npcData   = regionalVendorTable[npc:getName()]
    local npcRegion = npcData[regionParam.REGION]

    -- CoP Mission check for Tavnazia vendors.
    if
        npcRegion == xi.region.TAVNAZIANARCH and
        player:getCurrentMission(xi.mission.log_id.COP) < xi.mission.id.cop.THE_SAVAGE
    then
        player:showText(npc, npcData[regionParam.TEXT_UNAVAILABLE])
        return
    end

    -- Region owner check.
    if GetRegionOwner(npcRegion) ~= npcData[regionParam.NATION] then
        player:showText(npc, npcData[regionParam.TEXT_CLOSED])
        return
    end

    -- Build shop.
    player:showText(npc, npcData[regionParam.TEXT_OPEN])
    xi.shop.general(player, regionalStockTable[npcRegion], npcData[regionParam.FAME_AREA])
end

-----------------------------------
-- Valeriano Troupe Vendor
-----------------------------------
xi.shop.handleValerianoShop = function(player, npc)
    local zoneTable =
    {
        [xi.zone.SOUTHERN_SAN_DORIA] = { xi.nation.SANDORIA, xi.fameArea.SANDORIA },
        [xi.zone.PORT_BASTOK       ] = { xi.nation.BASTOK,   xi.fameArea.BASTOK   },
        [xi.zone.WINDURST_WOODS    ] = { xi.nation.WINDURST, xi.fameArea.WINDURST },
    }
    local stock =
    {
        { xi.item.GINGER_COOKIE,                  12 },
        { xi.item.FLUTE,                          49 },
        { xi.item.PICCOLO,                      1144 },
        { xi.item.SCROLL_OF_SCOPS_OPERETTA,      677 },
        { xi.item.SCROLL_OF_PUPPETS_OPERETTA,  19552 },
        { xi.item.SCROLL_OF_FOWL_AUBADE,        3369 },
        { xi.item.SCROLL_OF_ADVANCING_MARCH,    2379 },
        { xi.item.SCROLL_OF_GODDESSS_HYMNUS,  104000 },
        { xi.item.SCROLL_OF_FIRE_CAROL_II,     37128 },
        { xi.item.SCROLL_OF_WIND_CAROL_II,     34944 },
        { xi.item.SCROLL_OF_EARTH_CAROL_II,    30680 },
        { xi.item.SCROLL_OF_WATER_CAROL_II,    32240 },
        { xi.item.SCROLL_OF_MAGES_BALLAD_III, 140039 },
    }

    local zoneId = player:getZoneID()

    -- Fail-safe in case npc didnt despawn.
    if GetNationRank(zoneTable[zoneId][1]) ~= 1 then
        return
    end

    -- Build shop.
    player:showText(npc, zones[zoneId].text.VALERIANO_SHOP_DIALOG)
    xi.shop.general(player, stock, zoneTable[zoneId][2])
end