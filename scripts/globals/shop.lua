-----------------------------------
--    Functions for Shop system
-----------------------------------
require('scripts/globals/conquest')
-----------------------------------

-----------------------------------
-- IDs for Curio Vendor Moogle
-----------------------------------

local curio =
{
    ['medicine']        = 1,
    ['ammunition']      = 2,
    ['ninjutsuTools']   = 3,
    ['foodStuffs']      = 4,
    ['scrolls']         = 5,
    ['keys']            = 6,
    -- keyitems not implemented yet
}

xi = xi or {}

xi.shop =
{
    -- send general shop dialog to player
    -- stock cuts off after 16 items. if you add more, extras will not display
    -- stock is of form { itemId1, price1, itemId2, price2, ... }
    -- log is a fame area from xi.fameArea
    general = function(player, stock, log)
        local priceMultiplier = 1

        if log then
            priceMultiplier = (1 + (0.20 * (9 - player:getFameLevel(log)) / 8)) * xi.settings.main.SHOP_PRICE
        else
            log = -1
        end

        player:createShop(#stock / 2, log)

        for i = 1, #stock, 2 do
            player:addShopItem(stock[i], stock[i + 1] * priceMultiplier)
        end

        player:sendMenu(xi.menuType.SHOP)
    end,

    -- send general guild shop dialog to player (Added on June 2014 QoL)
    -- stock is of form { itemId1, price1, guildID, guildRank, ... }
    -- log is default set to -1 as it's needed as part of createShop()
    generalGuild = function(player, stock, guildSkillId)
        local log = -1

        player:createShop(#stock / 3, log)

        for i = 1, #stock, 3 do
            player:addShopItem(stock[i], stock[i + 1], guildSkillId, stock[i + 2])
        end

        player:sendMenu(xi.menuType.SHOP)
    end,

    -- send curio vendor moogle shop shop dialog to player
    -- stock is of form { itemId1, price1, keyItemRequired, ... }
    -- log is default set to -1 as it's needed as part of createShop()
    curioVendorMoogle = function(player, stock)
        local log = -1

        player:createShop(#stock / 3, log)

        for i = 1, #stock, 3 do
            if player:hasKeyItem(stock[i + 2]) then
                player:addShopItem(stock[i], stock[i + 1])
            end
        end

        player:sendMenu(xi.menuType.SHOP)
    end,

    -- send nation shop dialog to player
    -- stock cuts off after 16 items. if you add more, extras will not display
    -- stock is of form { itemId1, price1, place1, itemId2, price2, place2, ... }
    --     where place is what place the nation must be in for item to be stocked
    -- nation is a xi.nation ID from scripts/enum/nation.lua
    nation = function(player, stock, nation)
        local rank = GetNationRank(nation)
        local newStock = {}
        for i = 1, #stock, 3 do
            if
                (stock[i + 2] == 1 and player:getNation() == nation and rank == 1) or
                (stock[i + 2] == 2 and rank <= 2) or
                (stock[i + 2] == 3)
            then
                table.insert(newStock, stock[i])
                table.insert(newStock, stock[i + 1])
            end
        end

        xi.shop.general(player, newStock, nation)
    end,

    -- send outpost shop dialog to player
    outpost = function(player)
        local stock =
        {
            xi.item.ANTIDOTE,               316, -- Antidote
            xi.item.FLASK_OF_ECHO_DROPS,    800, -- Echo Drops
            xi.item.ETHER,                  4832, -- Ether
            xi.item.FLASK_OF_EYE_DROPS,     2595, -- Eye Drops
            xi.item.POTION,                 910, -- Potion
        }
        xi.shop.general(player, stock)
    end,

    -- send celebratory chest shop dialog to player
    celebratory = function(player)
        local stock =
        {
            xi.item.CRACKER,                 30, -- Cracker
            xi.item.TWINKLE_SHOWER,          30, -- Twinkle Shower
            xi.item.POPSTAR,                 60, -- Popstar
            xi.item.BRILLIANT_SNOW,          60, -- Brilliant Snow
            xi.item.OUKA_RANMAN,             30, -- Ouka Ranman
            xi.item.LITTLE_COMET,            30, -- Little Comet
            xi.item.POPPER,                 650, -- Popper
            xi.item.WEDDING_BELL,          1000, -- Wedding Bell
            xi.item.SERENE_SERINETTE,      6000, -- Serene Serinette
            xi.item.JOYOUS_SERINETTE,      6000, -- Joyous Serinette
            xi.item.BOTTLE_OF_GRAPE_JUICE, 1116, -- Grape Juice
            xi.item.INFERNO_CRYSTAL,       3000, -- Inferno Crystal
            xi.item.CYCLONE_CRYSTAL,       3000, -- Cyclone Crystal
            xi.item.TERRA_CRYSTAL,         3000, -- Terra Crystal
        }
        xi.shop.general(player, stock)
    end,

    -- stock for guild vendors that are open 24/8
    generalGuildStock =
    {
        [xi.skill.COOKING] =
        {
            xi.item.CHUNK_OF_ROCK_SALT,              16,      xi.craftRank.AMATEUR,      -- Rock Salt
            xi.item.FLASK_OF_DISTILLED_WATER,        12,      xi.craftRank.AMATEUR,      -- Distilled Water
            xi.item.LIZARD_EGG,                     100,      xi.craftRank.AMATEUR,      -- Lizard Egg
            xi.item.SARUTA_ORANGE,                   32,      xi.craftRank.AMATEUR,      -- Saruta Orange
            xi.item.BUNCH_OF_SAN_DORIAN_GRAPES,      76,      xi.craftRank.AMATEUR,      -- San d'Orian Grapes
            xi.item.JAR_OF_MISO,                   2500,      xi.craftRank.AMATEUR,      -- Miso
            xi.item.JAR_OF_SOY_SAUCE,              2500,      xi.craftRank.AMATEUR,      -- Soy Sauce
            xi.item.HANDFUL_OF_DRIED_BONITO,       2500,      xi.craftRank.AMATEUR,      -- Dried Bonito
            xi.item.BAG_OF_SAN_DORIAN_FLOUR,         60,      xi.craftRank.RECRUIT,      -- San d'Orian Flour
            xi.item.POT_OF_MAPLE_SUGAR,              40,      xi.craftRank.RECRUIT,      -- Maple Sugar
            xi.item.FAERIE_APPLE,                    44,      xi.craftRank.RECRUIT,      -- Faerie Apple
            xi.item.JUG_OF_SELBINA_MILK,             60,      xi.craftRank.RECRUIT,      -- Selbina Milk
            xi.item.POT_OF_HONEY,                   200,      xi.craftRank.RECRUIT,      -- Honey
            xi.item.KAZHAM_PINEAPPLE,                60,     xi.craftRank.INITIATE,      -- Kazham Pineapple
            xi.item.LA_THEINE_CABBAGE,               24,     xi.craftRank.INITIATE,      -- La Theine Cabbage
            xi.item.BAG_OF_RYE_FLOUR,                40,     xi.craftRank.INITIATE,      -- Rye Flour
            xi.item.THUNDERMELON,                   325,       xi.craftRank.NOVICE,      -- Thundermelon
            xi.item.WATERMELON,                     200,       xi.craftRank.NOVICE,      -- Watermelon
            xi.item.STICK_OF_SELBINA_BUTTER,         60,       xi.craftRank.NOVICE,      -- Selbina Butter
            xi.item.BUNCH_OF_KAZHAM_PEPPERS,         60,   xi.craftRank.APPRENTICE,      -- Kazham Peppers
            xi.item.BLOCK_OF_GELATIN,               900,   xi.craftRank.APPRENTICE,      -- Gelatin
            xi.item.SERVING_OF_SPAGHETTI,          3000,   xi.craftRank.JOURNEYMAN,      -- Spaghetti
            xi.item.JAR_OF_GROUND_WASABI,          2595,   xi.craftRank.JOURNEYMAN,      -- Ground Wasabi
            xi.item.PIECE_OF_PIE_DOUGH,            1600,    xi.craftRank.CRAFTSMAN,      -- Pie Dough
            xi.item.PIECE_OF_PIZZA_DOUGH,          3000,    xi.craftRank.CRAFTSMAN,      -- Pizza Dough
            xi.item.AZUKI_BEAN,                     600,    xi.craftRank.CRAFTSMAN,      -- Azuki Bean
            xi.item.COOKING_KIT_5,                  300,      xi.craftRank.AMATEUR,      -- Cooking Kit 5
            xi.item.COOKING_KIT_10,                 400,      xi.craftRank.AMATEUR,      -- Cooking Kit 10
            xi.item.COOKING_KIT_15,                 650,      xi.craftRank.AMATEUR,      -- Cooking Kit 15
            xi.item.COOKING_KIT_20,                1050,      xi.craftRank.AMATEUR,      -- Cooking Kit 20
            xi.item.COOKING_KIT_25,                1600,      xi.craftRank.AMATEUR,      -- Cooking Kit 25
            xi.item.COOKING_KIT_30,                2300,      xi.craftRank.AMATEUR,      -- Cooking Kit 30
            xi.item.COOKING_KIT_35,                3150,      xi.craftRank.AMATEUR,      -- Cooking Kit 35
            xi.item.COOKING_KIT_40,                4150,      xi.craftRank.AMATEUR,      -- Cooking Kit 40
            xi.item.COOKING_KIT_45,                5300,      xi.craftRank.AMATEUR,      -- Cooking Kit 45
            xi.item.COOKING_KIT_50,                7600,      xi.craftRank.AMATEUR       -- Cooking Kit 50
        },

        [xi.skill.CLOTHCRAFT] =
        {
            xi.item.SPINDLE,                      75,      xi.craftRank.AMATEUR,      -- Spindle
            xi.item.SPOOL_OF_ZEPHYR_THREAD,       75,      xi.craftRank.AMATEUR,      -- Zephyr Thread
            xi.item.CLUMP_OF_MOKO_GRASS,          20,      xi.craftRank.AMATEUR,      -- Moko Grass
            xi.item.BALL_OF_SARUTA_COTTON,       500,      xi.craftRank.RECRUIT,      -- Saruta Cotton
            xi.item.CLUMP_OF_RED_MOKO_GRASS,     200,      xi.craftRank.RECRUIT,      -- Red Moko Grass
            xi.item.SPOOL_OF_LINEN_THREAD,       150,     xi.craftRank.INITIATE,      -- Linen Thread
            xi.item.SPOOL_OF_WOOL_THREAD,       2800,       xi.craftRank.NOVICE,      -- Wool Thread
            xi.item.CLUMP_OF_MOHBWA_GRASS,       800,   xi.craftRank.APPRENTICE,      -- Mohbwa Grass
            xi.item.SPOOL_OF_SILK_THREAD,       1500,   xi.craftRank.APPRENTICE,      -- Silk Thread
            xi.item.CLUMP_OF_KARAKUL_WOOL,      1400,   xi.craftRank.JOURNEYMAN,      -- Karakul Wool
            xi.item.SPOOL_OF_GOLD_THREAD,      14500,    xi.craftRank.CRAFTSMAN,      -- Gold Thread
            xi.item.CLOTHCRAFT_KIT_5,            300,      xi.craftRank.AMATEUR,      -- Clothcraft kit 5
            xi.item.CLOTHCRAFT_KIT_10,           400,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 10
            xi.item.CLOTHCRAFT_KIT_15,           650,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 15
            xi.item.CLOTHCRAFT_KIT_20,          1050,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 20
            xi.item.CLOTHCRAFT_KIT_25,          1600,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 25
            xi.item.CLOTHCRAFT_KIT_30,          2300,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 30
            xi.item.CLOTHCRAFT_KIT_35,          3150,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 35
            xi.item.CLOTHCRAFT_KIT_40,          4150,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 40
            xi.item.CLOTHCRAFT_KIT_45,          5300,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 45
            xi.item.CLOTHCRAFT_KIT_50,          7600,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 50
            xi.item.SPOOL_OF_KHOMA_THREAD,   1126125,      xi.craftRank.AMATEUR       -- Khoma Thread
        },

        [xi.skill.GOLDSMITHING] =
        {
            xi.item.WORKSHOP_ANVIL,              75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
            xi.item.MANDREL,                     75,      xi.craftRank.AMATEUR,      -- Mandrel
            xi.item.CHUNK_OF_ZINC_ORE,          200,      xi.craftRank.AMATEUR,      -- Zinc Ore
            xi.item.CHUNK_OF_COPPER_ORE,         12,      xi.craftRank.AMATEUR,      -- Copper Ore
            xi.item.BRASS_NUGGET,                40,      xi.craftRank.RECRUIT,      -- Brass Nugget
            xi.item.BRASS_SHEET,                300,      xi.craftRank.RECRUIT,      -- Brass Sheet
            xi.item.CHUNK_OF_SILVER_ORE,        450,      xi.craftRank.RECRUIT,      -- Silver Ore
            xi.item.SILVER_NUGGET,              200,     xi.craftRank.INITIATE,      -- Silver Nugget
            xi.item.TOURMALINE,                1863,     xi.craftRank.INITIATE,      -- Tourmaline
            xi.item.SARDONYX,                  1863,     xi.craftRank.INITIATE,      -- Sardonyx
            xi.item.CLEAR_TOPAZ,               1863,     xi.craftRank.INITIATE,      -- Clear Topaz
            xi.item.AMETHYST,                  1863,     xi.craftRank.INITIATE,      -- Amethyst
            xi.item.LAPIS_LAZULI,              1863,     xi.craftRank.INITIATE,      -- Lapis Lazuli
            xi.item.AMBER_STONE,               1863,     xi.craftRank.INITIATE,      -- Amber
            xi.item.ONYX,                      1863,     xi.craftRank.INITIATE,      -- Onyx
            xi.item.LIGHT_OPAL,                1863,     xi.craftRank.INITIATE,      -- Light Opal
            xi.item.SILVER_CHAIN,             23000,       xi.craftRank.NOVICE,      -- Silver Chain
            xi.item.CHUNK_OF_MYTHRIL_ORE,      2000,       xi.craftRank.NOVICE,      -- Mythril Ore
            xi.item.CHUNK_OF_GOLD_ORE,         3000,   xi.craftRank.APPRENTICE,      -- Gold Ore
            xi.item.MYTHRIL_SHEET,            12000,   xi.craftRank.APPRENTICE,      -- Mythril Sheet
            xi.item.PERIDOT,                   8000,   xi.craftRank.APPRENTICE,      -- Peridot
            xi.item.GARNET,                    8000,   xi.craftRank.APPRENTICE,      -- Garnet
            xi.item.GOSHENITE,                 8000,   xi.craftRank.APPRENTICE,      -- Goshenite
            xi.item.AMETRINE,                  8000,   xi.craftRank.APPRENTICE,      -- Ametrine
            xi.item.TURQUOISE,                 8000,   xi.craftRank.APPRENTICE,      -- Turquoise
            xi.item.SPHENE,                    8000,   xi.craftRank.APPRENTICE,      -- Sphene
            xi.item.BLACK_PEARL,               8000,   xi.craftRank.APPRENTICE,      -- Black Pearl
            xi.item.PEARL,                     8000,   xi.craftRank.APPRENTICE,      -- Pearl
            xi.item.CHUNK_OF_ALUMINUM_ORE,     5000,   xi.craftRank.APPRENTICE,      -- Aluminum Ore
            xi.item.GOLD_SHEET,               32000,   xi.craftRank.JOURNEYMAN,      -- Gold Sheet
            xi.item.GOLD_CHAIN,               58000,   xi.craftRank.JOURNEYMAN,      -- Gold Chain
            xi.item.CHUNK_OF_PLATINUM_ORE,     6000,    xi.craftRank.CRAFTSMAN,      -- Platinum Ore
            xi.item.GOLDSMITHING_KIT_5,         300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 5
            xi.item.GOLDSMITHING_KIT_10,        400,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 10
            xi.item.GOLDSMITHING_KIT_15,        650,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 15
            xi.item.GOLDSMITHING_KIT_20,       1050,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 20
            xi.item.GOLDSMITHING_KIT_25,       1600,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 25
            xi.item.GOLDSMITHING_KIT_30,       2300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 30
            xi.item.GOLDSMITHING_KIT_35,       3150,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 35
            xi.item.GOLDSMITHING_KIT_40,       4150,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 40
            xi.item.GOLDSMITHING_KIT_45,       5300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 45
            xi.item.GOLDSMITHING_KIT_50,       7600,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 50
            xi.item.CHUNK_OF_RUTHENIUM_ORE, 1126125,      xi.craftRank.AMATEUR       -- Ruthenium Ore
        },

        [xi.skill.WOODWORKING] =
        {
            xi.item.SPOOL_OF_BUNDLING_TWINE,    100,      xi.craftRank.AMATEUR,      -- Bundling Twine
            xi.item.ARROWWOOD_LOG,               25,      xi.craftRank.AMATEUR,      -- Arrowwood Log
            xi.item.LAUAN_LOG,                   50,      xi.craftRank.AMATEUR,      -- Lauan Log
            xi.item.MAPLE_LOG,                   70,      xi.craftRank.AMATEUR,      -- Maple Log
            xi.item.HOLLY_LOG,                  800,      xi.craftRank.RECRUIT,      -- Holly Log
            xi.item.WILLOW_LOG,                1600,      xi.craftRank.RECRUIT,      -- Willow Log
            xi.item.WALNUT_LOG,                1300,      xi.craftRank.RECRUIT,      -- Walnut Log
            xi.item.YEW_LOG,                    500,     xi.craftRank.INITIATE,      -- Yew Log
            xi.item.ELM_LOG,                   3800,     xi.craftRank.INITIATE,      -- Elm Log
            xi.item.CHESTNUT_LOG,              3400,     xi.craftRank.INITIATE,      -- Chestnut Log
            xi.item.DOGWOOD_LOG,               2000,       xi.craftRank.NOVICE,      -- Dogwood Log
            xi.item.OAK_LOG,                   4000,       xi.craftRank.NOVICE,      -- Oak Log
            xi.item.ROSEWOOD_LOG,              4500,   xi.craftRank.APPRENTICE,      -- Rosewood Log
            xi.item.MAHOGANY_LOG,              4500,   xi.craftRank.JOURNEYMAN,      -- Mahogany Log
            xi.item.EBONY_LOG,                 5000,    xi.craftRank.CRAFTSMAN,      -- Ebony Log
            xi.item.FEYWEALD_LOG,              5500,    xi.craftRank.CRAFTSMAN,      -- Feyweald Log
            xi.item.SMITHING_KIT_5,             300,      xi.craftRank.AMATEUR,      -- Smithing Kit 5
            xi.item.SMITHING_KIT_10,            400,      xi.craftRank.AMATEUR,      -- Smithing Kit 10
            xi.item.SMITHING_KIT_15,            650,      xi.craftRank.AMATEUR,      -- Smithing Kit 15
            xi.item.SMITHING_KIT_20,           1050,      xi.craftRank.AMATEUR,      -- Smithing Kit 20
            xi.item.SMITHING_KIT_25,           1600,      xi.craftRank.AMATEUR,      -- Smithing Kit 25
            xi.item.SMITHING_KIT_30,           2300,      xi.craftRank.AMATEUR,      -- Smithing Kit 30
            xi.item.SMITHING_KIT_35,           3150,      xi.craftRank.AMATEUR,      -- Smithing Kit 35
            xi.item.SMITHING_KIT_40,           4150,      xi.craftRank.AMATEUR,      -- Smithing Kit 40
            xi.item.SMITHING_KIT_45,           5300,      xi.craftRank.AMATEUR,      -- Smithing Kit 45
            xi.item.SMITHING_KIT_50,           7600,      xi.craftRank.AMATEUR,      -- Smithing Kit 50
            xi.item.CYPRESS_LOG,            1126125,      xi.craftRank.AMATEUR       -- Cypress Log
        },

        [xi.skill.ALCHEMY] =
        {
            xi.item.TRITURATOR,                     75,      xi.craftRank.AMATEUR,      -- Triturator
            xi.item.BEEHIVE_CHIP,                   40,      xi.craftRank.AMATEUR,      -- Beehive Chip
            xi.item.VIAL_OF_MERCURY,              1700,      xi.craftRank.AMATEUR,      -- Mercury
            xi.item.BLOCK_OF_ANIMAL_GLUE,          300,      xi.craftRank.RECRUIT,      -- Animal Glue
            xi.item.PINCH_OF_POISON_DUST,          320,      xi.craftRank.RECRUIT,      -- Poison Dust
            xi.item.VIAL_OF_SLIME_OIL,            1500,     xi.craftRank.INITIATE,      -- Slime Oil
            xi.item.PINCH_OF_BOMB_ASH,             515,     xi.craftRank.INITIATE,      -- Bomb Ash
            xi.item.BOTTLE_OF_AHRIMAN_TEARS,       200,     xi.craftRank.INITIATE,      -- Ahriman Tears
            xi.item.LOOP_OF_GLASS_FIBER,          1200,       xi.craftRank.NOVICE,      -- Glass Fiber
            xi.item.JAR_OF_FIRESAND,              5000,       xi.craftRank.NOVICE,      -- Firesand
            xi.item.FLASH_OF_VITRIOL,              700,   xi.craftRank.APPRENTICE,      -- Vitriol
            xi.item.BOTTLE_OF_SIEGLINDE_PUTTY,    4000,   xi.craftRank.APPRENTICE,      -- Sieglinde Putty
            xi.item.DRYAD_ROOT,                   1800,   xi.craftRank.APPRENTICE,      -- Dryad Root
            xi.item.LOOP_OF_CARBON_FIBER,         1900,   xi.craftRank.JOURNEYMAN,      -- Carbon Fiber
            xi.item.HECTEYES_EYE,                 2100,   xi.craftRank.JOURNEYMAN,      -- Hecteyes Eye
            xi.item.JAR_OF_TOAD_OIL,              3600,   xi.craftRank.JOURNEYMAN,      -- Toad Oil
            xi.item.CERMET_CHUNK,                 5000,    xi.craftRank.CRAFTSMAN,      -- Cermet Chunk
            xi.item.PINCH_OF_VENOM_DUST,          1035,    xi.craftRank.CRAFTSMAN,      -- Venom Dust
            xi.item.ALCHEMY_KIT_5,                 300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 5
            xi.item.ALCHEMY_KIT_10,                400,      xi.craftRank.AMATEUR,      -- Alchemy Kit 10
            xi.item.ALCHEMY_KIT_15,                650,      xi.craftRank.AMATEUR,      -- Alchemy Kit 15
            xi.item.ALCHEMY_KIT_20,               1050,      xi.craftRank.AMATEUR,      -- Alchemy Kit 20
            xi.item.ALCHEMY_KIT_25,               1600,      xi.craftRank.AMATEUR,      -- Alchemy Kit 25
            xi.item.ALCHEMY_KIT_30,               2300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 30
            xi.item.ALCHEMY_KIT_35,               3150,      xi.craftRank.AMATEUR,      -- Alchemy Kit 35
            xi.item.ALCHEMY_KIT_40,               4150,      xi.craftRank.AMATEUR,      -- Alchemy Kit 40
            xi.item.ALCHEMY_KIT_45,               5300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 45
            xi.item.ALCHEMY_KIT_50,               7600,      xi.craftRank.AMATEUR,      -- Alchemy Kit 50
            xi.item.AZURE_LEAF,                1126125,      xi.craftRank.AMATEUR       -- Azure Leaf
        },

        [xi.skill.BONECRAFT] =
        {
            xi.item.SHAGREEN_FILE,                75,      xi.craftRank.AMATEUR,      -- Shagreen File
            xi.item.BONE_CHIP,                   150,      xi.craftRank.AMATEUR,      -- Bone Chip
            xi.item.HANDFUL_OF_FISH_SCALES,       96,      xi.craftRank.AMATEUR,      -- Fish Scales
            xi.item.CHICKEN_BONE,               1500,      xi.craftRank.RECRUIT,      -- Chicken Bone [Recruit]
            xi.item.GIANT_FEMUR,                1400,      xi.craftRank.RECRUIT,      -- Giant Femur [Recruit]
            xi.item.BEETLE_SHELL,                500,     xi.craftRank.INITIATE,      -- Beetle Shell [Initiate]
            xi.item.BEETLE_JAW,                 1000,     xi.craftRank.INITIATE,      -- Beetle Jaw [Initiate]
            xi.item.RAM_HORN,                   1800,       xi.craftRank.NOVICE,      -- Ram Horn [Novice]
            xi.item.BLACK_TIGER_FANG,           2000,       xi.craftRank.NOVICE,      -- Black Tiger Fang [Novice]
            xi.item.CRAB_SHELL,                 2500,   xi.craftRank.APPRENTICE,      -- Crab Shell [Apprentice]
            xi.item.TURTLE_SHELL,               6000,   xi.craftRank.JOURNEYMAN,      -- Turtle Shell [Journeyman]
            xi.item.SCORPION_CLAW,              2400,   xi.craftRank.JOURNEYMAN,      -- Scorpion Claw [Journeyman]
            xi.item.BUGARD_TUSK,                4000,   xi.craftRank.JOURNEYMAN,      -- Bugard Tusk [Journeyman]
            xi.item.SCORPION_SHELL,             3000,    xi.craftRank.CRAFTSMAN,      -- Scorpion Shell [Craftsman]
            xi.item.MARID_TUSK,                 4500,    xi.craftRank.CRAFTSMAN,      -- Marid Tusk [Craftsman]
            xi.item.BONECRAFT_KIT_5,             300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 5
            xi.item.BONECRAFT_KIT_10,            400,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 10
            xi.item.BONECRAFT_KIT_15,            650,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 15
            xi.item.BONECRAFT_KIT_20,           1050,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 20
            xi.item.BONECRAFT_KIT_25,           1600,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 25
            xi.item.BONECRAFT_KIT_30,           2300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 30
            xi.item.BONECRAFT_KIT_35,           3150,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 35
            xi.item.BONECRAFT_KIT_40,           4150,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 40
            xi.item.BONECRAFT_KIT_45,           5300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 45
            xi.item.BONECRAFT_KIT_50,           7600,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 50
            xi.item.FRAGMENT_OF_CYAN_CORAL,  1126125,      xi.craftRank.AMATEUR       -- Cyan Coral
        },

        [xi.skill.LEATHERCRAFT] =
        {
            xi.item.TANNING_VAT,                              75,      xi.craftRank.AMATEUR,      -- Tanning Vat
            xi.item.SHEEPSKIN,                               100,      xi.craftRank.AMATEUR,      -- Sheepskin
            xi.item.RABBIT_HIDE,                              80,      xi.craftRank.AMATEUR,      -- Rabbit Hide
            xi.item.LIZARD_SKIN,                             600,      xi.craftRank.RECRUIT,      -- Lizard Skin
            xi.item.KARAKUL_SKIN,                            600,      xi.craftRank.RECRUIT,      -- Karakul Skin
            xi.item.WOLF_HIDE,                               600,      xi.craftRank.RECRUIT,      -- Wolf Hide
            xi.item.DHALMEL_HIDE,                           2400,     xi.craftRank.INITIATE,      -- Dhalmel Hide
            xi.item.BUGARD_SKIN,                            2500,     xi.craftRank.INITIATE,      -- Bugard Skin
            xi.item.RAM_SKIN,                               1500,       xi.craftRank.NOVICE,      -- Ram Skin
            xi.item.BUFFALO_HIDE,                          16000,   xi.craftRank.APPRENTICE,      -- Buffalo Hide
            xi.item.RAPTOR_SKIN,                            3000,   xi.craftRank.JOURNEYMAN,      -- Raptor Skin
            xi.item.CATOBLEPAS_HIDE,                        2500,   xi.craftRank.JOURNEYMAN,      -- Catoblepas Hide
            xi.item.SMILODON_HIDE,                          3000,    xi.craftRank.CRAFTSMAN,      -- Smilodon Hide
            xi.item.COCKATRICE_SKIN,                        3000,    xi.craftRank.CRAFTSMAN,      -- Cockatrice Skin
            xi.item.LEATHERCRAFT_KIT_5,                      300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 5
            xi.item.LEATHERCRAFT_KIT_10,                     400,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 10
            xi.item.LEATHERCRAFT_KIT_15,                     650,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 15
            xi.item.LEATHERCRAFT_KIT_20,                    1050,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 20
            xi.item.LEATHERCRAFT_KIT_25,                    1600,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 25
            xi.item.LEATHERCRAFT_KIT_30,                    2300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 30
            xi.item.LEATHERCRAFT_KIT_35,                    3150,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 35
            xi.item.LEATHERCRAFT_KIT_40,                    4150,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 40
            xi.item.LEATHERCRAFT_KIT_45,                    5300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 45
            xi.item.LEATHERCRAFT_KIT_50,                    7600,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 50
            xi.item.SQUARE_OF_SYNTHETIC_FAULPIE_LEATHER, 1126125,      xi.craftRank.AMATEUR       -- Synthetic Faulpie Leather
        },

        [xi.skill.SMITHING] =
        {
            xi.item.WORKSHOP_ANVIL,              75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
            xi.item.MANDREL,                     75,      xi.craftRank.AMATEUR,      -- Mandrel
            xi.item.CHUNK_OF_COPPER_ORE,         12,      xi.craftRank.AMATEUR,      -- Copper Ore
            xi.item.BRONZE_NUGGET,               70,      xi.craftRank.AMATEUR,      -- Bronze Nugget
            xi.item.CHUNK_OF_TIN_ORE,            60,      xi.craftRank.RECRUIT,      -- Tin Ore
            xi.item.BRONZE_SHEET,               120,      xi.craftRank.RECRUIT,      -- Bronze Sheet
            xi.item.CHUNK_OF_IRON_ORE,          900,      xi.craftRank.RECRUIT,      -- Iron Ore
            xi.item.CHUNK_OF_KOPPARNICKEL_ORE,  800,     xi.craftRank.INITIATE,      -- Kopparnickel Ore
            xi.item.IRON_NUGGET,                500,     xi.craftRank.INITIATE,      -- Iron Nugget
            xi.item.IRON_SHEET,                6000,     xi.craftRank.INITIATE,      -- Iron Sheet
            xi.item.STEEL_SHEET,              10000,       xi.craftRank.NOVICE,      -- Steel Sheet
            xi.item.STEEL_INGOT,               6000,   xi.craftRank.APPRENTICE,      -- Steel Ingot
            xi.item.LUMP_OF_TAMA_HAGANE,      12000,   xi.craftRank.APPRENTICE,      -- Tama-Hagane
            xi.item.DARKSTEEL_NUGGET,          2700,   xi.craftRank.JOURNEYMAN,      -- Darksteel Nugget
            xi.item.CHUNK_OF_DARKSTEEL_ORE,    7000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Ore
            xi.item.STEEL_NUGGET,               800,   xi.craftRank.JOURNEYMAN,      -- Steel Nugget
            xi.item.DARKSTEEL_SHEET,          28000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Sheet
            xi.item.CHUNK_OF_SWAMP_ORE,        5000,    xi.craftRank.CRAFTSMAN,      -- Swamp Ore
            xi.item.SMITHING_KIT_5,             300,      xi.craftRank.AMATEUR,      -- Smithing Kit 5
            xi.item.SMITHING_KIT_10,            400,      xi.craftRank.AMATEUR,      -- Smithing Kit 10
            xi.item.SMITHING_KIT_15,            650,      xi.craftRank.AMATEUR,      -- Smithing Kit 15
            xi.item.SMITHING_KIT_20,           1050,      xi.craftRank.AMATEUR,      -- Smithing Kit 20
            xi.item.SMITHING_KIT_25,           1600,      xi.craftRank.AMATEUR,      -- Smithing Kit 25
            xi.item.SMITHING_KIT_30,           2300,      xi.craftRank.AMATEUR,      -- Smithing Kit 30
            xi.item.SMITHING_KIT_35,           3150,      xi.craftRank.AMATEUR,      -- Smithing Kit 35
            xi.item.SMITHING_KIT_40,           4150,      xi.craftRank.AMATEUR,      -- Smithing Kit 40
            xi.item.SMITHING_KIT_45,           5300,      xi.craftRank.AMATEUR,      -- Smithing Kit 45
            xi.item.SMITHING_KIT_50,           7600,      xi.craftRank.AMATEUR,      -- Smithing Kit 50
            xi.item.NIOBIUM_ORE,            1126125,      xi.craftRank.AMATEUR       -- Niobium Ore
        }
    },

    curioVendorMoogleStock =
    {
        [curio.medicine] =
        {
            xi.item.POTION,                    300,      xi.ki.RHAPSODY_IN_WHITE,   -- Potion
            xi.item.HI_POTION,                 600,      xi.ki.RHAPSODY_IN_UMBER,   -- Hi-Potion
            xi.item.X_POTION,                 1200,    xi.ki.RHAPSODY_IN_CRIMSON,   -- X-Potion
            -- xi.item.ETHER,                  650,      xi.ki.RHAPSODY_IN_WHITE,   -- Ether / Temporarily(?) removed by SE June 2021
            xi.item.HI_ETHER,                 1300,      xi.ki.RHAPSODY_IN_UMBER,   -- Hi-Ether
            xi.item.SUPER_ETHER,              3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Super Ether
            xi.item.ELIXIR,                  15000,      xi.ki.RHAPSODY_IN_AZURE,   -- Elixir
            xi.item.ANTIDOTE,                  300,      xi.ki.RHAPSODY_IN_WHITE,   -- Antidote
            xi.item.FLASK_OF_EYE_DROPS,       1000,      xi.ki.RHAPSODY_IN_UMBER,   -- Eye Drops
            xi.item.FLASK_OF_ECHO_DROPS,       700,      xi.ki.RHAPSODY_IN_UMBER,   -- Echo Drops
            xi.item.BOTTLE_OF_MULSUM,          500,      xi.ki.RHAPSODY_IN_WHITE,   -- Mulsum
            xi.item.PINCH_OF_PRISM_POWDER,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Prism Powder
            xi.item.POT_OF_SILENT_OIL,         500,      xi.ki.RHAPSODY_IN_WHITE,   -- Silent Oil
            xi.item.FLASK_OF_DEODORIZER,       250,      xi.ki.RHAPSODY_IN_WHITE,   -- Deodorizer
            xi.item.RERAISER,                 1000,      xi.ki.RHAPSODY_IN_AZURE,   -- Reraiser
        },

        [curio.ammunition] =
        {
            xi.item.STONE_QUIVER,              400,      xi.ki.RHAPSODY_IN_WHITE,   -- Stone Quiver
            xi.item.BONE_QUIVER,               680,      xi.ki.RHAPSODY_IN_WHITE,   -- Bone Quiver
            xi.item.IRON_QUIVER,              1200,      xi.ki.RHAPSODY_IN_WHITE,   -- Iron Quiver
            xi.item.BEETLE_QUIVER,            1350,      xi.ki.RHAPSODY_IN_WHITE,   -- Beetle Quiver
            xi.item.SILVER_QUIVER,            2040,      xi.ki.RHAPSODY_IN_WHITE,   -- Silver Quiver
            xi.item.HORN_QUIVER,              2340,      xi.ki.RHAPSODY_IN_WHITE,   -- Horn Quiver
            xi.item.SLEEP_QUIVER,             3150,      xi.ki.RHAPSODY_IN_UMBER,   -- Sleep Quiver
            xi.item.SCORPION_QUIVER,          3500,      xi.ki.RHAPSODY_IN_UMBER,   -- Scorpion Quiver
            xi.item.DEMON_QUIVER,             7000,      xi.ki.RHAPSODY_IN_AZURE,   -- Demon Quiver
            xi.item.KABURA_QUIVER,            8800,      xi.ki.RHAPSODY_IN_AZURE,   -- Kabura Quiver
            xi.item.ANTLION_QUIVER,           9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Antlion Quiver
            xi.item.BRONZE_BOLT_QUIVER,        400,      xi.ki.RHAPSODY_IN_WHITE,   -- Bronze Bolt Quiver
            xi.item.BLIND_BOLT_QUIVER,         800,      xi.ki.RHAPSODY_IN_WHITE,   -- Blind Bolt Quiver
            xi.item.ACID_BOLT_QUIVER,         1250,      xi.ki.RHAPSODY_IN_WHITE,   -- Acid Bolt Quiver
            xi.item.SLEEP_BOLT_QUIVER,        1500,      xi.ki.RHAPSODY_IN_WHITE,   -- Sleep Bolt Quiver
            xi.item.BLOODY_BOLT_QUIVER,       2100,      xi.ki.RHAPSODY_IN_WHITE,   -- Bloody Bolt Quiver
            xi.item.VENOM_BOLT_QUIVER,        2100,      xi.ki.RHAPSODY_IN_WHITE,   -- Venom Bolt Quiver
            xi.item.HOLY_BOLT_QUIVER,         2400,      xi.ki.RHAPSODY_IN_WHITE,   -- Holy Bolt Quiver
            xi.item.MYTHRIL_BOLT_QUIVER,      3500,      xi.ki.RHAPSODY_IN_UMBER,   -- Mythril Bolt Quiver
            xi.item.DARKSTEEL_BOLT_QUIVER,    5580,      xi.ki.RHAPSODY_IN_AZURE,   -- Darksteel Bolt Quiver
            xi.item.DARKLING_BOLT_QUIVER,     9460,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Darkling Bolt Quiver
            xi.item.FUSION_BOLT_QUIVER,       9790,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Fusion Bolt Quiver
            xi.item.BRONZE_BULLET_POUCH,       400,      xi.ki.RHAPSODY_IN_WHITE,   -- Bronze Bullet Pouch
            xi.item.BULLET_POUCH,             1920,      xi.ki.RHAPSODY_IN_WHITE,   -- Bullet Pouch
            xi.item.SPARTAN_BULLET_POUCH,     2400,      xi.ki.RHAPSODY_IN_WHITE,   -- Spartan Bullet Pouch
            xi.item.IRON_BULLET_POUCH,        4800,      xi.ki.RHAPSODY_IN_UMBER,   -- Iron Bullet Pouch
            xi.item.SILVER_BULLET_POUCH,      4800,      xi.ki.RHAPSODY_IN_UMBER,   -- Silver Bullet Pouch
            xi.item.CORSAIR_BULLET_POUCH,     7100,      xi.ki.RHAPSODY_IN_AZURE,   -- Corsair Bullet Pouch
            xi.item.STEEL_BULLET_POUCH,       7600,      xi.ki.RHAPSODY_IN_AZURE,   -- Steel Bullet Pouch
            xi.item.DWEOMER_BULLET_POUCH,     9680,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Dweomer Bullet Pouch
            xi.item.OBERON_BULLET_POUCH,      9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Oberon Bullet Pouch
            xi.item.SHURIKEN_POUCH,           1400,      xi.ki.RHAPSODY_IN_WHITE,   -- Shuriken Pouch
            xi.item.JUJI_SHURIKEN_POUCH,      2280,      xi.ki.RHAPSODY_IN_WHITE,   -- Juji Shuriken Pouch
            xi.item.MANJI_SHURIKEN_POUCH,     4640,      xi.ki.RHAPSODY_IN_UMBER,   -- Manji Shuriken Pouch
            xi.item.FUMA_SHURIKEN_POUCH,      7000,      xi.ki.RHAPSODY_IN_AZURE,   -- Fuma Shuriken Pouch
            xi.item.IGA_SHURIKEN_POUCH,       9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Iga Shuriken Pouch
        },

        [curio.ninjutsuTools] =
        {
            xi.item.TOOLBAG_UCHITAKE,           3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Uchi)
            xi.item.TOOLBAG_TSURARA,            3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Tsurara)
            xi.item.TOOLBAG_KAWAHORI_OGI,       3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kawahori-Ogi)
            xi.item.TOOLBAG_MAKIBISHI,          3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Makibishi)
            xi.item.TOOLBAG_HIRAISHIN,          3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Hiraishin)
            xi.item.TOOLBAG_MIZU_DEPPO,         3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Mizu-Deppo)
            xi.item.TOOLBAG_SHIHEI,             5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shihei)
            xi.item.TOOLBAG_JUSATSU,            5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Jusatsu)
            xi.item.TOOLBAG_KAGINAWA,           5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kaginawa)
            xi.item.TOOLBAG_SAIRUI_RAN,         5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sairui-Ran)
            xi.item.TOOLBAG_KODOKU,             5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kodoku)
            xi.item.TOOLBAG_SHINOBI_TABI,       3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shinobi-Tabi)
            xi.item.TOOLBAG_SANJAKU_TENUGUI,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sanjaku-Tenugui)
            xi.item.TOOLBAG_SOSHI,              5000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Toolbag (Soshi)
        },
        [curio.foodStuffs] =
        {
            xi.item.JUG_OF_SELBINA_MILK,           60,      xi.ki.RHAPSODY_IN_WHITE,   -- Selbina Milk
            xi.item.FLASK_OF_ORANGE_AU_LAIT,      100,      xi.ki.RHAPSODY_IN_WHITE,   -- Orange au Lait
            xi.item.JUG_OF_ULEGUERAND_MILK,       100,      xi.ki.RHAPSODY_IN_WHITE,   -- Uleguerand Milk
            xi.item.FLASK_OF_APPLE_AU_LAIT,       300,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Apple au Lait
            xi.item.FLASK_OF_PEAR_AU_LAIT,        600,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pear au Lait
            xi.item.BOTTLE_OF_ORANGE_JUICE,       200,      xi.ki.RHAPSODY_IN_WHITE,   -- Orange Juice
            xi.item.BOTTLE_OF_MELON_JUICE,       1100,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Melon Juice
            xi.item.BOTTLE_OF_YAGUDO_DRINK,      2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Yagudo Drink
            xi.item.RICE_BALL,                    160,      xi.ki.RHAPSODY_IN_WHITE,   -- Rice Ball
            xi.item.STRIP_OF_MEAT_JERKY,          120,      xi.ki.RHAPSODY_IN_WHITE,   -- Meat Jerky
            xi.item.SLICE_OF_GRILLED_HARE,        184,      xi.ki.RHAPSODY_IN_WHITE,   -- Grilled Hare
            xi.item.MEAT_MITHKABOB,               720,      xi.ki.RHAPSODY_IN_UMBER,   -- Meat Mithkabob
            -- xi.item.BOILED_CRAB,               550,      xi.ki.RHAPSODY_IN_WHITE,   -- Boiled Crab / Temporarily(?) removed by SE June 2021
            xi.item.FISH_MITHKABOB,              1080,      xi.ki.RHAPSODY_IN_UMBER,   -- Fish Mithkabob
            xi.item.COEURL_SUB,                  1500,      xi.ki.RHAPSODY_IN_WHITE,   -- Coeurl Sub
            xi.item.ROAST_PIPIRA,                 900,      xi.ki.RHAPSODY_IN_WHITE,   -- Roast Pipira
            xi.item.SLICE_OF_ANCHOVY_PIZZA,       500,      xi.ki.RHAPSODY_IN_AZURE,   -- Anchovy Slice
            xi.item.SLICE_OF_PEPPERONI_PIZZA,     400,      xi.ki.RHAPSODY_IN_UMBER,   -- Pepperoni Slice
            xi.item.POT_AUF_FEU,                 3500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pot-auf-feu
            xi.item.JACK_O_LANTERN,              1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Jack-o'-Lantern
            xi.item.PLATE_OF_BREAM_SUSHI,        5000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Bream Sushi
            xi.item.PLATE_OF_DORADO_SUSHI,       4000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Dorado Sushi
            xi.item.PLATE_OF_CRAB_SUSHI,         1500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Crab Sushi
            xi.item.CHOCOLATE_CREPE,              500,      xi.ki.RHAPSODY_IN_WHITE,   -- Chocolate Crepe
            xi.item.BUTTER_CREPE,                1000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Butter Crepe
            xi.item.APPLE_PIE,                    320,      xi.ki.RHAPSODY_IN_WHITE,   -- Apple Pie
            xi.item.MELON_PIE,                    800,      xi.ki.RHAPSODY_IN_WHITE,   -- Melon Pie
            xi.item.PUMPKIN_PIE,                 1200,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pumpkin Pie
            xi.item.ROAST_MUSHROOM,               344,      xi.ki.RHAPSODY_IN_WHITE,   -- Roast Mushroom
            xi.item.ACORN_COOKIE,                  24,      xi.ki.RHAPSODY_IN_WHITE,   -- Acorn Cookie
            xi.item.GINGER_COOKIE,                 12,      xi.ki.RHAPSODY_IN_AZURE,   -- Ginger Cookie
            xi.item.SUGAR_RUSK,                  1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Sugar Rusk
            xi.item.CHOCOLATE_RUSK,              2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Chocolate Rusk
            xi.item.CHERRY_MACARON,              1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Cherry Macaron
            xi.item.COFFEE_MACARON,              2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Coffee Macaron
            xi.item.SALTENA,                     1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Saltena
            xi.item.ELSHENA,                     2000,      xi.ki.RHAPSODY_IN_AZURE,   -- Elshena
            xi.item.MONTAGNA,                    2500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Montagna
            xi.item.STUFFED_PITARU,              1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Stuffed Pitaru
            xi.item.POULTRY_PITARU,              2000,      xi.ki.RHAPSODY_IN_AZURE,   -- Poultry Pitaru
            xi.item.SEAFOOD_PITARU,              2500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Seafood Pitaru
            xi.item.PIECE_OF_SHIROMOCHI,         3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Shiromochi
            xi.item.PIECE_OF_KUSAMOCHI,          3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Kusamochi
            xi.item.PIECE_OF_AKAMOCHI,           3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Akamochi
            xi.item.BEEF_STEWPOT,               15000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Beef Stewpot
            xi.item.SERVING_OF_ZARU_SOBA,       15000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Zaru Soba
            xi.item.SPICY_CRACKER,                450,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Spicy Cracker
        },

        [curio.scrolls] =
        {
            xi.item.SCROLL_OF_INSTANT_WARP,       500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Warp
            xi.item.SCROLL_OF_INSTANT_RERAISE,    500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Reraise
            xi.item.SCROLL_OF_INSTANT_RETRACE,    500,      xi.ki.RHAPSODY_IN_AZURE,   -- Instant Retrace
            xi.item.SCROLL_OF_INSTANT_PROTECT,    500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Protect
            xi.item.SCROLL_OF_INSTANT_SHELL,      500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Shell
            xi.item.SCROLL_OF_INSTANT_STONESKIN,  500,      xi.ki.RHAPSODY_IN_UMBER,   -- Instant Stoneskin
        },

        [curio.keys] =
        {
            xi.item.GHELSBA_CHEST_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ghelsba Chest Key
            xi.item.PALBOROUGH_CHEST_KEY,     2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Palborough Chest Key
            xi.item.GIDDEUS_CHEST_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Giddeus Chest Key
            xi.item.RANPERRE_CHEST_KEY,       2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ranperre Chest Key
            xi.item.DANGRUF_CHEST_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Dangruf Chest Key
            xi.item.HORUTOTO_CHEST_KEY,       2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Horutoto Chest Key
            xi.item.ORDELLE_CHEST_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ordelle Chest Key
            xi.item.GUSGEN_CHEST_KEY,         2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Gusgen Chest Key
            xi.item.SHAKHRAMI_CHEST_KEY,      2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Shakhrami Chest Key
            xi.item.DAVOI_CHEST_KEY,          2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Davoi Chest Key
            xi.item.BEADEAUX_CHEST_KEY,       2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Beadeaux Chest Key
            xi.item.OZTROJA_CHEST_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Oztroja Chest Key
            xi.item.DELKFUTT_CHEST_KEY,       2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Delkfutt Chest Key
            xi.item.FEIYIN_CHEST_KEY,         2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Fei'Yin Chest Key
            xi.item.ZVAHL_CHEST_KEY,          2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Zvahl Chest Key
            xi.item.ELDIME_CHEST_KEY,         2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Eldieme Chest Key
            xi.item.NEST_CHEST_KEY,           2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Nest Chest Key
            xi.item.GARLAIGE_CHEST_KEY,       2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Garlaige Chest Key
            xi.item.BEADEAUX_COFFER_KEY,      5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Beadeaux Coffer Key
            xi.item.DAVOI_COFFER_KEY,         5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Davoi Coffer Key
            xi.item.OZTROJA_COFFER_KEY,       5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Oztroja Coffer Key
            xi.item.NEST_COFFER_KEY,          5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Nest Coffer Key
            xi.item.ELDIEME_COFFER_KEY,       5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Eldieme Coffer Key
            xi.item.GARLAIGE_COFFER_KEY,      5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Garlaige Coffer Key
            xi.item.ZVAHL_COFFER_KEY,         5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Zvhal Coffer Key
            xi.item.UGGALEPIH_COFFER_KEY,     5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Uggalepih Coffer Key
            xi.item.RANCOR_DEN_COFFER_KEY,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Den Coffer Key
            xi.item.KUFTAL_COFFER_KEY,        5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Kuftal Coffer Key
            xi.item.BOYAHDA_COFFER_KEY,       5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Boyahda Coffer Key
            xi.item.CAULDRON_COFFER_KEY,      5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Cauldron Coffer Key
            xi.item.QUICKSAND_COFFER_KEY,     5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Quicksand Coffer Key
            xi.item.GROTTO_CHEST_KEY,         2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Grotto Chest Key
            xi.item.ONZOZO_CHEST_KEY,         2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Onzozo Chest Key
            xi.item.TORAIMARI_COFFER_KEY,     5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Toraimarai Coffer Key
            xi.item.GROTTO_COFFER_KEY,        5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Ru'Aun Coffer Key
            xi.item.GROTTO_COFFER_KEY,        5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Grotto Coffer Key
            xi.item.VELUGANNON_COFFER_KEY,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Ve'Lugannon Coffer Key
            xi.item.SACRARIUM_COFFER_KEY,     2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Sacrarium Chest Key
            xi.item.OLDTON_COFFER_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Oldton Chest Key
            xi.item.NEWTON_COFFER_KEY,        5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Newton Coffer Key
            xi.item.PSOXJA_COFFER_KEY,        2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Pso'Xja Chest Key
        }
    }
}
