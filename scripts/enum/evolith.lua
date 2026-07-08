-----------------------------------
-- Evolith
-----------------------------------
xi = xi or {}
xi.evolith = xi.evolith or {}

-- Stored in Evolith exdata
-- Not all shapes are used
---@enum xi.evolith.shape
xi.evolith.shape =
{
    DOWN_FILLED    = 1,  -- ▼ Additional effects, Weaponskills: R.Atk/Atk/Enmity/Accuracy
    DIAMOND_FILLED = 2,  -- ◆ Weaponskills: DA/TA/CritRate/TP Bonus, Skillchains
    STAR_FILLED    = 3,  -- ★
    UP_EMPTY       = 4,  -- △ HP, MP, Magic
    SQUARE_EMPTY   = 5,  -- □
    CIRCLE_EMPTY   = 6,  -- ○
    DOWN_EMPTY     = 7,  -- ▽
    DIAMOND_EMPTY  = 8,  -- ◇
    STAR_EMPTY     = 9,  -- ☆
    UP_FILLED      = 10, -- ▲ Vs Family, Resist traits
    SQUARE_FILLED  = 11, -- ■
    CIRCLE_FILLED  = 12, -- ●
    DOUBLE_CIRCLE  = 13, -- ◎ 1HR augments
}

-- Stored in Evolith exdata
---@enum xi.evolith.element
xi.evolith.element =
{
    FIRE      = 0,
    ICE       = 1,
    WIND      = 2,
    EARTH     = 3,
    LIGHTNING = 4,
    WATER     = 5,
    LIGHT     = 6,
    DARK      = 7,
}

---@enum xi.evolith.prefix
xi.evolith.prefix =
{
    NONE                       = 1022, -- (none)
    VS_BEASTS                  = 1024, -- Vs. beasts:
    VS_PLANTOIDS               = 1025, -- Vs. plantoids:
    VS_VERMIN                  = 1026, -- Vs. vermin:
    VS_LIZARDS                 = 1027, -- Vs. lizards:
    VS_BIRDS                   = 1028, -- Vs. birds:
    VS_AMORPHS                 = 1029, -- Vs. amorphs:
    VS_AQUANS                  = 1030, -- Vs. aquans:
    VS_UNDEAD                  = 1031, -- Vs. undead:
    VS_ELEMENTALS              = 1032, -- Vs. elementals:
    VS_ARCANA                  = 1033, -- Vs. arcana:
    VS_DEMONS                  = 1034, -- Vs. Demons:
    VS_DRAGONS                 = 1035, -- Vs. dragons:
    VS_EMPTY                   = 1036, -- Vs. Empty:
    VS_LUMINIANS               = 1037, -- Vs. Luminians:
    MIGHTY_STRIKES             = 1038, -- Mighty Strikes:
    HUNDRED_FISTS              = 1039, -- Hundred Fists:
    BENEDICTION                = 1040, -- Benediction:
    MANAFONT                   = 1041, -- Manafont:
    CHAINSPELL                 = 1042, -- Chainspell:
    PERFECT_DODGE              = 1043, -- Perfect Dodge:
    INVINCIBLE                 = 1044, -- Invincible:
    BLOOD_WEAPON               = 1045, -- Blood Weapon:
    FAMILIAR                   = 1046, -- Familiar:
    SOUL_VOICE                 = 1047, -- Soul Voice:
    EAGLE_EYE_SHOT             = 1048, -- Eagle Eye Shot:
    MEIKYO_SHISUI              = 1049, -- Meikyo Shisui:
    MIJIN_GAKURE               = 1050, -- Mijin Gakure:
    SPIRIT_SURGE               = 1051, -- Spirit Surge:
    ASTRAL_FLOW                = 1052, -- Astral Flow:
    AZURE_LORE                 = 1053, -- Azure Lore:
    WILD_CARD                  = 1054, -- Wild Card:
    OVERDRIVE                  = 1055, -- Overdrive:
    TRANCE                     = 1056, -- Trance:
    TABULA_RASA                = 1057, -- Tabula Rasa:
    HAND_TO_HAND_WS            = 1058, -- Hand. wpnskl.:
    DAGGER_WS                  = 1059, -- Dagger wpnskl.:
    SWORD_WS                   = 1060, -- Sword wpnskl.:
    GREAT_SWORD_WS             = 1061, -- Grtswrd. wpnskl.:
    AXE_WS                     = 1062, -- Axe wpnskl.:
    GREAT_AXE_WS               = 1063, -- Grtaxe. wpnskl.:
    SCYTHE_WS                  = 1064, -- Scythe wpnskl.:
    POLEARM_WS                 = 1065, -- Polearm wpnskl.:
    KATANA_WS                  = 1066, -- Katana wpnskl.:
    GREAT_KATANA_WS            = 1067, -- Grt.ktn. wpnskl.:
    CLUB_WS                    = 1068, -- Club wpnskl.:
    STAFF_WS                   = 1069, -- Staff wpnskl.:
    ARCHERY_WS                 = 1070, -- Arch. wpnskl.:
    MARKSMANSHIP_WS            = 1071, -- Mark. wpnskl.:
    DIVINE_MAGIC_LIGHT         = 1072, -- Div. mag. {LIT}:
    HEALING_MAGIC_LIGHT        = 1073, -- Heal. mag. {LIT}:
    ENHANCING_MAGIC_FIRE       = 1074, -- Enha.mag. {FIR}:
    ENHANCING_MAGIC_ICE        = 1075, -- Enha.mag. {ICE}:
    ENHANCING_MAGIC_WIND       = 1076, -- Enha.mag. {WND}:
    ENHANCING_MAGIC_EARTH      = 1077, -- Enha.mag. {ERT}:
    ENHANCING_MAGIC_LIGHTNING  = 1078, -- Enha.mag. {LTG}:
    ENHANCING_MAGIC_WATER      = 1079, -- Enha.mag. {WTR}:
    ENHANCING_MAGIC_LIGHT      = 1080, -- Enha.mag. {LIT}:
    ENHANCING_MAGIC_DARK       = 1081, -- Enha.mag. {DKN}:
    ENFEEBLING_MAGIC_FIRE      = 1082, -- Enfb.mag. {FIR}:
    ENFEEBLING_MAGIC_ICE       = 1083, -- Enfb.mag. {ICE}:
    ENFEEBLING_MAGIC_WIND      = 1084, -- Enfb.mag. {WND}:
    ENFEEBLING_MAGIC_EARTH     = 1085, -- Enfb.mag. {ERT}:
    ENFEEBLING_MAGIC_LIGHTNING = 1086, -- Enfb.mag. {LTG}:
    ENFEEBLING_MAGIC_WATER     = 1087, -- Enfb.mag. {WTR}:
    ENFEEBLING_MAGIC_LIGHT     = 1088, -- Enfb.mag. {LIT}:
    ENFEEBLING_MAGIC_DARK      = 1089, -- Enfb.mag. {DKN}:
    ELEMENTAL_MAGIC_FIRE       = 1090, -- Elem.mag. {FIR}:
    ELEMENTAL_MAGIC_ICE        = 1091, -- Elem.mag. {ICE}:
    ELEMENTAL_MAGIC_WIND       = 1092, -- Elem.mag. {WND}:
    ELEMENTAL_MAGIC_EARTH      = 1093, -- Elem.mag. {ERT}:
    ELEMENTAL_MAGIC_LIGHTNING  = 1094, -- Elem.mag. {LTG}:
    ELEMENTAL_MAGIC_WATER      = 1095, -- Elem.mag. {WTR}:
    ELEMENTAL_MAGIC_LIGHT      = 1096, -- Elem.mag. {LIT}:
    ELEMENTAL_MAGIC_DARK       = 1097, -- Elem.mag. {DKN}:
    DARK_MAGIC_DARK            = 1098, -- Dark mag. {DKN}:
    SONGS_FIRE                 = 1099, -- {FIR} Songs:
    SONGS_ICE                  = 1100, -- {ICE} Songs:
    SONGS_WIND                 = 1101, -- {WND} Songs:
    SONGS_EARTH                = 1102, -- {ERT} Songs:
    SONGS_LIGHTNING            = 1103, -- {LTG} Songs:
    SONGS_WATER                = 1104, -- {WTR} Songs:
    SONGS_LIGHT                = 1105, -- {LIT} Songs:
    SONGS_DARK                 = 1106, -- {DKN} Songs:
    NINJUTSU_FIRE              = 1107, -- {FIR} Ninjutsu:
    NINJUTSU_ICE               = 1108, -- {ICE} Ninjutsu:
    NINJUTSU_WIND              = 1109, -- {WND} Ninjutsu:
    NINJUTSU_EARTH             = 1110, -- {ERT} Ninjutsu:
    NINJUTSU_LIGHTNING         = 1111, -- {LTG} Ninjutsu:
    NINJUTSU_WATER             = 1112, -- {WTR} Ninjutsu:
    NINJUTSU_LIGHT             = 1113, -- {LIT} Ninjutsu:
    NINJUTSU_DARK              = 1114, -- {DKN} Ninjutsu:
    BLUE_MAGIC_FIRE            = 1115, -- Blue magic {FIR}:
    BLUE_MAGIC_ICE             = 1116, -- Blue magic {ICE}:
    BLUE_MAGIC_WIND            = 1117, -- Blue magic {WND}:
    BLUE_MAGIC_EARTH           = 1118, -- Blue magic {ERT}:
    BLUE_MAGIC_LIGHTNING       = 1119, -- Blue magic {LTG}:
    BLUE_MAGIC_WATER           = 1120, -- Blue magic {WTR}:
    BLUE_MAGIC_LIGHT           = 1121, -- Blue magic {LIT}:
    BLUE_MAGIC_DARK            = 1122, -- Blue magic {DKN}:
    BLUE_MAGIC_PHYSICAL        = 1123, -- Phys. blue magic:
    WEATHER_FIRE               = 1128, -- {FIR} Wthr.:
    WEATHER_ICE                = 1129, -- {ICE} Wthr.:
    WEATHER_WIND               = 1130, -- {WND} Wthr.:
    WEATHER_EARTH              = 1131, -- {ERT} Wthr.:
    WEATHER_LIGHTNING          = 1132, -- {LTG} Wthr.:
    WEATHER_WATER              = 1133, -- {WTR} Wthr.:
    WEATHER_LIGHT              = 1134, -- {LIT} Wthr.:
    WEATHER_DARK               = 1135, -- {DKN} Wthr.:
    SKILLCHAIN_LIGHT           = 1142, -- {LIT}-aligned sklchn.:
    SKILLCHAIN_DARK            = 1143, -- {DKN}-aligned sklchn.:
}

---@enum xi.evolith.suffix
xi.evolith.suffix =
{
    NONE                               = 0,    -- (none)
    HP                                 = 9,    -- HP+#
    MP                                 = 10,   -- MP+#
    ACCURACY                           = 18,   -- Accuracy+#
    ATTACK                             = 19,   -- Attack+#
    RANGED_ACCURACY                    = 20,   -- Rng. Acc.+#
    RANGED_ATTACK                      = 21,   -- Rng. Atk.+#
    EVASION                            = 22,   -- Evasion+#
    DEFENSE                            = 23,   -- DEF+#
    MAGIC_ACCURACY                     = 24,   -- Mag. Acc.+#
    MAGIC_EVASION                      = 25,   -- Mag. Evasion+#
    CRITICAL_HIT_RATE                  = 26,   -- Critical hit rate +#%
    ENMITY                             = 29,   -- Enmity+#
    MAGIC_CRITICAL_HIT_RATE            = 40,   -- Magic crit. hit rate +#
    MAGIC_ATTACK_BONUS                 = 133,  -- "Mag. Atk. Bns."+#
    MAGIC_DEFENSE_BONUS                = 134,  -- "Mag. Def. Bns."+#
    CONSERVE_MP                        = 141,  -- "Conserve MP"+#
    DOUBLE_ATTACK                      = 143,  -- "Double Attack"+#%
    TRIPLE_ATTACK                      = 144,  -- "Triple Attack"+#%
    RESIST_SLEEP                       = 176,  -- "Resist Sleep"+#
    RESIST_POISON                      = 177,  -- "Resist Poison"+#
    RESIST_PARALYZE                    = 178,  -- "Resist Paralyze"+#
    RESIST_SILENCE                     = 180,  -- "Resist Silence"+#
    RESIST_PETRIFY                     = 181,  -- "Resist Petrify"+#
    RESIST_VIRUS                       = 182,  -- "Resist Virus"+#
    RESIST_BIND                        = 185,  -- "Resist Bind"+#
    RESIST_GRAVITY                     = 186,  -- "Resist Gravity"+#
    RESIST_SLOW                        = 187,  -- "Resist Slow"+#
    SKILLCHAIN_DAMAGE                  = 332,  -- Skillchain dmg. +#%
    ADDITIONAL_EFFECT_FIRE_DAMAGE      = 449,  -- Add.eff.:{FIR} Dmg.+#
    ADDITIONAL_EFFECT_ICE_DAMAGE       = 450,  -- Add.eff.:{ICE} Dmg.+#
    ADDITIONAL_EFFECT_WIND_DAMAGE      = 451,  -- Add.eff.:{WND} Dmg.+#
    ADDITIONAL_EFFECT_EARTH_DAMAGE     = 452,  -- Add.eff.:{ERT} Dmg.+#
    ADDITIONAL_EFFECT_LIGHTNING_DAMAGE = 453,  -- Add.eff.:{LTG} Dmg.+#
    ADDITIONAL_EFFECT_WATER_DAMAGE     = 454,  -- Add.eff.:{WTR} Dmg.+#
    ADDITIONAL_EFFECT_LIGHT_DAMAGE     = 455,  -- Add.eff.:{LIT} Dmg.+#
    ADDITIONAL_EFFECT_DARK_DAMAGE      = 456,  -- Add.eff.:{DKN} Dmg.+#
    ADDITIONAL_EFFECT_DISEASE          = 457,  -- Add.eff.:Disease+#
    ADDITIONAL_EFFECT_PARALYSIS        = 458,  -- Add.eff.:Paralysis+#
    ADDITIONAL_EFFECT_SILENCE          = 459,  -- Add.eff.:Silence+#
    ADDITIONAL_EFFECT_SLOW             = 460,  -- Add.eff.:Slow+#
    ADDITIONAL_EFFECT_STUN             = 461,  -- Add.eff.:Stun+#
    ADDITIONAL_EFFECT_POISON           = 462,  -- Add.eff.:Poison+#
    ADDITIONAL_EFFECT_DEFENSE_DOWN     = 465,  -- Add.eff.:Weakens def.+#
    ADDITIONAL_EFFECT_SLEEP            = 466,  -- Add.eff.:Sleep+#
    ABILITY_DELAY                      = 1124, -- Ability delay -%d
    RECAST_DELAY                       = 1125, -- Recast delay -#%
    TP_BONUS                           = 1126, -- TP Bns. +#%
    CASTING_TIME                       = 1127, -- Cast. time -#%
    SKILLCHAIN_ACCURACY                = 1144, -- Sklchn.acc.+#
    MAGIC_BURST_DAMAGE                 = 1145, -- M.B. dmg.+#%
}
