-----------------------------------
-- 75 Era Vendor Shops
-----------------------------------
require("scripts/globals/shop")
require("modules/module_utils")
require("scripts/globals/keyitems")

local m = Module:new("75_era_vendors")

xi = xi or {}
xi.customShop = xi.customShop or {}

--Lower Jeuno
xi.customShop.Amalasanda =
{
    704,36, -- Bamboo Stick
    829,35070, --Silk Cloth 
    626,52, -- Black Pepper
    1240,2000, -- Koma
    657,8000, -- Tama-Hagane
    1415,20000, -- Urushi
    4928,1700, -- Katon: Ichi
    4934,1700, -- Huton: Ichi
    4937,1700, -- Doton: Ichi
    4943,1700, -- Suiton: Ni
    1471,190, -- Sticky Rice
    1554,140, -- Turmeric
    1555,317, -- Coriander
    1590,700, -- Holy Basil
    1475,244, -- Curry Powder
    5164,2595, -- Ground Wasabi
    1652,492, -- Rice Vinegar
    1161,70, -- Uchitake
    1170,70, -- Makibishi
    1176,70, -- Mizu-Deppo
}

xi.customShop.Creepstix =
{
    5023,   8160, -- Scroll of Goblin Gavotte
    4734,   7074, -- Scroll of Protectra II
    4738,   1700, -- Scroll of Shellra
}

xi.customShop.Hasim =
{
    4668,   1760,    -- Scroll of Barfire
    4669,   3624,    -- Scroll of Barblizzard
    4670,    930,    -- Scroll of Baraero
    4671,    156,    -- Scroll of Barstone
    4672,   5754,    -- Scroll of Barthunder
    4673,    360,    -- Scroll of Barwater
    4674,   1760,    -- Scroll of Barfira
    4675,   3624,    -- Scroll of Barblizzara
    4676,    930,    -- Scroll of Baraera
    4677,    156,    -- Scroll of Barstonra
    4678,   5754,    -- Scroll of Barthundra
    4679,    360,    -- Scroll of Barwatera
    4680,    244,    -- Scroll of Barsleep
    4612,  23400,    -- Scroll of Cure IV
    4616,  11200,    -- Scroll of Curaga II
    4617,  19932,    -- Scroll of Curaga III
    4653,  32000,    -- Scroll of Protect III
}

xi.customShop.Stinknix = 
{
    943,    294, -- Poison Dust
    944,   1035, -- Venom Dust
    945,   2000, -- Paralysis Dust
    17320,    7, -- Iron Arrow
    17336,    5, -- Crossbow Bolt
    17313, 1107, -- Grenade
}

xi.customShop.Taza = 
{        
    4881,10304,        -- Scroll of Sleepga
    4658,26244,        -- Scroll of Shell III
    4735,19200,        -- Scroll of Protectra III
    4739,14080,        -- Scroll of Shellra II
    4740,26244,        -- Scroll of Shellra III
    4685,15120,        -- Scroll of Barpetrify
    4686,9600,        -- Scroll of Barvirus
    4699,15120,        -- Scroll of Barpetra
    4700,9600,        -- Scroll of Barvira
    4867,18720,        -- Scroll of Sleep II
    4769,19932,        -- Scroll of Stone III
    4779,22682,        -- Scroll of Water III
    4764,27744,        -- Scroll of Aero III
    4754,33306,        -- Scroll of Fire III
    4759,39368,        -- Scroll of Blizzard III
    4774,45930,        -- Scroll of Thunder III
}

--Nashmau
xi.customShop.Mamaroon =
{
    4860,  27000,    -- Scroll of Stun
    4708,   5160,    -- Scroll of Enfire
    4709,   4098,    -- Scroll of Enblizzard
    4710,   2500,    -- Scroll of Enaero
    4711,   2030,    -- Scroll of Entone
    4712,   1515,    -- Scroll of Enthunder
    4713,   7074,    -- Scroll of Enwater
    4859,   9000,    -- Scroll of Shock Spikes
    2502,  29950,    -- White Puppet Turban
    2501,  29950,    -- Black Puppet Turban
}

xi.customShop.Yoyoroon =
{
    2239,  4940,    -- Tension Spring
    2243,  4940,    -- Loudspeaker
    2246,  4940,    -- Accelerator
    2251,  4940,    -- Armor Plate
    2254,  4940,    -- Stabilizer
    2258,  4940,    -- Mana Jammer
    2262,  4940,    -- Auto-Repair Kit
    2266,  4940,    -- Mana Tank
    2240,  9925,    -- Inhibitor
    2242,  9925,    -- Mana Booster
    2247,  9925,    -- Scope
    2250,  9925,    -- Shock Absorber
    2255,  9925,    -- Volt Gun
    2260,  9925,    -- Stealth Screen
    2264,  9925,    -- Damage Gauge
    2268,  9925,    -- Mana Conserver
}

-- Norg
xi.customShop.SolbyMaholby =
{
    17395,     9,    -- Lugworm
    4899,    450,    -- Earth Spirit Pact
}

-- Port Bastok
xi.customShop.Valeriano = 
{
    4394,     10,    -- Ginger Cookie
    17345,    43,    -- Flute
    17347,   990,    -- Piccolo
    5017,    585,    -- Scroll of Scop's Operetta
    5018,  16920,    -- Scroll of Puppet's Operetta
    5013,   2916,    -- Scroll of Fowl Aubade
    5027,   2059,    -- Scroll of Advancing March
    5072,  90000,    -- Scroll of Goddess's Hymnus
}

-- Port Jeuno
xi.customShop.Gekko = 
{
    4150,  2387,    -- Eye Drops
    4148,   290,    -- Antidote
    4151,   367,    -- Echo Drops
    4112,   837,    -- Potion
    4128,  4445,    -- Ether
    4365,   120,    -- Rolanberry
    189,  36000,    -- Autumn's End
    188,  31224,    -- Acolyte's Grief
}

-- Rabao
xi.customShop.Brave_Ox = 
{
    4654,  77350,    -- Protect IV
    4736,  73710,    -- Protectra IV
    4868,  63700,    -- Dispel
    4860,  31850,    -- Stun
    4720,  31850,    -- Flash
    4750, 546000,    -- Reraise III
    4638,  78260,    -- Banish III
}

-- Tavnazian Safehold
xi.customShop.MazuroOozuro =
{
    17005,   108,    -- Lufaise Fly
    17383,  2640,    -- Clothespole
    688,     200,    -- Arrowwood Log
    690,    7800,    -- Elm Log
}

-- Upper Jeuno
xi.customShop.Antonia = 
{
    17061,6256,  -- Mythril Rod
    17027,11232, -- Oak Cudgel
    17036,18048, -- Mythril Mace
    17044,6033,  -- Warhammer
    17098,37440, -- Oak Pole
    16836,44550, -- Halberd
    16774,10596, -- Scythe
    17320,7    -- Iron Arrow
}

-- Windurst Waters
xi.customShop.OrezEbrez = 
{
    12466, 20000,1,     --Red Cap
    12458,  8972,1,     --Soil Hachimaki
    12455,  7026,1,     --Beetle Mask

    12472,   144,2,     --Circlet
    12465,  8024,2,     --Cotton Headgear
    12440,   396,2,     --Leather Bandana
    12473,  1863,2,     --Poet's Circlet
    12499, 14400,2,     --Flax Headband
    12457,  3272,2,     --Cotton Hachimaki
    12454,  3520,2,     --Bone Mask
    12474, 10924,2,     --Wool Hat

    12464,  1742,3,     --Headgear
    12456,   552,3,     --Hachimaki
    12498,  1800,3,     --Cotton Headband
    12448,   151,3,     --Bronze Cap
    12449,  1471,3      --Brass Cap
}

-- Windurst Woods
xi.customShop.Mono_Nchaa =
{
    17318, 3,    2, -- Wooden Arrow
    17308, 55,   2, -- Hawkeye
    17216, 165,  2, -- Light Crossbow
    17319, 4,    3, -- Bone Arrow
    17336, 5,    3, -- Crossbow Bolt
    5009,  2649, 3, -- Scroll of Hunter's Prelude
}


local lookupTable =
--[[
    Nation: {"nation",Zone,NPCName,customShopTable,nation,DIALOG_NAME}
    No Fame: {"nofame",Zone,NPCName,customShopTable,DIALOG_NAME}
    No Shop: {"none",Zone,NPCName}
    Standard: {"standard",Zone,NPCName,customShopTable,fameArea,DIALOG_NAME}
    Tenshodo: {"tenshodo",Zone,NPCName,customShopTable,fameArea,DIALOG_NAME}
 ]]
{
    -- Lower Jeuno
    {"tenshodo", "Lower_Jeuno", "Amalasanda", xi.customShop.Amalasanda, xi.quest.fame_area.NORG, "AMALASANDA_SHOP_DIALOG"},
    {"standard", "Lower_Jeuno", "Creepstix", xi.customShop.Creepstix, xi.quest.fame_area.JEUNO, "JUNK_SHOP_DIALOG"},
    {"standard", "Lower_Jeuno", "Hasim", xi.customShop.Hasim, xi.quest.fame_area.JEUNO, "WAAG_DEEG_SHOP_DIALOG"},
    {"standard", "Lower_Jeuno", "Stinknix", xi.customShop.Stinknix, xi.quest.fame_area.JEUNO, "JUNK_SHOP_DIALOG"},
    {"standard", "Lower_Jeuno", "Taza", xi.customShop.Taza, xi.quest.fame_area.JEUNO, "WAAG_DEEG_SHOP_DIALOG"},
    -- Mhaura
    {"none", "Mhaura", "Tya_Padolih"},
    -- Nashmau
    {"none", "Nashmau","Chichiroon"},
    {"nofame", "Nashmau", "Mamaroon", xi.customShop.Mamaroon, "MAMAROON_SHOP_DIALOG"},
    {"nofame", "Nashmau", "Yoyoroon", xi.customShop.Yoyoroon, "YOYOROON_SHOP_DIALOG"}, 
    -- Norg
    {"standard", "Norg", "Solby-Maholby", xi.customShop.SolbyMaholby, xi.quest.fame_area.NORG, "SOLBYMAHOLBY_SHOP_DIALOG"},
    -- port Bastok  
    {"standard", "Port_Bastok", "Valeriano", xi.customShop.Valeriano, xi.quest.fame_area.BASTOK, "VALERIANO_SHOP_DIALOG"},
    -- Port Jeuno
    {"standard", "Port_Jeuno", "Gekko", xi.customShop.Gekko, xi.quest.fame_area.JEUNO, "DUTY_FREE_SHOP_DIALOG"},
    {"none", "Port_Jeuno", "Kindlix"},
    {"none", "Port_Jeuno", "Pyropox"},
    -- Rabao
    {"standard", "Rabao", "Brave_Ox", xi.customShop.Brave_Ox, xi.quest.fame_area.SELBINA_RABAO, "BRAVEOX_SHOP_DIALOG"},
    -- Selbina
    {"none", "Selbina", "Falgima"},
    -- Southern Sandoria
    {"standard", "Southern_San_dOria", "Valeriano", xi.customShop.Valeriano, xi.quest.fame_area.SANDORIA, "VALERIANO_SHOP_DIALOG"},
    -- Tavnazian Safehold
    {"nofame", "Tavnazian_Safehold", "Mazuro-Oozuro", xi.customShop.MazuroOozuro, "MAZUROOOZURO_SHOP_DIALOG"},
    -- Upper Jeuno
    {"standard", "Upper_Jeuno", "Antonia", xi.customShop.Antonia, xi.quest.fame_area.JEUNO, "VIETTES_SHOP_DIALOG"},
    -- Windurst Waters  
    {"nation", "Windurst_Waters", "Orez-Ebrez", xi.customShop.OrezEbrez, xi.nation.WINDURST, "OREZEBREZ_SHOP_DIALOG"},
    -- Windurst Woods
    {"nation", "Windurst_Woods", "Mono_Nchaa", xi.customShop.Mono_Nchaa, xi.nation.WINDURST, "MONONCHAA_SHOP_DIALOG"},
    {"standard", "Windurst_Woods", "Valeriano", xi.customShop.Valeriano, xi.quest.fame_area.WINDURST, "VALERIANO_SHOP_DIALOG"},

}

for _, shop in pairs(lookupTable) do
    if shop[1] == 'nation' then
        local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
        m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
        function(player, npc)
            player:showText(npc, ID.text[shop[6]])
            xi.shop.nation(player, shop[4], shop[5])
        end)
    elseif shop[1] =='nofame' then
        local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
        m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
        function(player, npc)
            player:showText(npc, ID.text[shop[5]])
            xi.shop.general(player, shop[4])
        end)
    elseif shop[1] == 'none' then
        m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
        function(player, npc)
        end)
    elseif shop[1] == 'standard' then
        local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
        m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
        function(player, npc)
            player:showText(npc, ID.text[shop[6]])
            xi.shop.general(player, shop[4], shop[5])
        end)
    elseif shop[1] == 'tenshodo' then
        local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
        m:addOverride(string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3]),
        function(player, npc)
            if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
                player:showText(npc, ID.text[shop[6]])
                xi.shop.general(player, shop[4], shop[5])
            end
        end)
    end
end

return m



    


