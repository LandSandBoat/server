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
            4148,  316, -- Antidote
            4151,  800, -- Echo Drops
            4128, 4832, -- Ether
            4150, 2595, -- Eye Drops
            4112,  910, -- Potion
        }
        xi.shop.general(player, stock)
    end,

    -- send celebratory chest shop dialog to player
    celebratory = function(player)
        local stock =
        {
            4167,   30, -- Cracker
            4168,   30, -- Twinkle Shower
            4215,   60, -- Popstar
            4216,   60, -- Brilliant Snow
            4256,   30, -- Ouka Ranman
            4169,   30, -- Little Comet
            5769,  650, -- Popper
            4170, 1000, -- Wedding Bell
            5424, 6000, -- Serene Serinette
            5425, 6000, -- Joyous Serinette
            4441, 1116, -- Grape Juice
            4238, 3000, -- Inferno Crystal
            4240, 3000, -- Cyclone Crystal
            4241, 3000, -- Terra Crystal
        }
        xi.shop.general(player, stock)
    end,

    -- stock for guild vendors that are open 24/8
    generalGuildStock =
    {
        -- TODO: Use xi.items enum for first value
        [xi.skill.COOKING] =
        {
            936,       16,      xi.craftRank.AMATEUR,      -- Rock Salt
            4509,      12,      xi.craftRank.AMATEUR,      -- Distilled Water
            4362,     100,      xi.craftRank.AMATEUR,      -- Lizard Egg
            4392,      32,      xi.craftRank.AMATEUR,      -- Saruta Orange
            4431,      76,      xi.craftRank.AMATEUR,      -- San d'Orian Grapes
            9193,    2500,      xi.craftRank.AMATEUR,      -- Miso
            9194,    2500,      xi.craftRank.AMATEUR,      -- Soy Sauce
            9195,    2500,      xi.craftRank.AMATEUR,      -- Dried Bonito
            610,       60,      xi.craftRank.RECRUIT,      -- San d'Orian Flour
            627,       40,      xi.craftRank.RECRUIT,      -- Maple Sugar
            4363,      44,      xi.craftRank.RECRUIT,      -- Faerie Apple
            4378,      60,      xi.craftRank.RECRUIT,      -- Selbina Milk
            4370,     200,      xi.craftRank.RECRUIT,      -- Honey
            4432,      60,     xi.craftRank.INITIATE,      -- Kazham Pineapple
            4366,      24,     xi.craftRank.INITIATE,      -- La Theine Cabbage
            611,       40,     xi.craftRank.INITIATE,      -- Rye Flour
            4412,     325,       xi.craftRank.NOVICE,      -- Thundermelon
            4491,     200,       xi.craftRank.NOVICE,      -- Watermelon
            615,       60,       xi.craftRank.NOVICE,      -- Selbina Butter
            612,       60,   xi.craftRank.APPRENTICE,      -- Kazham Peppers
            1111,     900,   xi.craftRank.APPRENTICE,      -- Gelatin
            1776,    3000,   xi.craftRank.JOURNEYMAN,      -- Spaghetti
            5164,    2595,   xi.craftRank.JOURNEYMAN,      -- Ground Wasabi
            616,     1600,    xi.craftRank.CRAFTSMAN,      -- Pie Dough
            2561,    3000,    xi.craftRank.CRAFTSMAN,      -- Pizza Dough
            8800,     600,    xi.craftRank.CRAFTSMAN,      -- Azuki Bean
            8903,     300,      xi.craftRank.AMATEUR,      -- Cooking Kit 5
            8904,     400,      xi.craftRank.AMATEUR,      -- Cooking Kit 10
            8905,     650,      xi.craftRank.AMATEUR,      -- Cooking Kit 15
            8906,    1050,      xi.craftRank.AMATEUR,      -- Cooking Kit 20
            8907,    1600,      xi.craftRank.AMATEUR,      -- Cooking Kit 25
            8908,    2300,      xi.craftRank.AMATEUR,      -- Cooking Kit 30
            8909,    3150,      xi.craftRank.AMATEUR,      -- Cooking Kit 35
            8910,    4150,      xi.craftRank.AMATEUR,      -- Cooking Kit 40
            8911,    5300,      xi.craftRank.AMATEUR,      -- Cooking Kit 45
            8912,    7600,      xi.craftRank.AMATEUR       -- Cooking Kit 50
        },

        [xi.skill.CLOTHCRAFT] =
        {
            2128,      75,      xi.craftRank.AMATEUR,      -- Spindle
            2145,      75,      xi.craftRank.AMATEUR,      -- Zephyr Thread
            833,       20,      xi.craftRank.AMATEUR,      -- Moko Grass
            834,      500,      xi.craftRank.RECRUIT,      -- Saruta Cotton
            1845,     200,      xi.craftRank.RECRUIT,      -- Red Moko Grass
            819,      150,     xi.craftRank.INITIATE,      -- Linen Thread
            820,     2800,       xi.craftRank.NOVICE,      -- Wool Thread
            2295,     800,   xi.craftRank.APPRENTICE,      -- Mohbwa Grass
            816,     1500,   xi.craftRank.APPRENTICE,      -- Silk Thread
            2315,    1400,   xi.craftRank.JOURNEYMAN,      -- Karakul Wool
            823,    14500,    xi.craftRank.CRAFTSMAN,      -- Gold Thread
            8847,     300,      xi.craftRank.AMATEUR,      -- Clothcraft kit 5
            8848,     400,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 10
            8849,     650,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 15
            8850,    1050,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 20
            8851,    1600,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 25
            8852,    2300,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 30
            8853,    3150,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 35
            8854,    4150,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 40
            8855,    5300,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 45
            8856,    7600,      xi.craftRank.AMATEUR,      -- Clothcraft Kit 50
            9251, 1126125,      xi.craftRank.AMATEUR       -- Khoma Thread
        },

        [xi.skill.GOLDSMITHING] =
        {
            2144,      75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
            2143,      75,      xi.craftRank.AMATEUR,      -- Mandrel
            642,      200,      xi.craftRank.AMATEUR,      -- Zinc Ore
            640,       12,      xi.craftRank.AMATEUR,      -- Copper Ore
            1231,      40,      xi.craftRank.RECRUIT,      -- Brass Nugget
            661,      300,      xi.craftRank.RECRUIT,      -- Brass Sheet
            736,      450,      xi.craftRank.RECRUIT,      -- Silver Ore
            1233,     200,     xi.craftRank.INITIATE,      -- Silver Nugget
            806,     1863,     xi.craftRank.INITIATE,      -- Tourmaline
            807,     1863,     xi.craftRank.INITIATE,      -- Sardonyx
            809,     1863,     xi.craftRank.INITIATE,      -- Clear Topaz
            800,     1863,     xi.craftRank.INITIATE,      -- Amethyst
            795,     1863,     xi.craftRank.INITIATE,      -- Lapis Lazuli
            814,     1863,     xi.craftRank.INITIATE,      -- Amber
            799,     1863,     xi.craftRank.INITIATE,      -- Onyx
            796,     1863,     xi.craftRank.INITIATE,      -- Light Opal
            760,    23000,       xi.craftRank.NOVICE,      -- Silver Chain
            644,     2000,       xi.craftRank.NOVICE,      -- Mythril Ore
            737,     3000,   xi.craftRank.APPRENTICE,      -- Gold Ore
            663,    12000,   xi.craftRank.APPRENTICE,      -- Mythril Sheet
            788,     8000,   xi.craftRank.APPRENTICE,      -- Peridot
            790,     8000,   xi.craftRank.APPRENTICE,      -- Garnet
            808,     8000,   xi.craftRank.APPRENTICE,      -- Goshenite
            811,     8000,   xi.craftRank.APPRENTICE,      -- Ametrine
            798,     8000,   xi.craftRank.APPRENTICE,      -- Turquoise
            815,     8000,   xi.craftRank.APPRENTICE,      -- Sphene
            793,     8000,   xi.craftRank.APPRENTICE,      -- Black Pearl
            792,     8000,   xi.craftRank.APPRENTICE,      -- Pearl
            678,     5000,   xi.craftRank.APPRENTICE,      -- Aluminum Ore
            752,    32000,   xi.craftRank.JOURNEYMAN,      -- Gold Sheet
            761,    58000,   xi.craftRank.JOURNEYMAN,      -- Gold Chain
            738,     6000,    xi.craftRank.CRAFTSMAN,      -- Platinum Ore
            8833,     300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 5
            8834,     400,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 10
            8835,     650,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 15
            8836,    1050,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 20
            8837,    1600,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 25
            8838,    2300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 30
            8839,    3150,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 35
            8840,    4150,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 40
            8841,    5300,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 45
            8842,    7600,      xi.craftRank.AMATEUR,      -- Goldsmithing Kit 50
            9249, 1126125,      xi.craftRank.AMATEUR       -- Ruthenium Ore
        },

        [xi.skill.WOODWORKING] =
        {
            1657,     100,      xi.craftRank.AMATEUR,      -- Bundling Twine
            688,       25,      xi.craftRank.AMATEUR,      -- Arrowwood Log
            689,       50,      xi.craftRank.AMATEUR,      -- Lauan Log
            691,       70,      xi.craftRank.AMATEUR,      -- Maple Log
            697,      800,      xi.craftRank.RECRUIT,      -- Holly Log
            695,     1600,      xi.craftRank.RECRUIT,      -- Willow Log
            693,     1300,      xi.craftRank.RECRUIT,      -- Walnut Log
            696,      500,     xi.craftRank.INITIATE,      -- Yew Log
            690,     3800,     xi.craftRank.INITIATE,      -- Elm Log
            694,     3400,     xi.craftRank.INITIATE,      -- Chestnut Log
            727,     2000,       xi.craftRank.NOVICE,      -- Dogwood Log
            699,     4000,       xi.craftRank.NOVICE,      -- Oak Log
            701,     4500,   xi.craftRank.APPRENTICE,      -- Rosewood Log
            700,     4500,   xi.craftRank.JOURNEYMAN,      -- Mahogany Log
            702,     5000,    xi.craftRank.CRAFTSMAN,      -- Ebony Log
            2761,    5500,    xi.craftRank.CRAFTSMAN,      -- Feyweald Log
            8805,     300,      xi.craftRank.AMATEUR,      -- Smithing Kit 5
            8806,     400,      xi.craftRank.AMATEUR,      -- Smithing Kit 10
            8807,     650,      xi.craftRank.AMATEUR,      -- Smithing Kit 15
            8808,    1050,      xi.craftRank.AMATEUR,      -- Smithing Kit 20
            8809,    1600,      xi.craftRank.AMATEUR,      -- Smithing Kit 25
            8810,    2300,      xi.craftRank.AMATEUR,      -- Smithing Kit 30
            8811,    3150,      xi.craftRank.AMATEUR,      -- Smithing Kit 35
            8812,    4150,      xi.craftRank.AMATEUR,      -- Smithing Kit 40
            8813,    5300,      xi.craftRank.AMATEUR,      -- Smithing Kit 45
            8814,    7600,      xi.craftRank.AMATEUR,      -- Smithing Kit 50
            9245, 1126125,      xi.craftRank.AMATEUR       -- Cypress Log
        },

        [xi.skill.ALCHEMY] =
        {
            2131,      75,      xi.craftRank.AMATEUR,      -- Triturator
            912,       40,      xi.craftRank.AMATEUR,      -- Beehive Chip
            914,     1700,      xi.craftRank.AMATEUR,      -- Mercury
            937,      300,      xi.craftRank.RECRUIT,      -- Animal Glue
            943,      320,      xi.craftRank.RECRUIT,      -- Poison Dust
            637,     1500,     xi.craftRank.INITIATE,      -- Slime Oil
            928,      515,     xi.craftRank.INITIATE,      -- Bomb Ash
            921,      200,     xi.craftRank.INITIATE,      -- Ahriman Tears
            933,     1200,       xi.craftRank.NOVICE,      -- Glass Fiber
            947,     5000,       xi.craftRank.NOVICE,      -- Firesand
            4171,     700,   xi.craftRank.APPRENTICE,      -- Vitriol
            1886,    4000,   xi.craftRank.APPRENTICE,      -- Sieglinde Putty
            923,     1800,   xi.craftRank.APPRENTICE,      -- Dryad Root
            932,     1900,   xi.craftRank.JOURNEYMAN,      -- Carbon Fiber
            939,     2100,   xi.craftRank.JOURNEYMAN,      -- Hecteyes Eye
            915,     3600,   xi.craftRank.JOURNEYMAN,      -- Toad Oil
            931,     5000,    xi.craftRank.CRAFTSMAN,      -- Cermet Chunk
            944,     1035,    xi.craftRank.CRAFTSMAN,      -- Venom Dust
            8889,     300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 5
            8890,     400,      xi.craftRank.AMATEUR,      -- Alchemy Kit 10
            8891,     650,      xi.craftRank.AMATEUR,      -- Alchemy Kit 15
            8892,    1050,      xi.craftRank.AMATEUR,      -- Alchemy Kit 20
            8893,    1600,      xi.craftRank.AMATEUR,      -- Alchemy Kit 25
            8894,    2300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 30
            8895,    3150,      xi.craftRank.AMATEUR,      -- Alchemy Kit 35
            8896,    4150,      xi.craftRank.AMATEUR,      -- Alchemy Kit 40
            8897,    5300,      xi.craftRank.AMATEUR,      -- Alchemy Kit 45
            8898,    7600,      xi.craftRank.AMATEUR,      -- Alchemy Kit 50
            9257, 1126125,      xi.craftRank.AMATEUR       -- Azure Leaf
        },

        [xi.skill.BONECRAFT] =
        {
            2130,      75,      xi.craftRank.AMATEUR,      -- Shagreen File
            880,      150,      xi.craftRank.AMATEUR,      -- Bone Chip
            864,       96,      xi.craftRank.AMATEUR,      -- Fish Scales
            898,     1500,      xi.craftRank.RECRUIT,      -- Chicken Bone [Recruit]
            893,     1400,      xi.craftRank.RECRUIT,      -- Giant Femur [Recruit]
            889,      500,     xi.craftRank.INITIATE,      -- Beetle Shell [Initiate]
            894,     1000,     xi.craftRank.INITIATE,      -- Beetle Jaw [Initiate]
            895,     1800,       xi.craftRank.NOVICE,      -- Ram Horn [Novice]
            884,     2000,       xi.craftRank.NOVICE,      -- Black Tiger Fang [Novice]
            881,     2500,   xi.craftRank.APPRENTICE,      -- Crab Shell [Apprentice]
            885,     6000,   xi.craftRank.JOURNEYMAN,      -- Turtle Shell [Journeyman]
            897,     2400,   xi.craftRank.JOURNEYMAN,      -- Scorpion Claw [Journeyman]
            1622,    4000,   xi.craftRank.JOURNEYMAN,      -- Bugard Tusk [Journeyman]
            896,     3000,    xi.craftRank.CRAFTSMAN,      -- Scorpion Shell [Craftsman]
            2147,    4500,    xi.craftRank.CRAFTSMAN,      -- Marid Tusk [Craftsman]
            8875,     300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 5
            8876,     400,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 10
            8877,     650,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 15
            8878,    1050,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 20
            8879,    1600,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 25
            8880,    2300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 30
            8881,    3150,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 35
            8882,    4150,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 40
            8883,    5300,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 45
            8884,    7600,      xi.craftRank.AMATEUR,      -- Bonecraft Kit 50
            9255, 1126125,      xi.craftRank.AMATEUR       -- Cyan Coral
        },

        [xi.skill.LEATHERCRAFT] =
        {
            2129,      75,      xi.craftRank.AMATEUR,      -- Tanning Vat
            505,      100,      xi.craftRank.AMATEUR,      -- Sheepskin
            856,       80,      xi.craftRank.AMATEUR,      -- Rabbit Hide
            852,      600,      xi.craftRank.RECRUIT,      -- Lizard Skin
            878,      600,      xi.craftRank.RECRUIT,      -- Karakul Skin
            858,      600,      xi.craftRank.RECRUIT,      -- Wolf Hide
            857,     2400,     xi.craftRank.INITIATE,      -- Dhalmel Hide
            1640,    2500,     xi.craftRank.INITIATE,      -- Bugard Skin
            859,     1500,       xi.craftRank.NOVICE,      -- Ram Skin
            1628,   16000,   xi.craftRank.APPRENTICE,      -- Buffalo Hide
            853,     3000,   xi.craftRank.JOURNEYMAN,      -- Raptor Skin
            2123,    2500,   xi.craftRank.JOURNEYMAN,      -- Catoblepas Hide
            2518,    3000,    xi.craftRank.CRAFTSMAN,      -- Smilodon Hide
            854,     3000,    xi.craftRank.CRAFTSMAN,      -- Cockatrice Skin
            8861,     300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 5
            8862,     400,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 10
            8863,     650,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 15
            8864,    1050,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 20
            8865,    1600,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 25
            8866,    2300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 30
            8867,    3150,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 35
            8868,    4150,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 40
            8869,    5300,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 45
            8870,    7600,      xi.craftRank.AMATEUR,      -- Leathercraft Kit 50
            9253, 1126125,      xi.craftRank.AMATEUR       -- Synthetic Faulpie Leather
        },

        [xi.skill.SMITHING] =
        {
            2144,      75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
            2143,      75,      xi.craftRank.AMATEUR,      -- Mandrel
            640,       12,      xi.craftRank.AMATEUR,      -- Copper Ore
            1232,      70,      xi.craftRank.AMATEUR,      -- Bronze Nugget
            641,       60,      xi.craftRank.RECRUIT,      -- Tin Ore
            660,      120,      xi.craftRank.RECRUIT,      -- Bronze Sheet
            643,      900,      xi.craftRank.RECRUIT,      -- Iron Ore
            1650,     800,     xi.craftRank.INITIATE,      -- Kopparnickel Ore
            1234,     500,     xi.craftRank.INITIATE,      -- Iron Nugget
            662,     6000,     xi.craftRank.INITIATE,      -- Iron Sheet
            666,    10000,       xi.craftRank.NOVICE,      -- Steel Sheet
            652,     6000,   xi.craftRank.APPRENTICE,      -- Steel Ingot
            657,    12000,   xi.craftRank.APPRENTICE,      -- Tama-Hagane
            1228,    2700,   xi.craftRank.JOURNEYMAN,      -- Darksteel Nugget
            645,     7000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Ore
            1235,     800,   xi.craftRank.JOURNEYMAN,      -- Steel Nugget
            664,    28000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Sheet
            2763,    5000,    xi.craftRank.CRAFTSMAN,      -- Swamp Ore
            8819,     300,      xi.craftRank.AMATEUR,      -- Smithing Kit 5
            8820,     400,      xi.craftRank.AMATEUR,      -- Smithing Kit 10
            8821,     650,      xi.craftRank.AMATEUR,      -- Smithing Kit 15
            8822,    1050,      xi.craftRank.AMATEUR,      -- Smithing Kit 20
            8823,    1600,      xi.craftRank.AMATEUR,      -- Smithing Kit 25
            8824,    2300,      xi.craftRank.AMATEUR,      -- Smithing Kit 30
            8825,    3150,      xi.craftRank.AMATEUR,      -- Smithing Kit 35
            8826,    4150,      xi.craftRank.AMATEUR,      -- Smithing Kit 40
            8827,    5300,      xi.craftRank.AMATEUR,      -- Smithing Kit 45
            8828,    7600,      xi.craftRank.AMATEUR,      -- Smithing Kit 50
            9247, 1126125,      xi.craftRank.AMATEUR       -- Niobium Ore
        }
    },

    curioVendorMoogleStock =
    {
        [curio.medicine] =
        {
            4112,     300,      xi.ki.RHAPSODY_IN_WHITE,   -- Potion
            4116,     600,      xi.ki.RHAPSODY_IN_UMBER,   -- Hi-Potion
            4120,    1200,    xi.ki.RHAPSODY_IN_CRIMSON,   -- X-Potion
            -- 4128,     650,      xi.ki.RHAPSODY_IN_WHITE,   -- Ether / Temporarily(?) removed by SE June 2021
            4132,    1300,      xi.ki.RHAPSODY_IN_UMBER,   -- Hi-Ether
            4136,    3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Super Ether
            4145,   15000,      xi.ki.RHAPSODY_IN_AZURE,   -- Elixir
            4148,     300,      xi.ki.RHAPSODY_IN_WHITE,   -- Antidote
            4150,    1000,      xi.ki.RHAPSODY_IN_UMBER,   -- Eye Drops
            4151,     700,      xi.ki.RHAPSODY_IN_UMBER,   -- Echo Drops
            4156,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Mulsum
            4164,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Prism Powder
            4165,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Silent Oil
            4166,     250,      xi.ki.RHAPSODY_IN_WHITE,   -- Deodorizer
            4172,    1000,      xi.ki.RHAPSODY_IN_AZURE,   -- Reraiser
        },

        [curio.ammunition] =
        {
            4219,     400,      xi.ki.RHAPSODY_IN_WHITE,   -- Stone Quiver
            4220,     680,      xi.ki.RHAPSODY_IN_WHITE,   -- Bone Quiver
            4225,    1200,      xi.ki.RHAPSODY_IN_WHITE,   -- Iron Quiver
            4221,    1350,      xi.ki.RHAPSODY_IN_WHITE,   -- Beetle Quiver
            4226,    2040,      xi.ki.RHAPSODY_IN_WHITE,   -- Silver Quiver
            4222,    2340,      xi.ki.RHAPSODY_IN_WHITE,   -- Horn Quiver
            5333,    3150,      xi.ki.RHAPSODY_IN_UMBER,   -- Sleep Quiver
            4223,    3500,      xi.ki.RHAPSODY_IN_UMBER,   -- Scorpion Quiver
            4224,    7000,      xi.ki.RHAPSODY_IN_AZURE,   -- Demon Quiver
            5332,    8800,      xi.ki.RHAPSODY_IN_AZURE,   -- Kabura Quiver
            5819,    9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Antlion Quiver
            4227,     400,      xi.ki.RHAPSODY_IN_WHITE,   -- Bronze Bolt Quiver
            5334,     800,      xi.ki.RHAPSODY_IN_WHITE,   -- Blind Bolt Quiver
            5335,    1250,      xi.ki.RHAPSODY_IN_WHITE,   -- Acid Bolt Quiver
            5337,    1500,      xi.ki.RHAPSODY_IN_WHITE,   -- Sleep Bolt Quiver
            5339,    2100,      xi.ki.RHAPSODY_IN_WHITE,   -- Bloody Bolt Quiver
            5338,    2100,      xi.ki.RHAPSODY_IN_WHITE,   -- Venom Bolt Quiver
            5336,    2400,      xi.ki.RHAPSODY_IN_WHITE,   -- Holy Bolt Quiver
            4228,    3500,      xi.ki.RHAPSODY_IN_UMBER,   -- Mythril Bolt Quiver
            4229,    5580,      xi.ki.RHAPSODY_IN_AZURE,   -- Darksteel Bolt Quiver
            5820,    9460,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Darkling Bolt Quiver
            5821,    9790,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Fusion Bolt Quiver
            5359,     400,      xi.ki.RHAPSODY_IN_WHITE,   -- Bronze Bullet Pouch
            5363,    1920,      xi.ki.RHAPSODY_IN_WHITE,   -- Bullet Pouch
            5341,    2400,      xi.ki.RHAPSODY_IN_WHITE,   -- Spartan Bullet Pouch
            5353,    4800,      xi.ki.RHAPSODY_IN_UMBER,   -- Iron Bullet Pouch
            5340,    4800,      xi.ki.RHAPSODY_IN_UMBER,   -- Silver Bullet Pouch
            5342,    7100,      xi.ki.RHAPSODY_IN_AZURE,   -- Corsair Bullet Pouch
            5416,    7600,      xi.ki.RHAPSODY_IN_AZURE,   -- Steel Bullet Pouch
            5822,    9680,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Dweomer Bullet Pouch
            5823,    9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Oberon Bullet Pouch
            6299,    1400,      xi.ki.RHAPSODY_IN_WHITE,   -- Shuriken Pouch
            6297,    2280,      xi.ki.RHAPSODY_IN_WHITE,   -- Juji Shuriken Pouch
            6298,    4640,      xi.ki.RHAPSODY_IN_UMBER,   -- Manji Shuriken Pouch
            6302,    7000,      xi.ki.RHAPSODY_IN_AZURE,   -- Fuma Shuriken Pouch
            6303,    9900,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Iga Shuriken Pouch
        },

        [curio.ninjutsuTools] =
        {
            5308,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Uchi)
            5309,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Tsurara)
            5310,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kawahori-Ogi)
            5311,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Makibishi)
            5312,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Hiraishin)
            5313,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Mizu-Deppo)
            5314,    5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shihei)
            5315,    5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Jusatsu)
            5316,    5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kaginawa)
            5317,    5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sairui-Ran)
            5318,    5000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kodoku)
            5319,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shinobi-Tabi)
            5417,    3000,      xi.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sanjaku-Tenugui)
            5734,    5000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Toolbag (Soshi)
        },
        [curio.foodStuffs] =
        {
            4378,      60,      xi.ki.RHAPSODY_IN_WHITE,   -- Selbina Milk
            4299,     100,      xi.ki.RHAPSODY_IN_WHITE,   -- Orange au Lait
            5703,     100,      xi.ki.RHAPSODY_IN_WHITE,   -- Uleguerand Milk
            4300,     300,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Apple au Lait
            4301,     600,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pear au Lait
            4422,     200,      xi.ki.RHAPSODY_IN_WHITE,   -- Orange Juice
            4424,    1100,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Melon Juice
            4558,    2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Yagudo Drink
            4405,     160,      xi.ki.RHAPSODY_IN_WHITE,   -- Rice Ball
            4376,     120,      xi.ki.RHAPSODY_IN_WHITE,   -- Meat Jerky
            4371,     184,      xi.ki.RHAPSODY_IN_WHITE,   -- Grilled Hare
            4381,     720,      xi.ki.RHAPSODY_IN_UMBER,   -- Meat Mithkabob
            -- 4456,     550,      xi.ki.RHAPSODY_IN_WHITE,   -- Boiled Crab / Temporarily(?) removed by SE June 2021
            4398,    1080,      xi.ki.RHAPSODY_IN_UMBER,   -- Fish Mithkabob
            5166,    1500,      xi.ki.RHAPSODY_IN_WHITE,   -- Coeurl Sub
            4538,     900,      xi.ki.RHAPSODY_IN_WHITE,   -- Roast Pipira
            6217,     500,      xi.ki.RHAPSODY_IN_AZURE,   -- Anchovy Slice
            6215,     400,      xi.ki.RHAPSODY_IN_UMBER,   -- Pepperoni Slice
            5752,    3500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pot-auf-feu
            4488,    1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Jack-o'-Lantern
            5176,    5000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Bream Sushi
            5178,    4000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Dorado Sushi
            5721,    1500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Crab Sushi
            5775,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Chocolate Crepe
            5766,    1000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Butter Crepe
            4413,     320,      xi.ki.RHAPSODY_IN_WHITE,   -- Apple Pie
            4421,     800,      xi.ki.RHAPSODY_IN_WHITE,   -- Melon Pie
            4446,    1200,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Pumpkin Pie
            4410,     344,      xi.ki.RHAPSODY_IN_WHITE,   -- Roast Mushroom
            4510,      24,      xi.ki.RHAPSODY_IN_WHITE,   -- Acorn Cookie
            4394,      12,      xi.ki.RHAPSODY_IN_AZURE,   -- Ginger Cookie
            5782,    1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Sugar Rusk
            5783,    2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Chocolate Rusk
            5779,    1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Cherry Macaron
            5780,    2000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Coffee Macaron
            5885,    1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Saltena
            5886,    2000,      xi.ki.RHAPSODY_IN_AZURE,   -- Elshena
            5887,    2500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Montagna
            5889,    1000,      xi.ki.RHAPSODY_IN_WHITE,   -- Stuffed Pitaru
            5890,    2000,      xi.ki.RHAPSODY_IN_AZURE,   -- Poultry Pitaru
            5891,    2500,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Seafood Pitaru
            6258,    3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Shiromochi
            6262,    3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Kusamochi
            6260,    3000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Akamochi
            5547,   15000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Beef Stewpot
            5727,   15000,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Zaru Soba
            4466,     450,    xi.ki.RHAPSODY_IN_CRIMSON,   -- Spicy Cracker
        },

        [curio.scrolls] =
        {
            4181,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Warp
            4182,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Reraise
            5428,     500,      xi.ki.RHAPSODY_IN_AZURE,   -- Instant Retrace
            5988,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Protect
            5989,     500,      xi.ki.RHAPSODY_IN_WHITE,   -- Instant Shell
            5990,     500,      xi.ki.RHAPSODY_IN_UMBER,   -- Instant Stoneskin
        },

        [curio.keys] =
        {
            1024,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ghelsba Chest Key
            1025,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Palborough Chest Key
            1026,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Giddeus Chest Key
            1027,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ranperre Chest Key
            1028,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Dangruf Chest Key
            1029,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Horutoto Chest Key
            1030,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Ordelle Chest Key
            1031,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Gusgen Chest Key
            1032,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Shakhrami Chest Key
            1033,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Davoi Chest Key
            1034,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Beadeaux Chest Key
            1035,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Oztroja Chest Key
            1036,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Delkfutt Chest Key
            1037,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Fei'Yin Chest Key
            1038,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Zvahl Chest Key
            1039,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Eldieme Chest Key
            1040,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Nest Chest Key
            1041,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Garlaige Chest Key
            1043,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Beadeaux Coffer Key
            1042,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Davoi Coffer Key
            1044,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Oztroja Coffer Key
            1045,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Nest Coffer Key
            1046,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Eldieme Coffer Key
            1047,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Garlaige Coffer Key
            1048,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Zvhal Coffer Key
            1049,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Uggalepih Coffer Key
            1050,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Den Coffer Key
            1051,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Kuftal Coffer Key
            1052,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Boyahda Coffer Key
            1053,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Cauldron Coffer Key
            1054,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Quicksand Coffer Key
            1055,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Grotto Chest Key
            1056,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Onzozo Chest Key
            1057,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Toraimarai Coffer Key
            1058,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Ru'Aun Coffer Key
            1059,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Grotto Coffer Key
            1060,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Ve'Lugannon Coffer Key
            1061,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Sacrarium Chest Key
            1062,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Oldton Chest Key
            1063,    5000,      xi.ki.RHAPSODY_IN_UMBER,   -- Newton Coffer Key
            1064,    2500,      xi.ki.RHAPSODY_IN_WHITE,   -- Pso'Xja Chest Key
        }
    }
}
