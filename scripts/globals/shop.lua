-----------------------------------
--
--    Functions for Shop system
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
-----------------------------------

-----------------------------------
-- IDs for Curio Vendor Moogle
-----------------------------------

curio =
{
    ["medicine"]        = 1,
    ["ammunition"]      = 2,
    ["ninjutsuTools"]   = 3,
    ["foodStuffs"]      = 4,
    ["scrolls"]         = 5,
    ["keys"]            = 6,
    -- keyitems not implemented yet
}

tpz = tpz or {}

tpz.shop =
{
    --[[ *******************************************************************************
        send general shop dialog to player
        stock cuts off after 16 items. if you add more, extras will not display
        stock is of form {itemId1, price1, itemId2, price2, ...}
        log is a log ID from scripts/globals/log_ids.lua
    ******************************************************************************* --]]
    general = function(player, stock, log)
        local priceMultiplier = 1

        if log then
            priceMultiplier = (1 + (0.20 * (9 - player:getFameLevel(log)) / 8)) * SHOP_PRICE
        else
            log = -1
        end

        player:createShop(#stock / 2, log)

        for i = 1, #stock, 2 do
            player:addShopItem(stock[i], stock[i+1] * priceMultiplier)
        end

        player:sendMenu(2)
    end,

    --[[ *******************************************************************************
        send general guild shop dialog to player (Added on June 2014 QoL)
        stock is of form {itemId1, price1, guildID, guildRank, ...}
        log is default set to -1 as it's needed as part of createShop()
    ******************************************************************************* --]]
    generalGuild = function(player, stock, guildSkillId)
        local log = -1

        player:createShop(#stock / 3, log)

        for i = 1, #stock, 3 do
            player:addShopItem(stock[i], stock[i+1], guildSkillId, stock[i+2])
        end

        player:sendMenu(2)
    end,

    --[[ *******************************************************************************
        send curio vendor moogle shop shop dialog to player
        stock is of form {itemId1, price1, keyItemRequired, ...}
        log is default set to -1 as it's needed as part of createShop()
    ******************************************************************************* --]]
    curioVendorMoogle = function(player, stock)
        local log = -1

        player:createShop(#stock / 3, log)

        for i = 1, #stock, 3 do
            if player:hasKeyItem(stock[i+2]) then
                player:addShopItem(stock[i], stock[i+1])
            end
        end

        player:sendMenu(2)
    end,

    --[[ *******************************************************************************
        send nation shop dialog to player
        stock cuts off after 16 items. if you add more, extras will not display
        stock is of form {itemId1, price1, place1, itemId2, price2, place2, ...}
            where place is what place the nation must be in for item to be stocked
        nation is a tpz.nation ID from scripts/globals/zone.lua
    ******************************************************************************* --]]
    nation = function(player, stock, nation)
        local rank = getNationRank(nation)
        local newStock = {}
        for i = 1, #stock, 3 do
            if
                (stock[i+2] == 1 and player:getNation() == nation and rank == 1) or
                (stock[i+2] == 2 and rank <= 2) or
                (stock[i+2] == 3)
            then
                table.insert(newStock, stock[i])
                table.insert(newStock, stock[i+1])
            end
        end
        tpz.shop.general(player, newStock, nation)
    end,

    --[[ *******************************************************************************
        send outpost shop dialog to player
    ******************************************************************************* --]]
    outpost = function(player)
        local stock =
        {
            4148,  316, -- Antidote
            4151,  800, -- Echo Drops
            4128, 4832, -- Ether
            4150, 2595, -- Eye Drops
            4112,  910, -- Potion
        }
        tpz.shop.general(player, stock)
    end,

    --[[ *******************************************************************************
        send celebratory chest shop dialog to player
    ******************************************************************************* --]]
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
        tpz.shop.general(player, stock)
    end,

    --[[ *******************************************************************************
        stock for guild vendors that are open 24/8
    ******************************************************************************* --]]
    generalGuildStock =
    {
        [tpz.skill.COOKING] =
        {
                 936,      16,      tpz.craftRank.AMATEUR,      -- Rock Salt
                4509,      12,      tpz.craftRank.AMATEUR,      -- Distilled Water
                4362,     100,      tpz.craftRank.AMATEUR,      -- Lizard Egg
                4392,      32,      tpz.craftRank.AMATEUR,      -- Saruta Orange
                4431,      76,      tpz.craftRank.AMATEUR,      -- San d'Orian Grapes
                9193,    2500,      tpz.craftRank.AMATEUR,      -- Miso
                9194,    2500,      tpz.craftRank.AMATEUR,      -- Soy Sauce
                9195,    2500,      tpz.craftRank.AMATEUR,      -- Dried Bonito
                 610,      60,      tpz.craftRank.RECRUIT,      -- San d'Orian Flour
                 627,      40,      tpz.craftRank.RECRUIT,      -- Maple Sugar
                4363,      44,      tpz.craftRank.RECRUIT,      -- Faerie Apple
                4378,      60,      tpz.craftRank.RECRUIT,      -- Selbina Milk
                4370,     200,      tpz.craftRank.RECRUIT,      -- Honey
                4432,      60,     tpz.craftRank.INITIATE,      -- Kazham Pineapple
                4366,      24,     tpz.craftRank.INITIATE,      -- La Theine Cabbage
                 611,      40,     tpz.craftRank.INITIATE,      -- Rye Flour
                4412,     325,       tpz.craftRank.NOVICE,      -- Thundermelon
                4491,     200,       tpz.craftRank.NOVICE,      -- Watermelon
                 615,      60,       tpz.craftRank.NOVICE,      -- Selbina Butter
                 612,      60,   tpz.craftRank.APPRENTICE,      -- Kazham Peppers
                1111,     900,   tpz.craftRank.APPRENTICE,      -- Gelatin
                1776,    3000,   tpz.craftRank.JOURNEYMAN,      -- Spaghetti
                5164,    2595,   tpz.craftRank.JOURNEYMAN,      -- Ground Wasabi
                 616,    1600,    tpz.craftRank.CRAFTSMAN,      -- Pie Dough
                2561,    3000,    tpz.craftRank.CRAFTSMAN,      -- Pizza Dough
                8800,     600,    tpz.craftRank.CRAFTSMAN,      -- Azuki Bean
                8903,     300,      tpz.craftRank.AMATEUR,      -- Cooking Kit 5
                8904,     400,      tpz.craftRank.AMATEUR,      -- Cooking Kit 10
                8905,     650,      tpz.craftRank.AMATEUR,      -- Cooking Kit 15
                8906,    1050,      tpz.craftRank.AMATEUR,      -- Cooking Kit 20
                8907,    1600,      tpz.craftRank.AMATEUR,      -- Cooking Kit 25
                8908,    2300,      tpz.craftRank.AMATEUR,      -- Cooking Kit 30
                8909,    3150,      tpz.craftRank.AMATEUR,      -- Cooking Kit 35
                8910,    4150,      tpz.craftRank.AMATEUR,      -- Cooking Kit 40
                8911,    5300,      tpz.craftRank.AMATEUR,      -- Cooking Kit 45
                8912,    7600,      tpz.craftRank.AMATEUR       -- Cooking Kit 50
        },
        [tpz.skill.CLOTHCRAFT] =
        {
                2128,      75,      tpz.craftRank.AMATEUR,      -- Spindle
                2145,      75,      tpz.craftRank.AMATEUR,      -- Zephyr Thread
                 833,      20,      tpz.craftRank.AMATEUR,      -- Moko Grass
                 834,     500,      tpz.craftRank.RECRUIT,      -- Saruta Cotton
                1845,     200,      tpz.craftRank.RECRUIT,      -- Red Moko Grass
                 819,     150,     tpz.craftRank.INITIATE,      -- Linen Thread
                 820,    2800,       tpz.craftRank.NOVICE,      -- Wool Thread
                2295,     800,   tpz.craftRank.APPRENTICE,      -- Mohbwa Grass
                 816,    1500,   tpz.craftRank.APPRENTICE,      -- Silk Thread
                2315,    1400,   tpz.craftRank.JOURNEYMAN,      -- Karakul Wool
                 823,   14500,    tpz.craftRank.CRAFTSMAN,      -- Gold Thread
                8847,     300,      tpz.craftRank.AMATEUR,      -- Clothcraft kit 5
                8848,     400,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 10
                8849,     650,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 15
                8850,    1050,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 20
                8851,    1600,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 25
                8852,    2300,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 30
                8853,    3150,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 35
                8854,    4150,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 40
                8855,    5300,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 45
                8856,    7600,      tpz.craftRank.AMATEUR,      -- Clothcraft Kit 50
                9251, 1126125,      tpz.craftRank.AMATEUR       -- Khoma Thread
        },
        [tpz.skill.GOLDSMITHING] =
        {
                2144,      75,      tpz.craftRank.AMATEUR,      -- Workshop Anvil
                2143,      75,      tpz.craftRank.AMATEUR,      -- Mandrel
                 642,     200,      tpz.craftRank.AMATEUR,      -- Zinc Ore
                 640,      12,      tpz.craftRank.AMATEUR,      -- Copper Ore
                1231,      40,      tpz.craftRank.RECRUIT,      -- Brass Nugget
                 661,     300,      tpz.craftRank.RECRUIT,      -- Brass Sheet
                 736,     450,      tpz.craftRank.RECRUIT,      -- Silver Ore
                1233,     200,     tpz.craftRank.INITIATE,      -- Silver Nugget
                 806,    1863,     tpz.craftRank.INITIATE,      -- Tourmaline
                 807,    1863,     tpz.craftRank.INITIATE,      -- Sardonyx
                 809,    1863,     tpz.craftRank.INITIATE,      -- Clear Topaz
                 800,    1863,     tpz.craftRank.INITIATE,      -- Amethyst
                 795,    1863,     tpz.craftRank.INITIATE,      -- Lapis Lazuli
                 814,    1863,     tpz.craftRank.INITIATE,      -- Amber
                 799,    1863,     tpz.craftRank.INITIATE,      -- Onyx
                 796,    1863,     tpz.craftRank.INITIATE,      -- Light Opal
                 760,   23000,       tpz.craftRank.NOVICE,      -- Silver Chain
                 644,    2000,       tpz.craftRank.NOVICE,      -- Mythril Ore
                 737,    3000,   tpz.craftRank.APPRENTICE,      -- Gold Ore
                 663,   12000,   tpz.craftRank.APPRENTICE,      -- Mythril Sheet
                 788,    8000,   tpz.craftRank.APPRENTICE,      -- Peridot
                 790,    8000,   tpz.craftRank.APPRENTICE,      -- Garnet
                 808,    8000,   tpz.craftRank.APPRENTICE,      -- Goshenite
                 811,    8000,   tpz.craftRank.APPRENTICE,      -- Ametrine
                 798,    8000,   tpz.craftRank.APPRENTICE,      -- Turquoise
                 815,    8000,   tpz.craftRank.APPRENTICE,      -- Sphene
                 793,    8000,   tpz.craftRank.APPRENTICE,      -- Black Pearl
                 792,    8000,   tpz.craftRank.APPRENTICE,      -- Pearl
                 678,    5000,   tpz.craftRank.APPRENTICE,      -- Aluminum Ore
                 752,   32000,   tpz.craftRank.JOURNEYMAN,      -- Gold Sheet
                 761,   58000,   tpz.craftRank.JOURNEYMAN,      -- Gold Chain
                 738,    5000,    tpz.craftRank.CRAFTSMAN,      -- Platinum Ore
                8833,     300,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 5
                8834,     400,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 10
                8835,     650,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 15
                8836,    1050,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 20
                8837,    1600,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 25
                8838,    2300,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 30
                8839,    3150,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 35
                8840,    4150,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 40
                8841,    5300,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 45
                8842,    7600,      tpz.craftRank.AMATEUR,      -- Goldsmithing Kit 50
                9249, 1126125,      tpz.craftRank.AMATEUR       -- Ruthenium Ore
        },
        [tpz.skill.WOODWORKING] =
        {
                1657,     100,      tpz.craftRank.AMATEUR,      -- Bundling Twine
                 688,      25,      tpz.craftRank.AMATEUR,      -- Arrowwood Log
                 689,      50,      tpz.craftRank.AMATEUR,      -- Lauan Log
                 691,      70,      tpz.craftRank.AMATEUR,      -- Maple Log
                 697,     800,      tpz.craftRank.RECRUIT,      -- Holly Log
                 695,    1600,      tpz.craftRank.RECRUIT,      -- Willow Log
                 693,    1300,      tpz.craftRank.RECRUIT,      -- Walnut Log
                 696,     500,     tpz.craftRank.INITIATE,      -- Yew Log
                 690,    3800,     tpz.craftRank.INITIATE,      -- Elm Log
                 694,    3400,     tpz.craftRank.INITIATE,      -- Chestnut Log
                 727,    2000,       tpz.craftRank.NOVICE,      -- Dogwood Log
                 699,    4000,       tpz.craftRank.NOVICE,      -- Oak Log
                 701,    4500,   tpz.craftRank.APPRENTICE,      -- Rosewood Log
                 700,    4500,   tpz.craftRank.JOURNEYMAN,      -- Mahogany Log
                 702,    5000,    tpz.craftRank.CRAFTSMAN,      -- Ebony Log
                2761,    5500,    tpz.craftRank.CRAFTSMAN,      -- Feyweald Log
                8805,     300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 5
                8806,     400,      tpz.craftRank.AMATEUR,      -- Smithing Kit 10
                8807,     650,      tpz.craftRank.AMATEUR,      -- Smithing Kit 15
                8808,    1050,      tpz.craftRank.AMATEUR,      -- Smithing Kit 20
                8809,    1600,      tpz.craftRank.AMATEUR,      -- Smithing Kit 25
                8810,    2300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 30
                8811,    3150,      tpz.craftRank.AMATEUR,      -- Smithing Kit 35
                8812,    4150,      tpz.craftRank.AMATEUR,      -- Smithing Kit 40
                8813,    5300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 45
                8814,    7600,      tpz.craftRank.AMATEUR,      -- Smithing Kit 50
                9245, 1126125,      tpz.craftRank.AMATEUR       -- Cypress Log
        },
        [tpz.skill.ALCHEMY] =
        {
                2131,      75,      tpz.craftRank.AMATEUR,      -- Triturator
                 912,      40,      tpz.craftRank.AMATEUR,      -- Beehive Chip
                 914,    1700,      tpz.craftRank.AMATEUR,      -- Mercury
                 937,     300,      tpz.craftRank.RECRUIT,      -- Animal Glue
                 943,     320,      tpz.craftRank.RECRUIT,      -- Poison Dust
                 637,    1500,     tpz.craftRank.INITIATE,      -- Slime Oil
                 928,     515,     tpz.craftRank.INITIATE,      -- Bomb Ash
                 921,     200,     tpz.craftRank.INITIATE,      -- Ahriman Tears
                 933,    1200,       tpz.craftRank.NOVICE,      -- Glass Fiber
                 947,    5000,       tpz.craftRank.NOVICE,      -- Firesand
                4171,     700,   tpz.craftRank.APPRENTICE,      -- Vitriol
                1886,    4000,   tpz.craftRank.APPRENTICE,      -- Sieglinde Putty
                 923,    1800,   tpz.craftRank.APPRENTICE,      -- Dryad Root
                 932,    1900,   tpz.craftRank.JOURNEYMAN,      -- Carbon Fiber
                 939,    2100,   tpz.craftRank.JOURNEYMAN,      -- Hecteyes Eye
                 915,    3600,   tpz.craftRank.JOURNEYMAN,      -- Toad Oil
                 931,    5000,    tpz.craftRank.CRAFTSMAN,      -- Cermet Chunk
                 944,    1035,    tpz.craftRank.CRAFTSMAN,      -- Venom Dust
                8889,     300,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 5
                8890,     400,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 10
                8891,     650,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 15
                8892,    1050,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 20
                8893,    1600,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 25
                8894,    2300,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 30
                8895,    3150,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 35
                8896,    4150,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 40
                8897,    5300,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 45
                8898,    7600,      tpz.craftRank.AMATEUR,      -- Alchemy Kit 50
                9257, 1126125,      tpz.craftRank.AMATEUR       -- Azure Leaf
        },
        [tpz.skill.BONECRAFT] =
        {
                2130,      75,      tpz.craftRank.AMATEUR,      -- Shagreen File
                 880,     150,      tpz.craftRank.AMATEUR,      -- Bone Chip
                 864,      96,      tpz.craftRank.AMATEUR,      -- Fish Scales
                 898,    1500,      tpz.craftRank.RECRUIT,      -- Chicken Bone [Recruit]
                 893,    1400,      tpz.craftRank.RECRUIT,      -- Giant Femur [Recruit]
                 889,     500,     tpz.craftRank.INITIATE,      -- Beetle Shell [Initiate]
                 894,    1000,     tpz.craftRank.INITIATE,      -- Beetle Jaw [Initiate]
                 895,    1800,       tpz.craftRank.NOVICE,      -- Ram Horn [Novice]
                 884,    2000,       tpz.craftRank.NOVICE,      -- Black Tiger Fang [Novice]
                 881,    2500,   tpz.craftRank.APPRENTICE,      -- Crab Shell [Apprentice]
                 885,    6000,   tpz.craftRank.JOURNEYMAN,      -- Turtle Shell [Journeyman]
                 897,    2400,   tpz.craftRank.JOURNEYMAN,      -- Scorpion Claw [Journeyman]
                1622,    4000,   tpz.craftRank.JOURNEYMAN,      -- Bugard Tusk [Journeyman]
                 896,    3000,    tpz.craftRank.CRAFTSMAN,      -- Scorpion Shell [Craftsman]
                2147,    4500,    tpz.craftRank.CRAFTSMAN,      -- Marid Tusk [Craftsman]
                8875,     300,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 5
                8876,     400,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 10
                8877,     650,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 15
                8878,    1050,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 20
                8879,    1600,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 25
                8880,    2300,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 30
                8881,    3150,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 35
                8882,    4150,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 40
                8883,    5300,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 45
                8884,    7600,      tpz.craftRank.AMATEUR,      -- Bonecraft Kit 50
                9255, 1126125,      tpz.craftRank.AMATEUR       -- Cyan Coral
        },
        [tpz.skill.LEATHERCRAFT] =
        {
                2129,      75,      tpz.craftRank.AMATEUR,      -- Tanning Vat
                 505,     100,      tpz.craftRank.AMATEUR,      -- Sheepskin
                 856,      80,      tpz.craftRank.AMATEUR,      -- Rabbit Hide
                 852,     600,      tpz.craftRank.RECRUIT,      -- Lizard Skin
                 878,     600,      tpz.craftRank.RECRUIT,      -- Karakul Skin
                 858,     600,      tpz.craftRank.RECRUIT,      -- Wolf Hide
                 857,    2400,     tpz.craftRank.INITIATE,      -- Dhalmel Hide
                1640,    2500,     tpz.craftRank.INITIATE,      -- Bugard Skin
                 859,    1500,       tpz.craftRank.NOVICE,      -- Ram Skin
                1628,   16000,   tpz.craftRank.APPRENTICE,      -- Buffalo Hide
                 853,    3000,   tpz.craftRank.JOURNEYMAN,      -- Raptor Skin
                2123,    2500,   tpz.craftRank.JOURNEYMAN,      -- Catoblepas Hide
                2518,    3000,    tpz.craftRank.CRAFTSMAN,      -- Smilodon Hide
                 854,    3000,    tpz.craftRank.CRAFTSMAN,      -- Cockatrice Skin
                8861,     300,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 5
                8862,     400,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 10
                8863,     650,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 15
                8864,    1050,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 20
                8865,    1600,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 25
                8866,    2300,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 30
                8867,    3150,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 35
                8868,    4150,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 40
                8869,    5300,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 45
                8870,    7600,      tpz.craftRank.AMATEUR,      -- Leathercraft Kit 50
                9253, 1126125,      tpz.craftRank.AMATEUR       -- Synthetic Faulpie Leather
        },
        [tpz.skill.SMITHING] =
        {
                2144,      75,      tpz.craftRank.AMATEUR,      -- Workshop Anvil
                2143,      75,      tpz.craftRank.AMATEUR,      -- Mandrel
                 640,      12,      tpz.craftRank.AMATEUR,      -- Copper Ore
                1232,      70,      tpz.craftRank.AMATEUR,      -- Bronze Nugget
                 641,      60,      tpz.craftRank.RECRUIT,      -- Tin Ore
                 660,     120,      tpz.craftRank.RECRUIT,      -- Bronze Sheet
                 643,     900,      tpz.craftRank.RECRUIT,      -- Iron Ore
                1650,     800,     tpz.craftRank.INITIATE,      -- Kopparnickel Ore
                1234,     500,     tpz.craftRank.INITIATE,      -- Iron Nugget
                 662,    6000,     tpz.craftRank.INITIATE,      -- Iron Sheet
                 666,   10000,       tpz.craftRank.NOVICE,      -- Steel Sheet
                 652,    6000,   tpz.craftRank.APPRENTICE,      -- Steel Ingot
                 657,   12000,   tpz.craftRank.APPRENTICE,      -- Tama-Hagane
                1228,    2700,   tpz.craftRank.JOURNEYMAN,      -- Darksteel Nugget
                 645,    7000,   tpz.craftRank.JOURNEYMAN,      -- Darksteel Ore
                1235,     800,   tpz.craftRank.JOURNEYMAN,      -- Steel Nugget
                 664,   28000,   tpz.craftRank.JOURNEYMAN,      -- Darksteel Sheet
                2763,    5000,    tpz.craftRank.CRAFTSMAN,      -- Swamp Ore
                8819,     300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 5
                8820,     400,      tpz.craftRank.AMATEUR,      -- Smithing Kit 10
                8821,     650,      tpz.craftRank.AMATEUR,      -- Smithing Kit 15
                8822,    1050,      tpz.craftRank.AMATEUR,      -- Smithing Kit 20
                8823,    1600,      tpz.craftRank.AMATEUR,      -- Smithing Kit 25
                8824,    2300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 30
                8825,    3150,      tpz.craftRank.AMATEUR,      -- Smithing Kit 35
                8826,    4150,      tpz.craftRank.AMATEUR,      -- Smithing Kit 40
                8827,    5300,      tpz.craftRank.AMATEUR,      -- Smithing Kit 45
                8828,    7600,      tpz.craftRank.AMATEUR,      -- Smithing Kit 50
                9247, 1126125,      tpz.craftRank.AMATEUR       -- Niobium Ore
        }
    },

    curioVendorMoogleStock =
    {
        [curio.medicine] =
        {
                4112,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Potion
                4116,     600,      tpz.ki.RHAPSODY_IN_UMBER,   -- Hi-Potion
                4128,     650,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ether
                4132,    1300,      tpz.ki.RHAPSODY_IN_UMBER,   -- Hi-Ether
                4145,   15000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Elixir
                4148,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Antidote
                4150,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Eye Drops
                4151,     700,      tpz.ki.RHAPSODY_IN_UMBER,   -- Echo Drops
                4156,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Mulsum
                4164,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Prism Powder
                4165,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Silent Oil
                4166,     250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Deodorizer
                4172,    1000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Reraiser
        },
        [curio.ammunition] =
        {
                4219,     400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Stone Quiver
                4220,     680,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bone Quiver
                4225,    1200,      tpz.ki.RHAPSODY_IN_WHITE,   -- Iron Quiver
                4221,    1350,      tpz.ki.RHAPSODY_IN_WHITE,   -- Beetle Quiver
                4226,    2040,      tpz.ki.RHAPSODY_IN_WHITE,   -- Silver Quiver
                4222,    2340,      tpz.ki.RHAPSODY_IN_WHITE,   -- Horn Quiver
                5333,    3150,      tpz.ki.RHAPSODY_IN_UMBER,   -- Sleep Quiver
                4223,    3500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Scorpion Quiver
                4224,    7000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Demon Quiver
                5332,    8800,      tpz.ki.RHAPSODY_IN_AZURE,   -- Kabura Quiver
                4227,     400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bronze Bolt Quiver
                5334,     800,      tpz.ki.RHAPSODY_IN_WHITE,   -- Blind Bolt Quiver
                5335,    1250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Acid Bolt Quiver
                5337,    1500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sleep Bolt Quiver
                5339,    2100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bloody Bolt Quiver
                5338,    2100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Venom Bolt Quiver
                5336,    2400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Holy Bolt Quiver
                4228,    3500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Mythril Bolt Quiver
                4229,    5580,      tpz.ki.RHAPSODY_IN_AZURE,   -- Darksteel Bolt Quiver
                5359,     400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bronze Bullet Pouch
                5363,    1920,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bullet Pouch
                5341,    2400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Spartan Bullet Pouch
                5353,    4800,      tpz.ki.RHAPSODY_IN_UMBER,   -- Iron Bullet Pouch
                5340,    4800,      tpz.ki.RHAPSODY_IN_UMBER,   -- Silver Bullet Pouch
                5342,    7100,      tpz.ki.RHAPSODY_IN_AZURE,   -- Corsair Bullet Pouch
                5416,    7600,      tpz.ki.RHAPSODY_IN_AZURE,   -- Steel Bullet Pouch
                6299,    1400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Shuriken Pouch
                6297,    2280,      tpz.ki.RHAPSODY_IN_WHITE,   -- Juji Shuriken Pouch
                6298,    4640,      tpz.ki.RHAPSODY_IN_UMBER,   -- Manji Shuriken Pouch
                6302,    7000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Fuma Shuriken Pouch
        },
        [curio.ninjutsuTools] =
        {
                5308,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Uchi)
                5309,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Tsurara)
                5310,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kawahori-Ogi)
                5311,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Makibishi)
                5312,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Hiraishin)
                5313,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Mizu-Deppo)
                5314,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shihei)
                5315,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Jusatsu)
                5316,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kaginawa)
                5317,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sairui-Ran)
                5318,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kodoku)
                5319,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shinobi-Tabi)
                5417,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sanjaku-Tenugui)
        },
        [curio.foodStuffs] =
        {
                4378,      60,      tpz.ki.RHAPSODY_IN_WHITE,   -- Selbina Milk
                4299,     100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Orange au Lait
                5703,     100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Uleguerand Milk
                4422,     200,      tpz.ki.RHAPSODY_IN_WHITE,   -- Orange Juice
                4405,     160,      tpz.ki.RHAPSODY_IN_WHITE,   -- Rice Ball
                4376,     120,      tpz.ki.RHAPSODY_IN_WHITE,   -- Meat Jerky
                4371,     184,      tpz.ki.RHAPSODY_IN_WHITE,   -- Grilled Hare
                4381,     720,      tpz.ki.RHAPSODY_IN_UMBER,   -- Meat Mithkabob
                4456,     550,      tpz.ki.RHAPSODY_IN_WHITE,   -- Boiled Crab
                4398,    1080,      tpz.ki.RHAPSODY_IN_UMBER,   -- Fish Mithkabob
                5166,    1500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Coeurl Sub
                4538,     900,      tpz.ki.RHAPSODY_IN_WHITE,   -- Roast Pipira
                6217,     500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Anchovy Slice
                6215,     400,      tpz.ki.RHAPSODY_IN_UMBER,   -- Pepperoni Slice
                4488,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Jack-o'-Lantern
                5775,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Chocolate Crepe
                4413,     320,      tpz.ki.RHAPSODY_IN_WHITE,   -- Apple Pie
                4421,     800,      tpz.ki.RHAPSODY_IN_WHITE,   -- Melon Pie
                4410,     344,      tpz.ki.RHAPSODY_IN_WHITE,   -- Roast Mushroom
                4510,      24,      tpz.ki.RHAPSODY_IN_WHITE,   -- Acorn Cookie
                4394,      12,      tpz.ki.RHAPSODY_IN_AZURE,   -- Ginger Cookie
                5782,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sugar Rusk
                5779,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Cherry Macaron
                5885,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Saltena
                5886,    2000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Elshena
                5889,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Stuffed Pitaru
                5890,    2000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Poultry Pitaru
        },
        [curio.scrolls] =
        {
                4181,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Instant Warp
                4182,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Instant Reraise
                5428,     500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Instant Retrace
                5988,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Instant Protect
                5989,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Instant Shell
                5990,     500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Instant Stoneskin
        },
        [curio.keys] =
        {
                1024,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ghelsba Chest Key
                1025,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Palborough Chest Key
                1026,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Giddeus Chest Key
                1027,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ranperre Chest Key
                1028,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Dangruf Chest Key
                1029,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Horutoto Chest Key
                1030,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ordelle Chest Key
                1031,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Gusgen Chest Key
                1032,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Shakhrami Chest Key
                1033,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Davoi Chest Key
                1034,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Beadeaux Chest Key
                1035,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Oztroja Chest Key
                1036,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Delkfutt Chest Key
                1037,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Fei'Yin Chest Key
                1038,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Zvahl Chest Key
                1039,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Eldieme Chest Key
                1040,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Nest Chest Key
                1041,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Garlaige Chest Key
                1043,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Beadeaux Coffer Key
                1042,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Davoi Coffer Key
                1044,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Oztroja Coffer Key
                1045,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Nest Coffer Key
                1046,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Eldieme Coffer Key
                1047,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Garlaige Coffer Key
                1048,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Zvhal Coffer Key
                1049,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Uggalepih Coffer Key
                1050,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Den Coffer Key
                1051,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Kuftal Coffer Key
                1052,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Boyahda Coffer Key
                1053,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Cauldron Coffer Key
                1054,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Quicksand Coffer Key
                1055,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Grotto Chest Key
                1056,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Onzozo Chest Key
                1057,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Toraimarai Coffer Key
                1058,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Ru'Aun Coffer Key
                1059,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Grotto Coffer Key
                1060,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Ve'Lugannon Coffer Key
                1061,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sacrarium Chest Key
                1062,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Oldton Chest Key
                1063,    5000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Newton Coffer Key
                1064,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pso'Xja Chest Key
        }
    }
}
