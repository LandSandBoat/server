xi = xi or {}

---@enum xi.mobSkill
xi.mobSkill =
{
    SHADOWSTITCH                  =   18,

    DANCING_EDGE                  =   23,
    SHARK_BITE                    =   24,
    EVISCERATION                  =   25,

    VORPAL_SCYTHE                 =  101,
    GUILLOTINE_1                  =  102,

    SPIRAL_HELL                   =  104,

    PENTA_THRUST                  =  116,

    SKEWER                        =  118,
    WHEELING_THRUST               =  119,
    IMPULSE_DRIVE                 =  120,

    BARBED_CRESCENT_1             =  245,

    FOOT_KICK_1                   =  257,
    DUST_CLOUD_1                  =  258,
    WHIRL_CLAWS_1                 =  259,
    LAMB_CHOP_1                   =  260,
    RAGE_1                        =  261,
    SHEEP_CHARGE_1                =  262,
    SHEEP_BLEAT_1                 =  263,
    SHEEP_SONG_1                  =  264,
    RAGE_2                        =  265,
    RAM_CHARGE                    =  266, -- Unique entry.
    RUMBLE                        =  267, -- Unique entry.
    GREAT_BLEAT                   =  268, -- Unique entry.
    PETRIBREATH                   =  269, -- Unique entry.
    ROAR_1                        =  270,
    RAZOR_FANG_1                  =  271,
    RANGED_ATTACK_1               =  272,
    CLAW_CYCLONE_1                =  273,
    SHEEP_CHARGE_2                =  274,
    SANDBLAST_1                   =  275,
    SANDPIT_1                     =  276,
    VENOM_SPRAY_1                 =  277,
    PIT_AMBUSH_1                  =  278,
    MANDIBULAR_BITE_1             =  279,

    STOMPING                      =  281,

    WHISTLE                       =  285,
    BERSERK_DHALMEL               =  286,
    HEALING_BREEZE                =  287,

    ENTANGLE_DRAIN                =  299,

    SUBSTITUTE                    =  307,
    FROGKICK_1                    =  308,
    SPORE_1                       =  309,
    QUEASYSHROOM_1                =  310,
    NUMBSHROOM_1                  =  311,
    SHAKESHROOM_1                 =  312,
    COUNTERSPORE_1                =  313,
    SILENCE_GAS_1                 =  314,
    DARK_SPORE_1                  =  315,

    SOMERSAULT_1                  =  318,

    BAD_BREATH_1                  =  319,

    DRILL_BRANCH                  =  328,
    PINECONE_BOMB                 =  329,

    LEAFSTORM                     =  331,
    ENTANGLE                      =  332,

    VELOCIOUS_BLADE               =  347, -- Mammet-800

    HEAVY_BLOW                    =  357,
    HEAVY_WHISK                   =  358,
    BIONIC_BOOST                  =  359,
    FLYING_HIP_PRESS              =  360,
    EARTH_SHOCK                   =  361,

    TAIL_BLOW_1                   =  366,
    FIREBALL_1                    =  367,
    BLOCKHEAD_1                   =  368,
    BRAIN_CRUSH_1                 =  369,
    BALEFUL_GAZE_LIZARD           =  370,
    PLAGUE_BREATH_1               =  371,
    INFRASONICS_1                 =  372,
    SECRETION_1                   =  373,

    TAIL_ROLL                     =  382,
    TUSK                          =  383,
    SCUTUM                        =  384,
    BONE_CRUNCH                   =  385,
    AWFUL_EYE                     =  386,
    HEAVY_BELLOW                  =  387,

    ULTRASONICS_1                 =  392,
    SONIC_BOOM_1                  =  393,
    BLOOD_DRAIN_1                 =  394,
    JET_STREAM_1                  =  395,
    SMITE_OF_FURY                 =  396,
    FLURRY_OF_RAGE                =  397,
    WHISPERS_OF_IRE               =  398,

    HAMMER_BEAK                   =  406,

    BALEFUL_GAZE_COCKATRICE       =  411,
    RANGED_ATTACK_2               =  412,

    SCISSION_THRUST               =  419, -- Mammet-800

    SONIC_BLADE                   =  422, -- Mammet-800

    SANDSPIN                      =  426,

    GLOEOSUCCUS                   =  436,
    DEATH_RAY                     =  437,
    HEX_EYE                       =  438,
    PETRO_GAZE                    =  439,
    CATHARSIS                     =  440,
    MICROQUAKE                    =  441, -- Mammet-800

    BIG_SCISSORS                  =  444,

    PERCUSSIVE_FOIN               =  447, -- Mammet-800

    GRAVITY_WHEEL                 =  457, -- Mammet-800

    PSYCHOMANCY                   =  464, -- Mammet-800

    MIND_WALL                     =  471, -- Mammet-800

    PETRIFACTIVE_BREATH           =  480,

    CHARGED_WHISKER               =  483,

    WHIP_TONGUE                   =  486,
    TRANSMOGRIFICATION            =  487, -- Mammet-800

    STINKING_GAS                  =  489,

    ABYSS_BLAST                   =  492,

    TRICLIP_1                     =  498,
    BACK_SWISH_1                  =  499,
    MOW_1                         =  500,
    FRIGHTFUL_ROAR_1              =  501,
    MORTAL_RAY_1                  =  502,
    UNBLESSED_ARMOR               =  503,

    SELF_DESTRUCT_BOMB            =  509,

    SELF_DESTRUCT_BOMB_321        =  511,

    SMITE_OF_RAGE                 =  513,
    WHIRL_OF_RAGE                 =  514,

    DANSE_MACABRE                 =  533,
    KARTSTRAHL                    =  534,
    BLITZSTRAHL                   =  535,
    PANZERFAUST                   =  536,
    BERSERK_DOLL                  =  537,

    TYPHOON                       =  539,

    TREMOROUS_TREAD               =  540, -- Mammet-800
    GRAVITY_FIELD                 =  541,

    CAMISADO_1                    =  544,

    NOCTOSHIELD_1                 =  546,
    ULTIMATE_TERROR_1             =  547,

    NIGHTMARE_1                   =  558,

    SLING_BOMB_1                  =  567,
    FORMATION_ATTACK_1            =  568,
    REFUELING_1                   =  569,
    CIRCLE_OF_FLAMES_1            =  570,
    SELF_DESTRUCT_CLUSTER_3       =  571,
    SELF_DESTRUCT_CLUSTER_3_DEATH =  572,
    SELF_DESTRUCT_CLUSTER_2       =  573,
    SELF_DESTRUCT_CLUSTER_2_DEATH =  574,
    SELF_DESTRUCT_CLUSTER_1_DEATH =  575,
    BACK_HEEL_1                   =  576,
    JETTATURA_1                   =  577,
    NIHILITY_SONG_1               =  578,
    CHOKE_BREATH_1                =  579,
    FANTOD_1                      =  580,
    BLOW                          =  581,

    BLANK_GAZE                    =  586,

    BOMB_TOSS_1                   =  591,

    BERSERK_BOMB_BIG              =  593, -- Big Bomb / Friars Lantern
    VULCANIAN_IMPACT              =  594, -- Big Bomb / Friars Lantern
    HEAT_WAVE                     =  595, -- Big Bomb / Friars Lantern
    HELLSTORM                     =  596, -- Big Bomb / Friars Lantern
    SELF_DESTRUCT_BOMB_BIG        =  597, -- Big Bomb / Friars Lantern

    ARCTIC_IMPACT                 =  599, -- Snoll Tzar
    COLD_WAVE_2                   =  600, -- Snoll Tzar
    HIEMAL_STORM                  =  601, -- Snoll Tzar
    HYPOTHERMAL_COMBUSTION_2      =  602, -- Snoll Tzar

    SWEEP                         =  620,

    HELLDIVE_1                    =  622,
    WING_CUTTER_1                 =  623,

    VULTURE_3                     =  626,

    FINAL_METEOR                  =  634, -- Final Meteor Chlevnik

    VOIDSONG_1                    =  649,
    THORNSONG_1                   =  650,
    LODESONG_1                    =  651,

    CHAOTIC_EYE_1                 =  653,

    CURSED_SPHERE_1               =  659,
    VENOM_1                       =  660,

    KICK_BACK                     =  668,
    IMPLOSION                     =  669,

    UMBRA_SMASH                   =  671,
    GIGA_SLASH                    =  672,
    DARK_NOVA                     =  673,

    CRYSTAL_RAIN                  =  678,
    CRYSTAL_WEAPON_FIRE           =  679, -- Zipacna Weapon Start

    CRYSTAL_WEAPON_WATER          =  682, -- Zipacna Weapon End

    MIGHTY_STRIKES_1              =  688,
    BENEDICTION_1                 =  689, -- Season's Greetings KSNM 30 (Gilagoge Tlugvi)
    HUNDRED_FISTS_1               =  690, -- Season's Greetings KSNM 30 (Goga Tlugvi)

    BLOOD_WEAPON_1                =  695,
    SOUL_VOICE_1                  =  696,

    CHARM                         =  710,

    JUMP_1                        =  718,

    MEIKYO_SHISUI_1               =  730, -- Tenzen, etc...
    MIJIN_GAKURE_1                =  731, -- Season's Greetings KSNM 30 (Ulagohvsdi Tlugvi)
    CALL_WYVERN                   =  732,

    ASTRAL_FLOW_1                 =  734,

    FAMILIAR_1                    =  740, -- "Tango with a Tracker" Shikaree X

    QUADRATIC_CONTINUUM_2         =  742,

    SPIRIT_ABSORPTION_2           =  745,

    VANITY_DRIVE_2                =  748,

    STYGIAN_FLATUS_1              =  750,

    PROMYVION_BARRIER_2           =  753,

    FISSION                       =  755,

    GREAT_WHIRLWIND_1             =  803,

    DISPELLING_WIND               =  813,
    DEADLY_DRIVE                  =  814,
    WIND_WALL                     =  815,
    FANG_RUSH                     =  816,
    DREAD_SHRIEK                  =  817,
    TAIL_CRUSH                    =  818,
    BLIZZARD_BREATH               =  819,
    THUNDER_BREATH                =  820,
    RADIANT_BREATH                =  821,
    CHAOS_BREATH                  =  822,

    LIGHT_BLADE_1                 =  830,

    HOWLING_MOON_1                =  838, -- Unknown usage.
    HOWLING_MOON_2                =  839, -- Confirmed usage: "The Moonlit Path" bcnm (Fenrir).

    INFERNO_1                     =  848, -- Confirmed usage: "Trial by Fire" bcnm. Regular avatar-type mobs (Ifrit).

    EARTHEN_FURY_1                =  857, -- Confirmed usage: "Trial by Earth" bcnm. Regular avatar-type mobs (Titan).

    TIDAL_WAVE_1                  =  866, -- Confirmed usage: "Trial by Water" bcnm. Regular avatar-type mobs (Leviathan).

    AERIAL_BLAST_1                =  875, -- Confirmed usage: "Trial by Wind" bcnm. Regular avatar-type mobs (Garuda).

    DIAMOND_DUST_1                =  884, -- Confirmed usage: "Trial by Ice" bcnm. Regular avatar-type mobs (Shiva).

    JUDGMENT_BOLT_1               =  893, -- Confirmed usage: "Trial by Lightning" bcnm. Regular avatar-type mobs (Ramuh).

    HEALING_BREATH_III            =  896,
    REMOVE_POISON                 =  897,
    REMOVE_BLINDNESS              =  898,
    REMOVE_PARALYSIS              =  899,
    PET_FLAME_BREATH              =  900,
    PET_FROST_BREATH              =  901,
    PET_GUST_BREATH               =  902,
    PET_SAND_BREATH               =  903,
    PET_LIGHTNING_BREATH          =  904,
    PET_HYDRO_BREATH              =  905,

    SEARING_LIGHT_1               =  912, -- Confirmed usage: Regular avatar-type mobs (Carbuncle).
    INFERNO_2                     =  913, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ifrit model avatar)
    EARTHEN_FURY_2                =  914, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Titan model avatar)
    TIDAL_WAVE_2                  =  915, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Leviathan model avatar)
    AERIAL_BLAST_2                =  916, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Garuda model avatar)
    DIAMOND_DUST_2                =  917, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Shiva model avatar)
    JUDGMENT_BOLT_2               =  918, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ramuh model avatar)
    SEARING_LIGHT_2               =  919, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin, Crimson-toothed Pawberry) (Carbuncle model avatar)

    GIGA_SCREAM_1                 =  923,
    DREAD_DIVE_1                  =  924,

    DRILL_BRANCH_NM               =  927,
    PINECONE_BOMB_NM              =  928,
    LEAFSTORM_DISPEL              =  929,
    ENTANGLE_POISON               =  930,

    SHIELD_STRIKE                 =  934, -- Ark Angel EV

    ARKANGEL_TT_WARP_OUT          =  936, -- Ark Angel TT Warp Out

    TACHI_YUKIKAZE                =  946, -- Ark Angel GK
    TACHI_GEKKO                   =  947, -- Ark Angel GK
    TACHI_KASHA                   =  948, -- Ark Angel GK

    ARKANGEL_TT_WARP_IN           =  962, -- Ark Angel TT Warp In

    TRION_RED_LOTUS_BLADE         =  968, -- Trion Red Lotus Blade
    TRION_FLAT_BLADE              =  969, -- Trion Flat Blade
    TRION_SAVAGE_BLADE            =  970, -- Trion Savage Blade

    VOLKER_RED_LOTUS_BLADE        =  973, -- Volker Red Lotus Blade
    VOLKER_SPIRITS_WITHIN         =  974, -- Volker Spirits Within
    VOLKER_VORPAL_BLADE           =  975, -- Volker Vorpal Blade

    AJIDO_WARP_OUT                =  977, -- Windurst 9-2 Ajido teleport
    AJIDO_WARP_IN                 =  978, -- Windurst 9-2 Ajido teleport

    PHASE_SHIFT_1_EXOPLATES       =  993,

    PHASE_SHIFT_2_EXOPLATES       =  997,

    PHASE_SHIFT_3_EXOPLATES       = 1001,
    ZEID_SUMMON_SHADOWS_1         = 1002, -- TODO: Investigate why was this in sql, where it came from and why wasnt it actually used in an scripted way.

    ZEID_SUMMON_SHADOWS_2         = 1007, -- Captured. Bastok mission 9-2 BCNM, phase 2. No actual name in log.

    CALL_BEAST                    = 1017, -- "Tango with a Tracker" Shikaree X

    HOWL                          = 1062,

    FRYPAN_1                      = 1081,
    SMOKEBOMB_1                   = 1082,

    GOBLIN_DICE_HEAL              = 1099,

    GOBLIN_DICE_RESET             = 1109,

    RANGED_ATTACK_3               = 1154,

    SUBSONICS_1                   = 1155,
    MARROW_DRAIN_1                = 1156,
    SLIPSTREAM_1                  = 1157,
    TURBULENCE_1                  = 1158,
    BROADSIDE_BARRAGE_1           = 1159,
    BLIND_SIDE_BARRAGE_1          = 1160,
    DAMNATION_DIVE_1              = 1161,
    INFERNO_3                     = 1162, -- Confirmed usage: "Trial-Size Trial by Fire" bcnm. (Ifrit)
    EARTHEN_FURY_3                = 1163, -- Confirmed usage: "Trial-Size Trial by Earth" bcnm. (Titan)
    TIDAL_WAVE_3                  = 1164, -- Confirmed usage: "Trial-Size Trial by Water" bcnm. (Leviathan)
    AERIAL_BLAST_3                = 1165, -- Confirmed usage: "Trial-Size Trial by Wind" bcnm. (Garuda)
    DIAMOND_DUST_3                = 1166, -- Confirmed usage: "Trial-Size Trial by Ice" bcnm. (Shiva)
    JUDGMENT_BOLT_3               = 1167, -- Confirmed usage: "Trial-Size Trial by Lightning" bcnm. (Ramuh)

    THORNSONG_2                   = 1176, -- Extremely powerful version of Thornsong

    RANGED_ATTACK_4               = 1202,
    RANGED_ATTACK_5               = 1203,
    RANGED_ATTACK_6               = 1204,
    RANGED_ATTACK_7               = 1205,
    RANGED_ATTACK_8               = 1206,

    RANGED_ATTACK_9               = 1209,
    RANGED_ATTACK_10              = 1210,
    RANGED_ATTACK_11              = 1211,
    RANGED_ATTACK_12              = 1212,
    RANGED_ATTACK_13              = 1213,
    RANGED_ATTACK_14              = 1214,

    MEMORY_OF_FIRE                = 1221,
    MEMORY_OF_ICE                 = 1222,
    MEMORY_OF_WIND                = 1223,
    MEMORY_OF_LIGHT               = 1224,
    MEMORY_OF_EARTH               = 1225,
    MEMORY_OF_LIGHTNING           = 1226,
    MEMORY_OF_WATER               = 1227,
    MEMORY_OF_DARK                = 1228,

    MURK                          = 1232,
    MATERIAL_FEND                 = 1233,
    CAROUSEL_1                    = 1234,

    PILE_PITCH                    = 1235,
    GUIDED_MISSILE                = 1236,
    HYPER_PULSE                   = 1237,
    TARGET_ANALYSIS               = 1238,
    DISCHARGER                    = 1239,
    ION_EFFLUX                    = 1240,
    REAR_LASERS                   = 1241,

    NEGATIVE_WHIRL_1              = 1243,
    STYGIAN_VAPOR                 = 1244,
    WINDS_OF_PROMYVION_1          = 1245,

    SPIRIT_ABSORPTION             = 1246,
    BINARY_ABSORPTION             = 1247,
    TRINARY_ABSORPTION            = 1248,
    SPIRIT_TAP                    = 1249,
    BINARY_TAP                    = 1250,
    TRINARY_TAP                   = 1251,
    SHADOW_SPREAD                 = 1252,

    WIRE_CUTTER                   = 1259,
    ANTIMATTER                    = 1260,
    EQUALIZER                     = 1261,
    FLAME_THROWER                 = 1262,
    CRYO_JET                      = 1263,
    TURBOFAN                      = 1264,
    SMOKE_DISCHARGER              = 1265,
    HIGH_TENSION_DISCHARGER       = 1266,
    HYDRO_CANON                   = 1267,
    NUCLEAR_WASTE                 = 1268,
    CHEMICAL_BOMB                 = 1269,
    PARTICLE_SHIELD               = 1270,

    EMPTY_CUTTER                  = 1271,

    IMPALEMENT                    = 1274,
    EMPTY_THRASH                  = 1275,
    PROMYVION_BRUME_2             = 1276,

    GERJIS_GRIP                   = 1322,

    HOOF_VOLLEY                   = 1330,

    COUNTERSTANCE                 = 1331, -- The Waughroon Kid

    CONTAGION_TRANSFER            = 1333,
    CONTAMINATION                 = 1334,
    TOXIC_PICK                    = 1335,
    FRENZIED_RAGE_1               = 1336,
    CHARM_2                       = 1337,
    INFERNAL_PESTILENCE           = 1338,

    CROSSTHRASH_1                 = 1340,
    KNIFE_EDGE_CIRCLE             = 1341,
    TRAIN_FALL                    = 1342,

    MANTLE_PIERCE                 = 1349,

    AERIAL_COLLISION              = 1353,

    SPINE_LASH                    = 1355,

    TIDAL_DIVE                    = 1357,
    PLASMA_CHARGE                 = 1358,

    HUNGRY_CRUNCH                 = 1363,

    SINUATE_RUSH                  = 1367,

    WING_THRUST                   = 1378,
    AURORAL_WIND                  = 1379,
    IMPACT_STREAM                 = 1380,
    DEPURATION                    = 1381,
    CRYSTALINE_COCOON             = 1382,

    MEDUSA_JAVELIN                = 1386,

    AMATSU_TORIMAI                = 1390,
    AMATSU_KAZAKIRI               = 1391,

    AMATSU_HANAIKUSA              = 1394,
    AMATSU_TSUKIKAGE              = 1395,
    COSMIC_ELUCIDATION            = 1396,

    RANGED_ATTACK_TENZEN_1        = 1398, -- Tenzen Bow High
    RICEBALL_TENZEN               = 1399,
    RANGED_ATTACK_TENZEN_2        = 1400, -- Tenzen Bow Low
    SOUL_ACCRETION                = 1401,

    ACTINIC_BURST                 = 1441,

    HEXIDISCS                     = 1443,
    VORPAL_BLADE_GHRAH            = 1444,
    DAMNATION_DIVE_GHRAH          = 1445,
    SICKLE_SLASH                  = 1446,

    DEADALUS_WING_COP_PRISHE      = 1487, -- Dwing COP 8-4 Dawn

    HOWLING_MOON_3                = 1520, -- Unknown usage.

    FOOT_KICK_2                   = 1567,
    DUST_CLOUD_2                  = 1568,
    WHIRL_CLAWS_2                 = 1569,

    FROGKICK_2                    = 1621,

    SHEEP_BLEAT_2                 = 1633,
    SHEEP_SONG_2                  = 1634,
    SHEEP_CHARGE_3                = 1635,

    ROAR_2                        = 1677,
    RAZOR_FANG_2                  = 1678,
    CLAW_CYCLONE_2                = 1679,

    HYPNIC_LAMP                   = 1695, -- Unique entry.

    PROBOSCIS_SHOWER              = 1708,

    FORCEFUL_BLOW                 = 1731, -- Used with Mamool's weapons break.

    LAVA_SPIT                     = 1785,

    GATES_OF_HADES                = 1790,

    VAMPIRIC_ROOT                 = 1793,

    XENOGLOSSIA                   = 1823, -- Unique entry.

    SANDBLAST_2                   = 1841,
    SANDPIT_2                     = 1842,
    VENOM_SPRAY_2                 = 1843,
    PIT_AMBUSH_2                  = 1844,
    MANDIBULAR_BITE_2             = 1845,

    RANGED_ATTACK_15              = 1949,

    WATER_BOMB                    = 1959,

    IMMORTAL_SHIELD               = 1965,

    ECLOSION                      = 1970, -- Unique entry.

    DEATHGNASH                    = 1977, -- Unique entry.

    BOREAS_MANTLE                 = 1980, -- Unique entry.

    REWARD                        = 2005,

    NOCTURNAL_SERVITUDE           = 2112,
    HELLSNAP                      = 2113,
    HELLCLAP                      = 2114,
    CACKLE                        = 2115,
    NECROBANE                     = 2116,
    NECROPURGE                    = 2117,
    BILGESTORM                    = 2118,
    THUNDRIS_SHRIEK               = 2119,

    RADIANT_SACRAMENT             = 2141,
    MEGA_HOLY                     = 2142,
    PERFECT_DEFENSE               = 2143,
    DIVINE_SPEAR                  = 2144,
    GOSPEL_OF_THE_LOST            = 2145,
    VOID_OF_REPENTANCE            = 2146,
    DIVINE_JUDGMENT               = 2147,

    GRIM_GLOWER                   = 2156,

    PEDAL_PIROUETTE               = 2210,

    HELL_SCISSORS                 = 2221,

    QUEASYSHROOM_2                = 2232,

    DI_HORN_ATTACK                = 2329,
    DI_BITE_ATTACK                = 2330,
    DI_KICK_ATTACK                = 2331,
    DI_TRAMPLE                    = 2332,
    DI_GLOW                       = 2333,
    WRATH_OF_ZEUS                 = 2334,
    LIGHTNING_SPEAR               = 2335,
    ACHERON_KICK                  = 2336,
    DAMSEL_MEMENTO                = 2337,
    RAMPANT_STANCE                = 2338,

    OPPRESSIVE_GLARE              = 2392,

    ROAR_3                        = 2406,

    REAVING_WIND                  = 2431,
    REAVING_WIND_KNOCKBACK        = 2434,

    AQUA_BLAST                    = 2437,

    HYDRO_WAVE                    = 2439,

    INFERNO_4                     = 2480, -- Unknown usage.
    TIDAL_WAVE_4                  = 2481, -- Unknown usage.
    EARTHEN_FURY_4                = 2482, -- Unknown usage.
    DIAMOND_DUST_4                = 2483, -- Unknown usage.
    JUDGMENT_BOLT_4               = 2484, -- Unknown usage.
    AERIAL_BLAST_4                = 2485, -- Unknown usage.

    BOOMING_BOMBINATION           = 2770,

    LIGHT_BLADE_2                 = 3214,

    INFERNO_5                     = 3325, -- Unknown usage.

    AERIAL_BLAST_5                = 3327, -- Unknown usage.

    DIAMOND_DUST_5                = 3329, -- Unknown usage.

    JUDGMENT_BOLT_5               = 3331, -- Unknown usage.

    EARTHEN_FURY_5                = 3333, -- Unknown usage.

    TIDAL_WAVE_5                  = 3335, -- Unknown usage.

    HOWLING_MOON_4                = 3336, -- Unknown usage.

    SHEEP_SONG_3                  = 3433,

    LIGHT_BLADE_3                 = 3471,

    FOOT_KICK_3                   = 3840,
    DUST_CLOUD_3                  = 3841,
    WHIRL_CLAWS_3                 = 3842,

    ROAR_4                        = 3848,
    RAZOR_FANG_3                  = 3849,
    CLAW_CYCLONE_3                = 3850,

    LAMB_CHOP_2                   = 3857,
    RAGE_3                        = 3858,
    SHEEP_CHARGE_4                = 3859,
    SHEEP_SONG_4                  = 3860,

    FROGKICK_3                    = 3868,
    SPORE_2                       = 3869,
    QUEASYSHROOM_3                = 3870,
    NUMBSHROOM_2                  = 3871,
    SHAKESHROOM_2                 = 3872,
    SILENCE_GAS_2                 = 3873,
    DARK_SPORE_2                  = 3874,

    SANDBLAST_3                   = 3882,
    SANDPIT_3                     = 3883,
    VENOM_SPRAY_3                 = 3884,
    MANDIBULAR_BITE_3             = 3885,
}
