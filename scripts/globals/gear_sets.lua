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
-- local MOD_UNKNOWN = 0

-- AF3 (Empyrean) +2/109/119 set values are based on BGWiki notes.
-- Each set has a bonus with 2 pieces equipped, with each additional piece adding pieceBonus to the MOD.
-- Exceptions to this rule are manually defined.
local baseRate = 2
local pieceBonus = 1


--              {id, {item, ids, in, no, particular, order}, minimum matches required, match type, mods{id, value, modvalue for each additional match, additional whole set bonus}
local GearSets =  {
            {id =   1, items = {15042, 11402}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ATT, 5, 0, 0}, {xi.mod.RATT, 5, 0, 0}} },                        -- Gothic Gauntlets/Sabatons: Atk/RAtk +5
            {id =   3, items = { 6141, 14581, 15005, 16312, 15749}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 1, 1, 0}, {xi.mod.ATT, 1, 1, 0}} },    -- Iron Ram Chainmail Set. Double mod here! It is why it has 2 IDs.
            {id =   5, items = {16142, 14582, 15006, 16313, 15750}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HP, 10, 10, 0}} },                          -- Fourth Division Cuirass Set
            {id =   6, items = {16143, 14583, 15007, 16314, 15751}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MP, 10, 10, 0}} },                          -- Cobra Unit Coat Set
            {id =   7, items = {15850, 15851}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ATT, 6, 0, 0}, {xi.mod.ACC, 12, 0, 0}, {xi.mod.DEF, 6, 0, 0}} }, -- Lava's/Kusha's earring set: Atk+6/Acc+12
            {id =  10, items = {15852, 15853}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HP, 50, 0, 0}, {xi.mod.MP, 50, 0, 0}} },                         -- Dasra's/Nasatya's Ring set gives HP/MP +50
            {id =  12, items = {16035, 16036}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AGI, 8, 0, 0}} },                                                -- Altdorf's/Wilhelm's earring: AGI+8
            {id =  13, items = {16037, 16038}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MATT, 5, 0, 0}, {xi.mod.MACC, 5, 0, 0}} },                       -- Helenus's/Cassandra's earring set: Mag atk bonus+5 and Mag acc +5
            {id =  15, items = {16146, 14588, 15009, 16315, 15755},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.FIRE_RES, 5, 5, 10}, {xi.mod.ICE_RES, 5, 5, 10}, {xi.mod.WIND_RES, 5, 5, 10}, {xi.mod.EARTH_RES, 5, 5, 10}, {xi.mod.THUNDER_RES, 5, 5, 10}, {xi.mod.WATER_RES, 5, 5, 10}, {xi.mod.LIGHT_RES, 5, 5, 10}, {xi.mod.DARK_RES, 5, 5, 10}} },    -- Iron Ram Haubert Set (8 ids)
            {id =  23, items = {16147, 14589, 15010, 16316, 15756}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ATT, 1, 4.7, 0}} },                         -- Fourth Division Brune Set
            {id =  24, items = {16148, 14590, 15011, 16317, 15757}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.COUNTER, 1, 1, 0}} },                       -- Cobra Unit Harness Set
            {id =  25, items = {16149, 14591, 15012, 16318, 15758}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MACC, 1, 1, 0}} },                          -- Cobra Unit Robe Set
            {id =  26, items = {18761, 18597, 17757, 19218, 18128, 18500, 16004, 18951}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STR, 6, 0, 0}, {xi.mod.ATT, 4, 0, 0}, {xi.mod.RATT, 4, 0, 0}, {xi.mod.MATT, 2, 0, 0}} }, --  Supremacy Earring Sets. Set Bonus: STR+6, Attack+4, Ranged Attack+4, "Magic Atk. Bonus"+2. Active with any 2 items(Earring+Weapon)
            {id =  30, items = {16005, 17756, 17962, 18596, 18760, 19112, 19215, 19271, 19156}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HP, 30, 0, 0}, {xi.mod.VIT, 6, 0, 0}, {xi.mod.ACC, 6, 0, 0}, {xi.mod.RACC, 6, 0, 0}} }, --  Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)
            {id =  34, items = {16006, 18450, 18499, 18861, 18862, 18952, 19111, 19217, 19272}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.EVA, 10, 0, 0}, {xi.mod.HPHEAL, 10, 0, 0}, {xi.mod.ENMITY, -5, 0, 0}} }, --  Brilliant Earring Set. Set Bonus: Evasion, HP Recovered while healing, Reduces Emnity. Active with any 2 items(Earring+Weapon)
            {id =  37, items = {14999, 15745}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ENH_DRAIN_ASPIR, 5, 0, 0}} },                                     -- Vampric Mitts/Boots: Enhances Drain/Aspir +5
            {id =  38, items = {15000, 16169}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.VIT, 10, 0, 0}} },                                                -- Caballero Gauntlets / Shield: VIT +10
            {id =  39, items = {15001, 16125}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DEF, 10, 0, 0}, {xi.mod.ENMITY, 5, 0, 0}} },                      -- Breeder Mufflers / Mask: Pet: DEF +10 / Enmity +5
            {id =  41, items = {16126, 15744}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.RATT, 15, 0, 0}} },                                              -- Bowman's set: Ranged Attack +15
            {id =  42, items = {18947, 15818}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 5, 0, 0}, {xi.mod.SOULEATER_EFFECT, 2, 0, 0}} },            -- Moliones's Sickle/Ring: Souleater +2
            {id =  44, items = {15995, 16127}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.CHR, 15, 0, 0}} },                                                -- Carline Ribbon/Ring: CHR +15
            {id =  45, items = {16062, 14525, 14933, 15604, 15688}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.UDMGBREATH, -800, 0, 0}, {xi.mod.UDMGMAGIC, -800, 0, 0}} },       --  Amir Korazin Set - Double mod here! It is why it has 2 IDs.
            {id =  47, items = {16064, 14527, 14935, 15606, 15690}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.REFRESH, 1, 0, 0}} },                       -- Yigit Set: Adds "Refresh" effect +1
            {id =  48, items = {16069, 14530, 14940, 15609, 15695}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.SUBTLE_BLOW, 8, 0, 0}} },                   -- Pahluwan Set: Subtle Blow +8 (guess)
            {id =  49, items = {11281, 15015, 16337, 11364}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STORETP, 5, 5, 5}} },                              -- Hachiryu Set: Store TP 5/10/20
            {id =  50, items = {16084, 14546, 14961, 15625, 15711}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 5, 0, 0}} },                 -- Ares's Set: DA +5
            {id =  51, items = {16088, 14550, 14965, 15629, 15715}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.CRITHITRATE, 5, 0, 0}} },                   -- Skadi's Set: Crit Hit Rate + 5 (guess)
            {id =  52, items = {16092, 14554, 14969, 15633, 15719}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 500, 0, 0}} },                  -- Usukane's Set: Haste +5% (Gear)
            {id =  53, items = {16096, 14558, 14973, 15637, 15723}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.FASTCAST, 5, 0, 0}} },                      -- Marduk's Set: Fast Cast +5%
            {id =  54, items = {16100, 14562, 14977, 15641, 15727}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.MATT, 5, 0, 0}} },                          -- Morrigan's Set: +5 Magic. Atk Bonus
            {id =  55, items = {16106, 14568, 14983, 15647, 15733}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.HPP, 10, 0, 0}} },                          -- Askar Set: Max HP Boost %10
            {id =  56, items = {16107, 14569, 14984, 15648, 15734}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.ACC, 20, 0, 0}} },                          -- Denali Set: ACC 20
            {id =  57, items = {16108, 14570, 14985, 15649, 15735}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.MDEF, 10, 0, 0}} },                         -- Goliard Set: +10% Magic Def. Bonus
            {id =  58, items = {12999, 14041}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HP, 90, 0, 0}} },                                                -- Surrus Sabatons / Gauntlets: HP +90
            {id =  59, items = {13146, 13619}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 6000, 0, 0}} },                                      -- Tern Necklace / Cape: Haste +6% (Gear)
            {id =  60, items = {13000, 14042}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STORETP, 5, 0, 0}} },                                            -- Praeda Sabatons / Gauntlets: Store TP +5
            {id =  61, items = {11503, 13759, 12745, 14210, 11413}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 500, 0, 0}} },                  -- Perle Set: Haste +5% (Gear)
            {id =  62, items = {11504, 13760, 12746, 14257, 11414}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.STORETP, 8, 0, 0}} },                       -- Aurore Set: Store TP +8
            {id =  63, items = {11505, 13778, 12747, 14258, 11415}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.FASTCAST, 4, 2, 0}} },                      -- Teal Set: Fast Cast +4-10%
            {id =  64, items = {14085, 15019}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.CURE_POTENCY, 5, 0, 0}} },                                       -- Serpentes Sabots / Cuffs: Cure Potency +5%
            {id =  65, items = {11064, 11084, 11104, 11124, 11144}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DA_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },          -- Ravager +2 Set: Double attack double damage chance
            {id =  66, items = {11065, 11085, 11105, 11125, 11145}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.EXTRA_KICK_ATTACK, baseRate, pieceBonus, 0}} },         -- Tantra +2 Set: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
            {id =  67, items = {11066, 11086, 11106, 11126, 11146}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0}} },                   -- Orison +2 Set: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
            {id =  68, items = {11067, 11087, 11107, 11127, 11147}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_CONSERVE_MP, baseRate, pieceBonus, 0}} },      -- Goetia +2 Set: Augments Conserve MP to occasionally increase damage proportional to % of MP Conserved.
            {id =  69, items = {11068, 11088, 11108, 11128, 11148}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_COMPOSURE, 50, 0, 0}} },                       -- Estoqueur +2 Set: Enhances duration of Enhancing Magic cast on OTHERS while under the effect of Composure 10/15/35/50.
            {id =  70, items = {11069, 11089, 11109, 11129, 11149}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.TA_TRIPLE_DAMAGE, baseRate, pieceBonus, 0}} },          -- Raider +2 Set: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
            {id =  71, items = {11070, 11090, 11110, 11130, 11150}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ABSORB_DMG_CHANCE, baseRate, pieceBonus, 0}} },         -- Creed +2 Set: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
            {id =  72, items = {11071, 11091, 11111, 11131, 11151}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_HP, baseRate, pieceBonus, 0}} },         -- Bale +2 Set: Occasionally increases damage in direct proportion to the percentage of current HP.
            {id =  73, items = {11072, 11092, 11112, 11132, 11152}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },     -- Ferine +2 Set: Occasionally increases damage in direct proportion to the percentage of the pets current HP.
            {id =  74, items = {11073, 11093, 11113, 11133, 11153}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_SONG_STAT, 1, 1, 0}} },                         -- Aoidos +2 Set: Enhancing Songs add +1/2/3/4 to stat related to element (Fire = STR, Thunder = DEX, etc). Adds +10/20/30/40 MP for Dark based Songs.
            {id =  75, items = {11074, 11094, 11114, 11134, 11154}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },  -- Sylvan +2 Set: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
            {id =  76, items = {11075, 11095, 11115, 11135, 11155}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ZANSHIN_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },     -- Unkai +2 Set: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
            {id =  77, items = {11076, 11096, 11116, 11136, 11156}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0}} },                   -- Iga +2 Set: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
            {id =  78, items = {11077, 11097, 11117, 11137, 11157}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },     -- Lancer +2 Set: Occasionally increases damage in direct proportion to the percentage of the wyverns current HP.
            {id =  79, items = {11078, 11098, 11118, 11138, 11158}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_BLOOD_BOON, baseRate, pieceBonus, 0}} },        -- Caller +2 Set: Occasionally increases damage of Blood Pacts when Blood Boon is triggered. Increased amount is proportional to the ratio of MP conserved.
            {id =  80, items = {11079, 11099, 11119, 11139, 11159}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_BLU_MAGIC, baseRate, pieceBonus, 0}} },        -- Mavi +2 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
            {id =  81, items = {11080, 11100, 11120, 11140, 11160}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, baseRate, pieceBonus, 0}} },  -- Navarch +2 Set: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
            {id =  82, items = {11081, 11101, 11121, 11141, 11161}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },     -- Cirque +2 Set: Occasionally increases damage in direct proportion to the percentage of the automaton's current HP.
            {id =  83, items = {11082, 11102, 11122, 11142, 11162}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.SAMBA_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },       -- Charis +2 Set: Augments "Samba". Occasionally doubles damage with Samba up.
            {id =  84, items = {11083, 11103, 11123, 11143, 11163}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.GRIMOIRE_INSTANT_CAST, baseRate, pieceBonus, 0}} },     -- Savant +2 Set: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
            {id =  85, items = {11798, 11362}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.RERAISE_III, 1, 0, 0}} },                                        -- Twilight Set: Auto-Reraise III
            {id =  86, items = {11808, 11824, 11850, 11857, 11858}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 5, 0, 0}} },                 -- Fazheluo Set: "Double Attack"+5%.
            {id =  87, items = {11809, 11825, 11851, 11855, 11859}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 800, 0, 0}} },                  -- Cuauhtli Set: Haste+8%.
            {id =  88, items = {11810, 11826, 11852, 11856, 11860}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MACC, 5, 0, 0}} },                          -- Hyskos Set: Magic Accuracy+5.
            {id =  89, items = {26711, 27851, 27997, 28138, 28277}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 200, 100, 0}} },                -- Perle +1 Set: Haste +2-5%
            {id =  90, items = {26712, 27852, 27998, 28139, 28278}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STORETP, 2, 2, 0}} },                       -- Aurore +1 Set: Store TP +2-8%
            {id =  91, items = {26713, 27853, 27999, 28140, 28279}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.FASTCAST, 4, 2, 0}} },                      -- Teal +1 Set: Fast Cast +4-10%
            {id =  92, items = {10864, 10867, 11863, 11866, 11869}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.TRIPLE_ATTACK, 3, 0, 0}} },                 -- Ocelo/Toci Set: Triple Attack +3
            {id =  93, items = {10865, 10868, 11864, 11867, 11870}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.REFRESH, 2, 0, 0}} },                       -- Nefer/Heka Set: Refresh +2 (EX HQ Body Carries it's own Refresh)
            {id =  94, items = {10866, 10869, 11865, 11868, 11871}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 800, 0, 0}} },                  -- Mekira Set: Haste +8% (Gear)
            {id =  95, items = {10890, 10462, 10512, 11980, 10610}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 600, 0, 0}} },                  -- Calma Set: Haste +6% (Gear)
            {id =  96, items = {10891, 10463, 10513, 11981, 10611}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.CRITHITRATE, 5, 0, 0}} },                   -- Mustela Set: Crit Hit Rate +5
            {id =  97, items = {10892, 10464, 10514, 11982, 10612}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.MACC, 5, 0, 0}} },                          -- Magavan Set: Magic Accuracy +5
            {id =  98, items = {10876, 10450, 10500, 11969, 10600}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.REFRESH, 1, 0, 0}} },                       -- Ogier Set: Refresh - 2-3 Pieces 1/tick, 4-5 Pieces 2/tick.
            {id =  99, items = {10877, 10451, 10501, 11970, 10601}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.CRITHITRATE, 3, 1, 0}} },                   -- Athos Set: Increases rate of critical hits. Gives +3/4/5/6.
            {id = 100, items = {10878, 10452, 10502, 11971, 10602}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.FASTCAST, 10, 0, 0}} },                     -- Rubeus Set: Fast Cast - 2-3 pieces +4, 4-5 pieces +10
            {id = 101, items = {10315, 10598},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.DMGMAGIC, -500, 0, 0}} },                                       -- Alcedo Cuisses/Gauntlets: Magic damage taken -5%
            {id = 102, items = {10474, 10523, 10554, 10620, 10901}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STR, 15, 0, 0}, {xi.mod.VIT, 15, 0, 0}, {xi.mod.INT, 15, 0, 0}, {xi.mod.MND, 15, 0, 0}} },      -- Phorcys Set: STR/VIT/INT/MND +2/5/10/15
            {id = 106, items = {10479, 10528, 10559, 10625, 10906}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STR, 15, 0, 0}, {xi.mod.DEX, 15, 0, 0}, {xi.mod.AGI, 15, 0, 0}, {xi.mod.MND, 15, 0, 0}} },      -- Thaumas Set: STR/DEX/AGI/MND +2/5/10/15
            {id = 110, items = {10484, 10533, 10564, 10630, 10911}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.STR, 15, 0, 0}, {xi.mod.INT, 15, 0, 0}, {xi.mod.MND, 15, 0, 0}, {xi.mod.CHR, 15, 0, 0}} },      -- Nares Set: STR/INT/MND/CHR +2/5/10/15
            {id = 114, items = {26191, 23308, 23643, 23241, 23576, 23174, 23509, 23107, 23442, 23040, 23375}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 WAR
            {id = 118, items = {26191, 23309, 23644, 23242, 23577, 23175, 23510, 23108, 23443, 23041, 23376}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 MNK
            {id = 121, items = {26085, 23310, 23645, 23243, 23578, 23176, 23511, 23109, 23444, 23042, 23377}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 WHM
            {id = 124, items = {26085, 23311, 23646, 23244, 23579, 23177, 23512, 23110, 23445, 23043, 23378}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BLM
            {id = 127, items = {26085, 23312, 23647, 23245, 23580, 23178, 23513, 23111, 23446, 23044, 23379}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RDM
            {id = 130, items = {26191, 23313, 23648, 23246, 23581, 23179, 23514, 23112, 23447, 23045, 23380}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 THF
            {id = 133, items = {26191, 23314, 23649, 23247, 23582, 23180, 23515, 23113, 23448, 23046, 23381}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 PLD
            {id = 136, items = {26191, 23315, 23650, 23248, 23583, 23181, 23516, 23114, 23449, 23047, 23382}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DRK
            {id = 139, items = {26191, 23316, 23651, 23249, 23584, 23182, 23517, 23115, 23450, 23048, 23383}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BST
            {id = 142, items = {26085, 23317, 23652, 23250, 23585, 23183, 23518, 23116, 23451, 23049, 23384}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BRD
            {id = 145, items = {26191, 23318, 23653, 23251, 23586, 23184, 23519, 23117, 23452, 23050, 23385}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RNG
            {id = 148, items = {26191, 23319, 23654, 23252, 23587, 23185, 23520, 23118, 23453, 23051, 23386}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SAM
            {id = 151, items = {26191, 23320, 23655, 23253, 23588, 23186, 23521, 23119, 23454, 23052, 23387}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 NIN
            {id = 154, items = {26191, 23321, 23656, 23254, 23589, 23187, 23522, 23120, 23455, 23053, 23388}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DRG
            {id = 157, items = {26342, 23322, 23657, 23255, 23590, 23188, 23523, 23121, 23456, 23054, 23389}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SMN
            {id = 160, items = {26085, 23323, 23658, 23256, 23591, 23189, 23524, 23122, 23457, 23055, 23390}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 BLU
            {id = 163, items = {26191, 23324, 23659, 23257, 23592, 23190, 23525, 23123, 23458, 23056, 23391}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 COR
            {id = 166, items = {26191, 23325, 23660, 23258, 23593, 23191, 23526, 23124, 23459, 23057, 23392}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 PUP
            {id = 169, items = {26191, 23326, 23661, 23259, 23594, 23192, 23527, 23125, 23460, 23058, 23393}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DNC (M)
            {id = 172, items = {26191, 23327, 23662, 23260, 23595, 23193, 23528, 23126, 23461, 23059, 23394}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 DNC (F)
            {id = 175, items = {26085, 23328, 23663, 23261, 23596, 23194, 23529, 23127, 23462, 23060, 23395}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 SCH
            {id = 178, items = {26085, 23329, 23664, 23262, 23597, 23195, 23530, 23128, 23463, 23061, 23396}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 GEO
            {id = 181, items = {26191, 23330, 23665, 23263, 23598, 23196, 23531, 23129, 23464, 23062, 23397}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 15, 0, 0}, {xi.mod.RACC, 15, 0, 0}, {xi.mod.MACC, 15, 0, 0}} }, -- AF1 119 +2/3 RUN
            {id = 184, items = {26204, 25574, 25790, 25828, 25879, 25946}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.SUBTLE_BLOW, 5, 5, 0}} },                                         -- Sulevia +2 Set: Subtle Blow +5-20 (Requires Sulevia's Ring to activate set effect)
            {id = 185, items = {26205, 25575, 25791, 25829, 25880, 25947}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.REGEN, 3, 3, 0}} },                                               -- Meghanada +2 Set: Regen +3-12 (Requires Megahanada Ring to activate set effect)
            {id = 186, items = {26206, 25576, 25792, 25830, 25881, 25948}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.COUNTER, 4, 4, 0}} },                                             -- Hizamaru +2 Set: Counter +4-16% (Requires Hizamaru Ring to activate set effect)
            {id = 187, items = {26207, 25577, 25793, 25831, 25882, 25949}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.REFRESH, 1, 1, 0}} },                                             -- Inyanga +2 Set: Refresh +1-4 (Requires Inyanga Ring to activate set effect)
            {id = 188, items = {26208, 25578, 25794, 25832, 25883, 25950}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.FAST_CAST, 1, 1, 0}} },                                           -- Jhakri +2 Set: Fast Cast +1-4% (Requires Jhakri Ring to activate set effect)
            {id = 189, items = {26209, 25572, 25795, 25833, 25884, 25951}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.STR, 8, 8, 0}, {xi.mod.VIT, 8, 8, 0}, {xi.mod.MND, 8, 8, 0}} },   -- Ayanmo +2 Set: STR/VIT/MND +8-32 (Requires Ayanmo Ring to activate set effect)
            {id = 192, items = {26210, 25573, 25796, 25834, 25885, 25952}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.DEX, 8, 8, 0}, {xi.mod.VIT, 8, 8, 0}, {xi.mod.CHR, 8, 8, 0}} },   -- Tali'ah +2 Set: DEX/VIT/CHR +8-32 (Requires Tali'ah Ring to activate set effect}
            {id = 195, items = {26211, 25569, 25797, 25385, 25886, 25953}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.STR, 8, 8, 0}, {xi.mod.DEX, 8, 8, 0}, {xi.mod.VIT, 8, 8, 0}} },   -- Flamma +2 Set: STR/DEX/VIT +8-32 (Requires Flamma Ring to activate set effect)
            {id = 198, items = {26212, 25570, 25798, 25836, 25887, 25954}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.DEX, 8, 8, 0}, {xi.mod.AGI, 8, 8, 0}, {xi.mod.CHR, 8, 8, 0}} },   -- Mummu +2 Set: DEX/AGI/CHR +8-32 (Requires Mummu Ring to activate set effect)
            {id = 201, items = {26213, 25571, 25799, 25837, 25888, 25955}, matches = 3, matchType = matchtype.ring_armor, mods = {{xi.mod.VIT, 8, 8, 0}, {xi.mod.INT, 8, 8, 0}, {xi.mod.MND, 8, 8, 0}} },   -- Mallquis +2 Set: VIT/INT/MND +8-32 (Requires Mallquis Ring to activate set effect)
            {id = 204, items = {25610, 25683, 27114, 27299, 27470}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 4, 2, 0}} },                                                     -- Emicho +1 Set: Double Attack +4-10
            {id = 205, items = {25612, 25685, 27116, 27301, 27472}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ATT, 20, 10, 0}} },                                                             -- Ryuo +1 Set: Attack +20-50
            {id = 206, items = {25614, 25687, 27118, 27303, 27474}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.CRITHITRATE, 4, 2, 0}} },                                                       -- Adhemar +1 Set: Crit Hit Rate +4-10
            {id = 207, items = {25616, 25689, 27120, 27305, 27476}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MATT, 20, 10, 0}} },                                                            -- Amalric +1 Set: Magic Attack Bonus +20-50
            {id = 208, items = {25618, 25691, 27122, 27307, 27478}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.CURE_POTENCY_II, 4, 2, 0}} },                                                   -- Kaykaus +1 Set: Cure Potency II + 4-10%
            {id = 209, items = {26669, 26845, 27021, 27197, 27373}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ALL_WSDMG_FIRST_HIT, 4, 2, 0}} },                                               -- Lustratio +1 Set: Weapon Skill Damage +4-10%
            {id = 210, items = {26671, 26847, 27023, 27199, 27375}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DMG, -4, -2, 0}} },                                                             -- Souveran +1 Set: Damage Taken - 4-> -10
            {id = 211, items = {26673, 26849, 27025, 27201, 27377}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 4, 2, 0}} },                                                     -- Argosy +1 Set: Double Attack +4-10
            {id = 212, items = {26675, 26851, 27027, 27203, 27379}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MARTIAL_ARTS, 8, 4, 0}} },                                                      -- Rao +1 Set: Martial Arts +8-20
            {id = 213, items = {26677, 26853, 27029, 27205, 27381}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.BP_DAMAGE, 4, 2, 0}} },                                                         -- Apogee +1 Set: Blood Pact Damage +4-10
            {id = 214, items = {26679, 26855, 27031, 27207, 27383}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ACC, 20, 10, 0}} },                                                             -- Carmine +1 Set: Accuracy +20-50
            {id = 215, items = {26740, 26741, 26898, 26899, 27052, 27053, 27237, 27238, 27411, 27412}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DA_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },           -- AF3 WAR 109/119 Set: Double attack double damage chance
            {id = 216, items = {26742, 26743, 26900, 26901, 27054, 27055, 27239, 27240, 27413, 27414}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.EXTRA_KICK_ATTACK, baseRate, pieceBonus, 0}} },          -- AF3 MNK 109/119 Set: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
            {id = 217, items = {26744, 26745, 26902, 26903, 27056, 27057, 27241, 27242, 27415, 27416}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0}} },                    -- AF3 WHM 109/119 Set: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
            {id = 218, items = {26746, 26747, 26904, 26905, 27058, 27059, 27243, 27244, 27417, 27418}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_CONSERVE_MP, baseRate, pieceBonus, 0}} },       -- AF3 BLM 109/119 Set: Augments Conserve MP to occasionally increase damage proportional to % of MP Conserved.
            {id = 219, items = {26748, 26749, 26906, 26907, 27060, 27061, 27245, 27246, 27419, 27420}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_COMPOSURE, 50, 0, 0}} },                        -- AF3 RDM 109/119 Set: Enhances duration of Enhancing Magic cast on OTHERS while under the effect of Composure 10/15/35/50.
            {id = 220, items = {26750, 26751, 26908, 26909, 27062, 27063, 27247, 27248, 27421, 27422}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.TA_TRIPLE_DAMAGE, baseRate, pieceBonus, 0}} },           -- AF3 THF 109/119 Set: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
            {id = 221, items = {26752, 26753, 26910, 26911, 27064, 27065, 27249, 27250, 27423, 27424}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ABSORB_DMG_CHANCE, baseRate, pieceBonus, 0}} },          -- AF3 PLD 109/119 Set: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
            {id = 222, items = {26754, 26755, 26912, 26913, 27066, 27067, 27251, 27252, 27425, 27426}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_HP, baseRate, pieceBonus, 0}} },          -- AF3 DRK 109/119 Set: Occasionally increases damage in direct proportion to the percentage of current HP.
            {id = 223, items = {26756, 26757, 26914, 26915, 27068, 27069, 27253, 27254, 27427, 27428}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },      -- AF3 BST 109/119 Set: Occasionally increases damage in direct proportion to the percentage of the pets current HP.
            {id = 224, items = {26758, 26759, 26916, 26917, 27070, 27071, 27255, 27256, 27429, 27430}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_SONG_STAT, 1, 1, 0}} },                          -- AF3 BRD 109/119 Set: Enhancing Songs add +1/2/3/4 to stat related to element (Fire = STR, Thunder = DEX, etc). Adds +10/20/30/40 MP for Dark based Songs.
            {id = 225, items = {26760, 26761, 26918, 26919, 27072, 27073, 27257, 27258, 27431, 27432}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },   -- AF3 RNG 109/119 Set: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
            {id = 226, items = {26762, 26763, 26920, 26921, 27074, 27075, 27259, 27260, 27433, 27434}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ZANSHIN_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },      -- AF3 SAM 109/119 Set: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
            {id = 227, items = {26764, 26765, 26922, 26923, 27076, 27077, 27261, 27262, 27435, 27436}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0}} },                    -- AF3 NIN 109/119 Set: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
            {id = 228, items = {26766, 26767, 26924, 26925, 27078, 27079, 27263, 27264, 27437, 27438}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },      -- AF3 DRG 109/119 Set: Occasionally increases damage in direct proportion to the percentage of the wyverns current HP.
            {id = 229, items = {26768, 26769, 26926, 26927, 27080, 27081, 27265, 27266, 27439, 27440}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_BLOOD_BOON, baseRate, pieceBonus, 0}} },         -- AF3 SMN 109/119 Set: Occasionally increases damage of Blood Pacts when Blood Boon is triggered. Increased amount is proportional to the ratio of MP conserved.
            {id = 230, items = {26770, 26771, 26928, 26929, 27082, 27083, 27267, 27268, 27441, 27442}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_BLU_MAGIC, baseRate, pieceBonus, 0}} },         -- AF3 BLU 109/119 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
            {id = 231, items = {26772, 26773, 26930, 26931, 27084, 27085, 27269, 27270, 27443, 27444}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, baseRate, pieceBonus, 0}} },   -- AF3 COR 109/119 Set: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
            {id = 232, items = {26774, 26775, 26932, 26933, 27086, 27087, 27271, 27272, 27445, 27446}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AUGMENT_DAMAGE_PET_HP, baseRate, pieceBonus, 0}} },      -- AF3 PUP 109/119 Set: Occasionally increases damage in direct proportion to the percentage of the automaton's current HP.
            {id = 233, items = {26776, 26777, 26934, 26935, 27088, 27089, 27273, 27274, 27447, 27448}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.SAMBA_DOUBLE_DAMAGE, baseRate, pieceBonus, 0}} },        -- AF3 DNC 109/119 Set: Augments "Samba". Occasionally doubles damage with Samba up.
            {id = 234, items = {26778, 26779, 26936, 26937, 27090, 27091, 27275, 27276, 27449, 27450}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.GRIMOIRE_INSTANT_CAST, baseRate, pieceBonus, 0}} },      -- AF3 SCH 109/119 Set: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
            {id = 235, items = {26780, 26781, 26938, 26939, 27092, 27093, 27277, 27278, 27451, 27452}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.GEOMANCY_MP_NO_DEPLETE, baseRate, pieceBonus, 0}} },     -- AF3 GEO 109/119 Set: Occasionally reduces the casting cost of Geomancy to 0.
            {id = 236, items = {26782, 26783, 26940, 26941, 27094, 27095, 27279, 27280, 27453, 27454}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.ABSORB_DMG_CHANCE, baseRate, pieceBonus, 0}} },          -- AF3 RUN 109/119 Set: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
            {id = 237, items = {27648, 27788, 27928, 28071, 28208},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 3, 2, 0}} },                    -- Ares +1 Set: Double Attack +3-9%
            {id = 238, items = {27649, 27789, 27929, 28072, 28209},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.CRITHITRATE, 3, 2, 0}} },                      -- Skadi +1 Set: Critical hit rate +3-9%
            {id = 239, items = {27650, 27790, 27930, 28073, 28210},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.HASTE_GEAR, 300, 200, 0}} },                   -- Usukane +1 Set: Haste +3-9%
            {id = 240, items = {27651, 27791, 27931, 28074, 28211},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.FASTCAST, 3, 2, 0}} },                         -- Marduk +1 Set: Fast Cast +3-9%
            {id = 241, items = {27652, 27792, 27932, 28075, 28212},  matches = 2, matchType = matchtype.any, mods = {{xi.mod.MATT, 3, 2, 0}} },                             -- Morrigan +1 Set: Magic Atk. Bonus +3-9%
            {id = 242, items = {27740, 27881, 28029, 28168, 28306}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.DMGPHYS, -1000, 0, 0}} },                       -- Outrider Set: Phys damage taken -10%
            {id = 243, items = {27741, 27882, 28030, 28169, 28307}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.CRIT_DMG_INCREASE, 10, 0, 0}} },                -- Espial Set: Crit damage +10%
            {id = 244, items = {27742, 27883, 28031, 28170, 28308}, matches = 5, matchType = matchtype.any, mods = {{xi.mod.REFRESH, 3, 0, 0}} },                           -- Wayfarer Set: Refresh+3
            {id = 245, items = {28520, 28521}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DOUBLE_ATTACK, 7, 0, 0}} },                                          -- Bladeborn/Steelflash Earrings
            {id = 246, items = {28522, 28523}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.DUAL_WIELD, 7, 0, 0}} },                                             -- Dudgeon/Heartseeker Earrings
            {id = 247, items = {28524, 28525}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.MACC, 12, 0, 0}} },                                                  -- Psystorm/Lifestorm Earrings
            {id = 248, items = {18244, 17595}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },        -- Begin Jailer weapons: Set is weapon + Virtue stone, bonus 50% extra melee swing.
            {id = 249, items = {18244, 17710}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },
            {id = 250, items = {18244, 17948}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },
            {id = 251, items = {18244, 18100}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },
            {id = 252, items = {18244, 18222}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },
            {id = 253, items = {18244, 18360}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },
            {id = 254, items = {18244, 18397}, matches = 2, matchType = matchtype.any, mods = {{xi.mod.AMMO_SWING, 50, 0, 0}} },        -- End Jailer weapons

             -- next id = 255
        }

             -- increment id by the number of mods in previous gearset (e.g. id 198 has 3 mods, 198 + 3 = 201)
             -- so in this example, the next usable id after 198 would be 201.

--              {id, {item, ids, in, no, particular, order}, minimum matches required, match type, mods{id, value, modvalue for each additional match, additional whole set bonus}

local specialHandlingSets =
{
    -- put the ids of sets that need their own handling here e.g. Rubeus
    {id =  39, specialHandling = true}, -- Breeders
    {id =  69, specialHandling = true}, -- RDM AF3 +2
    {id =  98, specialHandling = true}, -- Ogiers
    {id = 100, specialHandling = true}, -- Rubeus
    {id = 102, specialHandling = true}, -- Phorcys
    {id = 106, specialHandling = true}, -- Thaumas
    {id = 110, specialHandling = true}, -- Nares
    {id = 114, specialHandling = true}, -- Begin AF1 109/119 +2/3 ACC/RACC/MACC
    {id = 118, specialHandling = true},
    {id = 121, specialHandling = true},
    {id = 124, specialHandling = true},
    {id = 127, specialHandling = true},
    {id = 130, specialHandling = true},
    {id = 133, specialHandling = true},
    {id = 136, specialHandling = true},
    {id = 139, specialHandling = true},
    {id = 142, specialHandling = true},
    {id = 145, specialHandling = true},
    {id = 148, specialHandling = true},
    {id = 151, specialHandling = true},
    {id = 154, specialHandling = true},
    {id = 157, specialHandling = true},
    {id = 160, specialHandling = true},
    {id = 163, specialHandling = true},
    {id = 166, specialHandling = true},
    {id = 169, specialHandling = true},
    {id = 172, specialHandling = true},
    {id = 175, specialHandling = true},
    {id = 178, specialHandling = true},
    {id = 181, specialHandling = true}, -- End AF1 109/119 +2/3 ACC/RACC/MACC
    {id = 219, specialHandling = true}, -- AF3 109/119 RDM
}

local function FindMatchByType(gearset, gearMatch)
    if (gearset.matchType == matchtype.any) then
        return true
    elseif (gearset.matchType == matchtype.ring_armor and (gearMatch[xi.slot.HEAD+1] ~= nil or gearMatch[xi.slot.BODY+1] ~= nil or gearMatch[xi.slot.HANDS+1] ~= nil or gearMatch[xi.slot.LEGS+1] ~= nil or gearMatch[xi.slot.FEET+1] ~= nil) and (gearMatch[xi.slot.RING1+1] ~= nil or gearMatch[xi.slot.RING2+1] ~= nil)) then
        return true
    end

    for _, id in ipairs(gearMatch) do
        if (gearset.matchType == matchtype.earring_weapon and (gearMatch[xi.slot.MAIN+1] ~= nil or gearMatch[xi.slot.SUB+1] ~= nil) and (gearMatch[xi.slot.EAR1+1] ~= nil or gearMatch[xi.slot.EAR2+1] ~= nil)) then
            return true
        elseif (gearset.matchType == matchtype.weapon_weapon and (gearMatch[xi.slot.MAIN+1] ~= nil and gearMatch[xi.slot.SUB+1] ~= nil)) then
            return true
        end
    end

    return false
end

local function doSpecialHandling(player, gearset, matches)
    local modValue = 0
    if gearset.id == 39 then -- Breeders
        player:addGearSetMod(gearset.id, xi.mod.DEF, 10, 1)
        player:addGearSetMod(gearset.id + 1, xi.mod.ENMITY, 5, 1)
        return
    elseif (gearset.id == 69 or gearset.id == 219) then -- RDM AF3 90/109/119
        if matches == 2 then
            modValue = 10
        elseif matches == 3 then
            modValue = 15
        elseif matches == 4 then
            modValue = 35
        elseif matches == 5 then
            modValue = 50
        end
        player:addGearSetMod(gearset.id, xi.mod.AUGMENT_COMPOSURE, modValue, 0)
        return
    elseif gearset.id == 98 then -- Ogiers
        if (matches >=2 and matches <= 3) then
            modValue = 1 -- 2 or 3 pieces
        elseif (matches > 3) then
            modValue = 2 -- 4 or 5 pieces
        end
        player:addGearSetMod(gearset.id, xi.mod.REFRESH, modValue, 0)
        return
    elseif gearset.id == 100 then -- Rubeus
        if (matches > 1 and matches < 4) then
            modValue = 4 -- 2 or 3 pieces
        elseif (matches > 3) then
            modValue = 10 -- 4 or 5 pieces
        end
        -- printf("[DEBUG] Enabling Special Handling | gearset: %u | mod %u %u", gearset.id, xi.mod.FASTCAST, modValue)
        player:addGearSetMod(gearset.id, xi.mod.FASTCAST, modValue, 0)
        return
    elseif gearset.id == 102 then -- Phorcys
        if matches == 2 then
            modValue = 2
        elseif matches == 3 then
            modValue = 5
        elseif matches == 4 then
            modValue = 10
        elseif matches == 5 then
            modValue = 15
        end
        player:addGearSetMod(gearset.id, xi.mod.STR, modValue, 0)
        player:addGearSetMod(gearset.id + 1, xi.mod.VIT, modValue, 0)
        player:addGearSetMod(gearset.id + 2, xi.mod.INT, modValue, 0)
        player:addGearSetMod(gearset.id + 3, xi.mod.MND, modValue, 0)
        return
    elseif gearset.id == 106 then -- Thaumas
        if matches == 2 then
            modValue = 2
        elseif matches == 3 then
            modValue = 5
        elseif matches == 4 then
            modValue = 10
        elseif matches == 5 then
            modValue = 15
        end
        player:addGearSetMod(gearset.id, xi.mod.STR, modValue, 0)
        player:addGearSetMod(gearset.id + 1, xi.mod.DEX, modValue, 0)
        player:addGearSetMod(gearset.id + 2, xi.mod.AGI, modValue, 0)
        player:addGearSetMod(gearset.id + 3, xi.mod.MND, modValue, 0)
        return
    elseif gearset.id == 110 then -- Nares
        if matches == 2 then
            modValue = 2
        elseif matches == 3 then
            modValue = 5
        elseif matches == 4 then
            modValue = 10
        elseif matches == 5 then
            modValue = 15
        end
        player:addGearSetMod(gearset.id, xi.mod.STR, modValue, 0)
        player:addGearSetMod(gearset.id + 1, xi.mod.INT, modValue, 0)
        player:addGearSetMod(gearset.id + 2, xi.mod.MND, modValue, 0)
        player:addGearSetMod(gearset.id + 3, xi.mod.CHR, modValue, 0)
        return
    -- AF1 119+2/+3 ACC/RACC/MACC Sets EXCEPT SMN
    elseif (gearset.id >= 114 and gearset.id <= 181 and gearset.id ~= 157) then
        if (matches == 2) then
            modValue = 15 -- 2 matches
        elseif (matches == 3) then
            modValue = 30 -- 3 matches
        elseif (matches == 4) then
            modValue = 45 -- 4 matches
        elseif (matches >= 5) then
            modValue = 60 -- 5 or more matches
        end
        player:addGearSetMod(gearset.id, xi.mod.ACC, modValue, 0)
        player:addGearSetMod(gearset.id + 1, xi.mod.RACC, modValue, 0)
        player:addGearSetMod(gearset.id + 2, xi.mod.MACC, modValue, 0)
        return
    -- AF1 119 +2/+3 SMN Avatar:ACC/RACC/MACC
    elseif (gearset.id == 157) then
        if (matches == 2) then
            modValue = 15 -- 2 matches
        elseif (matches == 3) then
            modValue = 30 -- 3 matches
        elseif (matches == 4) then
            modValue = 45 -- 4 matches
        elseif (matches >= 5) then
            modValue = 60 -- 5 or more matches
        end
        player:addGearSetMod(gearset.id, xi.mod.ACC, modValue, 1)
        player:addGearSetMod(gearset.id + 1, xi.mod.RACC, modValue, 1)
        player:addGearSetMod(gearset.id + 2, xi.mod.MACC, modValue, 1)
        return
    end
end

-----------------------------------
-- Applys a gear set mod
-----------------------------------
local function ApplyMod(player, gearset, matches)

    for _, set in pairs(specialHandlingSets) do
        if (set.id == gearset.id) then
            doSpecialHandling(player, gearset, matches)
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
        player:addGearSetMod(gearset.id + i, modId, modValue + addSetBonus, 0)
        i = i + 1
    end
    -- print("Gear set! Mod applied: ModNameId:" .. modNameId .. " ModId:" .. modId .. " Value:" .. modValue .. "\n")
end

-----------------------------------
-- Checks for gear sets present on a player
-----------------------------------
function checkForGearSet(player)
    -- print("---Removed existing gear set mods!---\n")
    player:clearGearSetMods()

    -- cause we dont want hundreds of function calls
    local equip = {}
    for slot = 0, xi.MAX_SLOTID do
        equip[slot+1] = player:getEquipID(slot)
    end

    for index, gearset in pairs(GearSets) do
        local matches = 0
        if (player:hasGearSetMod(gearset.id) == false) then
            -- local slot = 0
            local gearMatch = {}

            for _, id in pairs(gearset.items) do
                for slot = 1, xi.MAX_SLOTID do
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
            if (gearMatch[xi.slot.EAR1+1] == gearMatch[xi.slot.EAR2+1] and gearMatch[xi.slot.EAR1+1] ~= nil) then
                matches = matches - 1
            end
            if (gearMatch[xi.slot.RING1+1] == gearMatch[xi.slot.RING2+1] and gearMatch[xi.slot.RING1+1] ~= nil) then
                matches = matches - 1
            end
            if (gearMatch[xi.slot.MAIN+1] == gearMatch[xi.slot.SUB+1] and gearMatch[xi.slot.MAIN+1] ~= nil) then
                matches = matches - 1
            end

            if (matches >= gearset.matches) then
                if (FindMatchByType(gearset, gearMatch) == true) then
                    ApplyMod(player, gearset, matches, 0)
                end
            end
        end
    end
end

--[[    WIP/TODO sets below

=======
Empyrean +2
=======

--Goetia Attire +2 Set
-----------------------------------
11067 -- Goetia Petasos+2
11087 -- Goetia Coat+2
11107 -- Goetia Gloves+2
11127 -- Goetia Chausses+2
11147 -- Goetia Sabots+2
-- Set Bonus: Augments "Conserve MP"
-- Occasionally increases damage of elemental spells when Conserve MP is triggered. Increased amount is proportional to twice the ratio of MP conserved.

--Mavi Attire +2 Set
-----------------------------------
11079 -- Mavi Kavuk+2
11099 -- Mavi Mintan+2
11119 -- Mavi Bazubands+2
11139 -- Mavi Tayt+2
11159 -- Mavi Basmak+2
-- Set Bonus: Occ. augments blue magic spells.
-- Occasionally increases the WSC value of the spell to 3x it's value. Stacks with Chain Affinity to make it 4x.

--Estoqueur's Attire +2 Set
-----------------------------------
11068 -- Estoqueur's Chappel+2
11088 -- Estoqueur's Sayon+2
11108 -- Estoqueur's Gantherots+2
11128 -- Estoqueur's Fuseau+2
11148 -- Estoqueur's Houseaux+2
-- Set Bonus: Augments "Composure"
-- Enhances duration of Enhancing Magic cast on OTHERS while under the effect of Composure by 10% for the first 2 pieces, and 15% for any additional pieces thereafter, up to 35% increase for 4 pieces and 50% for all 5 pieces. The "Increases enhancing magic effect duration" of the Estoqueur's Cape, Estoqueur's Houseaux +1 and Estoqueur's Houseaux +2 is multiplicative to this total.

--Caller's Attire +2 Set
-----------------------------------
11078 -- Caller's Horn+2
11098 -- Caller's Doublet+2
11118 -- Caller's Bracers+2
11138 -- Caller's Spats+2
11158 -- Caller's Pigaches+2
-- Set Bonus: Augments "Blood Boon"
-- Occasionally increases damage of Blood Pacts when Blood Boon is triggered. Increased amount is proportional to the ratio of MP conserved.

]]--
