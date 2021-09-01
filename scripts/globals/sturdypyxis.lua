-----------------------------------
-- Abyssea Sturdy Pyxis
-- Spawn conditions type and size.
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.chestType =
{
    BLUE = 1,
    RED  = 2,
    GOLD = 3,
}


xi.pyxis.chestData =
  --                                                               Light <= Tier
{ --                              MID
    [xi.pyxis.chestType.BLUE] = { 965, xi.abyssea.lightType.AZURE, { 101, 153, 204, 254 } },
    [xi.pyxis.chestType.RED ] = { 968, xi.abyssea.lightType.RUBY,  { 101, 153, 204, 254 } },
    [xi.pyxis.chestType.GOLD] = { 969, xi.abyssea.lightType.AMBER, {  79, 120, 160, 199 } },
}

xi.pyxis.contentMessage =
{
------------------------------------------------------
-- | Key | Value |          Description           | --
------------------------------------------------------
    [1]  = 0x0010000, -- Feeble soothing light
    [2]  = 0x0020000, -- Miniscule curor
    [3]  = 0x0030000, -- Tiny exp
    [4]  = 0x0050000, -- Faint soothing light
    [5]  = 0x0060000, -- Small cruor
    [6]  = 0x0070000, -- little exp
    [7]  = 0x0090000, -- Mild soothing light
    [8]  = 0x00A0000, -- Moderate cruor
    [9]  = 0x00B0000, -- Some exp
    [10] = 0x00D0000, -- Strong soothing light
    [11] = 0x00E0000, -- Considerable cruor
    [12] = 0x00F0000, -- Considerable exp
    [13] = 0x0110000, -- Intense soothing light
    [14] = 0x0120000, -- Numerous temp items {Does NOT show items when peering into chest, just drops what ever into inventory like normal chests}
    [15] = 0x0130000, -- Princely crour
    [16] = 0x0140000, -- Tremendous exp
    [17] = 0x0150000, -- Stone fragment {Time Extension}
    [18] = 0x0160000, -- Faint Pearl light
    [19] = 0x0170000, -- Faint Azure light
    [20] = 0x0180000, -- Faint Ruby light
    [21] = 0x0190000, -- Faint Amber light
    [22] = 0x01A0000, -- Mild Pearl light
    [23] = 0x01B0000, -- Mild Azure light
    [24] = 0x01C0000, -- Mild Ruby light
    [25] = 0x01D0000, -- Mild Amber light
    [26] = 0x01E0000, -- Strong Pearl light
    [27] = 0x01F0000, -- Strong Azure light
    [28] = 0x0200000, -- Strong Ruby light
    [29] = 0x0210000, -- Strong Amber light
    [30] = 0x0220000, -- Faint Gold light
    [31] = 0x0230000, -- Faint Silver light
    [32] = 0x0240000, -- Faint Ebon light
    [33] = 0x0250000, -- Intense Azure light
    [34] = 0x0260000, -- Intense Ruby light
    [35] = 0x0270000, -- Intense Amber light
    [36] = 0x0280000, -- Mild Gold light
    [37] = 0x0290000, -- Mild Silver light
    [38] = 0x02A0000, -- Mild Ebon light
    [39] = 0x02B0000, -- Strong Gold light
    [40] = 0x02C0000, -- Strong Silver light
    [41] = 0x02D0000, -- Strong Ebon light
    [42] = 0x1000000, -- Temp items
    [43] = 0x2000000, -- Items
    [44] = 0x3000000, -- Poweful items
    [45] = 0x4000000, -- Key items
    -- Total 45
}

xi.pyxis.lightsMessage =
{
    [xi.abyssea.lightType.PEARL  ] = { 18, 18, 22, 22, 26 },
    [xi.abyssea.lightType.GOLDEN ] = { 30, 30, 36, 36, 39 },
    [xi.abyssea.lightType.SILVERY] = { 31, 31, 37, 37, 40 },
    [xi.abyssea.lightType.EBON   ] = { 32, 32, 38, 38, 41 },
    [xi.abyssea.lightType.AZURE  ] = { 19, 19, 23, 27, 33 },
    [xi.abyssea.lightType.RUBY   ] = { 20, 20, 24, 28, 34 },
    [xi.abyssea.lightType.AMBER  ] = { 21, 21, 25, 29, 35 },
}

xi.pyxis.expmessage =
{
    [1] = 3,
    [2] = 6,
    [3] = 9,
    [4] = 12,
    [5] = 16,
}

xi.pyxis.cruormessage =
{
    [1] = 2,
    [2] = 5,
    [3] = 8,
    [4] = 11,
    [5] = 15,
}

xi.pyxis.soothinglightmessage =
{
    [1] = 1,
    [2] = 4,
    [3] = 7,
    [4] = 10,
    [5] = 13,
}

xi.pyxis.droptypes =
{
    [1]  = "tempitems",
    [2]  = "items",
    [3]  = "augments",
    [4]  = "keyitems",
    [5]  = "lights",
    [6]  = "restore",
    [7]  = "cruor",
    [8]  = "time",
    [9]  = "exp",
    [10] = "autotempitems",
}

---------------------------------
-- drop id's for temp items
-- use zone id as the key
---------------------------------
xi.pyxis.tempdrops =
{
    [1] = {4206,4254,5394,5397,5433,5824,5827},
    [2] = {4206,4254,5394,5397,5433,5824,5827,5440,5835,5837,5839,5841,5843,5850,5849},
    [3] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852},
    [4] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851},
    [5] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851,4146,4202,5845},
}

---------------------------------
-- drop id's for augmented items
-- uses zone id as the key
---------------------------------
xi.pyxis.augdrops =
{
    [15]  = { 14644, 12324, 16128 }, -- ABYSSEA_KONSCHTAT
    [45]  = { 12420, 13464, 16265 }, -- ABYSSEA_TAHRONGI
    [132] = { 13087, 13925, 13212 }, -- ABYSSEA_LA_THEINE
    [215] = { 19309, 11932, 11880 }, -- ABYSSEA_ATTOHWA
    [216] = { 11424, 18963, 11684 }, -- ABYSSEA_MISAREAUX
    [217] = { 13450, 11878, 11428 }, -- ABYSSEA_VUNKERL
    [218] = { 17664, 19310, 19267 }, -- ABYSSEA_ALTEPA
    [253] = { 18964, 18774, 18875 }, -- ABYSSEA_ULEGUERAND
    [254] = { 16660, 16485, 16971 }, -- ABYSSEA_GRAUBERG
}

---------------------------------------------------------------------------------------------
-- augs table holds potential augments with min/max values to be randomised for each item id
-- example: Tarutaru sash [13212] would have 6 potential augments, each with its own values
---------------------------------------------------------------------------------------------
xi.pyxis.augs =
{
    [14644] = {augments = {{aug=42,  min=1, max=3 }, {aug=56,  min=1, max=6 }, {aug=33,  min=2, max=4 }, {aug=53,  min=1, max=5 }, {aug=55,  min=1, max=6 }, {aug=54,  min=1, max=6 }                                                                                                        }}, -- Dark Ring
    [12324] = {augments = {{aug=1,   min=2, max=17}, {aug=180, min=1, max=4 }, {aug=181, min=1, max=5 }, {aug=188, min=1, max=5 }, {aug=153, min=1, max=2 }, {aug=39,  min=1, max=2 }                                                                                                        }}, -- Tower Shield
    [16128] = {augments = {{aug=771, min=1, max=10}, {aug=773, min=1, max=10}, {aug=769, min=1, max=10}, {aug=775, min=1, max=10}, {aug=9,   min=10,max=16}, {aug=138, min=1, max=2 }                                                                                                        }}, -- Wivre Hairpin
    [12420] = {augments = {{aug=774, min=1, max=9 }, {aug=137, min=1, max=3 }, {aug=188, min=1, max=5 }, {aug=53,  min=1, max=3 }, {aug=329, min=2, max=5 }, {aug=137, min=1, max=1 }, {aug=1,   min=1, max=16}                                                                              }}, -- Adaman Barbuta
    [13464] = {augments = {{aug=791, min=7, max=9 }, {aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=183, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=335, min=1, max=3 }, {aug=133, min=1, max=3 }                                                                              }}, -- Demon's Ring
    [16265] = {augments = {{aug=1,   min=3, max=5 }, {aug=9,   min=2, max=5 }, {aug=513, min=1, max=3 }, {aug=195, min=2, max=5 }, {aug=772, min=3, max=4 }, {aug=41,  min=1, max=2 }                                                                                                        }}, -- Wivre Gorget
    [13087] = {augments = {{aug=1,   min=1, max=15}, {aug=9,   min=1, max=15}, {aug=518, min=1, max=4 }, {aug=517, min=1, max=4 }, {aug=516, min=1, max=4 }, {aug=51,  min=1, max=3 }, {aug=52,  min=1, max=3 }, {aug=140, min=1, max=3 }, {aug=141, min=1, max=3 }                          }}, -- Jeweled Collar
    [13925] = {augments = {{aug=768, min=1, max=4 }, {aug=182, min=1, max=5 }, {aug=183, min=2, max=4 }, {aug=198, min=1, max=5 }, {aug=31,  min=1, max=10}                                                                                                                                  }}, -- Rasetsu Jinpachi
    [13212] = {augments = {{aug=1,   min=1, max=15}, {aug=516, min=1, max=5 }, {aug=517, min=1, max=5 }, {aug=518, min=1, max=5 }, {aug=148, min=1, max=3 }, {aug=147, min=1, max=1 }                                                                                                        }}, -- Tarutaru Sash
    [19309] = {augments = {{aug=768, min=1, max=10}, {aug=772, min=1, max=10}, {aug=771, min=5, max=10}, {aug=1,   min=5, max=18}, {aug=514, min=1, max=5 }, {aug=187, min=3, max=5 }, {aug=23,  min=3, max=5 }, {aug=286, min=1, max=2 }, {aug=326, min=1, max=10}, {aug=327, min=1, max=5 }}}, -- Gleaming Spear
    [11932] = {augments = {{aug=774, min=1, max=10}, {aug=518, min=1, max=3 }, {aug=51,  min=1, max=3 }, {aug=323, min=1, max=6 }, {aug=289, min=1, max=5 }                                                                                                                                  }}, -- Lore Slops
    [11880] = {augments = {{aug=771, min=1, max=9 }, {aug=1,   min=1, max=15}, {aug=187, min=1, max=5 }, {aug=514, min=1, max=5 }, {aug=286, min=1, max=5 }, {aug=54,  min=1, max=1 }                                                                                                        }}, -- Versa Mufflers
    [11424] = {augments = {{aug=770, min=1, max=6 }, {aug=512, min=1, max=3 }, {aug=40,  min=1, max=3 }, {aug=145, min=1, max=3 }, {aug=195, min=1, max=5 }, {aug=116, min=1, max=3 }                                                                                                        }}, -- Gules Leggings
    [18963] = {augments = {{aug=775, min=1, max=10}, {aug=1,   min=1, max=20}, {aug=9,   min=1, max=20}, {aug=293, min=1, max=5 }, {aug=23,  min=1, max=10}                                                                                                                                  }}, -- Gleaming Zaghnal
    [11684] = {augments = {{aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=177, min=1, max=3 }, {aug=515, min=1, max=2 }, {aug=41,  min=1, max=1 }, {aug=184, min=1, max=3 }                                                                                                        }}, -- Light Earring
    [13450] = {augments = {{aug=769, min=1, max=5 }, {aug=180, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=517, min=1, max=3 }, {aug=53,  min=1, max=5 }                                                                                                                                  }}, -- Diamond Ring
    [11878] = {augments = {{aug=515, min=1, max=4 }, {aug=184, min=1, max=4 }, {aug=211, min=1, max=2 }, {aug=195, min=1, max=4 }, {aug=98,  min=1, max=4 }                                                                                                                                  }}, -- Gules Mittens
    [11428] = {augments = {{aug=1,   min=3, max=7 }, {aug=51,  min=1, max=3 }, {aug=52,  min=3, max=4 }, {aug=53,  min=2, max=10}, {aug=141, min=2, max=5 }                                                                                                                                  }}, -- Lore Sabots
    [17664] = {augments = {{aug=787, min=1, max=7 }, {aug=184, min=1, max=5 }, {aug=517, min=2, max=8 }, {aug=45,  min=2, max=9 }, {aug=1033,min=1, max=8 }                                                                                                                                  }}, -- Firmament
    [19310] = {augments = {{aug=788, min=2, max=7 }, {aug=177, min=2, max=6 }, {aug=29,  min=2, max=3 }, {aug=512, min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1052,min=2, max=8 }                                                                                                        }}, -- Guisarme
    [19267] = {augments = {{aug=784, min=2, max=7 }, {aug=178, min=2, max=6 }, {aug=25,  min=2, max=3 }, {aug=39,  min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1078,min=2, max=8 }                                                                                                        }}, -- Ribauldequin
    [18964] = {augments = {{aug=770, min=4, max=5 }, {aug=787, min=3, max=8 }, {aug=184, min=3, max=5 }, {aug=23,  min=1, max=3 }, {aug=198, min=2, max=7 }, {aug=512, min=3, max=3 }, {aug=45,  min=3, max=19}, {aug=1048,min=2, max=8 }                                                    }}, -- Dire Scythe
    [18774] = {augments = {{aug=786, min=1, max=7 }, {aug=181, min=1, max=6 }, {aug=41,  min=1, max=4 }, {aug=45,  min=2, max=5 }, {aug=1024,min=2, max=6 }                                                                                                                                  }}, -- Savate Fists
    [18875] = {augments = {{aug=789, min=3, max=7 }, {aug=182, min=3, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=5, max=10}, {aug=1065,min=2, max=4 }, {aug=1064,min=2, max=4 }                                                                                                        }}, -- Vodun Mace
    [16660] = {augments = {{aug=786, min=2, max=5 }, {aug=187, min=1, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=3, max=8 }, {aug=1040,min=2, max=4 }                                                                                                                                  }}, -- Doom Tabar
    [16485] = {augments = {{aug=787, min=2, max=8 }, {aug=184, min=1, max=5 }, {aug=25,  min=1, max=3 }, {aug=23,  min=1, max=2 }, {aug=45,  min=1, max=8 }, {aug=1028,min=2, max=4 }                                                                                                        }}, -- Yataghan
    [16971] = {augments = {{aug=788, min=2, max=5 }, {aug=177, min=3, max=6 }, {aug=1080,min=1, max=3 }, {aug=45,  min=5, max=8 }, {aug=1060,min=2, max=4 }                                                                                                                                  }}, -- Yukitsugu
}

-------------------------------------------------------------------------------
-- This table reduces the total number of augments available by chest tier.
-- removes total from right to left
-- so {5,4,3,2,0},
-- will decrease the total augments available for tier 1 chest by 5,
-- tier 2 by 4, tier 3 by 3 and tier 4 by 2, leaving the full total for tier 5
-------------------------------------------------------------------------------
xi.pyxis.augTierDeduction =
{
    [14644] = {3,3,3,2,0}, -- Dark Ring
    [12324] = {5,2,2,0,0}, -- Tower Shield
    [16128] = {3,3,3,2,0}, -- Wivre Hairpin
    [12420] = {6,6,6,4,0}, -- Adaman Barbuta
    [13464] = {4,4,4,3,0}, -- Demon's Ring
    [16265] = {3,3,3,0,0}, -- Wivre Gorget
    [13087] = {7,7,3,2,0}, -- Jeweled Collar
    [13925] = {2,2,2,0,0}, -- Rasetsu Jinpachi
    [13212] = {5,5,3,2,0}, -- Tarutaru Sash
    [19309] = {6,5,4,3,0}, -- Gleaming Spear
    [11932] = {3,3,2,0,0}, -- Lore Slops
    [11880] = {2,2,2,0,0}, -- Versa Mufflers
    [11424] = {4,4,3,0,0}, -- Gules Leggings
    [18963] = {4,4,2,0,0}, -- Gleaming Zaghnal
    [11684] = {3,3,3,0,0}, -- Light Earring
    [13450] = {4,4,2,0,0}, -- Diamond Ring
    [11878] = {3,3,2,0,0}, -- Gules Mittens
    [11428] = {2,2,2,1,0}, -- Lore Sabots
    [17664] = {4,4,3,2,0}, -- Firmament
    [19310] = {4,4,3,2,0}, -- Guisarme
    [19267] = {4,4,3,2,0}, -- Ribauldequin
    [18964] = {6,6,4,2,0}, -- Dire Scythe
    [18774] = {3,3,2,0,0}, -- Savate Fists
    [18875] = {4,4,3,2,0}, -- Vodun Mace
    [16660] = {3,3,2,0,0}, -- Doom Tabar
    [16485] = {4,4,3,2,0}, -- Yataghan
    [16971] = {3,3,2,0,0}, -- Yukitsugu
}

---------------------------------
-- drop id's for keyitems
-- use zone id as the key
---------------------------------
xi.pyxis.kidrops =
{
    [15]  = {1461,1459,1465,1464,1462,1466,1463,1460}, -- ABYSSEA_KONSCHTAT
    [45]  = {1476,1471,1477,1470,1472,1473,1474,1475,1469,1468}, -- ABYSSEA_TAHRONGI
    [132] = {1478,1479,1480,1485,1486,1483,1484,1482,1481}, -- ABYSSEA_LA_THEINE
    [215] = {1489,1490,1488,1491,1492,1494}, -- ABYSSEA_ATTOHWA
    [216] = {1502,1504,1499,1501,1505,1500}, -- ABYSSEA_MISAREAUX
    [217] = {1509,1508,1510,1514,1511}, -- ABYSSEA_VUNKERL
    [218] = {0,0,0}, -- ABYSSEA_ALTEPA
    [253] = {0,0,0}, -- ABYSSEA_ULEGUERAND
    [254] = {0,0,0}, -- ABYSSEA_GRAUBERG
}

---------------------------------
-- drop id's for items
-- use zone id as the key
---------------------------------
xi.pyxis.itemDrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = {1633,4781,4272,5152,2903,2824,2910,2189,781,1262,778,1740,685,1259,740,1469,836,4377,5001},
    [xi.zone.ABYSSEA_TAHRONGI  ] = {2408,2198,887,4691,4771,4781,4660,4614,4982,5001,4965,645,1633,812,804,756,794,1259,785,4272,2946,740,786,1312,942,2920,2948,2922,2949,2924,2950,2925,2923,2947},
    [xi.zone.ABYSSEA_LA_THEINE ] = {1260,1415,2899,2901,2902,2895,2359,740,739,1446,685,1769,702,1258,756,4272,780,4377,5152,4781,4771,4655,5001,4982,4856,4991,4486,4965,2893,2900},
    [xi.zone.ABYSSEA_ATTOHWA   ] = {5455,898,887,654,4272,777,745,5564,1469,1302,1303,1306,2703,729,780,692,740,1740,4849,5099,5096,5057,5092,5089,4966,4893,5059,6059,4996,4850,4895,3076,3073,3080,3083,3075,3072,12088,12089,12090,12091,12092,12093},
    [xi.zone.ABYSSEA_MISAREAUX ] = {692,4387,2743,747,1711,2152,1447,685,1300,2408,1299,719,722,902,836,887,4377,793,4849,4766,6099,4863,5057,4707,4706,5092,5089,4996,5078,4893,5059,4895,3088,3097,3091,3092,3096,12094,12095,12096,12097,12098},
    [xi.zone.ABYSSEA_VUNKERL   ] = {747,2476,1711,2703,685,5564,1769,1304,1305,1301,1306,1299,1302,836,1312,4849,4766,5099,5057,4707,4706,5092,4850,4893,5059,5057,4895,4967,4966,3101,12102,12106,12105,12100, 12101, 12103, 12104, 12107, 12099},
    [xi.zone.ABYSSEA_ALTEPA    ] = {0,0,0},
    [xi.zone.ABYSSEA_ULEGUERAND] = {0,0,0},
    [xi.zone.ABYSSEA_GRAUBERG  ] = {0,0,0},
}

xi.pyxis.itemTierDeductions =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = {  7,  7,  7, 0, 0 },
    [xi.zone.ABYSSEA_TAHRONGI  ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_LA_THEINE ] = { 13, 13, 13, 9, 0 },
    [xi.zone.ABYSSEA_ATTOHWA   ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_MISAREAUX ] = { 14, 14, 14, 5, 0 },
    [xi.zone.ABYSSEA_VUNKERL   ] = { 14, 14, 14, 6, 0 },
    [xi.zone.ABYSSEA_ALTEPA    ] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG  ] = {  0,  0,  0, 0, 0 },
}


local function packLightData(lightTable)
    local lightMask = 0

    for lightType, lightValue in ipairs(lightTable) do
        lightMask = lightMask + bit.lshift(lightValue, (lightType - 1) * 2)
    end

    return lightMask
end

local function unpackLightData(lightMask)
    local lightValues = {}

    for _, v in ipairs(xi.abyssea.lightType) do
        lightValues[v] = bit.band(bit.rshift(lightMask, (v - 1) * 2), 0xFF)
    end

    return lightValues
end

---------------------------------------------------------------------------------------------
-- Desc: Check for time elapsed since last spawned
-- NOTE: will NOT allow a spawn if time since last spanwed is under 5 mins.
---------------------------------------------------------------------------------------------
local function timeElapsedCheck(npc, player)
    local spawnTime = os.time() + 180000 -- defualt time in case no var set.

    if npc == nil then
        return false
    end

    if npc:getLocalVar("[pyxis]SPAWNTIME") > 0 then
        spawnTime = npc:getLocalVar("[pyxis]SPAWNTIME")
    end

    if os.time() - spawnTime <= 0 then
        return true
    end

    return false
end

local function GetPyxisID(player)
    local zoneId      = player:getZoneID()
    local ID          = zones[zoneId]
    local baseChestId = ID.npc.Sturdy_Pyxis_Base
    local chestId     = 0

    for i = baseChestId, baseChestId + 79 do
        if timeElapsedCheck(GetNPCByID(i), player) then
            if GetNPCByID(i):getStatus() == xi.status.DISAPPEAR then
                chestId = i
                break
            end
        end
    end

	if chestId == 0 then
		for i = baseChestId, baseChestId + 79 do
			if GetNPCByID(i):getStatus() == xi.status.CUTSCENE_ONLY then
				GetNPCByID(i):setStatus(xi.status.DISAPPEAR)
			elseif GetNPCByID(i):getStatus() == xi.status.DISAPPEAR then
				GetNPCByID(i):setLocalVar("[pyxis]SPAWNTIME", (os.time() + 180000))
			end
		end
	end

    if GetNPCByID(chestId) == nil then
        return 0
    end

    return chestId
end

    ----------------------------------------------------------------------
    -- Desc: Messages sent to all players in a party in the zone
    ----------------------------------------------------------------------
local function MessageChest(player, messageid, param1, param2, param3, param4)
    local party = player:getAlliance()

    for _, member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() and member:isPC() then
            member:messageName(messageid, player, param1, param2, param3, param4)
        end
    end
end

    ----------------------------------------------------------------------
    -- Desc: Despawn a chest and reset its local var's
    ----------------------------------------------------------------------
local function RemoveChest(player, npc, addcruor, delay)
    local ID = zones[player:getZoneID()]
    local amount = npc:getLocalVar("TIER") * 10

    if addcruor ~= 0 then
        player:addCurrency("cruor",amount)
        player:messageSpecial(ID.text.CRUOR_OBTAINED, amount, 0, 0, 0)
    end

    npc:timer(delay * 1000, function(npcArg)
        npcArg:setAnimationSub(12)
		npcArg:setNpcFlags(3203)
		npcArg:setLocalVar("SPAWNSTATUS",0)
		npcArg:setStatus(xi.status.DISAPPEAR)
        npcArg:entityAnimationPacket("kesu")
    end)
end

local function isChestEmpty(contentsTable)
    for _, v in ipairs(contentsTable) do
        if v ~= 0 then
            return false
        end
    end

    return true
end

local function GetTempDropTable(npc)
    local tempTable = {}

    for i = 1, 8 do
        tempTable[i] = npc:getLocalVar("TEMP" .. i)
    end

    return tempTable
end

local function GiveTempItem(player, npc, tempNum)
    local tempItems = GetTempDropTable(npc)

    if tempItems[tempNum] == 0 then
        player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
        return
    else
        if player:hasItem(tempItems[tempNum], 3) then
            player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
            return
        else
            player:addTempItem(tempItems[tempNum])
            MessageChest(player,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,tempItems[tempNum], 0, 0, 0, npc)
            npc:setLocalVar("TEMP" .. tempNum, 0)
        end
    end

    if isChestEmpty(tempItems) then
        RemoveChest(player, npc, 0, 3)
    end
end

----------------------------------------------------------------------------------
-- Key item functions
----------------------------------------------------------------------------------

local function GetKiDrop(npc, kiNum)
    return npc:getLocalVar("KI" .. kiNum)
end

local function GivePlayerKi(npc, player, kiNum)
    local keyItem = npc:getLocalVar("KI" .. kiNum)

    if keyItem == 0 then
        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_DISAPPEARED)
        return
    elseif player:hasKeyItem(keyItem) then
        player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_KEY_ITEM)
        return
    else
        player:addKeyItem(keyItem)
        MessageChest(player,zones[player:getZoneID()].text.OBTAINS_THE_KEY_ITEM, keyItem, 0, 0, 0)
        npc:setLocalVar("KI" .. kiNum, 0)
    end

    if npc:getLocalVar("KI1") == 0 and npc:getLocalVar("KI2") == 0 then
        RemoveChest(player, npc, 0, 3)
    end
end

----------------------------------------------------------------------------------
-- Augmented item functions
----------------------------------------------------------------------------------

local function GetAugItemID(npc, slot)
    return npc:getLocalVar("ITEM" .. slot .. "ID")
end

local function GetAugID(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AU" .. augmentnumber)
end

local function GetAug(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AUGMENT".. augmentnumber)
end

local function GetAugVal(npc, slot, augmentnumber)
    return npc:getLocalVar("ITEM" .. slot .. "AUG" .. augmentnumber .. "VAL")
end

local function SetAugItemID(npc, itemNum, augmentNum, augment)
    npc:setLocalVar("ITEM" .. itemNum .. "AU" .. augmentNum, augment)
end

local function GetAugment(npc, itemid, slot)
    local secondAugment = false
    local tier          = npc:getLocalVar("TIER")
    local randaugment1  = 0
    local randaugment2  = 0
    local augment1      = 0
    local augment2      = 0
    local aug1          = 0
    local aug2          = 0
    local multival1     = 0
    local multival2     = 0
    local randLimit     = 98

    if tier == 5 then
        randLimit = 65
    elseif tier >= 3 then
        randLimit = 80
    end

    if math.random(100) > randLimit then
        secondAugment = true
    end

    randaugment1 = math.random(1,#xi.pyxis.augs[itemid].augments - xi.pyxis.augTierDeduction[itemid][tier])
    aug1 = xi.pyxis.augs[itemid].augments[randaugment1]

    multival1 = math.random(aug1.min, aug1.max)

    if multival1 > 1 then
        augment1 = bit.bor(aug1.aug,bit.lshift(multival1 - 1 , 11))
    else
        augment1 = aug1.aug
    end

    SetAugItemID(npc, slot, 1, augment1)
    npc:setLocalVar("ITEM" .. slot .. "AUGMENT1", aug1.aug)
    npc:setLocalVar("ITEM" .. slot .. "AUG1VAL", multival1 - 1)

    if secondAugment then
        randaugment2 = math.random(1,#xi.pyxis.augs[itemid].augments - xi.pyxis.augTierDeduction[itemid][tier])

        if randaugment2 == randaugment1 then
            randaugment2 = 0
        end

        if randaugment2 ~= 0 then
            aug2 = xi.pyxis.augs[itemid].augments[randaugment2]

            multival2 = math.random(aug2.min, aug2.max)

            if multival2 > 1 then
                augment2 = bit.bor(aug2.aug,bit.lshift(multival2 -1 ,11))
            else
                augment2 = aug2
            end

            SetAugItemID(npc, slot, 2, augment2)
            npc:setLocalVar("ITEM" .. slot .. "AUGMENT2", aug2.aug)
            npc:setLocalVar("ITEM" .. slot .. "AUG2VAL", multival2 - 1)
        end
    end
end

local function GetRandItem(zoneid, tier)
    local rand = math.random(1, #xi.pyxis.itemDrops[zoneid] - xi.pyxis.itemTierDeductions[zoneid][tier])

    return xi.pyxis.itemDrops[zoneid][rand]
end

local function GetDrops(npc,droptype,tier,zoneid)
    local chesttype = xi.pyxis.droptypes[droptype]

    if npc:getLocalVar("ITEMS_SET") == 1 then -- sets this to 1 so can get items once when triggered
        return
    end

    switch(chesttype): caseof
    {
        ["tempitems"] = function(x)
                        local tempcount = math.random(1, tier + 3)

                        for i = 1, tempcount do
                            local temp = xi.pyxis.tempdrops[tier][math.random(1, #xi.pyxis.tempdrops[tier])]
                            npc:setLocalVar("TEMP" .. i, temp)
                        end

                        npc:setLocalVar("ITEMS_SET", 1)
                      end,
        ["keyitems"]  = function(x)
                            local kicount = 1

                            if math.random(100) > 75 then
                                kicount = 2
                            end

                            for i = 1, kicount do
                                local ki = xi.pyxis.kidrops[zoneid][math.random(1, #xi.pyxis.kidrops[zoneid])]
                                npc:setLocalVar("KI" .. i, ki)
                            end

                            npc:setLocalVar("ITEMS_SET", 1)
                      end,
        ["augments"]  = function(x)
                            local item1 = xi.pyxis.augdrops[zoneid][math.random(1,3)]
                            local item2 = 0

                            if tier > 2 then
                                if math.random(100) > (90 / tier) then
                                    item2 = xi.pyxis.augdrops[zoneid][math.random(1,3)]
                                end
                            end

                            local chestid = npc:getLocalVar("CHESTID")
                            local chest   = GetNPCByID(chestid)

                            npc:setLocalVar("ITEM1ID",item1)
                            GetAugment(chest, item1, 1)
                            if item2 > 0 then
                                npc:setLocalVar("ITEM1ID",item1)
                                GetAugment(chest, item1, 1)
                                npc:setLocalVar("ITEM2ID",item2)
                                GetAugment(chest, item2, 2)
                            end

                            npc:setLocalVar("ITEMS_SET", 1)
                        end,
        ["items"]     = function(x)
                            local itemcount = 1

                            if (tier < 3 or tier == 5) then
                                itemcount = math.random(1,3)
                            elseif (tier == 3 or tier == 4) then
                                itemcount = math.random(1,8)
                            end

                            for i = 1, itemcount do
                                local item = GetRandItem(zoneid, tier)
                                npc:setLocalVar("ITEM" .. i, item)
                            end

                            npc:setLocalVar("ITEMS_SET", 1)
                        end
    }
end

local function GiveAugItem(npc, player, slot)
    local item1        = GetAugItemID(npc, 1)
    local item2        = GetAugItemID(npc, 2)

    local item1aug1    = GetAug(npc, 1, 1)
    local item1aug1val = GetAugVal(npc, 1, 1)
    local item1aug2    = GetAug(npc, 1, 2)
    local item1aug2val = GetAugVal(npc, 1, 2)

    local item2aug1    = GetAug(npc, 2, 1)
    local item2aug1val = GetAugVal(npc, 2, 1)
    local item2aug2    = GetAug(npc, 2, 2)
    local item2aug2val = GetAugVal(npc, 2, 2)

    if (slot == 1) then
        if (npc:getLocalVar("ITEM1ID") == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, item1)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (GetAugItemID(npc,1) ~= 0) then
                    player:addItem(item1, 1, item1aug1, item1aug1val, item1aug2, item1aug2val)
                    MessageChest(player,zones[player:getZoneID()].text.OBTIANS_THE_ITEM,item1,0,0,0)
                    npc:setLocalVar("ITEM1ID",0)
                end
            end
        end
    elseif (slot == 2) then
        if (npc:getLocalVar("ITEM2ID") == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, item2)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (GetAugItemID(npc,2) ~= 0) then
                    player:addItem(item2,1,item2aug1,item2aug1val,item2aug2,item2aug2val)
                    MessageChest(player,zones[player:getZoneID()].text.OBTIANS_THE_ITEM,item2,0,0,0)
                    npc:setLocalVar("ITEM2ID",0)
                end
            end
        end
    end

    if npc:getLocalVar("ITEM1ID") == 0 and npc:getLocalVar("ITEM2ID") == 0 then
        RemoveChest(player, npc, 0, 3)
    end
end

local function CanSpawnPyxis(player)
    local dropchance = math.random(1 + xi.abyssea.getLightValue(player, xi.abyssea.lightType.PEARL), 500)

    if dropchance >= 250 then
        return true
    end

    return false
end

-- TODO: This could be refactored
local function determineChestType(lightValues)
    local goldChance  = math.random(lightValues[xi.abyssea.lightType.AMBER]) + math.random(lightValues[xi.abyssea.lightType.PEARL])
    local redChance   = math.random(lightValues[xi.abyssea.lightType.RUBY]) + math.random(lightValues[xi.abyssea.lightType.PEARL])
    local blueChance  = math.random(lightValues[xi.abyssea.lightType.AZURE]) + math.random(lightValues[xi.abyssea.lightType.PEARL])

    local chestType   = math.random(#xi.pyxis.chestType)
    if goldChance > redChance and goldChance > blueChance then
        chestType = xi.pyxis.chestType.GOLD
    elseif redChance > goldChance and redChance > blueChance then
        chestType = xi.pyxis.chestType.RED
    elseif blueChance > goldChance and blueChance > redChance then
        chestType = xi.pyxis.chestType.BLUE
    end

    return chestType
end

local function getChestTier(chestType, lightValues)
    local requiredLight = xi.pyxis.chestData[chestType][2]
    local compareLight  = lightValues[requiredLight]
    local chestTier = 5

    -- Tabled Tier limits are sorted in ascending order.  Break out of the
    -- loop as soon as the condition is met.
    for k, v in ipairs(xi.pyxis.chestData[chestType][3]) do
        if compareLight <= v then
            chestTier = k
            break
        end
    end

    return chestTier
end

local function getLightValueByTier(chestTier)
    local lightValue = 5

    if chestTier == 5 then
        lightValue = 15
    elseif chestTier >= 3 then
        lightValue = 10
    end

    return lightValue
end

local function SetPyxisData(player, x, y, z, r, npc)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local lightValues = xi.abyssea.getLightsTable(player)

    ---------------------------------------------
    -- type chance
    ---------------------------------------------
    local droptype   = 0
    local restore    = 0
    local partyid    = player:getLeaderID()
    local chestType  = determineChestType(lightValues)
    local chestModel = xi.pyxis.chestData[chestType][1]
    local tier       = getChestTier(chestType, lightValues)
    local randnum    = 0
    local correctnum = 0
    local required   = math.random(1,6)
    local goldflag   = { 1155, 1159 }
    local sizeflag   = 3
    local message    = 0
    local light      = 1

    local chestLightValues =
    {
        [xi.abyssea.lightType.PEARL  ] = 8 * tier,
        [xi.abyssea.lightType.GOLDEN ] = 0,
        [xi.abyssea.lightType.SILVERY] = 0,
        [xi.abyssea.lightType.EBON   ] = 0,
        [xi.abyssea.lightType.AZURE  ] = 8 * tier,
        [xi.abyssea.lightType.RUBY   ] = 8 * tier,
        [xi.abyssea.lightType.AMBER  ] = 8 * tier,
    }

    if player:hasKeyItem(xi.ki.IVORY_ABYSSITE_OF_ACUMEN) then
        required = required - 2
        if required < 1 then
            required = 1
        end
    end

    chestModel = xi.pyxis.chestData[chestType][1]

    if chestType == xi.pyxis.chestType.BLUE then -- blue
        local bluedrops = 0
        local blueabyssitebonus = 0

        randnum = math.random(10, 99)

        for keyItem = xi.ki.SCARLET_ABYSSITE_OF_KISMET, xi.ki.VERMILLION_ABYSSITE_OF_KISMET do
            if player:hasKeyItem(keyItem) then
                blueabyssitebonus = blueabyssitebonus + 1
            end
        end

        tier = math.min(tier + blueabyssitebonus, 5)

        if tier < 4 then
            bluedrops = math.random(1,4)
        else
            bluedrops = math.random(1,6)
        end

        if bluedrops == 1 then
            message  = 14 -- Numerous temp items
            droptype = 10
        elseif bluedrops == 2 then
            message  = xi.pyxis.expmessage[tier]  -- exp
            droptype = 9
        elseif bluedrops == 3 then
            message  = xi.pyxis.soothinglightmessage[tier]  -- soothing light
            droptype = 6  -- tier 1 1 or 2, tier 2 1,2 or 3, tier 3 1,2,3 or 4, tier 4 3,4 or 5

            if tier < 4 then
                restore = math.random(1, tier + 1)
            else
                restore = math.random(3, 5)
            end
        elseif bluedrops == 4 then
            message  = xi.pyxis.cruormessage[tier]  -- curor
            droptype = 7
        elseif bluedrops == 5 then
            message  = 42 -- temp items
            droptype = 1
        elseif bluedrops == 6 then
            message  = 17 -- Time Extension
            droptype = 8
        end
    elseif chestType == xi.pyxis.chestType.RED then -- red
        light    = math.random(1,7)
        droptype = 5
        randnum  = math.random(25,75)

        message = xi.pyxis.lightsMessage[light][tier]

        if light >= 2 and light <= 4 then
            chestLightValues[light] = getLightValueByTier(tier)
        end

    elseif chestType == xi.pyxis.chestType.GOLD then -- gold
        local golddrops = 0
        local randByTier = { 33, 44, 55, 90, 77 }

        randnum  = math.random(11, randByTier[tier])
        sizeflag = goldflag[1]

        if tier > 3 and tier < 5 then
            if math.random(100) > 25 then
                sizeflag = goldflag[2]
            end
        elseif tier == 5 then
            if math.random(100) > 40 then
                sizeflag = goldflag[2]
            end
        end

        if tier < 4 then
            golddrops = math.random(1, 2)
        else
            golddrops = math.random(1, 4)
        end

        -- Messages: Temp Items = 42, Items = 43, Augmented = 44, Key Items = 45
        message = 41 + golddrops
        droptype = golddrops
    end

    if randnum <= 50 then
        correctnum = math.random(50, 99)
    else
        correctnum = math.random(1, 50)
    end

    if npc ~= nil or npc:getStatus() == xi.status.DISAPPEAR then
        npc:resetLocalVars()
        --------------------------------------
        -- Change flags
        --------------------------------------
        npc:setNpcFlags(sizeflag)

        -------------------------------------
        -- Chest data
        -------------------------------------
        npc:setLocalVar("KILLER",player:getID())
        npc:setLocalVar("TIER", tier)
        npc:setLocalVar("PARTYID", partyid)
        npc:setLocalVar("SIZE",sizeflag)
        npc:setLocalVar("LOCKTYPE", chestType)
        npc:setLocalVar("[pyxis]SPAWNTIME", os.time())
        npc:setLocalVar("RAND_NUM", randnum)
        npc:setLocalVar("REQUIREDGUESSES", required)
        npc:setLocalVar("CORRECT_NUM", correctnum)
        npc:setLocalVar("PEEKMESSAGE", message)
        npc:setLocalVar("LOOT_TYPE", droptype)
        npc:setLocalVar("LIGHT", light)
        npc:setLocalVar("CRUOR",250 * tier)
        npc:setLocalVar("EXP",250 * tier)
        npc:setLocalVar("RESTORE",restore)
        npc:setLocalVar("LIGHT_DATA", packLightData(chestLightValues))
        npc:setLocalVar("SPAWNSTATUS", 1)
        npc:setPos(x, y, z, r)
		npc:setStatus(xi.status.NORMAL)
		npc:entityAnimationPacket("deru")
        npc:setAnimationSub(12)
		MessageChest(player,ID.text.MONSTER_CONCEALED_CHEST,0,0,0,0)
        npc:setModelId(chestModel)

        npc:timer(180000, function(npcArg)
            if npcArg:getStatus() == xi.status.NORMAL then
                RemoveChest(player, npc, 0, 1)
            end
        end)
    else
        print("ERROR: Trying to spawn chest that is already spawned!")
    end
end

local function OpenChest(player, npc)
    local ID       = zones[player:getZoneID()]
    local party    = player:getPartyWithTrusts()
    local lootType = npc:getLocalVar("LOOT_TYPE")
    local tier     = npc:getLocalVar("TIER")
    local restoreType = npc:getLocalVar("RESTORE")

    npc:setAnimationSub(13)

    if lootType == 9 then
        local exp = npc:getLocalVar("EXP")

        for p, member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
                member:addExp(exp)
            end
        end
        RemoveChest(player, npc, 0, 3)

    elseif lootType == 7 then
        local cruorAmount = npc:getLocalVar("CRUOR")

        for p, member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
                member:addCurrency("cruor", cruorAmount)
                member:messageSpecial(ID.text.CRUOR_OBTAINED, cruorAmount)
            end
        end
        RemoveChest(player, npc, 0, 3)

    elseif lootType == 8 then
        for p, member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
                member:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 3, 10, 1)
				local effect = member:getStatusEffect(xi.effect.VISITANT)
				local old_duration = effect:getTimeRemaining()
				effect:setDuration((old_duration + (10 * 60)) * 1000)
                effect:resetStartTime()
                effect:setIcon(xi.effect.VISITANT)
            end
        end
        RemoveChest(player, npc, 0, 3)

    elseif lootType == 10 then
        for i = 1, #xi.pyxis.tempdrops[tier] do
            local item = xi.pyxis.tempdrops[tier][math.random(1,#xi.pyxis.tempdrops[tier])]
            for p, member in ipairs(party) do
                if member:isPC() and not member:hasItem(item,3) and member:getZoneID() == player:getZoneID() then
                    member:addTempItem(item, 1, 0, 0, 0, 0, 0, 0, 0, 0)
                end
            end
        end

        for p, member in ipairs(party) do
            if member:isPC() then
                member:messageSpecial(ID.text.OBTAINS_SEVERAL_TEMPS,0,0,0,0)
            end
        end
        RemoveChest(player, npc, 0, 3)

    elseif lootType == 5 then
        local light  = npc:getLocalVar("LIGHT")
        local lightData = unpackLightData(npc:getLocalVar("LIGHT_DATA"))

        for p, member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
                xi.abyssea.addPlayerLights(member, light, lightData[light])
            end
        end
        RemoveChest(player, npc, 0, 3)

    elseif lootType == 6 then
        switch(restoreType) : caseof
        {
            [1] = function()
                player:restoreFromChest(npc, 1)

                for p, member in ipairs(party) do
                    if member:getZoneID() == player:getZoneID() then
                        local hp = member:getMaxHP() - member:getHP()
                        member:addHP(hp)
                        if member:isPC() then
                            member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, hp)
                        end
                    end
                end

                RemoveChest(player, npc, 0, 4)
            end,

            [2] = function()
                player:restoreFromChest(npc, 2)

                for p, member in ipairs(party) do
                    if member:getZoneID() == player:getZoneID() then
                        local mp = member:getMaxMP() - member:getMP()
                        member:addMP(mp)
                        if member:isPC() then
                            member:messageBasic(xi.msg.basic.RECOVERS_MP, 0, mp)
                        end
                    end
                end

                RemoveChest(player, npc, 0, 4)
            end,

            [3] = function()
                player:restoreFromChest(npc, 1)

                for p, member in ipairs(party) do
                    if member:getZoneID() == player:getZoneID() then
                        member:addTP(1000)
                    end
                end

                RemoveChest(player, npc, 0, 4)
            end,

            [4] = function()
                player:restoreFromChest(npc, 1)

                for p, member in ipairs(party) do
                    if member:getZoneID() == player:getZoneID() then
                        local mp = member:getMaxMP() - member:getMP()
                        local hp = member:getMaxHP() - member:getHP()
                        member:addHP(hp)
                        member:addMP(mp)
                        member:addTP(3000)
                        if member:isPC() then
                            member:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
                        end
                    end
                end

                RemoveChest(player, npc, 0, 4)
            end,

            [5] = function()
                player:restoreFromChest(npc, 1)

                for p, member in ipairs(party) do
                    if member:getZoneID() == player:getZoneID() then
                        local mp = member:getMaxMP() - member:getMP()
                        local hp = member:getMaxHP() - member:getHP()
                        member:addHP(hp)
                        member:addMP(mp)
                        member:addTP(3000)
                        if member:isPC() then
                            member:resetRecasts()
                            member:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP)
                            member:messageBasic(xi.msg.basic.ALL_ABILITIES_RECHARGED)
                        end
                    end
                end

                RemoveChest(player, npc, 0, 4)
            end,
        }
    end
end

local function isEven(number)
    if number % 2 == 0 then
        return 0
    else
        return 1
    end
end

----------------------------------------------------------------------------------
-- Basic item functions
----------------------------------------------------------------------------------

local function GetChestItemTable(npc)
    local itemTable = {}

    for i = 1, 8 do
        itemTable[i] = npc:getLocalVar("ITEM" .. i)
    end

    return itemTable
end

local function GetLootTable(player, npc)
    local loot = {}

    for i = 1, 8 do
        table.insert(loot, npc:getLocalVar("ITEM" ..i))
    end
    return loot
end

local function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar("CHESTID")
    local chest   = GetNPCByID(chestid)
    local itemList = GetChestItemTable(npc)

    if itemList[itemnum] == 0 then
        player:messageSpecial(ID.text.ITEM_DISAPPEARED)
        return
    else
        if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemList[itemnum])
            return
        else
            player:addItem(itemList[itemnum], 1, 0, 0, 0, 0)
            MessageChest(player,ID.text.OBTAINS_ITEM, itemList[itemnum], 0, 0, 0, npc)
            chest:setLocalVar("ITEM" .. itemnum, 0)
        end
    end

    if isChestEmpty(itemList) then
        RemoveChest(player, npc, 0, 3)
    end
end

xi.pyxis.spawnPyxis = function(player, x, y, z, r)
    local chestId = GetPyxisID(player)
    local npc     = GetNPCByID(chestId)

    if chestId == 0 then
        return
    end

    if CanSpawnPyxis(player) then
        SetPyxisData(player, x, y, z, r, npc)
    end
end

----------------------------------------------------------------------
--
----------------------------------------------------------------------
xi.pyxis.onPyxisTrade = function(player,npc,trade)
    local zoneId     = player:getZoneID()
    local ID         = zones[zoneId]
    local tier       = npc:getLocalVar("TIER")
    local loottype   = npc:getLocalVar("LOOT_TYPE")
    local chestowner = npc:getLocalVar("PARTYID")

    if not player:getLeaderID() == chestowner then
        if player:getPartySize() < 2 then
            return ID.text.CANNOT_OPEN_CHEST
        else
            return ID.text.PARTY_NOT_OWN_CHEST
        end
    end

    if npc:getAnimationSub() == 12 then
        if trade:hasItemQty(2490,1) and trade:getItemCount() == 1 then
            player:tradeComplete() -- NOTE: Uncomment once test it complete!
            GetDrops(npc,loottype,tier,player:getZoneID())
            MessageChest(player,ID.text.TRADE_KEY_OPEN,2490,0,0,0,npc)
            OpenChest(player,npc)
        end
    end
end

xi.pyxis.onPyxisTrigger = function(player, npc)
    local zoneId          = player:getZoneID()
    local ID              = zones[zoneId]
    local chestid         = npc:getID()
    local tier            = npc:getLocalVar("TIER")
    local size            = npc:getLocalVar("SIZE")
    local timeleft        = os.time() - npc:getLocalVar("[pyxis]SPAWNTIME")
    local itemtype        = npc:getLocalVar("LOOT_TYPE")        -- Type: 1 Temps, 2 Items, 3 aug items, 4 keyitems
    local locktype        = npc:getLocalVar("LOCKTYPE")         -- 1:Blue "twist dial" || 2:Red "pressure" || 3:Gold "enter two-digit combination (10~99)".
    local chestowner      = npc:getLocalVar("PARTYID")          -- the id of the party that has rights to the chest.
    local playerpartyid   = player:getLeaderID()
    local messagetype     = npc:getLocalVar("PEEKMESSAGE")
    local keytype         = xi.pyxis.contentMessage[messagetype] + locktype
    local cs_base         = 2004                                -- base id of all cs's this should not change, but if it does, can adjust here
    local eventbase       = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent     = chestid - eventbase + cs_base
    local unlockedEvent   = chestid - eventbase + cs_base + 64
    local required        = npc:getLocalVar("REQUIREDGUESSES")
    local attemptsallowed = 5
    local failedAttempts  = npc:getLocalVar("FAILED_ATEMPTS")
    local currentAttempts = npc:getLocalVar("CURRENT_ATTEMPTS") -- Current Progress/Successful atempts made
    local targetnumber    = npc:getLocalVar("RAND_NUM")

    if playerpartyid ~= chestowner then
        if player:getLeaderID() ~= player:getID() then
            player:messageSpecial(ID.text.PARTY_NOT_OWN_CHEST)
        else
            player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
        end
        return
    end

    timeleft = timeleft * 60
    ------------------------------------------------------------------
    -- Red chest var's
    ------------------------------------------------------------------

    local targetpressure  = targetnumber
    local currentpressure = npc:getLocalVar("CURRENTPRESSURE")
    local pressurerange   = 10
    local targetlow       = 0
    local targethigh      = 0

    local lockwearmessage  = npc:getLocalVar("LOCKWEARMESSAGE") -- 0-3 good -> bad

    if (lockwearmessage == 0 or lockwearmessage == nil) then
        lockwearmessage = math.random(1,4)
    end

    local lockwear    = {[1] = {max = 5},[2] = {max = 10},[3] = {max = 15},[4] = {max = 30}}
    local lockwearmax = lockwear[lockwearmessage].max
    if currentpressure <= 0 then
        if targetnumber < 50 then
            currentpressure = math.random(targetnumber + 10,150)
        elseif targetnumber > 50 then
            currentpressure = math.random(1,targetnumber - 10)
        end
        npc:setLocalVar("CURRENTPRESSURE", currentpressure)
    end

    targetlow  = targetpressure - pressurerange
    targethigh = targetpressure + pressurerange

    npc:setLocalVar("LOCKWEARADD",math.random(0,lockwearmax))
    ------------------------------------------------------------------
    -- Gold chest var's
    ------------------------------------------------------------------
    local highNumberValues = { 33, 44, 55 }
    local highNumber = 0

    if tier < 4 then
        highNumber = highNumberValues[tier]
    else
        if size == 1155 then
            highNumber = 90
        else
            highNumber = 77
        end
    end

    GetDrops(npc, itemtype, tier, player:getZoneID())

    if lockedEvent > 2067 then
        lockedEvent = lockedEvent + 80     -- added because there is a jump in npc id's
    end

    if unlockedEvent > 2131 then
        unlockedEvent = unlockedEvent + 80 -- added because there is a jump in npc id's
    end

    --------------------------------------------------
    -- Chest Locked
    -------------------------------------------------
    if npc:getAnimationSub() == 12 then
        if locktype == 1 then
            player:startEvent(lockedEvent, keytype, targetnumber, currentAttempts, required, failedAttempts, attemptsallowed, 3, timeleft) -- Blue
        elseif locktype == 2 then
            player:startEvent(lockedEvent, keytype, currentpressure, bit.bor(targetlow,bit.lshift(targethigh,16)), lockwearmessage -1, attemptsallowed, currentAttempts, 3, timeleft) -- Red
        elseif locktype == 3 then
            player:startEvent(lockedEvent, keytype, 11, highNumber, attemptsallowed, currentAttempts, targetnumber, 3, timeleft) -- Gold
        end

    --------------------------------------------------
    -- Chest Unlocked
    -------------------------------------------------
    elseif npc:getAnimationSub() == 13 then -- NOTE: Maybe change this incase players can alter npc animations
        if itemtype == 10 then
            itemtype = 1
        end

        player:startEvent(unlockedEvent, 1, 1, 1, itemtype, 1, timeleft, 1, 1) -- Gold
    end
end

xi.pyxis.onPyxisEventUpdate = function(player, csid, option, input)
    local zoneId         = player:getZoneID()
    local ID             = zones[zoneId]
    local npc            = player:getEventTarget()
    local chestid        = npc:getID()
    local augmentFlag    = 0x0202
    local itemtype       = npc:getLocalVar("LOOT_TYPE")
    local cs_base        = 2004
    local eventbase      = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent    = chestid - eventbase + cs_base
    local unlockedEvent  = chestid - eventbase + cs_base + 64

    if lockedEvent > 2067 then
        lockedEvent = lockedEvent + 80
    end

    if unlockedEvent > 2131 then
        unlockedEvent = unlockedEvent + 80
    end

    if csid == lockedEvent and option ~= nil then
        player:updateEvent(lockedEvent)
    end

    if itemtype == 1 then -- temps
        if csid == lockedEvent or csid == unlockedEvent then
            player:updateEvent(unpack(GetTempDropTable(npc)))
        end
    elseif itemtype == 2 then -- basic items
        if csid == lockedEvent or csid == unlockedEvent then
            player:updateEvent(unpack(GetChestItemTable(npc)))
        end
    elseif itemtype == 3 then -- aug items
        if csid == lockedEvent or csid == unlockedEvent then
            player:updateEvent(GetAugItemID(npc,1), augmentFlag, GetAugID(npc,1,1), GetAugID(npc,1,2), GetAugItemID(npc,2), augmentFlag, GetAugID(npc,2,1), GetAugID(npc,2,2))
        end
    elseif itemtype == 4 then -- ki's
        if csid == lockedEvent or csid == unlockedEvent then
            player:updateEvent(GetKiDrop(npc,1), GetKiDrop(npc,2), 0, 0, 0, 0, 0, 0)
        end
    end
end

local function handleMinigameBlue(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local newRand          = math.random(10,99)
    local lockedChoice     = bit.lshift(1, option - 1)
    local currentAttempts  = npc:getLocalVar("CURRENT_ATTEMPTS")
    local failedAttempts   = npc:getLocalVar("FAILED_ATTEMPTS")
    local requiredGuesses  = npc:getLocalVar("REQUIREDGUESSES")
    local correctGuesses   = npc:getLocalVar("CORRECT_GUESSES")
    local lastrand         = npc:getLocalVar("RAND_NUM")
    local attemptsallowed  = 5

    if lockedChoice == 1 then
        npc:setLocalVar("RAND_NUM", newRand)

        if newRand > lastrand then -- check guesses
            MessageChest(player, ID.text.RANDOM_SUCCESS_FAIL_GUESS, newRand, 0, 0, 0, npc)
            correctGuesses = correctGuesses + 1
            npc:setLocalVar("CORRECT_GUESSES", correctGuesses)

            if correctGuesses >= requiredGuesses then
                MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                OpenChest(player,player:getEventTarget())
            elseif correctGuesses < requiredGuesses then
                currentAttempts = currentAttempts + 1
                npc:setLocalVar("CURRENT_ATTEMPTS", currentAttempts)
            end
        else
            MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newRand,1,0,0,npc)
            failedAttempts = failedAttempts + 1
            npc:setLocalVar("FAILED_ATTEMPTS", failedAttempts)

            if failedAttempts >= attemptsallowed then
                RemoveChest(player,npc,0,1)
                MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                player:messageSpecial(ID.text.CHEST_DISAPPEARED)
            end
        end
    elseif lockedChoice == 2 then
        npc:setLocalVar("RAND_NUM", newRand)

        if newRand < lastrand then -- check guesses
            MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newRand,0,0,0,npc)
            correctGuesses = correctGuesses + 1
            npc:setLocalVar("CORRECT_GUESSES", correctGuesses)

            if correctGuesses >= requiredGuesses then
                MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                OpenChest(player,player:getEventTarget())
            elseif correctGuesses < requiredGuesses then
                if currentAttempts == nil then
                    npc:setLocalVar("CURRENT_ATTEMPTS",1)
                else
                    currentAttempts = currentAttempts + 1
                    npc:setLocalVar("CURRENT_ATTEMPTS", currentAttempts)
                end
            end
        else
            MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newRand,1,0,0,npc)
            failedAttempts = failedAttempts + 1
            npc:setLocalVar("FAILED_ATTEMPTS", failedAttempts)

            if failedAttempts >= attemptsallowed then
                RemoveChest(player,npc,0,1)
                MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                player:messageSpecial(ID.text.CHEST_DISAPPEARED)
            end
        end
    end
end

-- TODO: Apply Math
local pressureChoice =
{
    [ 1] = 10,
    [ 2] = 20,
    [ 4] = 30,
    [ 8] = 10,
    [16] = 20,
    [32] = 30,
}

local function handleMinigameRed(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local lockedchoice     = bit.lshift(1, option - 1)
    local currentAttempts  = npc:getLocalVar("CURRENT_ATTEMPTS")
    local lastrand         = npc:getLocalVar("RAND_NUM")
    local lockwearadd      = npc:getLocalVar("LOCKWEARADD")
    local targetpressure   = lastrand
    local currentpressure  = npc:getLocalVar("CURRENTPRESSURE")
    local pressurerange    = 10
    local pressurechange   = pressureChoice[lockedchoice] + lockwearadd
    local targetlow        = targetpressure - pressurerange
    local targethigh       = targetpressure + pressurerange

    if
        currentpressure - pressurechange >= targetlow and
        currentpressure - pressurechange <= targethigh
    then
        MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
        OpenChest(player,npc)
    else
        npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

        if currentpressure - pressurechange > 0 then
            npc:setLocalVar("CURRENTPRESSURE", currentpressure - pressurechange)
            MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,currentpressure - pressurechange,npc)
        else
            npc:setLocalVar("CURRENTPRESSURE", 0)
            MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,0,npc)
        end

        if currentAttempts == nil or currentAttempts == 0 then
            npc:setLocalVar("CURRENT_ATTEMPTS",1)
        else
            if currentAttempts < 5 then
                currentAttempts = currentAttempts + 1
                npc:setLocalVar("CURRENT_ATTEMPTS", currentAttempts)
            else
                RemoveChest(player,npc,0,1)
                MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                player:messageSpecial(ID.text.CHEST_DISAPPEARED)
            end
        end
    end
end

local function handleMinigameGold(player, csid, option, npc)
    local ID              = zones[player:getZoneID()]
    local currentAttempts = npc:getLocalVar("CURRENT_ATTEMPTS")
    local inputnumber     = bit.band(option, 0xFF)
    local targetnumber    = npc:getLocalVar("RAND_NUM")

    if inputnumber > 10 and inputnumber < 100 then
        local splitnumbers = {}

        for digit in string.gmatch(tostring(targetnumber), "%d") do
            table.insert(splitnumbers, digit)
        end

        if inputnumber == targetnumber then
            MessageChest(player,ID.text.INPUT_SUCCESS_FAIL_GUESS,inputnumber, 1, 0, 0, npc) -- unlocking chest
            MessageChest(player,ID.text.PLAYER_OPENED_LOCK, 0, 0, 0, 0, npc)
            OpenChest(player,npc)
        else
            MessageChest(player,ID.text.INPUT_SUCCESS_FAIL_GUESS,inputnumber,0,0,0,npc) -- nothing happens

            if inputnumber > targetnumber then
                player:messageSpecial(ID.text.GREATER_OR_LESS_THAN,inputnumber,1,0,0) -- greater
            elseif inputnumber < targetnumber then
                player:messageSpecial(ID.text.GREATER_OR_LESS_THAN,inputnumber,0,0,0) -- less
            end
            npc:setLocalVar("CURRENT_ATTEMPTS", currentAttempts + 1)

            local randtext = math.random(1,5)
            local firstOrSecond = math.random(1,2)
            if randtext == 1 then
                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_EVEN_ODD, firstOrSecond - 1, isEven(splitnumbers[firstOrSecond]), 0, 0)
            elseif randtext == 2 then
                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS, firstOrSecond - 1, splitnumbers[firstOrSecond], 0, 0)
            elseif randtext == 3 then
                if tonumber(splitnumbers[firstOrSecond]) <= 3 then
                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR, firstOrSecond - 1, 1, 2, 3)
                elseif tonumber(splitnumbers[firstOrSecond]) >= 4 and splitnumbers[1] < 6 then
                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR, firstOrSecond - 1, 3, 4, 5)
                elseif tonumber(splitnumbers[firstOrSecond]) >= 8 then
                    player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR, firstOrSecond - 1, 7, 8, 9)
                end
            elseif randtext == 4 then
                player:messageSpecial(ID.text.HUNCH_ONE_DIGIT_IS,splitnumbers[firstOrSecond], 0, 0, 0)
            elseif randtext == 5 then
                local sum = tonumber(splitnumbers[1]) + tonumber(splitnumbers[2])
                player:messageSpecial(ID.text.HUNCH_SUM_EQUALS,sum)
            end
        end
    end
end

xi.pyxis.onPyxisEventFinish = function(player, csid, option, npc)
    local ID               = zones[player:getZoneID()]
    local chestid          = npc:getID()
    local spawnstatus      = npc:getLocalVar("SPAWNSTATUS")
    local locktype         = npc:getLocalVar("LOCKTYPE")
    local loottype         = npc:getLocalVar("LOOT_TYPE")
    local cs_base          = 2004
    local eventbase        = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent      = chestid - eventbase + cs_base
    local unlockedEvent    = chestid - eventbase + cs_base + 64
    local openchoice       = bit.lshift(1, option - 65)

    if lockedEvent > 2067 then
        lockedEvent = lockedEvent + 80
    end

    if unlockedEvent > 2131 then
        unlockedEvent = unlockedEvent + 80
    end

    if option > 0 and spawnstatus ~= 1 then
        player:messageSpecial(ID.text.CHEST_DESPAWNED)
        return
    end

    ------------------------------------
    -- Minigame
    ------------------------------------
    if csid == lockedEvent then
        if locktype == 1 then
            handleMinigameBlue(player, csid, option, npc)
        elseif locktype == 2 then
            handleMinigameRed(player, csid, option, npc)
        elseif locktype == 3 then
            handleMinigameGold(player, csid, option, npc)
        end

    elseif csid == unlockedEvent then
    ------------------------------------
    -- Grab items out of the chest
    ------------------------------------
        if openchoice == 1 then
            local selection  = bit.lshift(1, option - 1)

            if selection == 1 or selection == 2 then
                -- Temps
                if loottype == 1 then
                    local itemSelected = bit.rshift(option, 16)

                    if itemSelected > 0 and itemSelected <= 8 then
                        GiveTempItem(player, npc, itemSelected)
                    end

                -- Items
                elseif loottype == 2 then
                    local loottable = GetLootTable(player,npc)
                    local itemSelected = bit.rshift(option, 16)

                    if itemSelected > 0 and itemSelected <= 8 then
                        GiveItem(player, npc, itemSelected)

                    -- Add spoils to treasure
                    elseif itemSelected == 9 then
                        for _, v in ipairs(loottable) do
                            player:addTreasure(v)
                        end

                        MessageChest(player,ID.text.ADD_SPOILS_TO_TREASURE,0,0,0,0,npc)
                        RemoveChest(player, npc, 0, 1)
                        ---- NOTE: NEED A CHECK HERE TO MAKE SURE ITS UPDATED AND CANT REMOVE THE SAME ITEM AGAIN
                    end

                    ----------------------------------
                    -- Augmented Items
                    ----------------------------------
                elseif loottype == 3 then
                    local itemSelected = bit.rshift(option, 16)

                    if itemSelected > 0 and itemSelected <= 2 then
                        GiveAugItem(player, npc, itemSelected)
                    end

                    ----------------------------------
                    -- Key Items
                    ----------------------------------
                elseif loottype == 4 then
                    local itemSelected = bit.rshift(option, 16)

                    if itemSelected > 0 and itemSelected <= 2 then
                        GivePlayerKi(player, npc, itemSelected)
                    end
                end
            end
    ------------------------------------
    -- Destroying chest
    ------------------------------------
        elseif openchoice == 2 then
            RemoveChest(player, npc, 1, 1)
        end
    end

    if option == 999 then
        RemoveChest(player, npc, 1, 1)
    end
end
