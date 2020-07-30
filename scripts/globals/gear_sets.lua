-----------------------------------
-- Gear sets
-- Allows the use of gear sets with modifiers
-----------------------------------
require("scripts/globals/status")
-----------------------------------

local matchtype = {
    any            = 0,
    earring_weapon = 1,
    weapon_weapon  = 2,
    ring_armor     = 3
}

-- placeholder for unknown mod types
local MOD_UNKNOWN = 0

-- apparently these are static, so i'll leave them here
local extraDamageChance = 35
local extraAttackChance = 25
local nullDamageChance = 15
local instantCastChance = 15


--              {id, {item, ids, in, no, particular, order}, minimum matches required, match type, mods{id, value, modvalue for each additional match, additional whole set bonus}
local GearSets =  {
             {id = 1, items = {16092, 14554, 14969, 15633, 15719},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 500, 0, 0}} },    --  Usukane's set (5% Haste)
             {id = 2, items = {16088, 14550, 14965, 15629, 15715},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.CRITHITRATE, 5, 0, 0}} },    --  Skadi's set (5% critrate is guess)
             {id = 3, items = {16084, 14546, 14961, 15625, 15711},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.DOUBLE_ATTACK, 5, 0, 0}} },  --  Ares's set (5% DA)
             {id = 4, items = {16107, 14569, 14984, 15648, 15734},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.ACC, 20, 0, 0}} },           --  Denali Jacket Set (Increases Accuracy +20)
             {id = 5, items = {16106, 14568, 14983, 15647, 15733},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.HPP, 10, 0, 0}} },           --  Askar Korazin Set (Max HP Boost %10)
             {id = 6, items = {16069, 14530, 14940, 15609, 15695},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.SUBTLE_BLOW, 8, 0, 0}} },    --  Pahluwan Khazagand Set (8% is guess)
             {id = 7, items = {16100, 14562, 14977, 15641, 15727},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.MATT, 5, 0, 0}} },           --  Morrigan's Robe Set (+5 Magic. Atk Bonus)
             {id = 8, items = {16096, 14558, 14973, 15637, 15723},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.FASTCAST, 5, 0, 0}} },       --  Marduk's Jubbah Set (5% fastcast)
             {id = 9, items = {16108, 14570, 14985, 15649, 15735},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.MDEF, 10, 0, 0}} },          --  Goliard Saio Set - Total Set Bonus +10% Magic Def. Bonus

             {id = 10, items = {16064, 14527, 14935, 15606, 15690},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.REFRESH, 1, 0, 0}} },      --  Yigit Gomlek Set (1mp per tick) Adds "Refresh" effect
             {id = 11, items = {11503, 13759, 12745, 14210, 11413},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 500, 0, 0}} },   --  Perle Hauberk Set 5% haste
             {id = 12, items = {11504, 13760, 12746, 14257, 11414},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.STORETP, 8, 0, 0}} },      --  Aurore Doublet Set  store tp +8
             {id = 13, items = {11505, 13778, 12747, 14258, 11415},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.FASTCAST, 4, 2, 0}} },    -- Teal Set: Fast Cast +4-10%
             {id = 14, items = {10890, 10462, 10512, 11980, 10610},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 600, 0, 0}} },   --  Calma Armor Set haste%6
             {id = 15, items = {10892, 10464, 10514, 11982, 10612},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.MACC, 5, 0, 0}} },        --  Magavan Armor Set  magic accuracy +5
             {id = 16, items = {10891, 10463, 10513, 11981, 10611},  matches = 5, matchType = matchtype.any, mods = {{tpz.mod.CRITHITRATE, 5, 0, 0}} },  --  Mustela Harness Set  crit rate 5%
             {id = 17, items = {16126, 15744}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.RATT, 15, 0, 0}} }, -- Bowman's set: Ranged atk +15
             {id = 18, items = {16147, 14589, 15010, 16316, 15756},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ATT, 1, 4.7, 0}} },        --  Fourth Division Brune Set
             {id = 19, items = {16148, 14590, 15011, 16317, 15757},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.COUNTER, 1, 1, 0}} },      --  Cobra Unit Harness Set
             {id = 20, items = {16149, 14591, 15012, 16318, 15758},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MACC, 1, 1, 0}} },        --  Cobra Unit Robe Set
             {id = 21, items = { 6141, 14581, 15005, 16312, 15749},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 1, 1, 0}, {tpz.mod.ATT, 1, 1, 0}} },       --  Iron Ram Chainmail Set. Double mod here! It is why it has 2 IDs.
             {id = 23, items = {16142, 14582, 15006, 16313, 15750} , matches = 2, matchType = matchtype.any, mods = {{tpz.mod.HP, 10, 10, 0}} },        --  Fourth Division Cuirass Set
             {id = 24, items = {16143, 14583, 15007, 16314, 15751} , matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MP, 10, 10, 0}} },        --  Cobra Unit Coat Set
             {id = 25, items = {16062, 14525, 14933, 15604, 15688} , matches = 5, matchType = matchtype.any, mods = {{tpz.mod.UDMGBREATH, -8, 0, 0}, {tpz.mod.UDMGMAGIC, -8, 0, 0}} },       --  Amir Korazin Set - Double mod here! It is why it has 2 IDs.

             {id = 27, items = {11281, 15015, 16337, 11364}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.STORETP, 5, 5, 5}} },             --  Hachiryu Haramaki Set - Store tp
             {id = 28, items = {11064, 11084, 11104, 11124, 11144}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.DA_DOUBLE_DAMAGE, 5, 0, 0}} }, --  Ravager's Armor +2 Set - Double attack double damage chance

             {id = 29, items = {11808, 11824, 11850, 11857, 11858}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DOUBLE_ATTACK, 5, 0, 0}} },   --  Fazheluo Mail Set. Set Bonus: "Double Attack"+5%. Active with any 2 pieces.

             {id = 30, items = {11809, 11825, 11851, 11855, 11859}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 800, 0, 0}} }, --  Cuauhtli Harness Set. Set Bonus: Haste+8%. Active with any 2 pieces.

             {id = 31, items = {11810, 11826, 11852, 11856, 11860}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MACC, 5, 0, 0}} },    --  Hyskos Robe Set. Set Bonus: Magic Accuracy+5. Active with any 2 pieces.
             {id = 32, items = {10876, 10450, 10500, 11969, 10600}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.REFRESH, 1, 0.4, 0}} },     --  Ogier's Armor Set. Set Bonus: Adds "Refresh" tpz.effect. Provides 1 mp/tick for 2-3 pieces worn, 2 mp/tick for 4-5 pieces worn.
             {id = 33, items = {10877, 10451, 10501, 11970, 10601}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.CRITHITRATE, 1, 1, 0}} },   --  Athos's Armor Set. Set Bonus: Increases rate of critical hits. Gives +3% for the first 2 pieces and +1% for every additional piece.

             -- hipster set, stick it in HipsterSets below so we can handle it separately (still need to check if it's a set, though)
             {id = 34, items = {10878, 10452, 10502, 11971, 10602}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.FASTCAST, 10, 0, 0}} },        --  Rubeus Armor Set. Set Bonus: Enhances "Fast Cast" tpz.effect. 2 or 3 pieces equipped: Fast Cast +4, 4 or 5 pieces equipped: Fast Cast +10
             {id = 35, items = {11080, 11100, 11120, 11140, 11160}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.QUICK_DRAW_TRIPLE_DAMAGE, extraDamageChance, 0, 0}} },        --  Navarch's Attire +2 Set. Set Bonus: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
             {id = 36, items = {11082, 11102, 11122, 11142, 11162}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.SAMBA_DOUBLE_DAMAGE, 1, 1.8, 0}} },                         --  Charis Attire +2 Set. Set Bonus: Augments "Samba". Occasionally doubles damage with Samba up. Adds approximately 1-2% per piece past the first.
             {id = 37, items = {11076, 11096, 11116, 11136, 11156}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.EXTRA_DUAL_WIELD_ATTACK, extraAttackChance, 0, 0}} },         --  Iga Garb +2 Set. Set Bonus: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
             {id = 38, items = {11074, 11094, 11114, 11134, 11154}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.RAPID_SHOT_DOUBLE_DAMAGE, extraDamageChance, 0, 0}} },        --  Sylvan Attire +2 Set. Set Bonus: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
             {id = 39, items = {11070, 11090, 11110, 11130, 11150}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.ABSORB_DMG_CHANCE, 1, 1, 0}} },                          --  Creed Armor +2 Set. Set Bonus: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
             {id = 40, items = {11075, 11095, 11115, 11135, 11155}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.ZANSHIN_DOUBLE_DAMAGE, extraDamageChance, 0, 0}} },          --  Unkai Domaru +2 Set. Set Bonus: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
             {id = 41, items = {11065, 11085, 11105, 11125, 11145}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.EXTRA_KICK_ATTACK, extraAttackChance, 0, 0}} },             --  Tantra Attire +2 Set. Set Bonus: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
             {id = 42, items = {11069, 11089, 11109, 11129, 11149}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.TA_TRIPLE_DAMAGE, extraDamageChance, 0, 0}} },              --  Raider's Attire +2 Set. Set Bonus: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
             {id = 43, items = {11066, 11086, 11106, 11126, 11146}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.BAR_ELEMENT_NULL_CHANCE, nullDamageChance, 0, 0}} },        --  Orison Attire +2 Set. Set Bonus: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
             {id = 44, items = {11083, 11103, 11123, 11143, 11163}, matches = 5, matchType = matchtype.any, mods = {{tpz.mod.GRIMOIRE_INSTANT_CAST, instantCastChance, 0, 0}} },          --  Savant's Attire +2 Set. Set Bonus: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
             {id = 45, items = {16005, 17756, 17962, 18596, 18760, 19112, 19215, 19271, 19156}, matches = 2, matchType = matchtype.earring_weapon, mods = {{tpz.mod.HP, 30, 0, 0}, {tpz.mod.VIT, 6, 0, 0}, {tpz.mod.ACC, 6, 0, 0}, {tpz.mod.RACC, 6, 0, 0}} }, --  Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)
             {id = 45, items = {17756, 17962, 18596, 18760, 19112, 19215, 19271, 19156}, matches = 2, matchType = matchtype.weapon_weapon, mods = {{tpz.mod.HP, 30, 0, 0}, {tpz.mod.VIT, 6, 0, 0}, {tpz.mod.ACC, 6, 0, 0}, {tpz.mod.RACC, 6, 0, 0}} }, --  Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)

             {id = 49, items = {18761, 18597, 17757, 19218, 18128, 18500, 16004, 18951}, matches = 2, matchType = matchtype.earring_weapon, mods = {{tpz.mod.STR, 6, 0, 0}, {tpz.mod.ATT, 4, 0, 0}, {tpz.mod.RATT, 4, 0, 0}, {tpz.mod.MATT, 2, 0, 0}} }, --  Supremacy Earring Sets. Set Bonus: STR+6, Attack+4, Ranged Attack+4, "Magic Atk. Bonus"+2. Active with any 2 items(Earring+Weapon)

             {id = 53, items = {16006, 18450, 18499, 18861, 18862, 18952, 19111, 19217, 19272}, matches = 2, matchType = matchtype.earring_weapon, mods = {{tpz.mod.EVA, 10, 0, 0}, {tpz.mod.HPHEAL, 10, 0, 0}, {tpz.mod.ENMITY, -5, 0, 0}} }, --  Brilliant Earring Set. Set Bonus: Evasion, HP Recovered while healing, Reduces Emnity. Active with any 2 items(Earring+Weapon)
             {id = 56, items = {11798, 11362}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.RERAISE_III, 1, 0, 0}} },        -- Twilight Mail Set. Set Bonus: Auto-Reraise
             {id = 57, items = {18244, 17595}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },        -- Begin Jailer weapons: Set is weapon + Virtue stone, bonus 50% extra melee swing.
             {id = 58, items = {18244, 17710}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },
             {id = 59, items = {18244, 17948}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },
             {id = 60, items = {18244, 18100}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },
             {id = 61, items = {18244, 18222}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },
             {id = 62, items = {18244, 18360}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },
             {id = 63, items = {18244, 18397}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AMMO_SWING, 50, 0, 0}} },        -- End Jailer weapons
             {id = 71, items = {28520, 28521}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DOUBLE_ATTACK, 7, 0, 0}} }, -- Bladeborn/Steelflash Earrings
             {id = 72, items = {28522, 28523}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DUAL_WIELD, 7, 0, 0}} }, -- Dudgeon/Heartseeker Earrings
             {id = 73, items = {28524, 28525}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MACC, 12, 0, 0}} }, -- Psystorm/Lifestorm Earrings
             {id = 74, items = {26920, 26921, 27434, 27259, 27260, 26762, 26763, 27074, 27075, 27433}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ZANSHIN_DOUBLE_DAMAGE, extraDamageChance, 0, 0}} }, -- Samurai 109/119 af3
             {id = 75, items = {27414, 27413, 27240, 27239, 27055, 27054, 26901, 26900, 26743, 26742}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.EXTRA_KICK_ATTACK, extraAttackChance, 0, 0}} }, -- MNK 109/119 af3
             {id = 76, items = {26740, 26741, 27411, 27412, 27238, 27237, 27053, 27054, 26899, 26900}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DA_DOUBLE_DAMAGE, extraDamageChance, 0, 0}} }, -- 109/119 WAR AF3
             {id = 77, items = {26750, 26751, 27421, 27422, 27247, 27248, 27063, 27062, 26908, 26909}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.TA_TRIPLE_DAMAGE, extraDamageChance, 0, 0}} }, -- 109/119 THF AF3
             {id = 78, items = {26918, 26919, 26761, 26762, 27431, 27432, 27257, 27258, 27072, 27073}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.RAPID_SHOT_DOUBLE_DAMAGE, extraDamageChance, 0, 0}} }, -- 109/119 RNG AF3
             {id = 79, items = {26910, 26911, 26752, 26753, 27424, 27423, 27064, 27065, 27249, 27250}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ABSORB_DMG_CHANCE, nullDamageChance, 0, 0}} }, -- 109/119 PLD AF3
             {id = 80, items = {26922, 26923, 26764, 26765, 27076, 27077, 27261, 27262, 27435, 27436}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.EXTRA_DUAL_WIELD_ATTACK, extraAttackChance, 0, 0}} }, -- 109/119 NIN AF3
             {id = 81, items = {27443, 27444, 26772, 26773, 26930, 26931, 27084, 27085, 27269, 27270}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.QUICK_DRAW_TRIPLE_DAMAGE, extraDamageChance, 0, 0}} }, -- 109/119 COR AF3
             {id = 82, items = {27275, 27276, 27449, 27450, 26778, 26779, 26936, 26937, 27090, 27091}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.GRIMOIRE_INSTANT_CAST, instantCastChance, 0, 0}} }, -- 109/119 SCH AF3
             {id = 83, items = {27241, 27242, 27415, 27416, 26744, 26745, 26902, 26903, 27056, 27057}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.BAR_ELEMENT_NULL_CHANCE, nullDamageChance, 0, 0}} }, -- 109/119 WHM AF3
             {id = 84, items = {11867, 10868, 10865}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.REFRESH, 3, 0, 0}} }, -- Heka's body + NQ or HQ Khat = 3 tick refresh
             {id = 85, items = {10868, 11870, 11864, 10865}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.REFRESH, 2, 0, 0}} }, -- Nefer body/head NQ/HQ combo gives Refresh +2
             {id = 86, items = {15852, 15853}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.HP, 50, 0, 0}, {tpz.mod.MP, 50, 0, 0}} }, -- Dasra's/Nasatya's Ring set gives HP/MP +50
             {id = 88, items = {16037, 16038}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MATT, 5, 0, 0}, {tpz.mod.MACC, 5, 0, 0}} }, -- Helenus's/Cassandra's earring set: Mag atk bonus+5 and Mag acc +5
             {id = 90, items = {15850, 15851}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ATT, 6, 0, 0}, {tpz.mod.ACC, 12, 0, 0}, {tpz.mod.DEF, 6, 0, 0}} }, -- Lava's/Kusha's earring set: Atk+6/Acc+12
             {id = 93, items = {16146, 14588, 15009, 16315, 15755},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.FIRERES, 5, 5, 10}, {tpz.mod.ICERES, 5, 5, 10}, {tpz.mod.WINDRES, 5, 5, 10}, {tpz.mod.EARTHRES, 5, 5, 10}, {tpz.mod.THUNDERRES, 5, 5, 10}, {tpz.mod.WATERRES, 5, 5, 10}, {tpz.mod.LIGHTRES, 5, 5, 10}, {tpz.mod.DARKRES, 5, 5, 10}} }, --  Iron Ram Haubert Set
             {id = 101, items = {16035, 16036}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.AGI, 8, 0, 0}} }, -- Altdorf's/Wilhelm's earring: AGI+8
             {id = 102, items = {15042, 11402}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ATT, 5, 0, 0}, {tpz.mod.RATT, 5, 0, 0}} }, -- Gothic Gauntlets/Sabatons: Atk/RAtk +5
             {id = 104, items = {26713, 27853, 27999, 28140, 28279},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.FASTCAST, 4, 2, 0}} }, -- Teal Set +1: Fast Cast +4-10%
             {id = 105, items = {26712, 27852, 27998, 28139, 28278},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.STORETP, 2, 2, 0}} }, -- Aurore Set +1: Sore TP +2-8%
             {id = 106, items = {26711, 27851, 27997, 28138, 28277},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 200, 100, 0}} }, -- Perle Set +1: Haste +2-5%
             {id = 107, items = {27652, 27792, 27932, 28075, 28212},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.MATT, 3, 2, 0}} }, -- Morrigan's Attire Set +1: Magic Atk. Bonus +3-9%
             {id = 108, items = {27651, 27791, 27931, 28074, 28211},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.FASTCAST, 3, 2, 0}} }, -- Marduk's Attire Set +1: Fast Cast +3-9%
             {id = 109, items = {27650, 27790, 27930, 28073, 28210},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.HASTE_GEAR, 300, 200, 0}} }, -- Usukane Armor Set +1: Haste +3-9%
             {id = 110, items = {27649, 27789, 27929, 28072, 28209},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.CRITHITRATE, 3, 2, 0}} }, -- Skadi's Attire Set +1: Critical hit rate +3-9%
             {id = 111, items = {27648, 27788, 27928, 28071, 28208},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DOUBLE_ATTACK, 3, 2, 0}} }, -- Ares' Armor Set +1: Double Attack +3-9%
             {id = 112, items = {10315, 10598},  matches = 2, matchType = matchtype.any, mods = {{tpz.mod.DMGMAGIC, -5, 0, 0}} }, -- Alcedo Cuisses and Gauntlets: Magic damage taken -5%
             {id = 113, items = {26204, 25574, 25790, 25828, 25879, 25946}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.SUBTLE_BLOW, 5, 5, 0}} }, -- Sulevia's Armor Set +2: Subtle Blow +5-20 (Requires Sulevia's Ring to activate set effect)
             {id = 114, items = {26206, 25576, 25792, 25830, 25881, 25948}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.COUNTER, 4, 4, 0}} }, -- Hizamaru Armor Set +2: Counter +4-16% (Requires Hizamaru Ring to activate set effect)
             {id = 115, items = {26207, 25577, 25793, 25831, 25882, 25949}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.REFRESH, 1, 1, 0}} }, -- Inyanga Armor Set +2: Refresh +1-4 (Requires Inyanga Ring to activate set effect)
             {id = 116, items = {26205, 25575, 25791, 25829, 25880, 25947}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.REGEN, 3, 3, 0}} }, -- Meghanada Armor Set +2: Regen +3-12 (Requires Megahanada Ring to activate set effect)
             {id = 117, items = {26208, 25578, 25794, 25832, 25883, 25950}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.FAST_CAST, 1, 1, 0}} }, -- Jhakri Armor Set +2: Fast Cast +1-4% (Requires Jhakri Ring to activate set effect)
             {id = 118, items = {26211, 25569, 25797, 25385, 25886, 25953}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.STR, 8, 8, 0}, {tpz.mod.DEX, 8, 8, 0}, {tpz.mod.VIT, 8, 8, 0}} }, -- Flamma Armor Set +2 STR/DEX/VIT +8-32 (Requires Flamma Ring to activate set effect)
             {id = 121, items = {26210, 25573, 25796, 25834, 25885, 25952}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.DEX, 8, 8, 0}, {tpz.mod.VIT, 8, 8, 0}, {tpz.mod.CHR, 8, 8, 0}} }, -- Tali'ah Armor Set +2 DEX/VIT/CHR +8-32 (Requires Tali'ah Ring to activate set effect}
             {id = 124, items = {26212, 25570, 25798, 25836, 25887, 25954}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.DEX, 8, 8, 0}, {tpz.mod.AGI, 8, 8, 0}, {tpz.mod.CHR, 8, 8, 0}} }, -- Mummu Armor Set +2 DEX/AGI/CHR +8-32 (Requires Mummu Ring to activate set effect)
             {id = 127, items = {26209, 25572, 25795, 25833, 25884, 25951}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.STR, 8, 8, 0}, {tpz.mod.VIT, 8, 8, 0}, {tpz.mod.MND, 8, 8, 0}} }, -- Ayanmo Armor Set +2 STR/VIT/MND +8-32 (Requires Ayanmo Ring to activate set effect)
             {id = 130, items = {26213, 25571, 25799, 25837, 25888, 25955}, matches = 3, matchType = matchtype.ring_armor, mods = {{tpz.mod.VIT, 8, 8, 0}, {tpz.mod.INT, 8, 8, 0}, {tpz.mod.MND, 8, 8, 0}} }, -- Mallquis Armor Set +2 VIT/INT/MND +8-32 (Requires Mallquis Ring to activate set effect)
             {id = 133, items = {26191, 23308, 23643, 23241, 23576, 23174, 23509, 23107, 23442, 23040, 23375}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 WAR
             {id = 136, items = {26191, 23309, 23644, 23242, 23577, 23175, 23510, 23108, 23443, 23041, 23376}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 MNK
             {id = 139, items = {26085, 23310, 23645, 23243, 23578, 23176, 23511, 23109, 23444, 23042, 23377}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 WHM
             {id = 142, items = {26085, 23311, 23646, 23244, 23579, 23177, 23512, 23110, 23445, 23043, 23378}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BLM
             {id = 145, items = {26085, 23312, 23647, 23245, 23580, 23178, 23513, 23111, 23446, 23044, 23379}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RDM
             {id = 148, items = {26191, 23313, 23648, 23246, 23581, 23179, 23514, 23112, 23447, 23045, 23380}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 THF
             {id = 151, items = {26191, 23314, 23649, 23247, 23582, 23180, 23515, 23113, 23448, 23046, 23381}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 PLD
             {id = 154, items = {26191, 23315, 23650, 23248, 23583, 23181, 23516, 23114, 23449, 23047, 23382}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DRK
             {id = 157, items = {26191, 23316, 23651, 23249, 23584, 23182, 23517, 23115, 23450, 23048, 23383}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BST
             {id = 160, items = {26085, 23317, 23652, 23250, 23585, 23183, 23518, 23116, 23451, 23049, 23384}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BRD
             {id = 163, items = {26191, 23318, 23653, 23251, 23586, 23184, 23519, 23117, 23452, 23050, 23385}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RNG
             {id = 166, items = {26191, 23319, 23654, 23252, 23587, 23185, 23520, 23118, 23453, 23051, 23386}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SAM
             {id = 169, items = {26191, 23320, 23655, 23253, 23588, 23186, 23521, 23119, 23454, 23052, 23387}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 NIN
             {id = 172, items = {26191, 23321, 23656, 23254, 23589, 23187, 23522, 23120, 23455, 23053, 23388}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DRG
             {id = 175, items = {26342, 23322, 23657, 23255, 23590, 23188, 23523, 23121, 23456, 23054, 23389}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SMN
             {id = 178, items = {26085, 23323, 23658, 23256, 23591, 23189, 23524, 23122, 23457, 23055, 23390}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BLU
             {id = 181, items = {26191, 23324, 23659, 23257, 23592, 23190, 23525, 23123, 23458, 23056, 23391}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 COR
             {id = 184, items = {26191, 23325, 23660, 23258, 23593, 23191, 23526, 23124, 23459, 23057, 23392}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 PUP
             {id = 187, items = {26191, 23326, 23661, 23259, 23594, 23192, 23527, 23125, 23460, 23058, 23393}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DNC (M)
             {id = 190, items = {26191, 23327, 23662, 23260, 23595, 23193, 23528, 23126, 23461, 23059, 23394}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DNC (F)
             {id = 193, items = {26085, 23328, 23663, 23261, 23596, 23194, 23529, 23127, 23462, 23060, 23395}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SCH
             {id = 196, items = {26085, 23329, 23664, 23262, 23597, 23195, 23530, 23128, 23463, 23061, 23396}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 GEO
             {id = 199, items = {26191, 23330, 23665, 23263, 23598, 23196, 23531, 23129, 23464, 23062, 23397}, matches = 2, matchType = matchtype.any, mods = {{tpz.mod.ACC, 15, 0, 0}, {tpz.mod.RACC, 15, 0, 0}, {tpz.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RUN
        }

             -- increment id by (number of mods in previous gearset - 1)

--              {id, {item, ids, in, no, particular, order}, minimum matches required, match type, mods{id, value, modvalue for each additional match, additional whole set bonus}

local HipsterSets = {
    -- stick the ids of sets that need their own handling here e.g. Rubeus
    {id = 34, hipster = true},
    -- AF1 119 +2/+3 sets have 6 possible matching slots, but only 4 tiers. Using hipster to enforce a cap on buff level above 5 matches.
    {id = 133, hipster = true},
    {id = 136, hipster = true},
    {id = 139, hipster = true},
    {id = 142, hipster = true},
    {id = 145, hipster = true},
    {id = 148, hipster = true},
    {id = 151, hipster = true},
    {id = 154, hipster = true},
    {id = 157, hipster = true},
    {id = 160, hipster = true},
    {id = 163, hipster = true},
    {id = 166, hipster = true},
    {id = 169, hipster = true},
    {id = 172, hipster = true},
    {id = 175, hipster = true},
    {id = 178, hipster = true},
    {id = 181, hipster = true},
    {id = 184, hipster = true},
    {id = 187, hipster = true},
    {id = 190, hipster = true},
    {id = 193, hipster = true},
    {id = 196, hipster = true},
    {id = 199, hipster = true},
}

------------------------------------------
-- Checks for gear sets present on a player
-------------------------------------------
function checkForGearSet(player)
    -- print("---Removed existing gear set mods!---\n")
    player:clearGearSetMods()

    -- cause we dont want hundreds of function calls
    local equip = {}
    for slot = 0, tpz.MAX_SLOTID do
        equip[slot+1] = player:getEquipID(slot)
    end

    for index, gearset in pairs(GearSets) do
        local matches = 0
        if (player:hasGearSetMod(gearset.id) == false) then
            local slot = 0
            local gearMatch = {}

            for _, id in pairs(gearset.items) do
                for slot = 1, tpz.MAX_SLOTID do
                    local equipId = equip[slot]

                    -- check the item matches
                    if (equipId == id) then
                        matches = matches + 1
                        gearMatch[slot] = equipId
                        break
                    end
                end
            end

            -- doesnt count as a match if the same item is in both slots
            if (gearMatch[tpz.slot.EAR1+1] == gearMatch[tpz.slot.EAR2+1] and gearMatch[tpz.slot.EAR1+1] ~= nil) then
                matches = matches - 1
            end
            if (gearMatch[tpz.slot.RING1+1] == gearMatch[tpz.slot.RING2+1] and gearMatch[tpz.slot.RING1+1] ~= nil) then
                matches = matches - 1
            end
            if (gearMatch[tpz.slot.MAIN+1] == gearMatch[tpz.slot.SUB+1] and gearMatch[tpz.slot.MAIN+1] ~= nil) then
                matches = matches - 1
            end

            if (matches >= gearset.matches) then
                if (FindMatchByType(gearset, gearMatch) == true) then
                    ApplyMod(player, gearset, matches)
                end
            end
        end
    end
end

function FindMatchByType(gearset, gearMatch)
    if (gearset.matchType == matchtype.any) then
        return true
    elseif (gearset.matchType == matchtype.ring_armor and (gearMatch[tpz.slot.HEAD+1] ~= nil or gearMatch[tpz.slot.BODY+1] ~= nil or gearMatch[tpz.slot.HANDS+1] ~= nil or gearMatch[tpz.slot.LEGS+1] ~= nil or gearMatch[tpz.slot.FEET+1] ~= nil) and (gearMatch[tpz.slot.RING1+1] ~= nil or gearMatch[tpz.slot.RING2+1] ~= nil)) then
        return true
    end

    for _, id in ipairs(gearMatch) do
        if (gearset.matchType == matchtype.earring_weapon and (gearMatch[tpz.slot.MAIN+1] ~= nil or gearMatch[tpz.slot.SUB+1] ~= nil) and (gearMatch[tpz.slot.EAR1+1] ~= nil or gearMatch[tpz.slot.EAR2+1] ~= nil)) then
            return true
        elseif (gearset.matchType == matchtype.weapon_weapon and (gearMatch[tpz.slot.MAIN+1] ~= nil and gearMatch[tpz.slot.SUB+1] ~= nil)) then
            return true
        end
    end

    return false
end

---------------------------------------
-- Applys a gear set mod
---------------------------------------
function ApplyMod(player, gearset, matches)

    for _, set in pairs(HipsterSets) do
        if (set.id == gearset.id) then
            HandleHipsterSet(player, gearset, matches)
            return
        end
    end

    -- find any additional matches
    local addMatches = matches - gearset.matches

    -- just in case some d00d decides to customize things and complain the script is b0rked
    if (addMatches < 0) then
        return
    end

    local i = 0
    for _, mod in pairs(gearset.mods) do
        local modId = mod[1]
        local modValue = mod[2]

        -- value/multiplier for additional pieces
        local addMatchValue = mod[3]

        -- additional bonus for complete set
        local addSetBonus = 0

        -- cause we need all pieces to form a complete set
        if (matches == #gearset.items) then
            addSetBonus = mod[4]
        end

        -- add bonus mods per piece
        if (addMatches ~= 0 and addMatchValue ~= 0) then
            modValue = modValue + (addMatchValue * addMatches)
        end
        -- printf("gearset: %u, mod: %u, value %u", gearset.id, modId, modValue + addSetBonus)
        player:addGearSetMod(gearset.id + i, modId, modValue + addSetBonus)
        i = i + 1
    end
    -- print("Gear set! Mod applied: ModNameId:" .. modNameId .. " ModId:" .. modId .. " Value:" .. modValue .. "\n")
end

-- fkin hipsters
function HandleHipsterSet(player, gearset, matches)
    -- Rubeus Armor Set
    if (gearset.id == 34) then
        local modValue = 0

        if (matches > 1 and matches < 4) then
            modValue = 4 -- 2 or 3 pieces
        elseif (matches > 3) then
            modValue = 10 -- 4 or 5 pieces
        end
        -- printf("we have a special snowflake | gearset: %u | mod %u %u", gearset.id, tpz.mod.FASTCAST, modValue)
        player:addGearSetMod(gearset.id, tpz.mod.FASTCAST, modValue)
        return
    -- AF1 119+2/+3 ACC/RACC/MACC Sets EXCEPT SMN
    elseif (gearset.id >= 133 and gearset.id <= 199 and gearset.id ~= 175) then
        local modValue = 0

        if (matches == 2) then
            modValue = 15 -- 2 matches
        elseif (matches == 3) then
            modValue = 30 -- 3 matches
        elseif (matches == 4) then
            modValue = 45 -- 4 matches
        elseif (matches >= 5) then
            modValue = 60 -- 5 or more matches
        end
        player:addGearSetMod(gearset.id, tpz.mod.ACC, modValue)
        player:addGearSetMod(gearset.id + 1, tpz.mod.RACC, modValue)
        player:addGearSetMod(gearset.id + 2, tpz.mod.MACC, modValue)
        return
    -- AF1 119 +2/+3 SMN Avatar:ACC/RACC/MACC (unimplemented)
    elseif (gearset.id == 175) then
        local modValue = 0

        if (matches == 2) then
            modValue = 15 -- 2 matches
        elseif (matches == 3) then
            modValue = 30 -- 3 matches
        elseif (matches == 4) then
            modValue = 45 -- 4 matches
        elseif (matches >= 5) then
            modValue = 60 -- 5 or more matches
        end
        --Unimplemented method to add pet mods
        return
    end
end

--[[    Unimplemented sets below

=======
Stronghold NM(WOTG)
=======

-- Molione's Sickle Set
-------------
18947 -- Molione's Sickle
15818 -- Molione's Ring
-- Set Bonus: +5 Accuracy
-- Set Bonus: Enhances "Souleater" Effect

=======
Empyrean +2
=======

--Aoidos' Attire +2 Set
-------------
11073 -- Aoidos' Calot+2
11093 -- Aoidos' Hongreline +2
11113 -- Aoidos' Manchettes +2
11133 -- Aoidos' Rhingrave +2
11153 -- Aoidos' Cothurnes +2
-- Set Bonus: Augments Songs
-- Enhancing songs add an attribute bonus that corresponds to the element of the song (i.e. Thunder-based songs add +DEX). The attribute bonus begins at +1 for 2 pieces, increases by 1 for each additional piece, up to +5 for the whole set. For Dark-based songs, there is a bonus of +10 MP for 2 pieces, and increases by 10 for each additional piece.

--Ferine' Attire +2 Set
-------------
11072 -- Ferine Cabasset+2
11092 -- Ferine Gausape+2
11112 -- Ferine Manoplas+2
11132 -- Ferine Quijotes+2
11152 -- Ferine Ocreae+2
-- Set Bonus: Attack occ. varies with pet's HP
-- Occasionally increases damage in direct proportion to the percentage of pet's current HP. At 100% HP, damage is doubled when triggered, at 50% HP, damage increases by 50%, and so on.
-- 5% Proc Rate

--Goetia Attire +2 Set
-------------
11067 -- Goetia Petasos+2
11087 -- Goetia Coat+2
11107 -- Goetia Gloves+2
11127 -- Goetia Chausses+2
11147 -- Goetia Sabots+2
-- Set Bonus: Augments "Conserve MP"
-- Occasionally increases damage of elemental spells when Conserve MP is triggered. Increased amount is proportional to twice the ratio of MP conserved.

--Mavi Attire +2 Set
-------------
11079 -- Mavi Kavuk+2
11099 -- Mavi Mintan+2
11119 -- Mavi Bazubands+2
11139 -- Mavi Tayt+2
11159 -- Mavi Basmak+2
-- Set Bonus: Occ. augments blue magic spells.
-- no clue!


--Bale Armor +2 Set
-------------
11071 -- Bale Burgeonet+2
11091 -- Bale Cuirass+2
11111 -- Bale Gauntlets+2
11131 -- Bale Flanchard+2
11151 -- Bale Sollerets+2
-- Set Bonus: Attack occasionally varies with HP
-- Occasionally increases damage in direct proportion to the percentage of current HP. At 100% HP, damage is doubled when triggered, at 50% HP, damage increases by 50%, and so on.

--Lancer's Armor +2 Set
-------------
11077 -- Lancer's Mezail+2
11097 -- Lancer's Plackart+2
11117 -- Lancer's Vambrace+2
11137 -- Lancer's Cuissots+2
11157 -- Lancer's Schynbalds+2
-- Set Bonus: Attack occasionally varies with wyvern's HP.
-- Damage increases proportionate to Wyvern's HP, at 100%, damage is doubled. 2+ pieces required, more pieces increase proc rate. Full +2 set is about a 10% proc rate. (Confirmation needed)


--Cirque Attire +2 Set
-------------
11081 -- Cirque Capello+2
11101 -- Cirque Farsetto+2
11121 -- Cirque Gaunti+2
11141 -- Cirque Pantaloni+2
11161 -- Cirque Scarpe+2
-- Set Bonus: Attack occasionally varies with automaton's HP.
-- Occasionally increases damage in direct proportion to the percentage of Automaton's current HP. At 100% HP, damage is doubled when triggered, at 50% HP, damage increases by 50%, and so on.

--Estoqueur's Attire +2 Set
-------------
11068 -- Estoqueur's Chappel+2
11088 -- Estoqueur's Sayon+2
11108 -- Estoqueur's Gantherots+2
11128 -- Estoqueur's Fuseau+2
11148 -- Estoqueur's Houseaux+2
-- Set Bonus: Augments "Composure"
-- Enhances duration of Enhancing Magic cast on OTHERS while under the effect of Composure by 10% for the first 2 pieces, and 15% for any additional pieces thereafter, up to 35% increase for 4 pieces and 50% for all 5 pieces. The "Increases enhancing magic effect duration" of the Estoqueur's Cape, Estoqueur's Houseaux +1 and Estoqueur's Houseaux +2 is multiplicative to this total.

--Caller's Attire +2 Set
-------------
11078 -- Caller's Horn+2
11098 -- Caller's Doublet+2
11118 -- Caller's Bracers+2
11138 -- Caller's Spats+2
11158 -- Caller's Pigaches+2
-- Set Bonus: Augments "Blood Boon"
-- Occasionally increases damage of Blood Pacts when Blood Boon is triggered. Increased amount is proportional to the ratio of MP conserved.

]]--
