-----------------------------------
-- Gear sets
-- Allows the use of gear sets with modifiers
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/status')
-----------------------------------

xi = xi or {}
xi.gear_sets = xi.gear_sets or {}

local gearSets =
{
    [1] = -- Usukane's set (5% Haste)
    {
        items =
        {
            16092,
            14554,
            14969,
            15633,
            15719,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500, 0, 0 },
        },
    },

    [2] = -- Skadi's set (5% critrate is guess)
    {
        items =
        {
            16088,
            14550,
            14965,
            15629,
            15715,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5, 0, 0 },
        },
    },

    [3] = -- Ares's set (5% DA)
    {
        items =
        {
            16084,
            14546,
            14961,
            15625,
            15711,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5, 0, 0 },
        },
    },

    [4] = -- Denali Jacket Set (Increases Accuracy +20)
    {
        items =
        {
            16107,
            14569,
            14984,
            15648,
            15734,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.ACC, 20, 0, 0 },
        },
    },

    [5] = -- Askar Korazin Set (Max HP Boost %10)
    {
        items =
        {
            16106,
            14568,
            14983,
            15647,
            15733,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.HPP, 10, 0, 0 },
        },
    },

    [6] = -- Pahluwan Khazagand Set (Needs Verification)
    {
        items =
        {
            16069,
            14530,
            14940,
            15609,
            15695,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 8, 0, 0 },
        },
    },

    [7] = -- Morrigan's Robe Set (+5 Magic. Atk Bonus)
    {
        items =
        {
            16100,
            14562,
            14977,
            15641,
            15727,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.MATT, 5, 0, 0 },
        },
    },

    [8] = -- Marduk's Jubbah Set (5% fastcast)
    {
        items =
        {
            16096,
            14558,
            14973,
            15637,
            15723,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.FASTCAST, 5, 0, 0 },
        },
    },

    [9] = -- Goliard Saio Set - Total Set Bonus +10% Magic Def. Bonus
    {
        items =
        {
            16108,
            14570,
            14985,
            15649,
            15735,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.MDEF, 10, 0, 0 },
        },
    },

    [10] = -- Yigit Gomlek Set (1mp per tick) Adds "Refresh" effect
    {
        items =
        {
            16064,
            14527,
            14935,
            15606,
            15690,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.REFRESH, 1, 0, 0 },
        },
    },

    [11] = -- Perle Hauberk Set (Haste +5%)
    {
        items =
        {
            11503,
            13759,
            12745,
            14210,
            11413,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500, 0, 0 },
        },
    },

    [12] = -- Aurore Doublet Set (Store TP +8)
    {
        items =
        {
            11504,
            13760,
            12746,
            14257,
            11414,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.STORETP, 8, 0, 0 }
        },
    },

    [13] = -- Teal Set: Fast Cast +4-10%
    {
        items =
        {
            11505,
            13778,
            12747,
            14258,
            11415,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 2, 0 },
        },
    },

    [14] = -- Calma Armor Set haste%6
    {
        items =
        {
            10890,
            10462,
            10512,
            11980,
            10610,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 600, 0, 0 },
        },
    },

    [15] = -- Magavan Armor Set  magic accuracy +5
    {
        items =
        {
            10892,
            10464,
            10514,
            11982,
            10612,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [16] = -- Mustela Harness Set  crit rate 5%
    {
        items =
        {
            10891,
            10463,
            10513,
            11981,
            10611,
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5, 0, 0 },
        },
    },

    [17] = -- Bowman's set: Ranged atk +15
    {
        items =
        {
            16126,
            15744,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.RATT, 15, 0, 0 },
        },
    },

    [18] = -- Fourth Division Brune Set
    {
        items =
        {
            16147,
            14589,
            15010,
            16316,
            15756,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ATT, 1, 4.7, 0 },
        },
    },

    [19] = -- Cobra Unit Harness Set
    {
        items =
        {
            16148,
            14590,
            15011,
            16317,
            15757,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.COUNTER, 1, 1, 0 },
        },
    },

    [20] = -- Cobra Unit Robe Set
    {
        items =
        {
            16149,
            14591,
            15012,
            16318,
            15758,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MACC, 1, 1, 0 },
        },
    },

    [21] = -- Iron Ram Chainmail Set.
    {
        items =
        {
            6141,
            14581,
            15005,
            16312,
            15749,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ACC, 1, 1, 0 },
            { xi.mod.ATT, 1, 1, 0 },
        },
    },

    [22] = -- Fourth Division Cuirass Set
    {
        items =
        {
            16142,
            14582,
            15006,
            16313,
            15750,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HP, 10, 10, 0 },
        },
    },

    [23] = -- Cobra Unit Coat Set
    {
        items =
        {
            16143,
            14583,
            15007,
            16314,
            15751
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MP, 10, 10, 0 },
        },
    },

    [24] = -- Amir Korazin Set - Double mod here! It is why it has 2 IDs.
    {
        items =
        {
            16062,
            14525,
            14933,
            15604,
            15688
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.UDMGBREATH, -800, 0, 0 },
            { xi.mod.UDMGMAGIC,  -800, 0, 0 },
        },
    },

    [25] = -- Hachiryu Haramaki Set - Store tp (5, 10, 20)
    {
        items =
        {
            11281,
            15015,
            16337,
            11364
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.STORETP, 5, 5, 5 },
        },
    },

    [26] = -- Ravager's Armor +2 Set - Double attack double damage chance
    {
        items =
        {
            11064,
            11084,
            11104,
            11124,
            11144
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [27] = -- Fazheluo Mail Set. Set Bonus: "Double Attack"+5%. Active with any 2 pieces.
    {
        items =
        {
            11808,
            11824,
            11850,
            11857,
            11858
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5, 0, 0 },
        },
    },

    [28] = -- Cuauhtli Harness Set. Set Bonus: Haste+8%. Active with any 2 pieces.
    {
        items =
        {
            11809,
            11825,
            11851,
            11855,
            11859
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 800, 0, 0 },
        },
    },

    [29] = -- Hyskos Robe Set. Set Bonus: Magic Accuracy+5. Active with any 2 pieces.
    {
        items =
        {
            11810,
            11826,
            11852,
            11856,
            11860
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [30] = -- Ogier's Armor Set. Set Bonus: Adds "Refresh" xi.effect. Provides 1 mp/tick for 2-3 pieces worn, 2 mp/tick for 4-5 pieces worn.
    {
        items =
        {
            10876,
            10450,
            10500,
            11969,
            10600
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.REFRESH, 1, 0.4, 0 },
        },
    },

    [31] = -- Athos's Armor Set. Set Bonus: Increases rate of critical hits. Gives +3% for the first 2 pieces and +1% for every additional piece.
    {
        items =
        {
            10877,
            10451,
            10501,
            11970,
            10601
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 1, 1, 0 },
        },
    },

    [32] = -- Rubeus Armor Set. Set Bonus: Enhances "Fast Cast" effect. 2 or 3 pieces equipped: Fast Cast +4, 4 or 5 pieces equipped: Fast Cast +10
    {
        items =
        {
            10878,
            10452,
            10502,
            11971,
            10602
        },
        minMatches = 2,
        maxMatches = 4, -- Special Case
        mods =
        {
            { xi.mod.FASTCAST, 10, 0, 0 },
        },
    },

    [33] = -- Navarch's Attire +2 Set. Set Bonus: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
    {
        items =
        {
            11080,
            11100,
            11120,
            11140,
            11160
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 1, 0 },
        },
    },

    [34] = -- Charis Attire +2 Set. Set Bonus: Augments "Samba". Occasionally doubles damage with Samba up. Adds approximately 1-2% per piece past the first.
    {
        items =
        {
            11082,
            11102,
            11122,
            11142,
            11162
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.SAMBA_DOUBLE_DAMAGE, 1, 1.8, 0 },
        },
    },

    [35] = -- Iga Garb +2 Set. Set Bonus: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
    {
        items =
        {
            11076,
            11096,
            11116,
            11136,
            11156
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0 },
        }
    },

    [36] = -- Sylvan Attire +2 Set. Set Bonus: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
    {
        items =
        {
            11074,
            11094,
            11114,
            11134,
            11154
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [37] = -- Creed Armor +2 Set. Set Bonus: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
    {
        items =
        {
            11070,
            11090,
            11110,
            11130,
            11150
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 1, 0 },
        },
    },

    [38] = -- Unkai Domaru +2 Set. Set Bonus: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
    {
        items =
        {
            11075,
            11095,
            11115,
            11135,
            11155
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [39] = -- Tantra Attire +2 Set. Set Bonus: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
    {
        items =
        {
            11065,
            11085,
            11105,
            11125,
            11145
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 1, 0 },
        },
    },

    [40] = -- Raider's Attire +2 Set. Set Bonus: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
    {
        items =
        {
            11069,
            11089,
            11109,
            11129,
            11149
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [41] = -- Orison Attire +2 Set. Set Bonus: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
    {
        items =
        {
            11066,
            11086,
            11106,
            11126,
            11146
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0 },
        },
    },

    [42] = -- Savant's Attire +2 Set. Set Bonus: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
    {
        items =
        {
            11083,
            11103,
            11123,
            11143,
            11163
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 1, 0 },
        },
    },

    [43] = -- Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)
    {
        items =
        {
            16005,
            17756,
            17962,
            18596,
            18760,
            19112,
            19215,
            19271,
            19156
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HP,  30, 0, 0 },
            { xi.mod.VIT,  6, 0, 0 },
            { xi.mod.ACC,  6, 0, 0 },
            { xi.mod.RACC, 6, 0, 0 },
        },
    },

    [44] = -- Supremacy Earring Sets. Set Bonus: STR+6, Attack+4, Ranged Attack+4, "Magic Atk. Bonus"+2. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            18761,
            18597,
            17757,
            19218,
            18128,
            18500,
            16004,
            18951
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.STR,  6, 0, 0 },
            { xi.mod.ATT,  4, 0, 0 },
            { xi.mod.RATT, 4, 0, 0 },
            { xi.mod.MATT, 2, 0, 0 },
        },
    },

    [45] = -- Brilliant Earring Set. Set Bonus: Evasion, HP Recovered while healing, Reduces Emnity. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            16006,
            18450,
            18499,
            18861,
            18862,
            18952,
            19111,
            19217,
            19272
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.EVA,    10, 0, 0 },
            { xi.mod.HPHEAL, 10, 0, 0 },
            { xi.mod.ENMITY, -5, 0, 0 },
        }
    },

    [46] = -- Twilight Mail Set. Set Bonus: Auto-Reraise
    {
        items =
        {
            11798,
            11362
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.RERAISE_III, 1, 0, 0 },
        },
    },

    [47] = -- Begin Jailer weapons: Set is weapon + Virtue stone, bonus 50% extra melee swing.
    {
        items =
        {
            18244,
            17595
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [48] =
    {
        items =
        {
            18244,
            17710
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [49] =
    {
        items =
        {
            18244,
            17948
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [50] =
    {
        items =
        {
            18244,
            18100
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [51] =
    {
        items =
        {
            18244,
            18222
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [52] =
    {
        items =
        {
            18244,
            18360
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [53] = -- End Jailer weapons
    {
        items =
        {
            18244,
            18397
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [54] = -- Bladeborn/Steelflash Earrings
    {
        items =
        {
            28520,
            28521
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 7, 0, 0 },
        },
    },

    [55] = -- Dudgeon/Heartseeker Earrings
    {
        items =
        {
            28522,
            28523
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DUAL_WIELD, 7, 0, 0 },
        },
    },

    [56] = -- Psystorm/Lifestorm Earrings
    {
        items =
        {
            28524,
            28525
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MACC, 12, 0, 0 },
        },
    },

    [57] = -- Samurai 109/119 af3
    {
        items =
        {
            26920,
            26921,
            27434,
            27259,
            27260,
            26762,
            26763,
            27074,
            27075,
            27433,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [58] = -- MNK 109/119 af3
    {
        items =
        {
            27414,
            27413,
            27240,
            27239,
            27055,
            27054,
            26901,
            26900,
            26743,
            26742,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 1, 0 },
        },
    },

    [59] = -- 109/119 WAR AF3
    {
        items =
        {
            26740,
            26741,
            27411,
            27412,
            27238,
            27237,
            27053,
            27054,
            26899,
            26900,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [60] = -- 109/119 THF AF3
    {
        items =
        {
            26750,
            26751,
            27421,
            27422,
            27247,
            27248,
            27063,
            27062,
            26908,
            26909,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [61] = -- 109/119 RNG AF3
    {
        items =
        {
            26918,
            26919,
            26761,
            26762,
            27431,
            27432,
            27257,
            27258,
            27072,
            27073,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [62] = -- 109/119 PLD AF3
    {
        items =
        {
            26910,
            26911,
            26752,
            26753,
            27424,
            27423,
            27064,
            27065,
            27249,
            27250,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 1, 0 },
        },
    },

    [63] = -- 109/119 NIN AF3
    {
        items =
        {
            26922,
            26923,
            26764,
            26765,
            27076,
            27077,
            27261,
            27262,
            27435,
            27436,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0 },
        },
    },

    [64] = -- 109/119 COR AF3
    {
        items =
        {
            27443,
            27444,
            26772,
            26773,
            26930,
            26931,
            27084,
            27085,
            27269,
            27270,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 1, 0 },
        },
    },

    [65] = -- 109/119 SCH AF3
    {
        items =
        {
            27275,
            27276,
            27449,
            27450,
            26778,
            26779,
            26936,
            26937,
            27090,
            27091,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 1, 0 },
        },
    },

    [66] = -- 109/119 WHM AF3
    {
        items =
        {
            27241,
            27242,
            27415,
            27416,
            26744,
            26745,
            26902,
            26903,
            27056,
            27057,
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0 },
        },
    },

    [67] = -- Heka's body + NQ or HQ Khat = 3 tick refresh
    {
        items =
        {
            11867,
            10868,
            10865
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.REFRESH, 3, 0, 0 },
        },
    },

    [68] = -- Nefer body/head NQ/HQ combo gives Refresh +2
    {
        items =
        {
            10868,
            11870,
            11864,
            10865
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.REFRESH, 2, 0, 0 },
        },
    },

    [69] = -- Dasra's/Nasatya's Ring set gives HP/MP +50
    {
        items =
        {
            15852,
            15853
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HP, 50, 0, 0 },
            { xi.mod.MP, 50, 0, 0 },
        },
    },

    [70] = -- Helenus's/Cassandra's earring set: Mag atk bonus+5 and Mag acc +5
    {
        items =
        {
            16037,
            16038
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MATT, 5, 0, 0 },
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [71] = -- Lava's/Kusha's earring set: Atk+6/Acc+12
    {
        items =
        {
            15850,
            15851
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ATT,  6, 0, 0 },
            { xi.mod.ACC, 12, 0, 0 },
            { xi.mod.DEF,  6, 0, 0 },
        },
    },

    [72] = -- Iron Ram Haubert Set
    {
        items =
        {
            16146,
            14588,
            15009,
            16315,
            15755
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.FIRE_MEVA,    5, 5, 10 },
            { xi.mod.ICE_MEVA,     5, 5, 10 },
            { xi.mod.WIND_MEVA,    5, 5, 10 },
            { xi.mod.EARTH_MEVA,   5, 5, 10 },
            { xi.mod.THUNDER_MEVA, 5, 5, 10 },
            { xi.mod.WATER_MEVA,   5, 5, 10 },
            { xi.mod.LIGHT_MEVA,   5, 5, 10 },
            { xi.mod.DARK_MEVA,    5, 5, 10 },
        },
    },

    [73] = -- Altdorf's/Wilhelm's earring: AGI+8
    {
        items =
        {
            16035,
            16036
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AGI, 8, 0, 0 },
        },
    },

    [74] = -- Gothic Gauntlets/Sabatons: Atk/RAtk +5
    {
        items =
        {
            15042,
            11402
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ATT,  5, 0, 0 },
            { xi.mod.RATT, 5, 0, 0 },
        },
    },

    [75] = -- Teal Set +1: Fast Cast +4-10%
    {
        items =
        {
            26713,
            27853,
            27999,
            28140,
            28279
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 2, 0 },
        },
    },

    [76] = -- Aurore Set +1: Sore TP +2-8%
    {
        items =
        {
            26712,
            27852,
            27998,
            28139,
            28278
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.STORETP, 2, 2, 0 },
        },
    },

    [77] = -- Perle Set +1: Haste +2-5%
    {
        items =
        {
            26711,
            27851,
            27997,
            28138,
            28277
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 200, 100, 0 },
        },
    },

    [78] = -- Morrigan's Attire Set +1: Magic Atk. Bonus +3-9%
    {
        items =
        {
            27652,
            27792,
            27932,
            28075,
            28212
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MATT, 3, 2, 0 },
        },
    },

    [79] = -- Marduk's Attire Set +1: Fast Cast +3-9%
    {
        items =
        {
            27651,
            27791,
            27931,
            28074,
            28211
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.FASTCAST, 3, 2, 0 },
        },
    },

    [80] = -- Usukane Armor Set +1: Haste +3-9%
    {
        items =
        {
            27650,
            27790,
            27930,
            28073,
            28210
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 300, 200, 0 },
        },
    },

    [81] = -- Skadi's Attire Set +1: Critical hit rate +3-9%
    {
        items =
        {
            27649,
            27789,
            27929,
            28072,
            28209
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 3, 2, 0 },
        },
    },

    [82] = -- Ares' Armor Set +1: Double Attack +3-9%
    {
        items =
        {
            27648,
            27788,
            27928,
            28071,
            28208
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 3, 2, 0 },
        },
    },

    [83] = -- Alcedo Cuisses and Gauntlets: Magic damage taken -5%
    {
        items =
        {
            10315,
            10598
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DMGMAGIC, -500, 0, 0 },
        },
    },

    [84] = -- Sulevia's Armor Set +2: Subtle Blow +5-20
    {
        items =
        {
            26204,
            25574,
            25790,
            25828,
            25879,
            25946
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 5, 5, 0 },
        },
    },

    [85] = -- Hizamaru Armor Set +2: Counter +4-16%
    {
        items =
        {
            26206,
            25576,
            25792,
            25830,
            25881,
            25948
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.COUNTER, 4, 4, 0 },
        },
    },

    [86] = -- Inyanga Armor Set +2: Refresh +1-4
    {
        items =
        {
            26207,
            25577,
            25793,
            25831,
            25882,
            25949
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.REFRESH, 1, 1, 0 },
        },
    },

    [87] = -- Meghanada Armor Set +2: Regen +3-12
    {
        items =
        {
            26205,
            25575,
            25791,
            25829,
            25880,
            25947
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.REGEN, 3, 3, 0 },
        },
    },

    [88] = -- Jhakri Armor Set +2: Fast Cast +1-4%
    {
        items =
        {
            26208,
            25578,
            25794,
            25832,
            25883,
            25950
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.FAST_CAST, 1, 1, 0 },
        },
    },

    [89] = -- Flamma Armor Set +2 STR/DEX/VIT +8-32
    {
        items =
        {
            26211,
            25569,
            25797,
            25385,
            25886,
            25953
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.STR, 8, 8, 0 },
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
        },
    },

    [90] = -- Tali'ah Armor Set +2 DEX/VIT/CHR +8-32
    {
        items =
        {
            26210,
            25573,
            25796,
            25834,
            25885,
            25952
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.CHR, 8, 8, 0 },
        }
    },

    [91] = -- Mummu Armor Set +2 DEX/AGI/CHR +8-32
    {
        items =
        {
            26212,
            25570,
            25798,
            25836,
            25887,
            25954
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.AGI, 8, 8, 0 },
            { xi.mod.CHR, 8, 8, 0 },
        },
    },

    [92] = -- Ayanmo Armor Set +2 STR/VIT/MND +8-32
    {
        items =
        {
            26209,
            25572,
            25795,
            25833,
            25884,
            25951
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.STR, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.MND, 8, 8, 0 },
        }
    },

    [93] = -- Mallquis Armor Set +2 VIT/INT/MND +8-32
    {
        items =
        {
            26213,
            25571,
            25799,
            25837,
            25888,
            25955
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.INT, 8, 8, 0 },
            { xi.mod.MND, 8, 8, 0 },
        }
    },

    [94] = -- AF1 119 +2/3 WAR
    {
        items =
        {
            26191,
            23308,
            23643,
            23241,
            23576,
            23174,
            23509,
            23107,
            23442,
            23040,
            23375
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [95] = -- AF1 119 +2/3 MNK
    {
        items =
        {
            26191,
            23309,
            23644,
            23242,
            23577,
            23175,
            23510,
            23108,
            23443,
            23041,
            23376
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [96] = -- AF1 119 +2/3 WHM
    {
        items =
        {
            26085,
            23310,
            23645,
            23243,
            23578,
            23176,
            23511,
            23109,
            23444,
            23042,
            23377
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [97] = -- AF1 119 +2/3 BLM
    {
        items =
        {
            26085,
            23311,
            23646,
            23244,
            23579,
            23177,
            23512,
            23110,
            23445,
            23043,
            23378
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [98] = -- AF1 119 +2/3 RDM
    {
        items =
        {
            26085,
            23312,
            23647,
            23245,
            23580,
            23178,
            23513,
            23111,
            23446,
            23044,
            23379
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [99] = -- AF1 119 +2/3 THF
    {
        items =
        {
            26191,
            23313,
            23648,
            23246,
            23581,
            23179,
            23514,
            23112,
            23447,
            23045,
            23380
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [100] = -- AF1 119 +2/3 PLD
    {
        items =
        {
            26191,
            23314,
            23649,
            23247,
            23582,
            23180,
            23515,
            23113,
            23448,
            23046,
            23381
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [101] = -- AF1 119 +2/3 DRK
    {
        items =
        {
            26191,
            23315,
            23650,
            23248,
            23583,
            23181,
            23516,
            23114,
            23449,
            23047,
            23382
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [102] = -- AF1 119 +2/3 BST
    {
        items =
        {
            26191,
            23316,
            23651,
            23249,
            23584,
            23182,
            23517,
            23115,
            23450,
            23048,
            23383
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [103] = -- AF1 119 +2/3 BRD
    {
        items =
        {
            26085,
            23317,
            23652,
            23250,
            23585,
            23183,
            23518,
            23116,
            23451,
            23049,
            23384
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [104] = -- AF1 119 +2/3 RNG
    {
        items =
        {
            26191,
            23318,
            23653,
            23251,
            23586,
            23184,
            23519,
            23117,
            23452,
            23050,
            23385
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [105] = -- AF1 119 +2/3 SAM
    {
        items =
        {
            26191,
            23319,
            23654,
            23252,
            23587,
            23185,
            23520,
            23118,
            23453,
            23051,
            23386
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [106] = -- AF1 119 +2/3 NIN
    {
        items =
        {
            26191,
            23320,
            23655,
            23253,
            23588,
            23186,
            23521,
            23119,
            23454,
            23052,
            23387
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        }
    },

    [107] = -- AF1 119 +2/3 DRG
    {
        items =
        {
            26191,
            23321,
            23656,
            23254,
            23589,
            23187,
            23522,
            23120,
            23455,
            23053,
            23388
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [108] = -- AF1 119 +2/3 SMN
    {
        items =
        {
            26342,
            23322,
            23657,
            23255,
            23590,
            23188,
            23523,
            23121,
            23456,
            23054,
            23389
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        }
    },

    [109] = -- AF1 119 +2/3 BLU
    {
        items =
        {
            26085,
            23323,
            23658,
            23256,
            23591,
            23189,
            23524,
            23122,
            23457,
            23055,
            23390
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [110] = -- AF1 119 +2/3 COR
    {
        items =
        {
            26191,
            23324,
            23659,
            23257,
            23592,
            23190,
            23525,
            23123,
            23458,
            23056,
            23391
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [111] = -- AF1 119 +2/3 PUP
    {
        items =
        {
            26191,
            23325,
            23660,
            23258,
            23593,
            23191,
            23526,
            23124,
            23459,
            23057,
            23392
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [112] = -- AF1 119 +2/3 DNC (M)
    {
        items =
        {
            26191,
            23326,
            23661,
            23259,
            23594,
            23192,
            23527,
            23125,
            23460,
            23058,
            23393
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [113] = -- AF1 119 +2/3 DNC (F)
    {
        items =
        {
            26191,
            23327,
            23662,
            23260,
            23595,
            23193,
            23528,
            23126,
            23461,
            23059,
            23394
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [114] = -- AF1 119 +2/3 SCH
    {
        items =
        {
            26085,
            23328,
            23663,
            23261,
            23596,
            23194,
            23529,
            23127,
            23462,
            23060,
            23395
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [115] = -- AF1 119 +2/3 GEO
    {
        items =
        {
            26085,
            23329,
            23664,
            23262,
            23597,
            23195,
            23530,
            23128,
            23463,
            23061,
            23396
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [116] = -- AF1 119 +2/3 RUN
    {
        items =
        {
            26191,
            23330,
            23665,
            23263,
            23598,
            23196,
            23531,
            23129,
            23464,
            23062,
            23397
        },
        minMatches = 2,
        maxMatches = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [117] = -- Outrider set (Phys damage taken -10%)
    {
        items =
        {
            27740,
            27881,
            28029,
            28168,
            28306
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.DMGPHYS, -1000, 0, 0 },
        },
    },

    [118] = -- Espial set (Crit damage +10%)
    {
        items =
        {
            27741,
            27882,
            28030,
            28169,
            28307
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.CRIT_DMG_INCREASE, 10, 0, 0 },
        },
    },

    [119] = -- Wayfarer set (Refresh+3)
    {
        items =
        {
            27742,
            27883,
            28031,
            28170,
            28308
        },
        minMatches = 5,
        mods =
        {
            { xi.mod.REFRESH, 3, 0, 0 },
        },
    },

    [120] = -- Apogee +1
    {
        items =
        {
            26677,
            26853,
            27029,
            27205,
            27381
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.BP_DAMAGE, 4, 2, 0 },
        },
    },

    [121] = -- Ryuo +1
    {
        items =
        {
            25612,
            25685,
            27116,
            27301,
            27472
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ATT, 20, 10, 0 },
        },
    },

    [122] = -- Souveran +1
    {
        items =
        {
            26671,
            26847,
            27023,
            27199,
            27375
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DMG, -4, -2, 0 },
        },
    },

    [123] = -- Emicho +1
    {
        items =
        {
            25610,
            25683,
            27114,
            27299,
            27470
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 2, 0 },
        },
    },

    [124] = -- Kaykaus +1
    {
        items =
        {
            25618,
            25691,
            27122,
            27307,
            27478
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.CURE_POTENCY_II, 4, 2, 0 },
        },
    },

    [125] = -- Rao +1
    {
        items =
        {
            26675,
            26851,
            27027,
            27203,
            27379
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MARTIAL_ARTS, 8, 4, 0 },
        },
    },

    [126] = -- Adhemar +1
    {
        items =
        {
            25614,
            25687,
            27118,
            27303,
            27474
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 4, 2, 0 },
        },
    },

    [127] = -- Carmine +1
    {
        items =
        {
            26679,
            26855,
            27031,
            27207,
            27383
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ACC, 20, 10, 0 },
        },
    },

    [128] = -- Lustratio +1
    {
        items =
        {
            26669,
            26845,
            27021,
            27197,
            27373
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ALL_WSDMG_FIRST_HIT, 4, 2, 0 },
        },
    },

    [129] = -- Argosy +1
    {
        items =
        {
            26673,
            26849,
            27025,
            27201,
            27377
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 2, 0 },
        },
    },

    [130] = -- Amalric +1
    {
        items =
        {
            25616,
            25689,
            27120,
            27305,
            27476
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.MATT, 20, 10, 0 },
        },
    },

    [131] = -- Moliones's Sickle/Ring
    {
        items =
        {
            18947,
            15818
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.ACC,              5, 0, 0 },
            { xi.mod.SOULEATER_EFFECT, 2, 0, 0 },
        },
    },

    [132] = -- Mavi +2 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            11079,
            11099,
            11119,
            11139,
            11159
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 1, 0 },
        },
    },

    [133] = -- AF3 BLU 109/119 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            26770,
            26771,
            26928,
            26929,
            27082,
            27083,
            27267,
            27268,
            27441,
            27442
        },
        minMatches = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 1, 0 },
        },
    }
}

local function FindMatchByType(gearset, gearMatch)
    if gearset.matchType == matchtype.any then
        return true
    elseif
        gearset.matchType == matchtype.ring_armor and
        (
            gearMatch[xi.slot.HEAD + 1] ~= nil or
            gearMatch[xi.slot.BODY + 1] ~= nil or
            gearMatch[xi.slot.HANDS + 1] ~= nil or
            gearMatch[xi.slot.LEGS + 1] ~= nil or
            gearMatch[xi.slot.FEET + 1] ~= nil
        )
        and
        (
            gearMatch[xi.slot.RING1 + 1] ~= nil or
            gearMatch[xi.slot.RING2 + 1] ~= nil
        )
    then
        return true
    end

    for _, id in ipairs(gearMatch) do
        if (gearset.matchType == matchtype.earring_weapon and
            (gearMatch[xi.slot.MAIN + 1] ~= nil or gearMatch[xi.slot.SUB + 1] ~=
                nil) and
            (gearMatch[xi.slot.EAR1 + 1] ~= nil or gearMatch[xi.slot.EAR2 + 1] ~=
                nil)) then
            return true
        elseif (gearset.matchType == matchtype.weapon_weapon and
            (gearMatch[xi.slot.MAIN + 1] ~= nil and gearMatch[xi.slot.SUB + 1] ~=
                nil)) then
            return true
        end
    end

    return false
end

local function handleCappedTierSet(player, gearset, minMatches)
    -- Rubeus Armor Set
    if (gearset.id == 32) then
        local modValue = 0

        if (minMatches > 1 and minMatches < 4) then
            modValue = 4 -- 2 or 3 pieces
        elseif (minMatches > 3) then
            modValue = 10 -- 4 or 5 pieces
        end

        player:addGearSetMod(gearset.id, xi.mod.FASTCAST, modValue)
        return
        -- AF1 119+2/+3 ACC/RACC/MACC Sets EXCEPT SMN
    elseif (gearset.id >= 133 and gearset.id <= 199 and gearset.id ~= 175) then
        local modValue = 0

        if (minMatches == 2) then
            modValue = 15 -- 2 minMatches
        elseif (minMatches == 3) then
            modValue = 30 -- 3 minMatches
        elseif (minMatches == 4) then
            modValue = 45 -- 4 minMatches
        elseif (minMatches >= 5) then
            modValue = 60 -- 5 or more minMatches
        end
        player:addGearSetMod(gearset.id, xi.mod.ACC, modValue)
        player:addGearSetMod(gearset.id + 1, xi.mod.RACC, modValue)
        player:addGearSetMod(gearset.id + 2, xi.mod.MACC, modValue)
        return
        -- AF1 119 +2/+3 SMN Avatar:ACC/RACC/MACC (unimplemented)
        --[[
    elseif (gearset.id == 175) then
        local modValue = 0

        if (minMatches == 2) then
            modValue = 15 -- 2 minMatches
        elseif (minMatches == 3) then
            modValue = 30 -- 3 minMatches
        elseif (minMatches == 4) then
            modValue = 45 -- 4 minMatches
        elseif (minMatches >= 5) then
            modValue = 60 -- 5 or more minMatches
        end
        --Unimplemented method to add pet mods
        return
    ]] --
    end
end

-----------------------------------
-- Applys a gear set mod
-----------------------------------
local function ApplyMod(player, gearset, minMatches)

    for _, set in pairs(cappedTierSets) do
        if (set.id == gearset.id) then
            handleCappedTierSet(player, gearset, minMatches)
            return
        end
    end

    -- find any additional minMatches
    local addMatches = minMatches - gearset.minMatches

    -- just in case someone decides to customize things
    if (addMatches < 0) then return end

    local i = 0
    for _, mod in pairs(gearset.mods) do
        local modId = mod[1]
        local modValue = mod[2]

        -- value/multiplier for additional pieces
        local addMatchValue = mod[3]

        -- additional bonus for complete set
        local addSetBonus = 0

        -- cause we need all pieces to form a complete set
        if (minMatches == #gearset.items) then
            addSetBonus = mod[4]
        end

        -- add bonus mods per piece
        if (addMatches ~= 0 and addMatchValue ~= 0) then
            modValue = modValue + (addMatchValue * addMatches)
        end

        player:addGearSetMod(gearset.id + i, modId, modValue + addSetBonus)
        i = i + 1
    end
end

-----------------------------------
-- Checks for gear sets present on a player
-----------------------------------
xi.gear_sets.checkForGearSet = function(player)
    player:clearGearSetMods()

    -- cause we dont want hundreds of function calls
    local equip = {}
    for slot = 0, xi.MAX_SLOTID do
        equip[slot + 1] = player:getEquipID(slot)
    end

    for index, gearset in pairs(gearSets) do
        local minMatches = 0
        if (player:hasGearSetMod(gearset.id) == false) then
            -- local slot = 0
            local gearMatch = {}

            for _, id in pairs(gearset.items) do
                for slot = 1, xi.MAX_SLOTID do
                    local equipId = equip[slot]

                    -- check the item minMatches
                    if (equipId == id) then
                        minMatches = minMatches + 1
                        gearMatch[slot] = equipId
                        break
                    end
                end
            end

            -- doesnt count as a match if the same item is in both slots
            if (gearMatch[xi.slot.EAR1 + 1] == gearMatch[xi.slot.EAR2 + 1] and
                gearMatch[xi.slot.EAR1 + 1] ~= nil) then
                minMatches = minMatches - 1
            end
            if (gearMatch[xi.slot.RING1 + 1] == gearMatch[xi.slot.RING2 + 1] and
                gearMatch[xi.slot.RING1 + 1] ~= nil) then
                minMatches = minMatches - 1
            end
            if (gearMatch[xi.slot.MAIN + 1] == gearMatch[xi.slot.SUB + 1] and
                gearMatch[xi.slot.MAIN + 1] ~= nil) then
                minMatches = minMatches - 1
            end

            if (minMatches >= gearset.minMatches) then
                if (FindMatchByType(gearset, gearMatch) == true) then
                    ApplyMod(player, gearset, minMatches)
                end
            end
        end
    end
end
