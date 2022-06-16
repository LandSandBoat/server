-----------------------------------
-- Conquest: Regional npcs shops always open, regardless of conquest results
-----------------------------------
require("scripts/globals/shop")
require("modules/module_utils")

local m = Module:new("conquest_npc_shop_always_open")

xi = xi or {}
xi.customShop = xi.customShop or {}

--Bastok Markets
xi.customShop.Oggodett =
{
    631,    36,    -- Horo Flour
    629,    43,    -- Millioncorn
    4415,  111,    -- Roasted Corn
    4505,   90,    -- Sunflower Seeds
    841,    36,     -- Yagudo Feather
}

xi.customShop.Yafafa =
{
    4503,  184,    --Buburimu Grape
    1120, 1620,    --Casablanca
    4359,  220,    --Dhalmel Meat
    614,    72,    --Mhaura Garlic
    4445,   40,     --Yagudo Cherry
}

xi.customShop.SomnPaemn =
{
    689,  33,    --Lauan Log
    619,  43,    --Popoto
    4444, 22,    --Rarab Tail
    4392, 29,    --Saruta Orange
    635,  18,     --Windurstian Tea Leaves
}

--Bastok Mines
xi.customShop.Aulavia =
{
    636,   119,    -- Chamomile
    864,    88,    -- Fish Scales
    936,    14,    -- Rock Salt
    1410, 1656,     -- Sweet William
}

xi.customShop.Emaliveulaux =
{
    1523,  290, -- Apple Mint
    5164, 1945, -- Ground Wasabi
    17005,  99, -- Lufaise Fly
    5195,  233, -- Misareaux Parsley
    1695,  920, -- Habanero Peppers
}

xi.customShop.Faustin =
{
    639, 110,    -- Chestnut
    4389, 29,    -- San d'Orian Carrot
    610,  55,    -- San d'Orian Flour
    4431, 69,     -- San d'Orian Grape
}

xi.customShop.Galdeo =
{
    623,   119,    -- Bay Leaves
    4154, 6440,    -- Holy Water
}

xi.customShop.Mille =
{
    688, 18,    -- Arrowwood Log
    698, 88,    -- Ash Log
    618, 25,    -- Blue Peas
    621, 25,     -- Crying Mustard
}

xi.customShop.Rodellieux =
{
    4571, 90, -- Beaugreens
    4363, 39, -- Faerie Apple
    691,  54, -- Maple Log
}

xi.customShop.Tibelda =
{
    4382,  29, --Frost Turnip
    638,  170, --Sage
}

--Metalworks
xi.customShop.Takiyah =
{
    954, 4121,    -- Magic Pot Shard
}

--Northern Sandoria
xi.customShop.Antonian =
{
    631,   36,    -- Horo Flour
    629,   43,    -- Millioncorn
    4415, 111,    -- Roasted Corn
    841,   36,    -- Yagudo Feather
    4505,  90,    -- Sunflower Seeds
}

xi.customShop.Attarena =
{
    623,   119,    -- Bay Leaves
    4154, 6440,    -- Holy Water
}

xi.customShop.Eugballion =
{
    954, 4121,    -- Magic Pot Shard
}

xi.customShop.Millechuca =
{
    636,   119,    -- Chamomile
    864,    88,    -- Fish Scales
    936,    14,    -- Rock Salt
    1410, 1656,    -- Sweet William
}

xi.customShop.Palguevion =
{
    4382,  29,    -- Frost Turnip
    638,  170,    -- Sage
}

xi.customShop.Vichuel =
{
    4571, 90,    -- Beaugreens
    4363, 39,    -- Faerie Apple
    691,  54,    -- Maple Log
}

--Port Bastok
xi.customShop.Bagnobrok =
{
    640,    11,    -- Copper Ore
    4450,  694,    -- Coral Fungus
    4375, 4032,    -- Danceshroom
    1650, 6500,    -- Kopparnickel Ore
    5165,  736,    -- Movalpolos Water
}

xi.customShop.Belka =
{
    4352,  128,    -- Derfland Pear
    617,   142,    -- Ginger
    4545,   62,    -- Gysahl Greens
    1412, 1656,    -- Olive Flower
    633,    14,    -- Olive Oil
    951,   110,    -- Wijnruit
}

xi.customShop.Dhen_Tevryukoh =
{
    1413, 1656,    -- Cattleya
    628,   239,    -- Cinnamon
    4468,   73,    -- Pamamas
    721,   147,    -- Rattan Lumber
}

xi.customShop.Evelyn =
{
    1108, 703,    -- Sulfur
    619,   43,    -- Popoto
    611,   36,    -- Rye Flour
    4388,  40,    -- Eggplant
}

xi.customShop.Rosswald =
{
    4372,   44,    -- Giant Sheep Meat
    622,    44,    -- Dried Marjoram
    610,    55,    -- San d'Orian Flour
    611,    36,    -- Rye Flour
    1840, 1840,    -- Semolina
    4366,   22,    -- La Theine Cabbage
    4378,   55,    -- Selbina Milk
}

xi.customShop.Vattian =
{
    916,  855,    -- Cactuar Needle
    4412, 299,    -- Thundermelon
    4491, 184,    -- Watermelon
}

xi.customShop.Zoby_Quhyo =
{
    626,   234,    -- Black Pepper
    612,    55,    -- Kazham Peppers
    4432,   55,    -- Kazham Pineapple
    632,   110,    -- Kukuru Bean
    4390,   36,    -- Mithran Tomato
    630,    88,    -- Ogre Pumpkin
    1411, 1656,    -- Phalaenopsis
}

--Port Sandoria
xi.customShop.Bonmaurieut =
{
    1413, 1656,    -- Cattleya
    628,   239,    -- Cinnamon
    4468,   73,    -- Pamamas
    721,   147,    -- Rattan Lumber
}

xi.customShop.Deguerendars =
{
    1523,  290,    -- Apple Mint
    5164, 1945,    -- Ground Wasabi
    17005,  99,    -- Lufaise Fly
    5195,  233,    -- Misareaux Parsley
    1695,  920,    -- Habanero Peppers
}

xi.customShop.Fiva =
{
    4503,  184,    -- Buburimu Grape
    1120, 1620,    -- Casablanca
    4359,  220,    -- Dhalmel Meat
    614,    72,    -- Mhaura Garlic
    4445,   40,    -- Yagudo Cherry
}

xi.customShop.Milva =
{
    4444, 22,    -- Rarab Tail
    689,  33,    -- Lauan Log
    619,  43,    -- Popoto
    4392, 29,    -- Saruta Orange
    635,  18,    -- Windurstian Tea Leaves
}

xi.customShop.Nimia =
{
    612,    55,    -- Kazham Peppers
    4432,   55,    -- Kazham Pineapple
    4390,   36,    -- Mithran Tomato
    626,   234,    -- Black Pepper
    630,    88,    -- Ogre Pumpkin
    632,   110,    -- Kukuru Bean
    1411, 1656,    -- Phalaenopsis
}

xi.customShop.Patolle =
{
    916,  855,    -- Cactuar Needle
    4412, 299,    -- Thundermelon
    4491, 184,    -- Watermelon
}

xi.customShop.Vendavoq =
{
    640,    11,    -- Copper Ore
    4450,  694,    -- Coral Fungus
    4375, 4032,    -- Danceshroom
    1650, 6500,    -- Kopparnickel Ore
    5165,  736,    -- Movalpolos Water
}

--Port Windurst
xi.customShop.Alizabe =
{
    1523,  290,    -- Apple Mint
    5164, 1945,    -- Ground Wasabi
    17005,  99,    -- Lufaise Fly
    5195,  233,    -- Misareaux Parsley
    1695,  920,    -- Habanero Peppers
}

xi.customShop.Lebondur =
{
    636,   119,    -- Chamomile
    864,    88,    -- Fish Scales
    936,    14,    -- Rock Salt
    1410, 1656,    -- Sweet William
}

xi.customShop.Posso_Ruhbini =
{
    688, 18,    -- Arrowwood Log
    698, 87,    -- Ash Log
    618, 25,    -- Blue Peas
    621, 25,    -- Crying Mustard
}

xi.customShop.Sattsuh_Ahkanpari =
{
    1413, 1656,    -- Cattleya
    628,   239,    -- Cinnamon
    4468,   73,    -- Pamamas
    721,   147,    -- Rattan Lumber
}

xi.customShop.Sheia_Pohrichamaha =
{
    4571, 90,    -- Beaugreens
    4363, 39,    -- Faerie Apple
    691,  54,    -- Maple Log
}

xi.customShop.Zoreen =
{
    4382, 29,    -- Frost Turnip
    638, 170,    -- Sage
}

--Southern Sandoria

xi.customShop.Apairemant =
{
    1108, 703,    -- Sulfur
    619,   43,    -- Popoto
    611,   36,    -- Rye Flour
    4388,  40,    -- Eggplant
}

xi.customShop.Corua =
{
    4389,  29,    -- San d'Orian Carrot
    4431,  69,    -- San d'Orian Grape
    639,  110,    -- Chestnut
    610,   55,    -- San d'Orian Flour
}

xi.customShop.Machielle =
{
    688, 18,    -- Arrowwood Log
    621, 25,    -- Crying Mustard
    618, 25,    -- Blue Peas
    698, 88,    -- Ash Log
}

xi.customShop.Phamelise =
{
    4372,   44,    -- Giant Sheep Meat
    622,    44,    -- Dried Marjoram
    610,    55,    -- San d'Orian Flour
    611,    36,    -- Rye Flour
    1840, 1840,    -- Semolina
    4366,   22,    -- La Theine Cabbage
    4378,   55,    -- Selbina Milk
}

xi.customShop.Pourette =
{
    4352,  128,    -- Derfland Pear
    617,   142,    -- Ginger
    4545,   62,    -- Gysahl Greens
    1412, 1656,    -- Olive Flower
    633,    14,    -- Olive Oil
    951,   110,    -- Wijnruit
}

--Windurst Waters
xi.customShop.Ahyeekih =
{
    4503,   184,  -- Buburimu Grape
    1120,  1620,  -- Casablanca
    4359,   220,  -- Dhalmel Meat
    614,     72,  -- Mhaura Garlic
    4445,    40   -- Yagudo Cherry
}

xi.customShop.BaehuFaehu =
{
    4444,  22,  -- Rarab Tail
    689,   33,  -- Lauan Log
    619,   43,  -- Popoto
    4392,  29,  -- Saruta Orange
    635,   18   -- Windurstian Tea Leaves
}

xi.customShop.Fomina =
{
    612,     55,  -- Kazham Peppers
    4432,    55,  -- Kazham Pineapple
    4390,    36,  -- Mithran Tomato
    626,    234,  -- Black Pepper
    630,     88,  -- Ogre Pumpkin
    632,    110,  -- Kukuru Bean
    1411,  1656   -- Phalaenopsis
}

xi.customShop.Jourille =
{
    639,   110,  -- Chestnut
    4389,   29,  -- San d'Orian Carrot
    610,    55,  -- San d'Orian Flour
    4431,   69,  -- San d'Orian Grape
}

xi.customShop.Maqu_Molpih =
{
    631,    36,  -- Horo Flour
    629,    44,  -- Millioncorn
    4415,  114,  -- Roasted Corn
    4505,   92,  -- Sunflower Seeds
    841,    36   -- Yagudo Feather
}

xi.customShop.Otete =
{
    623,    119, -- Bay Leaves
    4154,  6440  -- Holy Water
}

xi.customShop.Prestapiq =
{
    640,    11,   --Copper Ore
    4450,   694,   --Coral Fungus
    4375,  4032,   --Danceshroom
    1650,  6500,   --Kopparnickel Ore
    5165,   736    --Movalpolos Water
}

--Windurst Woods
xi.customShop.Bin_Stejihna =
{
    1840,  1840,  -- Semolina
    4372,    44,  -- Giant Sheep Meat
    622,     44,  -- Dried Marjoram
    610,     55,  -- San d'Orian Flour
    611,     36,  -- Rye Flour
    4366,    22,  -- La Theine Cabbage
    4378,    55   -- Selbina Milk
}

xi.customShop.Millerovieunet =
{
    954,  4032  -- Magic Pot Shard
}

xi.customShop.Nhobi_Zalkia =
{
    916,   855,  -- Cactuar Needle
    4412,  299,  -- Thundermelon
    4491,  184   -- Watermelon
}

xi.customShop.Nya_Labiccio =
{
    1108,  703, -- Sulfur
    619,    43, -- Popoto
    611,    36, -- Rye Flour
    4388,   40  -- Eggplant
}

xi.customShop.TaraihiPerunhi =
{
    4352,  128, -- Derfland Pear
    617,   142, -- Ginger
    4545,   62, -- Gysahl Greens
    1412, 1656, -- Olive Flower
    633,    14, -- Olive Oil
    951,   110  -- Wijnruit
}

local lookupTable =
{
    --Bastok Markets
    {"Bastok_Markets", "Oggodett", xi.customShop.Oggodett, xi.quest.fame_area.BASTOK, "OGGODETT_OPEN_DIALOG"},
    {"Bastok_Markets", "Yafafa", xi.customShop.Yafafa, xi.quest.fame_area.BASTOK, "YAFAFA_OPEN_DIALOG"},
    {"Bastok_Markets", "Somn-Paemn", xi.customShop.SomnPaemn, xi.quest.fame_area.BASTOK, "SOMNPAEMN_OPEN_DIALOG"},
    --Bastok Mines
    {"Bastok_Mines", "Aulavia", xi.customShop.Aulavia, xi.quest.fame_area.BASTOK, "AULAVIA_OPEN_DIALOG"},
    {"Bastok_Mines", "Emaliveulaux", xi.customShop.Emaliveulaux, xi.quest.fame_area.BASTOK, "EMALIVEULAUX_OPEN_DIALOG"},
    {"Bastok_Mines", "Faustin", xi.customShop.Faustin, xi.quest.fame_area.BASTOK, "FAUSTIN_OPEN_DIALOG"},
    {"Bastok_Mines", "Galdeo", xi.customShop.Galdeo, xi.quest.fame_area.BASTOK, "GALDEO_OPEN_DIALOG"},
    {"Bastok_Mines", "Mille", xi.customShop.Mille, xi.quest.fame_area.BASTOK, "MILLE_OPEN_DIALOG"},
    {"Bastok_Mines", "Rodellieux", xi.customShop.Rodellieux, xi.quest.fame_area.BASTOK, "RODELLIEUX_OPEN_DIALOG"},
    {"Bastok_Mines", "Tibelda", xi.customShop.Tibelda, xi.quest.fame_area.BASTOK, "TIBELDA_OPEN_DIALOG"},
    --Metalworks
    {"Metalworks", "Takiyah", xi.customShop.Takiyah, xi.quest.fame_area.BASTOK, "TAKIYAH_OPEN_DIALOG"},
    --Northern Sandoria
    {"Northern_San_dOria", "Antonian", xi.customShop.Antonian, xi.quest.fame_area.SANDORIA, "ANTONIAN_OPEN_DIALOG"},
    {"Northern_San_dOria", "Attarena", xi.customShop.Attarena, xi.quest.fame_area.SANDORIA, "ATTARENA_OPEN_DIALOG"},
    {"Northern_San_dOria", "Eugballion", xi.customShop.Eugballion, xi.quest.fame_area.SANDORIA, "EUGBALLION_OPEN_DIALOG"},
    {"Northern_San_dOria", "Millechuca", xi.customShop.Millechuca, xi.quest.fame_area.SANDORIA, "MILLECHUCA_OPEN_DIALOG"},
    {"Northern_San_dOria", "Palguevion", xi.customShop.Palguevion, xi.quest.fame_area.SANDORIA, "PALGUEVION_OPEN_DIALOG"},
    {"Northern_San_dOria", "Vichuel", xi.customShop.Vichuel, xi.quest.fame_area.SANDORIA, "VICHUEL_OPEN_DIALOG"},
    --Port Bastok
    {"Port_Bastok", "Bagnobrok", xi.customShop.Bagnobrok, xi.quest.fame_area.BASTOK, "BAGNOBROK_OPEN_DIALOG"},
    {"Port_Bastok", "Belka", xi.customShop.Belka, xi.quest.fame_area.BASTOK, "BELKA_OPEN_DIALOG"},
    {"Port_Bastok", "Dhen_Tevryukoh", xi.customShop.Dhen_Tevryukoh, xi.quest.fame_area.BASTOK, "DHENTEVRYUKOH_OPEN_DIALOG"},
    {"Port_Bastok", "Evelyn", xi.customShop.Evelyn, xi.quest.fame_area.BASTOK, "EVELYN_OPEN_DIALOG"},
    {"Port_Bastok", "Rosswald", xi.customShop.Rosswald, xi.quest.fame_area.BASTOK, "ROSSWALD_OPEN_DIALOG"},
    {"Port_Bastok", "Vattian", xi.customShop.Vattian, xi.quest.fame_area.BASTOK, "VATTIAN_OPEN_DIALOG"},
    {"Port_Bastok", "Zoby_Quhyo", xi.customShop.Zoby_Quhyo, xi.quest.fame_area.BASTOK, "ZOBYQUHYO_OPEN_DIALOG"},
    --Port Sandoria
    {"Port_San_dOria", "Bonmaurieut", xi.customShop.Bonmaurieut, xi.quest.fame_area.SANDORIA, "BONMAURIEUT_OPEN_DIALOG"},
    {"Port_San_dOria", "Deguerendars", xi.customShop.Deguerendars, xi.quest.fame_area.SANDORIA, "DEGUERENDARS_OPEN_DIALOG"},
    {"Port_San_dOria", "Fiva", xi.customShop.Fiva, xi.quest.fame_area.SANDORIA, "FIVA_OPEN_DIALOG"},
    {"Port_San_dOria", "Milva", xi.customShop.Milva, xi.quest.fame_area.SANDORIA, "MILVA_OPEN_DIALOG"},
    {"Port_San_dOria", "Nimia", xi.customShop.Nimia, xi.quest.fame_area.SANDORIA, "NIMIA_OPEN_DIALOG"},
    {"Port_San_dOria", "Patolle", xi.customShop.Patolle, xi.quest.fame_area.SANDORIA, "PATOLLE_OPEN_DIALOG"},
    {"Port_San_dOria", "Vendavoq", xi.customShop.Vendavoq, xi.quest.fame_area.SANDORIA, "VENDAVOQ_OPEN_DIALOG"},
    --Port Windurst
    {"Port_Windurst", "Alizabe", xi.customShop.Alizabe, xi.quest.fame_area.WINDURST, "ALIZABE_OPEN_DIALOG"},
    {"Port_Windurst", "Lebondur", xi.customShop.Lebondur, xi.quest.fame_area.WINDURST, "LEBONDUR_OPEN_DIALOG"},
    {"Port_Windurst", "Posso_Ruhbini", xi.customShop.Posso_Ruhbini, xi.quest.fame_area.WINDURST, "POSSORUHBINI_OPEN_DIALOG"},
    {"Port_Windurst", "Sattsuh_Ahkanpari", xi.customShop.Sattsuh_Ahkanpari, xi.quest.fame_area.WINDURST, "SATTSUHAHKANPARI_OPEN_DIALOG"},
    {"Port_Windurst", "Sheia_Pohrichamaha", xi.customShop.Sheia_Pohrichamaha, xi.quest.fame_area.WINDURST, "SHEIAPOHRICHAMAHA_OPEN_DIALOG"},
    {"Port_Windurst", "Zoreen", xi.customShop.Zoreen, xi.quest.fame_area.WINDURST, "ZOREEN_OPEN_DIALOG"},
    --Southern Sandoria
    {"Southern_San_dOria", "Apairemant", xi.customShop.Apairemant, xi.quest.fame_area.SANDORIA, "APAIREMANT_OPEN_DIALOG"},
    {"Southern_San_dOria", "Corua", xi.customShop.Corua, xi.quest.fame_area.SANDORIA, "CORUA_OPEN_DIALOG"},
    {"Southern_San_dOria", "Machielle", xi.customShop.Machielle, xi.quest.fame_area.SANDORIA, "MACHIELLE_OPEN_DIALOG"},
    {"Southern_San_dOria", "Phamelise", xi.customShop.Phamelise, xi.quest.fame_area.SANDORIA, "PHAMELISE_OPEN_DIALOG"},
    {"Southern_San_dOria", "Pourette", xi.customShop.Pourette, xi.quest.fame_area.SANDORIA, "POURETTE_OPEN_DIALOG"},
    --Windurst Waters
    {"Windurst_Waters", "Ahyeekih", xi.customShop.Ahyeekih, xi.quest.fame_area.WINDURST, "AHYEEKIH_OPEN_DIALOG"},
    {"Windurst_Waters", "Baehu-Faehu", xi.customShop.BaehuFaehu, xi.quest.fame_area.WINDURST, "BAEHUFAEHU_OPEN_DIALOG"},
    {"Windurst_Waters", "Fomina", xi.customShop.Fomina, xi.quest.fame_area.WINDURST, "FOMINA_OPEN_DIALOG"},
    {"Windurst_Waters", "Jourille", xi.customShop.Jourille, xi.quest.fame_area.WINDURST, "JOURILLE_OPEN_DIALOG"},
    {"Windurst_Waters", "Maqu_Molpih", xi.customShop.Maqu_Molpih, xi.quest.fame_area.WINDURST, "MAQUMOLPIH_OPEN_DIALOG"},
    {"Windurst_Waters", "Otete", xi.customShop.Otete, xi.quest.fame_area.WINDURST, "OTETE_OPEN_DIALOG"},
    {"Windurst_Waters", "Prestapiq", xi.customShop.Prestapiq, xi.quest.fame_area.WINDURST, "PRESTAPIQ_OPEN_DIALOG"},
    --Windurst Woods
    {"Windurst_Woods", "Bin_Stejihna", xi.customShop.Bin_Stejihna, xi.quest.fame_area.WINDURST, "BIN_STEJIHNA_OPEN_DIALOG"},
    {"Windurst_Woods", "Millerovieunet", xi.customShop.Millerovieunet, xi.quest.fame_area.WINDURST, "MILLEROVIEUNET_OPEN_DIALOG"},
    {"Windurst_Woods", "Nhobi_Zalkia", xi.customShop.Nhobi_Zalkia, xi.quest.fame_area.WINDURST, "NHOBI_ZALKIA_OPEN_DIALOG"},
    {"Windurst_Woods", "Nya_Labiccio", xi.customShop.Nya_Labiccio, xi.quest.fame_area.WINDURST, "NYALABICCIO_OPEN_DIALOG"},
    {"Windurst_Woods", "Taraihi-Perunhi", xi.customShop.TaraihiPerunhi, xi.quest.fame_area.WINDURST, "TARAIHIPERUNHI_OPEN_DIALOG"},
}

for _, shop in pairs(lookupTable) do
    local ID = require(string.format("scripts/zones/%s/IDs", shop[1]))
    m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[1], shop[2]),
    function(player, npc)
        player:showText(npc, ID.text[shop[5]])
        xi.shop.general(player, shop[3], shop[4])
    end)
end

return m
