-----------------------------------
--
--  Armor Storage
--
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

tpz = tpz or {}
tpz.armorStorage = tpz.armorStorage or {}

-- {SetId, SetGroup, SetMask, SetCount, Head, Body, Hands, Legs, Feet, StorageCost, KeyItem}
local armorSets =
{
    1,  4, 0x000001, 5, 12511, 12638, 13961, 14214, 14089, 500,  tpz.ki.FIGHTERS_ARMOR_CLAIM_SLIP,
    2,  4, 0x000002, 5, 12512, 12639, 13962, 14215, 14090, 500,  tpz.ki.TEMPLE_ATTIRE_CLAIM_SLIP,
    3,  4, 0x000004, 5, 13855, 12640, 13963, 14216, 14091, 500,  tpz.ki.HEALERS_ATTIRE_CLAIM_SLIP,
    4,  4, 0x000008, 5, 13856, 12641, 13964, 14217, 14092, 500,  tpz.ki.WIZARDS_ATTIRE_CLAIM_SLIP,
    5,  4, 0x000010, 5, 12513, 12642, 13965, 14218, 14093, 500,  tpz.ki.WARLOCKS_ARMOR_CLAIM_SLIP,
    6,  4, 0x000020, 5, 12514, 12643, 13966, 14219, 14094, 500,  tpz.ki.ROGUES_ATTIRE_CLAIM_SLIP,
    7,  4, 0x000040, 5, 12515, 12644, 13967, 14220, 14095, 500,  tpz.ki.GALLANT_ARMOR_CLAIM_SLIP,
    8,  4, 0x000080, 5, 12516, 12645, 13968, 14221, 14096, 500,  tpz.ki.CHAOS_ARMOR_CLAIM_SLIP,
    9,  4, 0x000100, 5, 12517, 12646, 13969, 14222, 14097, 500,  tpz.ki.BEAST_ARMOR_CLAIM_SLIP,
    10, 4, 0x000200, 5, 13857, 12647, 13970, 14223, 14098, 500,  tpz.ki.CHORAL_ATTIRE_CLAIM_SLIP,
    11, 4, 0x000400, 5, 12518, 12648, 13971, 14224, 14099, 500,  tpz.ki.HUNTERS_ATTIRE_CLAIM_SLIP,
    12, 4, 0x000800, 5, 13868, 13781, 13972, 14225, 14100, 500,  tpz.ki.MYOCHIN_ARMOR_CLAIM_SLIP,
    13, 4, 0x001000, 5, 13869, 13782, 13973, 14226, 14101, 500,  tpz.ki.NINJAS_GARB_CLAIM_SLIP,
    14, 4, 0x002000, 5, 12519, 12649, 13974, 14227, 14102, 500,  tpz.ki.DRACHEN_ARMOR_CLAIM_SLIP,
    15, 4, 0x004000, 5, 12520, 12650, 13975, 14228, 14103, 500,  tpz.ki.EVOKERS_ATTIRE_CLAIM_SLIP,
    16, 1, 0x000001, 5, 13871, 13783, 14001, 14243, 14118, 600,  tpz.ki.IRON_SCALE_ARMOR_CLAIM_SLIP,
    17, 1, 0x000002, 5, 15165, 14426, 14858, 14327, 15315, 300,  tpz.ki.SHADE_HARNESS_CLAIM_SLIP,
    18, 1, 0x000004, 5, 12433, 12561, 12689, 12817, 12945, 400,  tpz.ki.BRASS_SCALE_MAIL_CLAIM_SLIP,
    19, 1, 0x000008, 5, 12474, 12602, 12730, 12858, 12986, 400,  tpz.ki.WOOL_ROBE_CLAIM_SLIP,
    20, 1, 0x000010, 5, 15167, 14431, 14860, 14329, 15317, 200,  tpz.ki.EISENPLATTE_ARMOR_CLAIM_SLIP,
    21, 1, 0x000020, 5, 12458, 12586, 12714, 12842, 12970, 400,  tpz.ki.SOIL_GI_CLAIM_SLIP,
    22, 1, 0x000040, 5, 15163, 14424, 14856, 14325, 15313, 200,  tpz.ki.SEERS_TUNIC_CLAIM_SLIP,
    23, 1, 0x000080, 5, 12442, 12570, 12698, 12826, 12954, 400,  tpz.ki.STUDDED_ARMOR_CLAIM_SLIP,
    24, 1, 0x000100, 5, 12438, 12566, 12694, 12822, 12950, 200,  tpz.ki.CENTURION_SCALE_MAIL_CLAIM_SLIP,
    25, 1, 0x000200, 5, 12470, 12598, 12726, 12854, 12982, 200,  tpz.ki.MRCCPT_DOUBLET_CLAIM_SLIP,
    26, 1, 0x000400, 5, 15164, 14425, 14857, 14326, 15314, 400,  tpz.ki.GARISH_TUNIC_CLAIM_SLIP,
    27, 1, 0x000800, 5, 15161, 14422, 14854, 14323, 15311, 200,  tpz.ki.NOCT_DOUBLET_CLAIM_SLIP,
    28, 2, 0x000001, 4, 0,     12654, 12761, 12871, 13015, 250,  tpz.ki.CUSTOM_ARMOR_MALE_CLAIM_SLIP,
    29, 2, 0x000002, 4, 0,     12655, 12762, 12872, 13016, 250,  tpz.ki.CUSTOM_ARMOR_FEMALE_CLAIM_SLIP,
    30, 2, 0x000004, 4, 0,     12656, 12763, 12873, 13017, 250,  tpz.ki.MAGNA_ARMOR_MALE_CLAIM_SLIP,
    31, 2, 0x000008, 4, 0,     12657, 12764, 12874, 13018, 250,  tpz.ki.MAGNA_ARMOR_FEMALE_CLAIM_SLIP,
    32, 2, 0x000010, 4, 0,     12658, 12765, 12875, 13019, 250,  tpz.ki.WONDER_ARMOR_CLAIM_SLIP,
    33, 2, 0x000020, 4, 0,     12659, 12766, 12876, 13020, 250,  tpz.ki.SAVAGE_ARMOR_CLAIM_SLIP,
    34, 2, 0x000040, 4, 0,     12660, 12767, 12877, 13021, 250,  tpz.ki.ELDER_ARMOR_CLAIM_SLIP,
    35, 2, 0x000080, 4, 0,     12610, 12738, 12866, 12994, 500,  tpz.ki.LINEN_CLOAK_CLAIM_SLIP,
    36, 2, 0x000100, 5, 12450, 12578, 12706, 12836, 12962, 500,  tpz.ki.PADDED_ARMOR_CLAIM_SLIP,
    37, 2, 0x000200, 5, 12425, 12553, 12681, 12809, 12937, 500,  tpz.ki.SILVER_CHAINMAIL_CLAIM_SLIP,
    38, 2, 0x000400, 5, 12466, 12594, 12722, 12850, 12978, 600,  tpz.ki.GAMBISON_CLAIM_SLIP,
    39, 2, 0x000800, 5, 12424, 12552, 12680, 12808, 12936, 150,  tpz.ki.IRON_CHAINMAIL_CLAIM_SLIP,
    40, 2, 0x001000, 5, 12443, 12571, 12699, 12827, 12955, 600,  tpz.ki.CUIR_ARMOR_CLAIM_SLIP,
    41, 2, 0x002000, 5, 12475, 12603, 12731, 12859, 12987, 600,  tpz.ki.VELVET_ROBE_CLAIM_SLIP,
    42, 2, 0x004000, 4, 13931, 14384, 0,     14249, 14116, 600,  tpz.ki.OPALINE_DRESS_CLAIM_SLIP,
    43, 2, 0x008000, 5, 12431, 12559, 12687, 12815, 12943, 300,  tpz.ki.RYLSQR_CHAINMAIL_CLAIM_SLIP,
    44, 2, 0x010000, 5, 12416, 12544, 12672, 12800, 12928, 600,  tpz.ki.PLATE_ARMOR_CLAIM_SLIP,
    45, 2, 0x020000, 4, 0,     12614, 12743, 12870, 12998, 600,  tpz.ki.COMBAT_CASTERS_CLOAK_CLAIM_SLIP,
    46, 3, 0x000001, 5, 15205, 14444, 14051, 15402, 15341, 700,  tpz.ki.ALUMINE_HAUBERT_CLAIM_SLIP,
    47, 3, 0x000002, 5, 13711, 13712, 13713, 12837, 13715, 700,  tpz.ki.CARAPACE_HARNESS_CLAIM_SLIP,
    48, 3, 0x000004, 5, 12426, 12554, 12682, 12810, 12938, 800,  tpz.ki.BANDED_MAIL_CLAIM_SLIP,
    49, 3, 0x000008, 5, 12459, 12587, 12715, 12843, 12974, 800,  tpz.ki.HARA_ATE_CLAIM_SLIP,
    50, 3, 0x000010, 5, 12444, 12572, 12700, 12828, 12956, 800,  tpz.ki.RAPTOR_ARMOR_CLAIM_SLIP,
    51, 3, 0x000020, 5, 13873, 13785, 14003, 14245, 14120, 800,  tpz.ki.STEEL_SCALE_CLAIM_SLIP,
    52, 3, 0x000040, 5, 12467, 12595, 12723, 12851, 12979, 800,  tpz.ki.WOOL_GAMBISON_CLAIM_SLIP,
    53, 3, 0x000080, 5, 12460, 12588, 12716, 12844, 12972, 800,  tpz.ki.SHINOBI_GI_CLAIM_SLIP,
    54, 3, 0x000200, 5, 12422, 12550, 12678, 12806, 12934, 800,  tpz.ki.IRNMSK_CUIRASS_CLAIM_SLIP,
    55, 3, 0x000400, 5, 12478, 12606, 12734, 12862, 12990, 800,  tpz.ki.TCTMGC_CLOAK_CLAIM_SLIP,
    56, 3, 0x000800, 4, 0,     12611, 12739, 12867, 12995, 800,  tpz.ki.WHITE_CLOAK_CLAIM_SLIP,
    57, 3, 0x001000, 5, 13939, 13814, 14826, 14310, 14189, 800,  tpz.ki.AUSTERE_ROBE_CLAIM_SLIP,
    58, 3, 0x000100, 5, 12417, 12545, 12673, 12801, 12929, 800,  tpz.ki.MYTHRIL_PLATE_ARMOR_CLAIM_SLIP,
    59, 3, 0x002000, 5, 15242, 14498, 14907, 15578, 15663, 800,  tpz.ki.CROW_JUPON_CLAIM_SLIP,
    60, 4, 0x008000, 5, 15265, 14521, 14928, 15600, 15684, 500,  tpz.ki.MAGUS_ATTIRE_CLAIM_SLIP,
    61, 4, 0x010000, 5, 15266, 14522, 14929, 15601, 15685, 500,  tpz.ki.CORSAIRS_ATTIRE_CLAIM_SLIP,
    62, 4, 0x020000, 5, 15267, 14523, 14930, 15602, 15686, 500,  tpz.ki.PUPPETRY_ATTIRE_CLAIM_SLIP,
    63, 6, 0x000001, 5, 15072, 15087, 15102, 15117, 15132, 1000, tpz.ki.WARRIORS_ARMOR_CLAIM_SLIP,
    64, 6, 0x000002, 5, 15073, 15088, 15103, 15118, 15133, 1000, tpz.ki.MELEE_ATTIRE_CLAIM_SLIP,
    65, 6, 0x000004, 5, 15074, 15089, 15104, 15119, 15134, 1000, tpz.ki.CLERICS_ATTIRE_CLAIM_SLIP,
    66, 6, 0x000008, 5, 15075, 15090, 15105, 15120, 15135, 1000, tpz.ki.SORCERERS_ATTIRE_CLAIM_SLIP,
    67, 6, 0x000010, 5, 15076, 15091, 15106, 15121, 15136, 1000, tpz.ki.DUELISTS_ARMOR_CLAIM_SLIP,
    68, 6, 0x000020, 5, 15077, 15092, 15107, 15122, 15137, 1000, tpz.ki.ASSASSINS_ATTIRE_CLAIM_SLIP,
    69, 6, 0x000040, 5, 15078, 15093, 15108, 15123, 15138, 1000, tpz.ki.VALOR_ARMOR_CLAIM_SLIP,
    70, 6, 0x000080, 5, 15079, 15094, 15109, 15124, 15139, 1000, tpz.ki.ABYSS_ARMOR_CLAIM_SLIP,
    71, 6, 0x000100, 5, 15080, 15095, 15110, 15125, 15140, 1000, tpz.ki.MONSTER_ARMOR_CLAIM_SLIP,
    72, 6, 0x000200, 5, 15081, 15096, 15111, 15126, 15141, 1000, tpz.ki.BARDS_ATTIRE_CLAIM_SLIP,
    73, 6, 0x000400, 5, 15082, 15097, 15112, 15127, 15142, 1000, tpz.ki.SCOUTS_ATTIRE_CLAIM_SLIP,
    74, 6, 0x000800, 5, 15083, 15098, 15113, 15128, 15143, 1000, tpz.ki.SAOTOME_ARMOR_CLAIM_SLIP,
    75, 6, 0x001000, 5, 15084, 15099, 15114, 15129, 15144, 1000, tpz.ki.KOGA_GARB_CLAIM_SLIP,
    76, 6, 0x002000, 5, 15085, 15100, 15115, 15130, 15145, 1000, tpz.ki.WYRM_ARMOR_CLAIM_SLIP,
    77, 6, 0x004000, 5, 15086, 15101, 15116, 15131, 15146, 1000, tpz.ki.SUMMONERS_ATTIRE_CLAIM_SLIP,
    78, 4, 0x040000, 5, 16138, 14578, 15002, 15659, 15746, 500,  tpz.ki.DANCERS_ATTIRE_CLAIM_SLIP_M,
    79, 4, 0x080000, 5, 16139, 14579, 15003, 15660, 15747, 500,  tpz.ki.DANCERS_ATTIRE_CLAIM_SLIP_F,
    80, 4, 0x100000, 5, 16140, 14580, 15004, 16311, 15748, 500,  tpz.ki.SCHOLARS_ATTIRE_CLAIM_SLIP,
    81, 4, 0x200000, 5, 16062, 14525, 14933, 15604, 15688, 1000, tpz.ki.AMIR_ARMOR_CLAIM_SLIP,
    82, 4, 0x400000, 5, 16069, 14530, 14940, 15609, 15695, 1000, tpz.ki.PAHLUWAN_ARMOR_CLAIM_SLIP,
    83, 4, 0x800000, 5, 16064, 14527, 14935, 15606, 15690, 1000, tpz.ki.YIGIT_ARMOR_CLAIM_SLIP,
    84, 6, 0x008000, 5, 11465, 11292, 15025, 16346, 11382, 1000, tpz.ki.MIRAGE_ATTIRE_CLAIM_SLIP,
    85, 6, 0x010000, 5, 11468, 11295, 15028, 16349, 11385, 1000, tpz.ki.COMMODORE_ATTIRE_CLAIM_SLIP,
    86, 6, 0x020000, 5, 11471, 11298, 15031, 16352, 11388, 1000, tpz.ki.PANTIN_ATTIRE_CLAIM_SLIP,
    87, 6, 0x040000, 5, 11478, 11305, 15038, 16360, 11396, 1000, tpz.ki.ETOILE_ATTIRE_CLAIM_SLIP,
    88, 6, 0x080000, 5, 11480, 11307, 15040, 16362, 11398, 1000, tpz.ki.ARGUTE_ATTIRE_CLAIM_SLIP,
    89, 2, 0x040000, 2, 0,     11310, 0,     16365, 0,     600,  tpz.ki.ARGENT_ATTIRE_CLAIM_SLIP,
}

tpz.armorStorage.onTrade = function(player, trade, deposit)
    local returnValue = false

    for i = 1, #armorSets, 11 do
        local T1 = trade:hasItemQty(armorSets[i + 5], 1)

        if T1 then
            if not player:hasKeyItem(armorSets[i + 10]) then
                if trade:getItemCount() == armorSets[i + 3] then
                    local T2 = trade:hasItemQty(armorSets[i + 4], 1) or armorSets[i + 4] == 0
                    local T3 = trade:hasItemQty(armorSets[i + 6], 1) or armorSets[i + 6] == 0
                    local T4 = trade:hasItemQty(armorSets[i + 7], 1) or armorSets[i + 7] == 0
                    local T5 = trade:hasItemQty(armorSets[i + 8], 1) or armorSets[i + 8] == 0

                    if T2 and T3 and T4 and T5 then
                        player:startEvent(deposit, 0, 0, 0, 0, 0, armorSets[i + 9])
                        player:addKeyItem(armorSets[i + 10])
                        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, armorSets[i + 10])
                        returnValue = true
                        break
                    end
                end
            end
        end
    end

    return returnValue
end

tpz.armorStorage.onTrigger = function(player, withdrawal)
    local G1 = 0
    local G2 = 0
    local G3 = 0
    local G4 = 0
    local G5 = 0

    for i = 11, #armorSets, 11 do
        if player:hasKeyItem(armorSets[i]) then
            local group = armorSets[i - 9]
            local mask  = armorSets[i - 8]

            if group == 1 then
                G1 = G1 + mask
            elseif group == 2 then
                G2 = G2 + mask
            elseif group == 3 then
                G3 = G3 + mask
            elseif group == 4 then
                G4 = G4 + mask
            elseif group == 6 then
                G5 = G5 + mask
            end
        end
    end

    player:startEvent(withdrawal, G1, G2, G3, G4, player:getGil(), G5)
end

tpz.armorStorage.onEventUpdate = function(player, csid, option, withdrawal)
    if csid == withdrawal then
        player:updateEvent(
            armorSets[option * 11 - 6],
            armorSets[option * 11 - 5],
            armorSets[option * 11 - 4],
            armorSets[option * 11 - 3],
            armorSets[option * 11 - 2],
            armorSets[option * 11 - 1]
        )
    end
end

tpz.armorStorage.onEventFinish = function(player, csid, option, deposit, withdrawal)
    if csid == deposit then
        player:tradeComplete()

    elseif csid == withdrawal then
        if option > 0 and option <= armorSets[#armorSets] - 10 then
            local idx   = (option * 11) - 10
            local count = armorSets[idx + 3]
            local cost  = armorSets[idx + 9]
            local ki    = armorSets[idx + 10]

            if player:hasKeyItem(ki) and player:getFreeSlotsCount() >= count and player:getGil() >= cost then
                for i = 4, 8 do
                    local itemId = armorSets[idx + i]
                    if itemId > 0 then
                        player:addItem(itemId, 1)
                        player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
                    end
                end
                player:delKeyItem(ki)
                player:setGil(player:getGil() - cost)
            else
                for i = 4, 8 do
                    local itemId = armorSets[idx + i]
                    if itemId > 0 then
                        player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, itemId)
                    end
                end
            end
        end
    end
end
