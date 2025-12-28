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
-- stock is of form { itemId1, price1, guildID, guildRank, ... }
-- log is default set to -1 as it's needed as part of createShop()
xi.shop.generalGuild = function(player, stock, guildSkillId)
    local log = -1

    player:createShop(#stock, log)

    for _, stockItem in ipairs(stock) do
        player:addShopItem(stockItem[1], stockItem[2], guildSkillId, stockItem[3])
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
        { xi.item.CYCLONE_CRYSTAL,       3000 },
        { xi.item.TERRA_CRYSTAL,         3000 },
    }
    xi.shop.general(player, stock)
end

-- stock for guild vendors that are open 24/8
xi.shop.generalGuildStock =
{
    [xi.skill.COOKING] =
    {
        { xi.item.CHUNK_OF_ROCK_SALT,           16, xi.craftRank.AMATEUR    },
        { xi.item.FLASK_OF_DISTILLED_WATER,     12, xi.craftRank.AMATEUR    },
        { xi.item.LIZARD_EGG,                  100, xi.craftRank.AMATEUR    },
        { xi.item.SARUTA_ORANGE,                32, xi.craftRank.AMATEUR    },
        { xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,   76, xi.craftRank.AMATEUR    },
        { xi.item.JAR_OF_MISO,                2500, xi.craftRank.AMATEUR    },
        { xi.item.JAR_OF_SOY_SAUCE,           2500, xi.craftRank.AMATEUR    },
        { xi.item.HANDFUL_OF_DRIED_BONITO,    2500, xi.craftRank.AMATEUR    },
        { xi.item.BAG_OF_SAN_DORIAN_FLOUR,      60, xi.craftRank.RECRUIT    },
        { xi.item.POT_OF_MAPLE_SUGAR,           40, xi.craftRank.RECRUIT    },
        { xi.item.FAERIE_APPLE,                 44, xi.craftRank.RECRUIT    },
        { xi.item.JUG_OF_SELBINA_MILK,          60, xi.craftRank.RECRUIT    },
        { xi.item.POT_OF_HONEY,                200, xi.craftRank.RECRUIT    },
        { xi.item.KAZHAM_PINEAPPLE,             60, xi.craftRank.INITIATE   },
        { xi.item.LA_THEINE_CABBAGE,            24, xi.craftRank.INITIATE   },
        { xi.item.BAG_OF_RYE_FLOUR,             40, xi.craftRank.INITIATE   },
        { xi.item.THUNDERMELON,                325, xi.craftRank.NOVICE     },
        { xi.item.WATERMELON,                  200, xi.craftRank.NOVICE     },
        { xi.item.STICK_OF_SELBINA_BUTTER,      60, xi.craftRank.NOVICE     },
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,      60, xi.craftRank.APPRENTICE },
        { xi.item.BLOCK_OF_GELATIN,            900, xi.craftRank.APPRENTICE },
        { xi.item.SERVING_OF_SPAGHETTI,       3000, xi.craftRank.JOURNEYMAN },
        { xi.item.JAR_OF_GROUND_WASABI,       2595, xi.craftRank.JOURNEYMAN },
        { xi.item.PIECE_OF_PIE_DOUGH,         1600, xi.craftRank.CRAFTSMAN  },
        { xi.item.PIECE_OF_PIZZA_DOUGH,       3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.AZUKI_BEAN,                  600, xi.craftRank.CRAFTSMAN  },
        { xi.item.COOKING_KIT_5,               300, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_10,              400, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_15,              650, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_20,             1050, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_25,             1600, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_30,             2300, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_35,             3150, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_40,             4150, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_45,             5300, xi.craftRank.AMATEUR    },
        { xi.item.COOKING_KIT_50,             7600, xi.craftRank.AMATEUR    },
    },

    [xi.skill.CLOTHCRAFT] =
    {
        { xi.item.SPINDLE,                      75, xi.craftRank.AMATEUR    },
        { xi.item.SPOOL_OF_ZEPHYR_THREAD,       75, xi.craftRank.AMATEUR    },
        { xi.item.CLUMP_OF_MOKO_GRASS,          20, xi.craftRank.AMATEUR    },
        { xi.item.BALL_OF_SARUTA_COTTON,       500, xi.craftRank.RECRUIT    },
        { xi.item.CLUMP_OF_RED_MOKO_GRASS,     200, xi.craftRank.RECRUIT    },
        { xi.item.SPOOL_OF_LINEN_THREAD,       150, xi.craftRank.INITIATE   },
        { xi.item.SPOOL_OF_WOOL_THREAD,       2800, xi.craftRank.NOVICE     },
        { xi.item.CLUMP_OF_MOHBWA_GRASS,       800, xi.craftRank.APPRENTICE },
        { xi.item.SPOOL_OF_SILK_THREAD,       1500, xi.craftRank.APPRENTICE },
        { xi.item.CLUMP_OF_KARAKUL_WOOL,      1400, xi.craftRank.JOURNEYMAN },
        { xi.item.SPOOL_OF_GOLD_THREAD,      14500, xi.craftRank.CRAFTSMAN  },
        { xi.item.CLOTHCRAFT_KIT_5,            300, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_10,           400, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_15,           650, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_20,          1050, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_25,          1600, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_30,          2300, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_35,          3150, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_40,          4150, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_45,          5300, xi.craftRank.AMATEUR    },
        { xi.item.CLOTHCRAFT_KIT_50,          7600, xi.craftRank.AMATEUR    },
        { xi.item.SPOOL_OF_KHOMA_THREAD,   1126125, xi.craftRank.AMATEUR    },
    },

    [xi.skill.GOLDSMITHING] =
    {
        { xi.item.WORKSHOP_ANVIL,              75, xi.craftRank.AMATEUR    },
        { xi.item.MANDREL,                     75, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_ZINC_ORE,          200, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_COPPER_ORE,         12, xi.craftRank.AMATEUR    },
        { xi.item.BRASS_NUGGET,                40, xi.craftRank.RECRUIT    },
        { xi.item.BRASS_SHEET,                300, xi.craftRank.RECRUIT    },
        { xi.item.CHUNK_OF_SILVER_ORE,        450, xi.craftRank.RECRUIT    },
        { xi.item.SILVER_NUGGET,              200, xi.craftRank.INITIATE   },
        { xi.item.TOURMALINE,                1863, xi.craftRank.INITIATE   },
        { xi.item.SARDONYX,                  1863, xi.craftRank.INITIATE   },
        { xi.item.CLEAR_TOPAZ,               1863, xi.craftRank.INITIATE   },
        { xi.item.AMETHYST,                  1863, xi.craftRank.INITIATE   },
        { xi.item.LAPIS_LAZULI,              1863, xi.craftRank.INITIATE   },
        { xi.item.AMBER_STONE,               1863, xi.craftRank.INITIATE   },
        { xi.item.ONYX,                      1863, xi.craftRank.INITIATE   },
        { xi.item.LIGHT_OPAL,                1863, xi.craftRank.INITIATE   },
        { xi.item.SILVER_CHAIN,             23000, xi.craftRank.NOVICE     },
        { xi.item.CHUNK_OF_MYTHRIL_ORE,      2000, xi.craftRank.NOVICE     },
        { xi.item.CHUNK_OF_GOLD_ORE,         3000, xi.craftRank.APPRENTICE },
        { xi.item.MYTHRIL_SHEET,            12000, xi.craftRank.APPRENTICE },
        { xi.item.PERIDOT,                   8000, xi.craftRank.APPRENTICE },
        { xi.item.GARNET,                    8000, xi.craftRank.APPRENTICE },
        { xi.item.GOSHENITE,                 8000, xi.craftRank.APPRENTICE },
        { xi.item.AMETRINE,                  8000, xi.craftRank.APPRENTICE },
        { xi.item.TURQUOISE,                 8000, xi.craftRank.APPRENTICE },
        { xi.item.SPHENE,                    8000, xi.craftRank.APPRENTICE },
        { xi.item.BLACK_PEARL,              12000, xi.craftRank.APPRENTICE },
        { xi.item.PEARL,                    11000, xi.craftRank.APPRENTICE },
        { xi.item.CHUNK_OF_ALUMINUM_ORE,     5000, xi.craftRank.APPRENTICE },
        { xi.item.GOLD_SHEET,               32000, xi.craftRank.JOURNEYMAN },
        { xi.item.GOLD_CHAIN,               58000, xi.craftRank.JOURNEYMAN },
        { xi.item.CHUNK_OF_PLATINUM_ORE,     6000, xi.craftRank.CRAFTSMAN  },
        { xi.item.GOLDSMITHING_KIT_5,         300, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_10,        400, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_15,        650, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_20,       1050, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_25,       1600, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_30,       2300, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_35,       3150, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_40,       4150, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_45,       5300, xi.craftRank.AMATEUR    },
        { xi.item.GOLDSMITHING_KIT_50,       7600, xi.craftRank.AMATEUR    },
        { xi.item.CHUNK_OF_RUTHENIUM_ORE, 1126125, xi.craftRank.AMATEUR    },
    },

    [xi.skill.WOODWORKING] =
    {
        { xi.item.SPOOL_OF_BUNDLING_TWINE,     100, xi.craftRank.AMATEUR    },
        { xi.item.ARROWWOOD_LOG,                25, xi.craftRank.AMATEUR    },
        { xi.item.LAUAN_LOG,                    50, xi.craftRank.AMATEUR    },
        { xi.item.MAPLE_LOG,                    70, xi.craftRank.AMATEUR    },
        { xi.item.HOLLY_LOG,                   800, xi.craftRank.RECRUIT    },
        { xi.item.WILLOW_LOG,                 1600, xi.craftRank.RECRUIT    },
        { xi.item.WALNUT_LOG,                 1300, xi.craftRank.RECRUIT    },
        { xi.item.YEW_LOG,                     500, xi.craftRank.INITIATE   },
        { xi.item.ELM_LOG,                    3800, xi.craftRank.INITIATE   },
        { xi.item.CHESTNUT_LOG,               3400, xi.craftRank.INITIATE   },
        { xi.item.DOGWOOD_LOG,                2000, xi.craftRank.NOVICE     },
        { xi.item.OAK_LOG,                    4000, xi.craftRank.NOVICE     },
        { xi.item.ROSEWOOD_LOG,               4500, xi.craftRank.APPRENTICE },
        { xi.item.MAHOGANY_LOG,               4500, xi.craftRank.JOURNEYMAN },
        { xi.item.EBONY_LOG,                  5000, xi.craftRank.CRAFTSMAN  },
        { xi.item.FEYWEALD_LOG,               5500, xi.craftRank.CRAFTSMAN  },
        { xi.item.WOODWORKING_KIT_5,           300, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_10,          400, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_15,          650, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_20,         1050, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_25,         1600, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_30,         2300, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_35,         3150, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_40,         4150, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_45,         5300, xi.craftRank.AMATEUR    },
        { xi.item.WOODWORKING_KIT_50,         7600, xi.craftRank.AMATEUR    },
        { xi.item.CYPRESS_LOG,             1126125, xi.craftRank.AMATEUR    },
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
        { xi.item.ALCHEMY_KIT_5,                 300, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_10,                400, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_15,                650, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_20,               1050, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_25,               1600, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_30,               2300, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_35,               3150, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_40,               4150, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_45,               5300, xi.craftRank.AMATEUR    },
        { xi.item.ALCHEMY_KIT_50,               7600, xi.craftRank.AMATEUR    },
        { xi.item.AZURE_LEAF,                1126125, xi.craftRank.AMATEUR    },
    },

    [xi.skill.BONECRAFT] =
    {
        { xi.item.SHAGREEN_FILE,               75, xi.craftRank.AMATEUR    },
        { xi.item.BONE_CHIP,                  150, xi.craftRank.AMATEUR    },
        { xi.item.HANDFUL_OF_FISH_SCALES,      96, xi.craftRank.AMATEUR    },
        { xi.item.CHICKEN_BONE,              1500, xi.craftRank.RECRUIT    },
        { xi.item.GIANT_FEMUR,               1400, xi.craftRank.RECRUIT    },
        { xi.item.BEETLE_SHELL,               500, xi.craftRank.INITIATE   },
        { xi.item.BEETLE_JAW,                1000, xi.craftRank.INITIATE   },
        { xi.item.RAM_HORN,                  1800, xi.craftRank.NOVICE     },
        { xi.item.BLACK_TIGER_FANG,          2000, xi.craftRank.NOVICE     },
        { xi.item.CRAB_SHELL,                2500, xi.craftRank.APPRENTICE },
        { xi.item.TURTLE_SHELL,              6000, xi.craftRank.JOURNEYMAN },
        { xi.item.SCORPION_CLAW,             2400, xi.craftRank.JOURNEYMAN },
        { xi.item.BUGARD_TUSK,               4000, xi.craftRank.JOURNEYMAN },
        { xi.item.SCORPION_SHELL,            3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.MARID_TUSK,                4500, xi.craftRank.CRAFTSMAN  },
        { xi.item.BONECRAFT_KIT_5,            300, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_10,           400, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_15,           650, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_20,          1050, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_25,          1600, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_30,          2300, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_35,          3150, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_40,          4150, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_45,          5300, xi.craftRank.AMATEUR    },
        { xi.item.BONECRAFT_KIT_50,          7600, xi.craftRank.AMATEUR    },
        { xi.item.FRAGMENT_OF_CYAN_CORAL, 1126125, xi.craftRank.AMATEUR    },
    },

    [xi.skill.LEATHERCRAFT] =
    {
        { xi.item.TANNING_VAT,                              75, xi.craftRank.AMATEUR    },
        { xi.item.SHEEPSKIN,                               100, xi.craftRank.AMATEUR    },
        { xi.item.RABBIT_HIDE,                              80, xi.craftRank.AMATEUR    },
        { xi.item.LIZARD_SKIN,                             600, xi.craftRank.RECRUIT    },
        { xi.item.KARAKUL_SKIN,                            600, xi.craftRank.RECRUIT    },
        { xi.item.WOLF_HIDE,                               600, xi.craftRank.RECRUIT    },
        { xi.item.DHALMEL_HIDE,                           2400, xi.craftRank.INITIATE   },
        { xi.item.BUGARD_SKIN,                            2500, xi.craftRank.INITIATE   },
        { xi.item.RAM_SKIN,                               1500, xi.craftRank.NOVICE     },
        { xi.item.BUFFALO_HIDE,                          16000, xi.craftRank.APPRENTICE },
        { xi.item.RAPTOR_SKIN,                            3000, xi.craftRank.JOURNEYMAN },
        { xi.item.CATOBLEPAS_HIDE,                        2500, xi.craftRank.JOURNEYMAN },
        { xi.item.SMILODON_HIDE,                          3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.COCKATRICE_SKIN,                        3000, xi.craftRank.CRAFTSMAN  },
        { xi.item.LEATHERCRAFT_KIT_5,                      300, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_10,                     400, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_15,                     650, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_20,                    1050, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_25,                    1600, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_30,                    2300, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_35,                    3150, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_40,                    4150, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_45,                    5300, xi.craftRank.AMATEUR    },
        { xi.item.LEATHERCRAFT_KIT_50,                    7600, xi.craftRank.AMATEUR    },
        { xi.item.SQUARE_OF_SYNTHETIC_FAULPIE_LEATHER, 1126125, xi.craftRank.AMATEUR    },
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
        { xi.item.SMITHING_KIT_5,                300, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_10,               400, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_15,               650, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_20,              1050, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_25,              1600, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_30,              2300, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_35,              3150, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_40,              4150, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_45,              5300, xi.craftRank.AMATEUR    },
        { xi.item.SMITHING_KIT_50,              7600, xi.craftRank.AMATEUR    },
        { xi.item.NIOBIUM_ORE,               1126125, xi.craftRank.AMATEUR    },
    }
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
