-----------------------------------
-- Conquest: Regional npcs always up, regardless of conquest results
-----------------------------------
require("modules/module_utils")
require("scripts/globals/shop")
-----------------------------------
local m = Module:new("guild_no_kits")

m:addOverride("xi.shop.generalGuild", function(player, stock, guildSkillId)
    local log = -1
    local generalGuildStockNoKit =
        {
            [xi.skill.COOKING] =
            {
                     936,      16,      xi.craftRank.AMATEUR,      -- Rock Salt
                    4509,      12,      xi.craftRank.AMATEUR,      -- Distilled Water
                    4362,     100,      xi.craftRank.AMATEUR,      -- Lizard Egg
                    4392,      32,      xi.craftRank.AMATEUR,      -- Saruta Orange
                    4431,      76,      xi.craftRank.AMATEUR,      -- San d'Orian Grapes
                    9193,    2500,      xi.craftRank.AMATEUR,      -- Miso
                    9194,    2500,      xi.craftRank.AMATEUR,      -- Soy Sauce
                    9195,    2500,      xi.craftRank.AMATEUR,      -- Dried Bonito
                     610,      60,      xi.craftRank.RECRUIT,      -- San d'Orian Flour
                     627,      40,      xi.craftRank.RECRUIT,      -- Maple Sugar
                    4363,      44,      xi.craftRank.RECRUIT,      -- Faerie Apple
                    4378,      60,      xi.craftRank.RECRUIT,      -- Selbina Milk
                    4370,     200,      xi.craftRank.RECRUIT,      -- Honey
                    4432,      60,     xi.craftRank.INITIATE,      -- Kazham Pineapple
                    4366,      24,     xi.craftRank.INITIATE,      -- La Theine Cabbage
                     611,      40,     xi.craftRank.INITIATE,      -- Rye Flour
                    4412,     325,       xi.craftRank.NOVICE,      -- Thundermelon
                    4491,     200,       xi.craftRank.NOVICE,      -- Watermelon
                     615,      60,       xi.craftRank.NOVICE,      -- Selbina Butter
                     612,      60,   xi.craftRank.APPRENTICE,      -- Kazham Peppers
                    1111,     900,   xi.craftRank.APPRENTICE,      -- Gelatin
                    1776,    3000,   xi.craftRank.JOURNEYMAN,      -- Spaghetti
                    5164,    2595,   xi.craftRank.JOURNEYMAN,      -- Ground Wasabi
                     616,    1600,    xi.craftRank.CRAFTSMAN,      -- Pie Dough
                    2561,    3000,    xi.craftRank.CRAFTSMAN,      -- Pizza Dough
                    8800,     600,    xi.craftRank.CRAFTSMAN,      -- Azuki Bean
            },
            [xi.skill.CLOTHCRAFT] =
            {
                    2128,      75,      xi.craftRank.AMATEUR,      -- Spindle
                    2145,      75,      xi.craftRank.AMATEUR,      -- Zephyr Thread
                     833,      20,      xi.craftRank.AMATEUR,      -- Moko Grass
                     834,     500,      xi.craftRank.RECRUIT,      -- Saruta Cotton
                    1845,     200,      xi.craftRank.RECRUIT,      -- Red Moko Grass
                     819,     150,     xi.craftRank.INITIATE,      -- Linen Thread
                     820,    2800,       xi.craftRank.NOVICE,      -- Wool Thread
                    2295,     800,   xi.craftRank.APPRENTICE,      -- Mohbwa Grass
                     816,    1500,   xi.craftRank.APPRENTICE,      -- Silk Thread
                    2315,    1400,   xi.craftRank.JOURNEYMAN,      -- Karakul Wool
                     823,   14500,    xi.craftRank.CRAFTSMAN,      -- Gold Thread
                    9251, 1126125,      xi.craftRank.AMATEUR       -- Khoma Thread
            },
            [xi.skill.GOLDSMITHING] =
            {
                    2144,      75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
                    2143,      75,      xi.craftRank.AMATEUR,      -- Mandrel
                     642,     200,      xi.craftRank.AMATEUR,      -- Zinc Ore
                     640,      12,      xi.craftRank.AMATEUR,      -- Copper Ore
                    1231,      40,      xi.craftRank.RECRUIT,      -- Brass Nugget
                     661,     300,      xi.craftRank.RECRUIT,      -- Brass Sheet
                     736,     450,      xi.craftRank.RECRUIT,      -- Silver Ore
                    1233,     200,     xi.craftRank.INITIATE,      -- Silver Nugget
                     806,    1863,     xi.craftRank.INITIATE,      -- Tourmaline
                     807,    1863,     xi.craftRank.INITIATE,      -- Sardonyx
                     809,    1863,     xi.craftRank.INITIATE,      -- Clear Topaz
                     800,    1863,     xi.craftRank.INITIATE,      -- Amethyst
                     795,    1863,     xi.craftRank.INITIATE,      -- Lapis Lazuli
                     814,    1863,     xi.craftRank.INITIATE,      -- Amber
                     799,    1863,     xi.craftRank.INITIATE,      -- Onyx
                     796,    1863,     xi.craftRank.INITIATE,      -- Light Opal
                     760,   23000,       xi.craftRank.NOVICE,      -- Silver Chain
                     644,    2000,       xi.craftRank.NOVICE,      -- Mythril Ore
                     737,    3000,   xi.craftRank.APPRENTICE,      -- Gold Ore
                     663,   12000,   xi.craftRank.APPRENTICE,      -- Mythril Sheet
                     788,    8000,   xi.craftRank.APPRENTICE,      -- Peridot
                     790,    8000,   xi.craftRank.APPRENTICE,      -- Garnet
                     808,    8000,   xi.craftRank.APPRENTICE,      -- Goshenite
                     811,    8000,   xi.craftRank.APPRENTICE,      -- Ametrine
                     798,    8000,   xi.craftRank.APPRENTICE,      -- Turquoise
                     815,    8000,   xi.craftRank.APPRENTICE,      -- Sphene
                     793,    8000,   xi.craftRank.APPRENTICE,      -- Black Pearl
                     792,    8000,   xi.craftRank.APPRENTICE,      -- Pearl
                     678,    5000,   xi.craftRank.APPRENTICE,      -- Aluminum Ore
                     752,   32000,   xi.craftRank.JOURNEYMAN,      -- Gold Sheet
                     761,   58000,   xi.craftRank.JOURNEYMAN,      -- Gold Chain
                     738,    6000,    xi.craftRank.CRAFTSMAN,      -- Platinum Ore
                    9249, 1126125,      xi.craftRank.AMATEUR       -- Ruthenium Ore
            },
            [xi.skill.WOODWORKING] =
            {
                    1657,     100,      xi.craftRank.AMATEUR,      -- Bundling Twine
                     688,      25,      xi.craftRank.AMATEUR,      -- Arrowwood Log
                     689,      50,      xi.craftRank.AMATEUR,      -- Lauan Log
                     691,      70,      xi.craftRank.AMATEUR,      -- Maple Log
                     697,     800,      xi.craftRank.RECRUIT,      -- Holly Log
                     695,    1600,      xi.craftRank.RECRUIT,      -- Willow Log
                     693,    1300,      xi.craftRank.RECRUIT,      -- Walnut Log
                     696,     500,     xi.craftRank.INITIATE,      -- Yew Log
                     690,    3800,     xi.craftRank.INITIATE,      -- Elm Log
                     694,    3400,     xi.craftRank.INITIATE,      -- Chestnut Log
                     727,    2000,       xi.craftRank.NOVICE,      -- Dogwood Log
                     699,    4000,       xi.craftRank.NOVICE,      -- Oak Log
                     701,    4500,   xi.craftRank.APPRENTICE,      -- Rosewood Log
                     700,    4500,   xi.craftRank.JOURNEYMAN,      -- Mahogany Log
                     702,    5000,    xi.craftRank.CRAFTSMAN,      -- Ebony Log
                    2761,    5500,    xi.craftRank.CRAFTSMAN,      -- Feyweald Log
                    9245, 1126125,      xi.craftRank.AMATEUR       -- Cypress Log
            },
            [xi.skill.ALCHEMY] =
            {
                    2131,      75,      xi.craftRank.AMATEUR,      -- Triturator
                     912,      40,      xi.craftRank.AMATEUR,      -- Beehive Chip
                     914,    1700,      xi.craftRank.AMATEUR,      -- Mercury
                     937,     300,      xi.craftRank.RECRUIT,      -- Animal Glue
                     943,     320,      xi.craftRank.RECRUIT,      -- Poison Dust
                     637,    1500,     xi.craftRank.INITIATE,      -- Slime Oil
                     928,     515,     xi.craftRank.INITIATE,      -- Bomb Ash
                     921,     200,     xi.craftRank.INITIATE,      -- Ahriman Tears
                     933,    1200,       xi.craftRank.NOVICE,      -- Glass Fiber
                     947,    5000,       xi.craftRank.NOVICE,      -- Firesand
                    4171,     700,   xi.craftRank.APPRENTICE,      -- Vitriol
                    1886,    4000,   xi.craftRank.APPRENTICE,      -- Sieglinde Putty
                     923,    1800,   xi.craftRank.APPRENTICE,      -- Dryad Root
                     932,    1900,   xi.craftRank.JOURNEYMAN,      -- Carbon Fiber
                     939,    2100,   xi.craftRank.JOURNEYMAN,      -- Hecteyes Eye
                     915,    3600,   xi.craftRank.JOURNEYMAN,      -- Toad Oil
                     931,    5000,    xi.craftRank.CRAFTSMAN,      -- Cermet Chunk
                     944,    1035,    xi.craftRank.CRAFTSMAN,      -- Venom Dust
                    9257, 1126125,      xi.craftRank.AMATEUR       -- Azure Leaf
            },
            [xi.skill.BONECRAFT] =
            {
                    2130,      75,      xi.craftRank.AMATEUR,      -- Shagreen File
                     880,     150,      xi.craftRank.AMATEUR,      -- Bone Chip
                     864,      96,      xi.craftRank.AMATEUR,      -- Fish Scales
                     898,    1500,      xi.craftRank.RECRUIT,      -- Chicken Bone [Recruit]
                     893,    1400,      xi.craftRank.RECRUIT,      -- Giant Femur [Recruit]
                     889,     500,     xi.craftRank.INITIATE,      -- Beetle Shell [Initiate]
                     894,    1000,     xi.craftRank.INITIATE,      -- Beetle Jaw [Initiate]
                     895,    1800,       xi.craftRank.NOVICE,      -- Ram Horn [Novice]
                     884,    2000,       xi.craftRank.NOVICE,      -- Black Tiger Fang [Novice]
                     881,    2500,   xi.craftRank.APPRENTICE,      -- Crab Shell [Apprentice]
                     885,    6000,   xi.craftRank.JOURNEYMAN,      -- Turtle Shell [Journeyman]
                     897,    2400,   xi.craftRank.JOURNEYMAN,      -- Scorpion Claw [Journeyman]
                    1622,    4000,   xi.craftRank.JOURNEYMAN,      -- Bugard Tusk [Journeyman]
                     896,    3000,    xi.craftRank.CRAFTSMAN,      -- Scorpion Shell [Craftsman]
                    2147,    4500,    xi.craftRank.CRAFTSMAN,      -- Marid Tusk [Craftsman]
                    9255, 1126125,      xi.craftRank.AMATEUR       -- Cyan Coral
            },
            [xi.skill.LEATHERCRAFT] =
            {
                    2129,      75,      xi.craftRank.AMATEUR,      -- Tanning Vat
                     505,     100,      xi.craftRank.AMATEUR,      -- Sheepskin
                     856,      80,      xi.craftRank.AMATEUR,      -- Rabbit Hide
                     852,     600,      xi.craftRank.RECRUIT,      -- Lizard Skin
                     878,     600,      xi.craftRank.RECRUIT,      -- Karakul Skin
                     858,     600,      xi.craftRank.RECRUIT,      -- Wolf Hide
                     857,    2400,     xi.craftRank.INITIATE,      -- Dhalmel Hide
                    1640,    2500,     xi.craftRank.INITIATE,      -- Bugard Skin
                     859,    1500,       xi.craftRank.NOVICE,      -- Ram Skin
                    1628,   16000,   xi.craftRank.APPRENTICE,      -- Buffalo Hide
                     853,    3000,   xi.craftRank.JOURNEYMAN,      -- Raptor Skin
                    2123,    2500,   xi.craftRank.JOURNEYMAN,      -- Catoblepas Hide
                    2518,    3000,    xi.craftRank.CRAFTSMAN,      -- Smilodon Hide
                     854,    3000,    xi.craftRank.CRAFTSMAN,      -- Cockatrice Skin
                    9253, 1126125,      xi.craftRank.AMATEUR       -- Synthetic Faulpie Leather
            },
            [xi.skill.SMITHING] =
            {
                    2144,      75,      xi.craftRank.AMATEUR,      -- Workshop Anvil
                    2143,      75,      xi.craftRank.AMATEUR,      -- Mandrel
                     640,      12,      xi.craftRank.AMATEUR,      -- Copper Ore
                    1232,      70,      xi.craftRank.AMATEUR,      -- Bronze Nugget
                     641,      60,      xi.craftRank.RECRUIT,      -- Tin Ore
                     660,     120,      xi.craftRank.RECRUIT,      -- Bronze Sheet
                     643,     900,      xi.craftRank.RECRUIT,      -- Iron Ore
                    1650,     800,     xi.craftRank.INITIATE,      -- Kopparnickel Ore
                    1234,     500,     xi.craftRank.INITIATE,      -- Iron Nugget
                     662,    6000,     xi.craftRank.INITIATE,      -- Iron Sheet
                     666,   10000,       xi.craftRank.NOVICE,      -- Steel Sheet
                     652,    6000,   xi.craftRank.APPRENTICE,      -- Steel Ingot
                     657,   12000,   xi.craftRank.APPRENTICE,      -- Tama-Hagane
                    1228,    2700,   xi.craftRank.JOURNEYMAN,      -- Darksteel Nugget
                     645,    7000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Ore
                    1235,     800,   xi.craftRank.JOURNEYMAN,      -- Steel Nugget
                     664,   28000,   xi.craftRank.JOURNEYMAN,      -- Darksteel Sheet
                    2763,    5000,    xi.craftRank.CRAFTSMAN,      -- Swamp Ore
                    9247, 1126125,      xi.craftRank.AMATEUR       -- Niobium Ore
            }
        }
    local stock = generalGuildStockNoKit[guildSkillId]
--    player:createShop(#stock / 3, log)
--
--    for i = 1, #stock, 3 do
--        player:addShopItem(stock[i], stock[i+1], guildSkillId, stock[i+2])
--    end
--
--    player:sendMenu(2)
end)

return m
