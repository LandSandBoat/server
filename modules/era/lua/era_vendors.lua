-----------------------------------
-- 75 Era Vendor Shops
-----------------------------------
require("scripts/globals/shop")
require("modules/module_utils")

local m = Module:new("era_vendors")

xi = xi or {}
xi.eraShops = xi.eraShops or {}

-- --------------------------------
-- Bastok
-- --------------------------------
--Bastok Markets
xi.eraShops.Mjoll =
{
    17321,    16, 1, -- Silver Arrow
    17318,     3, 2, -- Wooden Arrow
    17320,     7, 3, -- Iron Arrow
    5069,    199, 3, -- Scroll of Dark Threnody
    5063,   1000, 3, -- Scroll of Ice Threnody
}

xi.eraShops.Charging_Chocobo =
{
    12801, 58738, 1,    -- Mythril Cuisses
    12929, 36735, 1,    -- Mythril Leggings
    12817, 14131, 2,    -- Brass Cuisses
    12800, 34776, 2,    -- Cuisses
    12945,  8419, 2,    -- Brass Greaves
    12928, 21859, 2,    -- Plate Leggings
    13080, 16891, 2,    -- Gorget
    12832,   191, 3,    -- Bronze Subligar
    12816,  1646, 3,    -- Scale Cuisses
    12960,   117, 3,    -- Bronze Leggings
    12944,   998, 3,    -- Scale Greaves
}

xi.eraShops.Zhikkom =
{
    16473,  5713, 1, -- Kukri
    16537, 31648, 1, -- Mythril Sword
    16545, 21535, 1, -- Broadsword
    16513, 11845, 1, -- Tuck
    16558, 62560, 1, -- Falchion
    16536,  7286, 2, -- Iron Sword
    16552,  4163, 2, -- Scimitar
    16466,  2231, 2, -- Knife
    16465,   150, 3, -- Bronze Knife
    16405,   106, 3, -- Cat Baghnakhs
    16535,   246, 3, -- Bronze Sword
    16517,  9406, 3, -- Degen
    16551,   713, 3, -- Sapara
}

xi.eraShops.Peritrage =
{
    17218, 14158, 1, -- Zamburak
    17298,   294, 1, -- Tathlum
    17217,  2166, 2, -- Crossbow
    17337,    22, 2, -- Mythril Bolt
    17216,   165, 3, -- Light Crossbow
    17336,     5, 3, -- Crossbow Bolt
}

xi.eraShops.Ciqala =
{
    16392,  4818, 1, -- Metal Knuckles
    17044,  6033, 1, -- Warhammer
    16643, 11285, 1, -- Battleaxe
    16705,  4186, 1, -- Greataxe
    16391,   828, 2, -- Brass Knuckles
    17043,  2083, 2, -- Brass Hammer
    16641,  1435, 2, -- Brass Axe
    16704,   618, 2, -- Butterfly Axe
    16390,   224, 3, -- Bronze Knuckles
    17042,   312, 3, -- Bronze Hammer
    16640,   290, 3, -- Bronze Axe
    17049,    47, 3, -- Maple Wand
    17088,    58, 3, -- Ash Staff
}

xi.eraShops.Hortense =
{
    4976,    64, 3, -- Scroll of Foe Requiem
    4977,   441, 3, -- Scroll of Foe Requiem II
    4978,  3960, 3, -- Scroll of Foe Requiem III
    4979,  6912, 3, -- Scroll of Foe Requiem IV
    4986,    37, 3, -- Scroll of Army's Paeon
    4987,   321, 3, -- Scroll of Army's Paeon II
    4988,  3240, 3, -- Scroll of Army's Paeon III
    4989,  5940, 3, -- Scroll of Army's Paeon IV
    5002,    21, 3, -- Scroll of Valor Minuet
    5003,  1101, 3, -- Scroll of Valor Minuet II
    5004,  5544, 3, -- Scroll of Valor Minuet III
}

xi.eraShops.Sororo =
{
    4641,  1165, 1, -- Diaga
    4662,  7025, 1, -- Stoneskin
    4664,   837, 1, -- Slow
    4610,   585, 2, -- Cure II
    4636,   140, 2, -- Banish
    4646,  1165, 2, -- Banishga
    4661,  2097, 2, -- Blink
    4609,    61, 3, -- Cure
    4615,  1363, 3, -- Curaga
    4622,   180, 3, -- Poisona
    4623,   324, 3, -- Paralyna
    4624,   990, 3, -- Blindna
    4631,    82, 3, -- Dia
    4651,   219, 3, -- Protect
    4656,  1584, 3, -- Shell
    -- 4721, 29700, 3, -- Repose (WoTG)
    4663,   368, 3, -- Aquaveil
}

-- Port Bastok
xi.eraShops.Valeriano =
{
    4394,     10, -- Ginger Cookie
    17345,    43, -- Flute
    17347,   990, -- Piccolo
    5017,    585, -- Scroll of Scop's Operetta
    5018,  16920, -- Scroll of Puppet's Operetta
    5013,   2916, -- Scroll of Fowl Aubade
    5027,   2059, -- Scroll of Advancing March
    5072,  90000, -- Scroll of Goddess's Hymnus
}

xi.eraShops.Numa =
{
    12457, 5079, 1, -- Cotton Hachimaki
    12585, 7654, 1, -- Cotton Dogi
    12713, 4212, 1, -- Cotton Tekko
    12841, 6133, 1, -- Cotton Sitabaki
    12969, 3924, 1, -- Cotton Kyahan
    13205, 3825, 1, -- Silver Obi
    12456,  759, 2, -- Hachimaki
    12584, 1145, 2, -- Kenpogi
    12712,  630, 2, -- Tekko
    12840,  915, 2, -- Sitabaki
    12968,  584, 2, -- Kyahan
    704,    132, 2, -- Bamboo Stick
    605,    180, 3, -- Pickaxe
}

-- Metalworks
xi.eraShops.Nogga =
{
    17316,  675, 2, -- Bomb Arm
    17313, 1083, 3, -- Grenade
}


-- Sandoria --
-- Northern Sandy
xi.eraShops.Arlenne =
{
    17051,  1409, 1, -- Yew Wand
    17090,  3245, 1, -- Elm Staff
    17097, 16416, 1, -- Elm Pole
    16835, 15876, 1, -- Spear
    16845, 16578, 1, -- Lance
    16770, 11286, 1, -- Zaghnal
    17050,   333, 2, -- Willow Wand
    17089,   571, 2, -- Holly Staff
    17096,  4568, 2, -- Holly Pole
    16834,  4680, 2, -- Brass Spear
    16769,  2542, 2, -- Brass Zaghnal
    17049,    46, 3, -- Maple Wand
    17088,    57, 3, -- Ash Staff
    16833,   792, 3, -- Brass Baghnakhs
    16768,   309, 3, -- Bronze Zaghnal
}

xi.eraShops.Tavourine =
{
    16584, 37800, 1,    -- Mythril Claymore
    16466,  2182, 1,    -- Knife
    17060,  2386, 1,    -- Rod
    16640,   284, 2,    -- Bronze Axe
    16465,   147, 2,    -- Bronze Knife
    17059,    91, 2,    -- Bronze Rod
    16583,  2448, 2,    -- Claymore
    17035,  4363, 2,    -- Mace
    17081,   627, 3,    -- Brass Rod
    17034,   169, 3,    -- Bronze Mace
}

xi.eraShops.Pirvidiauce =
{
    12986, 9180, 1, -- Chestnut Sabbots
    4128,  4445, 1, -- Ether
    4112,   837, 1, -- Potion
    17336,    6, 2, -- Crossbow bolt
    4151,   720, 2, -- Echo Drops
    12985, 1462, 2, -- Holly Clogs
    4148,   284, 3, -- Antidote
    12984,  111, 3, -- Ash Clogs
    219,    900, 3, -- Ceramic Flowerpot
    4150,  2335, 3, -- Eye Drops
    1774,  1984, 3, -- Red Gravel
    17318,    3, 3, -- Wooden Arrow
}

xi.eraShops.Coullave =
{
    4128,  4445, 1, -- Ether
    17313, 1107, 1, -- Grenade
    12456,  552, 1, -- Hachimaki
    12584,  833, 1, -- Kenpogi
    12968,  424, 1, -- Kyahan
    4112,   837, 1, -- Potion
    12712,  458, 1, -- Tekko
    12840,  666, 1, -- Sitabaki
    704,     96, 2, -- Bamboo Stick
    4151,   736, 2, -- Echo Drops
    4148,   290, 3, -- Antidote
    4150,  2387, 3, -- Eye Drops
    13469, 1150, 3, -- Leather Ring
}

-- Southern Sandoria
xi.eraShops.Ashene =
{
    16455,  4309, 1, -- Baselard
    16532, 16934, 1, -- Gladius
    16545, 21067, 1, -- Broadsword
    16576, 35769, 1, -- Hunting Sword
    16524, 13406, 1, -- Fleuret
    16450,  1827, 2, -- Dagger
    16536,  7128, 2, -- Iron Sword
    16566,  8294, 2, -- Longsword
    16385,   129, 3, -- Cesti
    16448,   140, 3, -- Bronze Dagger
    16449,   837, 3, -- Brass Dagger
    16531,  3523, 3, -- Brass Xiphos
    16535,   241, 3, -- Bronze Sword
    16565,  1674, 3, -- Spatha
}

xi.eraShops.Carautia =
{
    12808, 11340, 1, -- Chain Hose
    12936,  6966, 1, -- Greaves
    12306, 10281, 1, -- Kite Shield
    12292,  4482, 2, -- Mahogany Shield
    12826, 16552, 2, -- Studded Trousers
    12954, 10054, 2, -- Studded Boots
    12290,   544, 3, -- Maple Shield
    12832,   187, 3, -- Bronze Subligar
    12833,  1800, 3, -- Brass Subligar
    12824,   482, 3, -- Leather Trousers
    12960,   115, 3, -- Bronze Leggings
    12961,  1116, 3, -- Brass Leggings
    12952,   302, 3, -- Leather Highboots
}

xi.eraShops.Ferdoulemiont =
{
    845,   1125, 1, -- Black Chocobo Feather
    17307,    9, 2, -- Dart
    17862,  680, 3, -- Bug Broth
    17866,  680, 3, -- Carrion Broth
    17860,   81, 3, -- Carrot Broth
    17864,  124, 3, -- Herbal Broth
    840,      7, 3, -- Chocobo Feather
    4545,    61, 3, -- Gysahl Greens
    17016,   10, 3, -- Pet Food Alpha Biscuit
    17017,   81, 3, -- Pet Food Beta Biscuit
    5073, 49680, 3, -- Scroll of Chocobo Mazurka
    4997,    16, 3, -- Scroll of Knight's Minne
    4998,   864, 3, -- Scroll of Knight's Minne II
    4999,  5148, 3, -- Scroll of Knight's Minne III
    2343,  1984, 3, -- La Theine Millet
}

xi.eraShops.Benaige =
{
    628,   234, 1, -- Cinnamon
    629,    43, 1, -- Millioncorn
    622,    43, 2, -- Dried Marjoram
    610,    54, 2, -- San d'Orian Flour
    1840, 1800, 2, -- Semolina
    627,    36, 2, -- Maple Sugar
    621,    25, 3, -- Crying Mustard
    611,    36, 3, -- Rye Flour
    936,    14, 3, -- Rock Salt
    4509,   10, 3, -- Distilled Water
    5234,  198, 3, -- Cibol
}

xi.eraShops.Ostalie =
{
    4128,  4445, 1,    -- Ether
    4112,   837, 1,    -- Potion
    4151,   736, 2,    -- Echo Drops
    4148,   290, 3,    -- Antidote
    12472,  144, 3,    -- Circlet
    12728,  118, 3,    -- Cuffs
    4150,  2387, 3,    -- Eye Drops
    1021,   450, 3,    -- Hatchet
    13192,  382, 3,    -- Leather Belt
    13193, 2430, 3,    -- Lizard Belt
    605,    180, 3,    -- Pickaxe
    12600,  216, 3,    -- Robe
    12856,  172, 3,    -- Slops
}

-- Windurst
xi.eraShops.HohbibaMubiba =
{
    17051,  1440, 1, -- Yew Wand
    17090,  3642, 1, -- Elm Staff
    17097, 18422, 1, -- Elm Pole
    17059,    91, 1, -- Bronze Rod
    17050,   340, 2, -- Willow Wand
    17026,  4945, 2, -- Bone Cudgel
    17089,   584, 2, -- Holly Staff
    17096,  4669, 2, -- Holly Pole
    17049,    47, 3, -- Maple Wand
    17024,    66, 3, -- Ash Club
    17025,  1600, 3, -- Chestnut Club
    17088,    58, 3, -- Ash Staff
    17095,   386, 3, -- Ash Pole
    16448,   140, 3, -- Bronze Dagger
}

xi.eraShops.TanikoManiko =
{
    16769, 2542, 1, -- Brass Zaghnal
    17154, 7999, 1, -- Wrapped Bow
    17323,  141, 1, -- Ice Arrow
    17324,  141, 1, -- Lighning Arrow
    16405,  104, 2, -- Cat Baghnakhs
    16385,  129, 2, -- Cesti
    16649, 5864, 2, -- Bone Pick
    17153,  493, 2, -- Self Bow
    17318,    3, 2, -- Wooden Arrow
    17308,   55, 2, -- Hawkeye
    17280, 1610, 2, -- Boomerang
    16642, 4198, 3, -- Bone Axe
    16768,  309, 3, -- Bronze Zaghnal
    16832,   97, 3, -- Harpoon
    17152,   40, 3, -- Bone Axe
    17319,    4, 3, -- Bone Arrow
}

xi.eraShops.GurunaMaguruna =
{
    13090,  4714, 1, -- Beetle Gorget
    12601,  2776, 1, -- Linen Robe
    12729,  1570, 1, -- Linen Cuffs
    12608,  1260, 2, -- Tunic
    12593, 12355, 2, -- Cotton Doublet
    12696,   324, 2, -- Leather Gloves
    12736,   589, 2, -- Mitts
    12721,  6696, 2, -- Cotton Gloves
    13085,   972, 3, -- Hemp Gorget
    12592,  2470, 3, -- Doublet
    12600,   216, 3, -- Robe
    12568,   604, 3, -- Leather Vest
    12720,  1363, 3, -- Gloves
    12728,   118, 3, -- Cuffs
}

xi.eraShops.Kumama =
{
    12857, 2268, 1, -- Linen Slops
    12985, 1462, 1, -- Holly Clogs
    12292, 4481, 1, -- Mahogony Shield
    12824,  482, 2, -- Leather Trousers
    12849, 9936, 2, -- Cotton Brais
    12952,  309, 2, -- Leather Highboots
    12992,  544, 2, -- Solea
    12977, 6633, 2, -- Cotton Gaiters
    12290,  556, 2, -- Maple Shield
    12848, 1899, 3, -- Brais
    12856,  172, 3, -- Slops
    12976, 1269, 3, -- Gaiters
    12984,  111, 3, -- Ash Clogs
    12289,  110, 3, -- Lauan Shield
}

-- Windurst Woods
xi.eraShops.WijeTiren =
{
    4148,   290,       --Antidote
    4509,    10,       --Distilled Water
    4151,   728,       --Echo Drops
    4128,  4445,       --Ether
    4150,  2387,       --Eye Drops
    4112,   837,       --Potion
    5014,    98,       --Scroll of Herb Pastoral
}

xi.eraShops.Creepstix =
{
    5023,   8160, -- Scroll of Goblin Gavotte
    4734,   7074, -- Scroll of Protectra II
    4738,   1700, -- Scroll of Shellra
}

xi.eraShops.Hasim =
{
    4668,   1760, -- Scroll of Barfire
    4669,   3624, -- Scroll of Barblizzard
    4670,    930, -- Scroll of Baraero
    4671,    156, -- Scroll of Barstone
    4672,   5754, -- Scroll of Barthunder
    4673,    360, -- Scroll of Barwater
    4674,   1760, -- Scroll of Barfira
    4675,   3624, -- Scroll of Barblizzara
    4676,    930, -- Scroll of Baraera
    4677,    156, -- Scroll of Barstonra
    4678,   5754, -- Scroll of Barthundra
    4679,    360, -- Scroll of Barwatera
    4680,    244, -- Scroll of Barsleep
    4612,  23400, -- Scroll of Cure IV
    4616,  11200, -- Scroll of Curaga II
    4617,  19932, -- Scroll of Curaga III
    4653,  32000, -- Scroll of Protect III
}

xi.eraShops.Stinknix =
{
    943,    294, -- Poison Dust
    944,   1035, -- Venom Dust
    945,   2000, -- Paralysis Dust
    17320,    7, -- Iron Arrow
    17336,    5, -- Crossbow Bolt
    17313, 1107, -- Grenade
}

xi.eraShops.Susu =
{
    4647, 20000, -- Scroll of Banishga II
    4683,  2030, -- Scroll of Barblind
    4697,  2030, -- Scroll of Barblindra
    4682,   780, -- Scroll of Barparalyze
    4696,   780, -- Scroll of Barparalyzra
    4681,   400, -- Scroll of Barpoison
    4695,   400, -- Scroll of Barpoisonra
    4684,  4608, -- Scroll of Barsilence
    4698,  4608, -- Scroll of Barsilencera
    4680,   244, -- Scroll of Barsleep
    4694,   244, -- Scroll of Barsleepra
    4628,  8586, -- Scroll of Cursna
    4629, 35000, -- Scroll of Holy
    4625,  2330, -- Scroll of Silena
    4626, 19200, -- Scroll of Stona
    4627, 13300, -- Scroll of Viruna
}

xi.eraShops.Taza =
{
    4881, 10304, -- Scroll of Sleepga
    4658, 26244, -- Scroll of Shell III
    4735, 19200, -- Scroll of Protectra III
    4739, 14080, -- Scroll of Shellra II
    4740, 26244, -- Scroll of Shellra III
    4685, 15120, -- Scroll of Barpetrify
    4686,  9600, -- Scroll of Barvirus
    4699, 15120, -- Scroll of Barpetra
    4700,  9600, -- Scroll of Barvira
    4867, 18720, -- Scroll of Sleep II
    4769, 19932, -- Scroll of Stone III
    4779, 22682, -- Scroll of Water III
    4764, 27744, -- Scroll of Aero III
    4754, 33306, -- Scroll of Fire III
    4759, 39368, -- Scroll of Blizzard III
    4774, 45930, -- Scroll of Thunder III
}

-- Upper Jeuno
xi.eraShops.Coumuna =
{
    16705,  4550, -- Greataxe
    16518, 31000, -- Mythril Degen
    16460, 12096, -- Kris
    16467, 14560, -- Mythril Knife
    16399, 15488, -- Katars
    16589, 13962, -- Two-Handed Sword
    16412, 29760, -- Mythril Claws
    16567, 85250, -- Knight's Sword
}

xi.eraShops.Areebah =
{
    636,  119, -- Chamomile
    951,  110, -- Wijnruit
    948,   60, -- Carnation
    941,   80, -- Red Rose
    949,   96, -- Rain Lily
    956,  120, -- Lilac
    957,  120, -- Amaryllis
    958,  120, -- Marguerite
}

--Kazham
xi.eraShops.TojiMumosulah =
{
    112,    456, -- Yellow Jar
    13199,   95, -- Blood Stone
    13076, 3510, -- Fang Necklace
    13321, 1667, -- Bone Earring
    17351, 4747, -- Gemshorn
    16993,   69, -- Peeled Crayfish
    16998,   36, -- Insect Paste
    17876,  165, -- Fish Broth
    17880,  695, -- Seedbed Soil
    1021,   450, -- Hatchet
    4987,   328, -- Scroll of Army's Paeon II
    4988,  3312, -- Scroll of Army's Paeon III
}

-- Rulude Gardens
xi.eraShops.DabihJajalioh =
{
    957,     120, -- Amaryllis
    948,      60, -- Carnation
    636,     119, -- Chamomile
    956,     120, -- Lilac
    958,     120, -- Marguerite
    949,      96, -- Rain Lily
    941,      80, -- Red Rose
    951,     110, -- Wijnruit
}

-- Mhaura
xi.eraShops.PikiniMikini =
{
    4150, 2335,    -- Eye Drops
    4148,  284,    -- Antidote
    4151,  720,    -- Echo Drops
    4112,  819,    -- Potion
    4509,   10,    -- Distilled Water
    917,  1821,    -- Parchment
    4716,  3974,   -- Regen
    4718,  7203,   -- Regen II
    4881,  10304,  -- Sleepga
    17395,   9,    -- Lugworm
    1021,  450,    -- Hatchet
    4376,  108,    -- Meat Jerky
    5299,  133,    -- Salsa
}

-- Selbina
xi.eraShops.Dohdjuma =
{
    611,    36,    -- Rye Flour
    5011,  233,    -- Scroll of Sheepfoe Mambo
    4150, 2335,    -- Eye Drops
    4148,  284,    -- Antidote
    4509,   10,    -- Distilled Water
    4112,  819,    -- Potion
    17395,  10,    -- Lugworm
    4378,   54,    -- Selbina Milk
    4490,  432,    -- Pickled Herring
    4559, 4485,    -- Herb Quus
}

--Nashmau
xi.eraShops.Mamaroon =
{
    4860,  27000, -- Scroll of Stun
    4708,   5160, -- Scroll of Enfire
    4709,   4098, -- Scroll of Enblizzard
    4710,   2500, -- Scroll of Enaero
    4711,   2030, -- Scroll of Entone
    4712,   1515, -- Scroll of Enthunder
    4713,   7074, -- Scroll of Enwater
    4859,   9000, -- Scroll of Shock Spikes
    2502,  29950, -- White Puppet Turban
    2501,  29950, -- Black Puppet Turban
}

xi.eraShops.Yoyoroon =
{
    2239,  4940, -- Tension Spring
    2243,  4940, -- Loudspeaker
    2246,  4940, -- Accelerator
    2251,  4940, -- Armor Plate
    2254,  4940, -- Stabilizer
    2258,  4940, -- Mana Jammer
    2262,  4940, -- Auto-Repair Kit
    2266,  4940, -- Mana Tank
    2240,  9925, -- Inhibitor
    2242,  9925, -- Mana Booster
    2247,  9925, -- Scope
    2250,  9925, -- Shock Absorber
    2255,  9925, -- Volt Gun
    2260,  9925, -- Stealth Screen
    2264,  9925, -- Damage Gauge
    2268,  9925, -- Mana Conserver
}

-- Norg
xi.eraShops.SolbyMaholby =
{
    17395,     9, -- Lugworm
    4899,    450, -- Earth Spirit Pact
}


-- Port Jeuno
xi.eraShops.Gekko =
{
    4150,  2387, -- Eye Drops
    4148,   290, -- Antidote
    4151,   720, -- Echo Drops
    4112,   837, -- Potion
    4128,  4445, -- Ether
    4365,   120, -- Rolanberry
    189,  36000, -- Autumn's End
    188,  31224, -- Acolyte's Grief
}

-- Rabao
xi.eraShops.Brave_Ox =
{
    4654,  77350, -- Protect IV
    4736,  73710, -- Protectra IV
    4868,  63700, -- Dispel
    4860,  31850, -- Stun
    4720,  31850, -- Flash
    4750, 546000, -- Reraise III
    4638,  78260, -- Banish III
    -- 4701, 20092, -- Cura
    -- 4702, 62192, -- Sacrifice
    -- 4703, 64584, -- Esuna
    -- 4704, 30967, -- Auspice
}

-- Upper Jeuno
xi.eraShops.Antonia =
{
    17061,  6256, -- Mythril Rod
    17027, 11232, -- Oak Cudgel
    17036, 18048, -- Mythril Mace
    17044,  6033, -- Warhammer
    17098, 37440, -- Oak Pole
    16836, 44550, -- Halberd
    16774, 10596, -- Scythe
    17320,     7, -- Iron Arrow
}

-- Windurst Waters
xi.eraShops.OrezEbrez =
{
    12466, 20000,1, --Red Cap
    12458,  8972,1, --Soil Hachimaki
    12455,  7026,1, --Beetle Mask
    12472,   144,2, --Circlet
    12465,  8024,2, --Cotton Headgear
    12440,   396,2, --Leather Bandana
    12473,  1863,2, --Poet's Circlet
    12499, 14400,2, --Flax Headband
    12457,  3272,2, --Cotton Hachimaki
    12454,  3520,2, --Bone Mask
    12474, 10924,2, --Wool Hat
    12464,  1742,3, --Headgear
    12456,   552,3, --Hachimaki
    12498,  1800,3, --Cotton Headband
    12448,   151,3, --Bronze Cap
    12449,  1471,3, --Brass Cap
}

-- Windurst Woods
xi.eraShops.Mono_Nchaa =
{
    17318,    3, 2, -- Wooden Arrow
    17308,   55, 2, -- Hawkeye
    17216,  165, 2, -- Light Crossbow
    17319,    4, 3, -- Bone Arrow
    17336,    5, 3, -- Crossbow Bolt
    5009,  2649, 3, -- Scroll of Hunter's Prelude
}


local lookupTable =
--[[
    Nation: {"nation",Zone,NPCName,customShopTable,nation,DIALOG_NAME}
    No Fame: {"nofame",Zone,NPCName,customShopTable,DIALOG_NAME}
    No Shop: {"none",Zone,NPCName}
    Standard: {"standard",Zone,NPCName,customShopTable,fameArea,DIALOG_NAME}
    Tenshodo: {"tenshodo",Zone,NPCName,customShopTable,fameArea,DIALOG_NAME}
--]]

{
    -- Bastok
    {"nation", "Bastok_Markets", "Mjoll", xi.eraShops.Mjoll, xi.nation.BASTOK, "MJOLL_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Charging_Chocobo", xi.eraShops.Charging_Chocobo, xi.nation.BASTOK, "CHARGINGCHOCOBO_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Zhikkom", xi.eraShops.Zhikkom, xi.nation.BASTOK, "ZHIKKOM_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Peritrage", xi.eraShops.Peritrage, xi.nation.BASTOK, "PERITRAGE_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Ciqala", xi.eraShops.Ciqala, xi.nation.BASTOK, "CIQALA_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Hortense", xi.eraShops.Hortense, xi.nation.BASTOK, "HORTENSE_SHOP_DIALOG", 1},
    {"nation", "Bastok_Markets", "Sororo", xi.eraShops.Sororo, xi.nation.BASTOK, "SORORO_SHOP_DIALOG", 1},
    {"standard", "Port_Bastok", "Valeriano", xi.eraShops.Valeriano, xi.quest.fame_area.BASTOK, "VALERIANO_SHOP_DIALOG", 1},
    {"nation", "Port_Bastok", "Numa", xi.eraShops.Numa, xi.nation.BASTOK, "NUMA_SHOP_DIALOG", 1},
    {"nation", "Metalworks", "Nogga", xi.eraShops.Nogga, xi.nation.BASTOK, "NOGGA_SHOP_DIALOG", 1},

    -- Sandoria
    {"nation", "Northern_San_dOria", "Arlenne", xi.eraShops.Arlenne, xi.nation.SANDORIA, "ARLENNE_SHOP_DIALOG", 1},
    {"nation", "Northern_San_dOria", "Tavourine", xi.eraShops.Tavourine, xi.nation.SANDORIA, "TAVOURINE_SHOP_DIALOG", 1},
    {"nation", "Northern_San_dOria", "Pirvidiauce", xi.eraShops.Pirvidiauce, xi.nation.SANDORIA, "PIRVIDIAUCE_SHOP_DIALOG", 1},
    {"nation", "Port_San_dOria", "Coullave", xi.eraShops.Coullave, xi.nation.SANDORIA, "COULLAVE_SHOP_DIALOG", 1},
    {"nation", "Southern_San_dOria", "Ashene", xi.eraShops.Ashene, xi.nation.SANDORIA, "ASH_THADI_ENE_SHOP_DIALOG", 1},
    {"nation", "Southern_San_dOria", "Carautia", xi.eraShops.Carautia, xi.nation.SANDORIA, "CARAUTIA_SHOP_DIALOG", 1},
    {"nation", "Southern_San_dOria", "Ferdoulemiont", xi.eraShops.Ferdoulemiont, xi.nation.SANDORIA, "FERDOULEMIONT_SHOP_DIALOG", 1},
    {"nation", "Southern_San_dOria", "Benaige", xi.eraShops.Benaige, xi.nation.SANDORIA, "BENAIGE_SHOP_DIALOG", 1},
    {"nation", "Southern_San_dOria", "Ostalie", xi.eraShops.Ostalie, xi.nation.SANDORIA, "OSTALIE_SHOP_DIALOG", 1},
    {"standard", "Southern_San_dOria", "Valeriano", xi.eraShops.Valeriano, xi.quest.fame_area.SANDORIA, "VALERIANO_SHOP_DIALOG", 1},

    -- Windurst
    {"nation", "Port_Windurst", "Hohbiba-Mubiba", xi.eraShops.HohbibaMubiba, xi.nation.WINDURST, "HOHBIBAMUBIBA_SHOP_DIALOG", 1},
    {"nation", "Port_Windurst", "Taniko-Maniko", xi.eraShops.TanikoManiko, xi.nation.WINDURST, "TANIKOMANIKO_SHOP_DIALOG", 1},
    {"nation", "Port_Windurst", "Guruna-Maguruna", xi.eraShops.GurunaMaguruna, xi.nation.WINDURST, "GURUNAMAGURUNA_SHOP_DIALOG", 1},
    {"nation", "Port_Windurst", "Kumama", xi.eraShops.Kumama, xi.nation.WINDURST, "KUMAMA_SHOP_DIALOG", 1},
    {"nation", "Windurst_Waters", "Orez-Ebrez", xi.eraShops.OrezEbrez, xi.nation.WINDURST, "OREZEBREZ_SHOP_DIALOG", 1},
    {"nation", "Windurst_Woods", "Mono_Nchaa", xi.eraShops.Mono_Nchaa, xi.nation.WINDURST, "MONONCHAA_SHOP_DIALOG", 1},
    {"standard", "Windurst_Woods", "Wije_Tiren", xi.eraShops.WijeTiren, xi.quest.fame_area.WINDURST, "WIJETIREN_SHOP_DIALOG", 1},
    {"standard", "Windurst_Woods", "Valeriano", xi.eraShops.Valeriano, xi.quest.fame_area.WINDURST, "VALERIANO_SHOP_DIALOG", 1},

    -- Jeuno
    {"standard", "Lower_Jeuno", "Creepstix", xi.eraShops.Creepstix, nil, "JUNK_SHOP_DIALOG", 1},
    {"standard", "Lower_Jeuno", "Hasim", xi.eraShops.Hasim, nil, "WAAG_DEEG_SHOP_DIALOG", 1},
    {"standard", "Lower_Jeuno", "Susu", xi.eraShops.Susu, nil, "WAAG_DEEG_SHOP_DIALOG", 1},
    {"standard", "Lower_Jeuno", "Stinknix", xi.eraShops.Stinknix, nil, "JUNK_SHOP_DIALOG", 1},
    {"standard", "Lower_Jeuno", "Taza", xi.eraShops.Taza, nil, "WAAG_DEEG_SHOP_DIALOG", 1},
    {"standard", "Upper_Jeuno", "Antonia", xi.eraShops.Antonia, nil, "VIETTES_SHOP_DIALOG", 1},
    {"standard", "Upper_Jeuno", "Coumuna", xi.eraShops.Coumuna, nil, "VIETTES_SHOP_DIALOG", 1},
    {"standard", "Upper_Jeuno", "Areebah", xi.eraShops.Areebah, xi.quest.fame_area.JEUNO, "MP_SHOP_DIALOG", 1},
    {"standard", "RuLude_Gardens", "Dabih_Jajalioh", xi.eraShops.DabihJajalioh, xi.quest.fame_area.JEUNO, "DABIHJAJALIOH_SHOP_DIALOG", 1},
    {"standard", "Port_Jeuno", "Gekko", xi.eraShops.Gekko, xi.quest.fame_area.JEUNO, "DUTY_FREE_SHOP_DIALOG", 1},
    -- Mhaura
    {"standard", "Mhaura", "Pikini-Mikini", xi.eraShops.PikiniMikini, xi.quest.fame_area.WINDURST, "PIKINIMIKINI_SHOP_DIALOG", 1},
    -- Selbina
    {"standard", "Selbina", "Dohdjuma", xi.eraShops.Dohdjuma, xi.quest.fame_area.SELBINA_RABAO, "DOHDJUMA_SHOP_DIALOG", 1},
    -- Kazham
    {"standard", "Kazham", "Toji_Mumosulah", xi.eraShops.TojiMumosulah, xi.quest.fame_area.WINDURST, "TOJIMUMOSULAH_SHOP_DIALOG", 1},
    -- Norg
    {"standard", "Norg", "Solby-Maholby", xi.eraShops.SolbyMaholby, xi.quest.fame_area.NORG, "SOLBYMAHOLBY_SHOP_DIALOG", 1},
    -- Rabao
    {"standard", "Rabao", "Brave_Ox", xi.eraShops.Brave_Ox, nil, "BRAVEOX_SHOP_DIALOG", 1},
    -- Nashmau
    {"nofame", "Nashmau", "Mamaroon", xi.eraShops.Mamaroon, "MAMAROON_SHOP_DIALOG", xi.settings.main.ENABLE_TOAU},
    {"nofame", "Nashmau", "Yoyoroon", xi.eraShops.Yoyoroon, "YOYOROON_SHOP_DIALOG", xi.settings.main.ENABLE_TOAU},
}

for _, shop in pairs(lookupTable) do
    local ID = require(string.format("scripts/zones/%s/IDs", shop[2]))
    local onTrigger = string.format("xi.zones.%s.npcs.%s.onTrigger", shop[2], shop[3])
    if
    shop[1] == 'nation' and
    shop[7] == 1
    then
        m:addOverride(onTrigger,
        function(player, npc)
            player:showText(npc, ID.text[shop[6]])
            xi.shop.nation(player, shop[4], shop[5])
        end)
    elseif
        shop[1] =='nofame' and
        shop[7] == 1
    then
        m:addOverride(onTrigger,
        function(player, npc)
            player:showText(npc, ID.text[shop[5]])
            xi.shop.general(player, shop[4])
        end)
    elseif
        shop[1] == 'none' and
        shop[4] == 1
    then
        m:addOverride(onTrigger,
        function(player, npc)
        end)
    elseif
        shop[1] == 'standard' and
        shop[7] == 1
    then
        m:addOverride(onTrigger,
        function(player, npc)
            player:showText(npc, ID.text[shop[6]])
            xi.shop.general(player, shop[4], shop[5])
        end)
    elseif
        shop[1] == 'tenshodo' and
        shop[7] == 1
    then
        m:addOverride(onTrigger,
        function(player, npc)
            if player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
                player:showText(npc, ID.text[shop[6]])
                xi.shop.general(player, shop[4], shop[5])
            end
        end)
    end
end

return m