xi = xi or {}

---@enum xi.mobSkill
xi.mobSkill =
{
    COMBO_1                       =    1,
    SHOULDER_TACKLE_1             =    2,
    ONE_INCH_PUNCH_1              =    3,
    BACKHAND_BLOW_1               =    4,
    RAGING_FISTS_1                =    5,
    SPINNING_ATTACK_1             =    6,
    HOWLING_FIST_1                =    7,
    DRAGON_KICK_1                 =    8,

    WASP_STING_1                  =   16,
    VIPER_BITE                    =   17,
    SHADOWSTITCH                  =   18,
    GUST_SLASH                    =   19,
    CYCLONE                       =   20,
    ENERGY_STEAL                  =   21,
    ENERGY_DRAIN                  =   22,
    DANCING_EDGE                  =   23,
    SHARK_BITE                    =   24,
    EVISCERATION                  =   25,

    FAST_BLADE_1                  =   32,
    BURNING_BLADE_1               =   33,
    RED_LOTUS_BLADE_1             =   34,
    FLAT_BLADE_1                  =   35,
    SHINING_BLADE_1               =   36,
    SERAPH_BLADE_1                =   37,
    CIRCLE_BLADE_1                =   38,
    SPIRITS_WITHIN_1              =   39,
    VORPAL_BLADE_1                =   40,

    SAVAGE_BLADE_1                =   42,

    HARD_SLASH_1                  =   48,
    POWER_SLASH_1                 =   49,
    FROSTBITE_1                   =   50,
    FREEZEBITE_1                  =   51,
    SHOCKWAVE_1                   =   52,
    CRESCENT_MOON_1               =   53,
    SICKLE_MOON_1                 =   54,

    DIMIDIATION_1                 =   61,

    RAGING_AXE                    =   64,
    SMASH_AXE                     =   65,
    GALE_AXE                      =   66,
    AVALANCHE_AXE                 =   67,
    SPINNING_AXE                  =   68,
    RAMPAGE_1                     =   69,

    STURMWIND                     =   82,
    ARMOR_BREAK                   =   83,
    WEAPON_BREAK                  =   85,
    RAGING_RUSH                   =   86,

    SLICE                         =   96,
    DARK_HARVEST                  =   97,
    SHADOW_OF_DEATH               =   98,
    NIGHTMARE_SCYTHE              =   99,
    SPINNING_SCYTHE_1             =  100,
    VORPAL_SCYTHE                 =  101,
    GUILLOTINE_1                  =  102,

    SPIRAL_HELL                   =  104,

    DOUBLE_THRUST                 =  112,
    THUNDER_THRUST                =  113,
    RAIDEN_THRUST_1               =  114,
    LEG_SWEEP                     =  115,
    PENTA_THRUST                  =  116,
    VORPAL_THRUST                 =  117,
    SKEWER                        =  118,
    WHEELING_THRUST               =  119,
    IMPULSE_DRIVE                 =  120,

    BLADE_RIN                     =  128,
    BLADE_RETSU                   =  129,
    BLADE_TEKI                    =  130,
    BLADE_TO                      =  131,
    BLADE_CHI                     =  132,
    BLADE_EI                      =  133,
    BLADE_JIN                     =  134,

    TACHI_ENPI                    =  144,
    TACHI_HOBAKU                  =  145,
    TACHI_GOTEN_1                 =  146,
    TACHI_KAGERO                  =  147,
    TACHI_JINPU                   =  148,
    TACHI_KOKI                    =  149,
    TACHI_YUKIKAZE_1              =  150,

    SHINING_STRIKE_1              =  160,
    SERAPH_STRIKE_1               =  161,
    BRAINSHAKER_1                 =  162,
    STARLIGHT                     =  163,
    MOONLIGHT                     =  164,
    SKULLBREAKER_1                =  165,
    TRUE_STRIKE_1                 =  166,

    RANDGRITH_1                   =  170,

    HEAVY_SWING                   =  176,
    ROCK_CRUSHER                  =  177,
    EARTH_CRUSHER                 =  178,
    STARBURST                     =  179,
    SUNBURST                      =  180,
    SHELL_CRUSHER                 =  181,
    FULL_SWING                    =  182,

    FLAMING_ARROW                 =  192,
    PIERCING_ARROW                =  193,
    DULLING_ARROW                 =  194,
    SIDEWINDER_1                  =  196,

    HOT_SHOT_1                    =  208,
    SPLIT_SHOT_1                  =  209,
    SNIPER_SHOT_1                 =  210,

    SLUG_SHOT_1                   =  212,

    DETONATOR_1                   =  215,

    NETHERSPIKES_1                =  241,
    CARNAL_NIGHTMARE_1            =  242,
    AEGIS_SCHISM_1                =  243,
    DANCING_CHAINS_1              =  244,
    BARBED_CRESCENT_1             =  245,

    FOXFIRE                       =  247,

    VULCAN_SHOT                   =  254,

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

    -- HUNDRED_FISTS                 =  303,

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

    THOUSAND_NEEDLES_1            =  322,
    WILD_CARROT_1                 =  323,

    DRILL_BRANCH                  =  328,
    PINECONE_BOMB                 =  329,

    LEAFSTORM                     =  331,
    ENTANGLE                      =  332,

    VULCANIAN_IMPACT_1            =  342, -- COP Bombs

    VELOCIOUS_BLADE               =  347, -- Mammet-800

    DEATH_SCISSORS                =  353,
    WILD_RAGE                     =  354,
    EARTH_POUNDER                 =  355,

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

    FOUL_BREATH_1                 =  376,
    FROST_BREATH_1                =  377,
    THUNDERBOLT_RAPTOR            =  378,

    SCYTHE_TAIL_1                 =  380,

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
    -- EES_?                         =  413,

    SCISSION_THRUST               =  419, -- Mammet-800

    SONIC_BLADE                   =  422, -- Mammet-800

    SANDSPIN                      =  426,

    GLOEOSUCCUS                   =  436,
    DEATH_RAY                     =  437,
    HEX_EYE                       =  438,
    PETRO_GAZE                    =  439,
    CATHARSIS                     =  440,
    MICROQUAKE                    =  441, -- Mammet-800

    BUBBLE_SHOWER_1               =  442,
    BUBBLE_CURTAIN_1              =  443,
    BIG_SCISSORS_1                =  444,
    SCISSOR_GUARD_1               =  445,

    PERCUSSIVE_FOIN               =  447, -- Mammet-800
    METALLIC_BODY_1               =  448,

    GRAVITY_WHEEL                 =  457, -- Mammet-800

    CROSS_ATTACK_1                =  460,

    MAELSTROM_1                   =  462,

    PSYCHOMANCY                   =  464, -- Mammet-800

    MIND_WALL                     =  471, -- Mammet-800

    GRAVE_REEL                    =  472,

    PETRIFACTIVE_BREATH           =  480,

    CHARGED_WHISKER               =  483,

    WHIP_TONGUE                   =  486,
    TRANSMOGRIFICATION            =  487, -- Mammet-800

    STINKING_GAS                  =  489,

    ABYSS_BLAST                   =  492,

    SNORT_1                       =  495,
    RABID_DANCE                   =  496,
    LOWING                        =  497,

    TRICLIP_1                     =  498,
    BACK_SWISH_1                  =  499,
    MOW_1                         =  500,
    FRIGHTFUL_ROAR_1              =  501,
    MORTAL_RAY_1                  =  502,
    UNBLESSED_ARMOR               =  503,
    GAS_SHELL_1                   =  504,
    VENOM_SHELL_1                 =  505,
    PALSYNYXIS_1                  =  506,
    PAINFUL_WHIP_1                =  507,
    SUCTORIAL_TENTACLE_1          =  508,

    SELF_DESTRUCT_BOMB            =  509,
    BERSERK_BOMB                  =  510,
    SELF_DESTRUCT_BOMB_321        =  511,
    HEAT_WAVE_1                   =  512, -- COP Bombs

    SMITE_OF_RAGE                 =  513,
    WHIRL_OF_RAGE                 =  514,

    BERSERK_SNOLL                 =  526, -- Snoll
    FREEZE_RUSH_1                 =  527, -- Snoll
    COLD_WAVE_1                   =  528, -- Snoll
    HYPOTHERMAL_COMBUSTION_1      =  529, -- Snoll

    DANSE_MACABRE                 =  533,
    KARTSTRAHL                    =  534,
    BLITZSTRAHL                   =  535,
    PANZERFAUST                   =  536,
    BERSERK_DOLL                  =  537,
    PANZERSCHRECK                 =  538,
    TYPHOON                       =  539,

    TREMOROUS_TREAD               =  540, -- Mammet-800
    GRAVITY_FIELD                 =  541,
    EMPTY_SEED                    =  542,

    CAMISADO_1                    =  544,
    SOMNOLENCE_1                  =  545,
    NOCTOSHIELD_1                 =  546,
    ULTIMATE_TERROR_1             =  547,

    DREAM_SHROUD_1                =  556,

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
    CACODEMONIA_1                 =  582,

    BLANK_GAZE                    =  586,

    BOMB_TOSS_1                   =  591,

    BERSERK_BOMB_BIG              =  593, -- Big Bomb / Friars Lantern
    VULCANIAN_IMPACT_2            =  594, -- Big Bomb / Friars Lantern
    HEAT_WAVE_2                   =  595, -- Big Bomb / Friars Lantern
    HELLSTORM                     =  596, -- Big Bomb / Friars Lantern
    SELF_DESTRUCT_BOMB_BIG        =  597, -- Big Bomb / Friars Lantern

    ARCTIC_IMPACT                 =  599, -- Snoll Tzar
    COLD_WAVE_2                   =  600, -- Snoll Tzar
    HIEMAL_STORM                  =  601, -- Snoll Tzar
    HYPOTHERMAL_COMBUSTION_2      =  602, -- Snoll Tzar
    COUNTERSTANCE_1               =  603, -- Geush Urvan

    SHOULDER_TACKLE_2             =  606,
    SLAM_DUNK_1                   =  607,

    NETHER_BLAST_1                =  610,

    RUINOUS_OMEN_1                =  616,

    SWEEP                         =  620,

    HELLDIVE_1                    =  622,
    WING_CUTTER_1                 =  623,

    VULTURE_3                     =  626,

    WILD_HORN                     =  628,
    THUNDERBOLT_BEHEMOTH          =  629,
    KICK_OUT                      =  630,
    SHOCK_WAVE_BEHEMOTH           =  631,
    FLAME_ARMOR                   =  632,
    HOWL_BEHEMOTH                 =  633,
    FINAL_METEOR                  =  634, -- Final Meteor Chlevnik

    RECOIL_DIVE_1                 =  641,

    VOIDSONG_1                    =  649,
    THORNSONG_1                   =  650,
    LODESONG_1                    =  651,

    CHAOTIC_EYE_1                 =  653,

    CURSED_SPHERE_1               =  659,
    VENOM_1                       =  660,
    SNOW_CLOUD_1                  =  661,

    GRAND_SLAM_1                  =  665,

    POWER_ATTACK_ARMED_1          =  667,
    KICK_BACK                     =  668,
    IMPLOSION                     =  669,

    UMBRA_SMASH                   =  671,
    GIGA_SLASH                    =  672,
    DARK_NOVA                     =  673,

    ICE_BREAK_1                   =  676,
    THUNDER_BREAK_1               =  677,
    CRYSTAL_RAIN_1                =  678,
    CRYSTAL_WEAPON_FIRE_1         =  679,
    CRYSTAL_WEAPON_STONE_1        =  680,
    CRYSTAL_WEAPON_WATER_1        =  681,
    CRYSTAL_WEAPON_WIND_1         =  682,

    MIGHTY_STRIKES_1              =  688,
    BENEDICTION_1                 =  689,
    HUNDRED_FISTS_1               =  690,
    MANAFONT_1                    =  691,
    CHAINSPELL_1                  =  692,
    PERFECT_DODGE_1               =  693,
    INVINCIBLE_1                  =  694,
    BLOOD_WEAPON_1                =  695,
    SOUL_VOICE_1                  =  696,

    CHARM                         =  710,
    -- EES_?                         =  711,
    -- EES_?                         =  712,

    VENOM_BREATH_1                =  717,
    JUMP_1                        =  718,
    CRITICAL_BITE                 =  719,
    VENOM_STING_1                 =  720,
    STASIS                        =  721,
    VENOM_STORM_1                 =  722,
    EARTHBREAKER_1                =  723,
    EVASION                       =  724,

    DEATH_TRAP                    =  729, -- Lockpicked coffer mimics only
    MEIKYO_SHISUI_1               =  730, -- Tenzen, etc...
    MIJIN_GAKURE_1                =  731, -- Season's Greetings KSNM 30 (Ulagohvsdi Tlugvi)
    CALL_WYVERN_1                 =  732,

    ASTRAL_FLOW_1                 =  734,
    EES_GOBLIN                    =  735,
    EES_ANTICA                    =  736,
    EES_ORC                       =  737,
    EES_SHADE                     =  738,
    EES_GIGAS                     =  739,
    FAMILIAR_1                    =  740, -- "Tango with a Tracker" Shikaree X

    QUADRATIC_CONTINUUM_2         =  742,

    SPIRIT_ABSORPTION_GORGER_2    =  745,

    VANITY_DRIVE_2                =  748,

    STYGIAN_FLATUS_1              =  750,

    PROMYVION_BARRIER_2           =  753,

    FISSION                       =  755,

    GREAT_WHIRLWIND_1             =  803,
    TORTOISE_SONG_1               =  804,
    HEAD_BUTT_TURTLE_1            =  805,
    TORTOISE_STOMP_1              =  806,
    HARDEN_SHELL_1                =  807,
    EARTH_BREATH_1                =  808,
    AQUA_BREATH_1                 =  809,

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
    FIRE_BLADE_1                  =  823,
    FROST_BLADE_1                 =  824,
    WIND_BLADE_1                  =  825,
    EARTH_BLADE_1                 =  826,
    LIGHTNING_BLADE_1             =  827,
    WATER_BLADE_1                 =  828,
    GREAT_WHEEL_1                 =  829,
    LIGHT_BLADE_1                 =  830,
    MOONLIT_CHARGE                =  831,
    CRESCENT_FANG                 =  832,
    LUNAR_CRY                     =  833,
    ECLIPTIC_GROWL                =  834,
    LUNAR_ROAR                    =  835,
    ECLIPSE_BITE                  =  836,
    ECLIPTIC_HOWL                 =  837,
    HOWLING_MOON_1                =  838, -- Unknown usage.
    HOWLING_MOON_2                =  839, -- Confirmed usage: "The Moonlit Path" bcnm (Fenrir).
    PUNCH                         =  840,
    FIRE_II                       =  841,
    BURNING_STRIKE                =  842,
    DOUBLE_PUNCH                  =  843,
    CRIMSON_HOWL                  =  844,
    FIRE_IV                       =  845,

    INFERNO_1                     =  848, -- Confirmed usage: "Trial by Fire" bcnm. Regular avatar-type mobs (Ifrit).
    ROCK_THROW                    =  849,
    STONE_II                      =  850,
    ROCK_BUSTER                   =  851,
    MEGALITH_THROW                =  852,
    EARTHEN_WARD                  =  853,
    STONE_IV                      =  854,

    EARTHEN_FURY_1                =  857, -- Confirmed usage: "Trial by Earth" bcnm. Regular avatar-type mobs (Titan).
    BARRACUDA_DIVE                =  858,
    WATER_II                      =  859,
    TAIL_WHIP                     =  860,
    SPRING_WATER                  =  861,
    SLOWGA                        =  862,
    WATER_IV                      =  863,

    TIDAL_WAVE_1                  =  866, -- Confirmed usage: "Trial by Water" bcnm. Regular avatar-type mobs (Leviathan).
    CLAW                          =  867,
    AERO_II                       =  868,
    WHISPERING_WIND               =  869,
    HASTEGA                       =  870,
    AERIAL_ARMOR                  =  871,
    AERO_IV                       =  872,

    AERIAL_BLAST_1                =  875, -- Confirmed usage: "Trial by Wind" bcnm. Regular avatar-type mobs (Garuda).
    AXE_KICK                      =  876,
    BLIZZARD_II                   =  877,
    FROST_ARMOR                   =  878,
    SLEEPGA                       =  879,
    DOUBLE_SLAP                   =  880,
    BLIZZARD_IV                   =  881,

    DIAMOND_DUST_1                =  884, -- Confirmed usage: "Trial by Ice" bcnm. Regular avatar-type mobs (Shiva).
    SHOCK_STRIKE                  =  885,
    THUNDER_II                    =  886,
    ROLLING_THUNDER               =  887,
    THUNDERSPARK                  =  888,
    LIGHTNING_ARMOR               =  889,
    THUNDER_IV                    =  890,

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
    HEALING_RUBY                  =  906,
    POISON_NAILS                  =  907,
    SHINING_RUBY                  =  908,
    GLITTERING_RUBY               =  909,
    METEORITE                     =  910,

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
    CROSS_REAVER_1                =  931, -- Ark Angel HM

    DOMINION_SLASH_1              =  933, -- Ark Angel EV
    SHIELD_STRIKE                 =  934, -- Ark Angel EV

    WARP_OUT_AATT                 =  936, -- Ark Angel TT Warp Out

    TACHI_YUKIKAZE                =  946, -- Ark Angel GK
    TACHI_GEKKO                   =  947, -- Ark Angel GK
    TACHI_KASHA                   =  948, -- Ark Angel GK

    FLAME_BLAST_ATTACK            =  950,
    HURRICANE_WING_1              =  951,
    SPIKE_FLAIL_1                 =  952,
    DRAGON_BREATH_1               =  953,
    TOUCHDOWN_1                   =  954,
    FLAME_BLAST_1                 =  955,
    HURRICANE_WING_FLYING         =  956,
    ABSOLUTE_TERROR_1             =  957,
    HORRID_ROAR_1                 =  958,

    WARP_IN_AATT                  =  962, -- Ark Angel TT Warp In

    TRION_RED_LOTUS_BLADE         =  968, -- Trion Red Lotus Blade
    TRION_FLAT_BLADE              =  969, -- Trion Flat Blade
    TRION_SAVAGE_BLADE            =  970, -- Trion Savage Blade

    VOLKER_RED_LOTUS_BLADE        =  973, -- Volker Red Lotus Blade
    VOLKER_SPIRITS_WITHIN         =  974, -- Volker Spirits Within
    VOLKER_VORPAL_BLADE           =  975, -- Volker Vorpal Blade

    WARP_OUT_AJIDO                =  977, -- Windurst 9-2 Ajido teleport
    WARP_IN_AJIDO                 =  978, -- Windurst 9-2 Ajido teleport

    STELLAR_BURST_1               =  986,
    VORTEX_1                      =  987,

    PHASE_SHIFT_1_EXOPLATES       =  993,

    PHASE_SHIFT_2_EXOPLATES       =  997,

    PHASE_SHIFT_3_EXOPLATES       = 1001,
    ZEID_SUMMON_SHADOWS_1         = 1002, -- TODO: Investigate why was this in sql, where it came from and why wasnt it actually used in an scripted way.

    OMEGA_JAVELIN_1               = 1006,
    ZEID_SUMMON_SHADOWS_2         = 1007, -- Captured. Bastok mission 9-2 BCNM, phase 2. No actual name in log.
    MIGHTY_STRIKES_MAAT           = 1008,
    HUNDRED_FISTS_MAAT            = 1009,
    BENEDICTION_MAAT              = 1010,
    MANAFONT_MAAT                 = 1011,
    CHAINSPELL_MAAT               = 1012,
    PERFECT_DODGE_MAAT            = 1013,
    INVINCIBLE_MAAT               = 1014,
    BLOOD_WEAPON_MAAT             = 1015,
    FAMILIAR_MAAT                 = 1016,
    CALL_BEAST                    = 1017, -- "Tango with a Tracker" Shikaree X
    SOUL_VOICE_MAAT               = 1018,
    EES_MAAT                      = 1019,
    MEIKYO_SHISUI_MAAT            = 1020,
    MIJIN_GAKURE_MAAT             = 1021,
    CALL_WYVERN_MAAT              = 1022,
    ASTRAL_FLOW_MAAT              = 1023,

    DRAGON_BREATH_2               = 1041,

    HOWL                          = 1062,

    -- EES_?                         = 1065,

    FRYPAN_1                      = 1081,
    SMOKEBOMB_1                   = 1082,
    SMOKEBOMB_2                   = 1083,
    CRISPY_CANDLE_1               = 1084,
    CRISPY_CANDLE_2               = 1085,
    PARALYSIS_SHOWER_1            = 1086,
    PARALYSIS_SHOWER_2            = 1087,
    GOBLIN_RUSH_2                 = 1088,

    -- EES_?                         = 1091,

    GOBLIN_DICE_HEAL              = 1099,

    GOBLIN_DICE_RESET             = 1109,

    EES_YAGUDO                    = 1121,
    EES_QUADAV                    = 1122,

    EES_KINDRED                   = 1151,

    -- EES_?                         = 1153,
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

    INFERNO_BLAST_ATTACK          = 1278,
    TEBBAD_WING_1                 = 1279,
    SPIKE_FLAIL_3                 = 1280,
    FIERY_BREATH_1                = 1281,
    TOUCHDOWN_3                   = 1282,
    INFERNO_BLAST                 = 1283,
    TEBBAD_WING_2                 = 1284,
    ABSOLUTE_TERROR_3             = 1285,
    HORRID_ROAR_3                 = 1286,

    SLEET_BLAST_ATTACK            = 1288,
    GREGALE_WING_1                = 1289,
    SPIKE_FLAIL_4                 = 1290,
    GLACIAL_BREATH_1              = 1291,
    TOUCHDOWN_4                   = 1292,
    SLEET_BLAST                   = 1293,
    GREGALE_WING_2                = 1294,
    ABSOLUTE_TERROR_4             = 1295,
    HORRID_ROAR_4                 = 1296,

    CYCLONE_WING_1                = 1309,
    SPIKE_FLAIL_6                 = 1310,
    SABLE_BREATH_1                = 1311,

    ABSOLUTE_TERROR_6             = 1315,
    HORRID_ROAR_6                 = 1316,

    GERJIS_GRIP                   = 1322,

    -- EES_?                         = 1327,

    HOOF_VOLLEY                   = 1330,
    COUNTERSTANCE_3               = 1331, -- The Waughroon Kid
    EXTREMELY_BAD_BREATH_1        = 1332,
    CONTAGION_TRANSFER            = 1333,
    CONTAMINATION                 = 1334,
    TOXIC_PICK                    = 1335,
    FRENZIED_RAGE_1               = 1336,
    CHARM_2                       = 1337,
    INFERNAL_PESTILENCE           = 1338,

    CROSSTHRASH_1                 = 1340,
    KNIFE_EDGE_CIRCLE             = 1341,
    TRAIN_FALL                    = 1342,
    MOBLIN_EMOTE_1                = 1343,
    MOBLIN_EMOTE_2                = 1344,
    MOBLIN_EMOTE_3                = 1345,
    MOBLIN_EMOTE_4                = 1346,

    MANTLE_PIERCE                 = 1349,

    AERIAL_COLLISION              = 1353,

    SPINE_LASH                    = 1355,

    TIDAL_DIVE                    = 1357,
    PLASMA_CHARGE                 = 1358,
    CHTHONIAN_RAY                 = 1359,
    APOCALYPTIC_RAY               = 1360,

    WILD_GINSENG                  = 1362,
    HUNGRY_CRUNCH                 = 1363,

    SINUATE_RUSH                  = 1367,

    WING_THRUST                   = 1378,
    AURORAL_WIND                  = 1379,
    IMPACT_STREAM                 = 1380,
    DEPURATION                    = 1381,
    CRYSTALINE_COCOON             = 1382,

    MEDUSA_JAVELIN                = 1386,

    EES_AERN                      = 1389,
    AMATSU_TORIMAI                = 1390,
    AMATSU_KAZAKIRI               = 1391,
    AMATSU_YUKIARASHI             = 1392,
    AMATSU_TSUKIOBORO             = 1393,
    AMATSU_HANAIKUSA              = 1394,
    AMATSU_TSUKIKAGE              = 1395,
    COSMIC_ELUCIDATION            = 1396,
    OISOYA                        = 1397,
    RANGED_ATTACK_TENZEN_1        = 1398, -- Tenzen Bow High
    RICEBALL_TENZEN               = 1399,
    RANGED_ATTACK_TENZEN_2        = 1400, -- Tenzen Bow Low
    SOUL_ACCRETION                = 1401,

    OCHER_BLAST_ATTACK_2          = 1405,
    TYPHOON_WING_2                = 1406,
    SPIKE_FLAIL_7                 = 1407,
    GEOTIC_BREATH_2               = 1408,
    TOUCHDOWN_7                   = 1409,
    OCHER_BLAST_2                 = 1410,
    BAI_WING_2                    = 1411,
    ABSOLUTE_TERROR_7             = 1412,
    HORRID_ROAR_7                 = 1413,

    MARIONETTE_DICE_2             = 1415,
    MARIONETTE_DICE_3             = 1416,
    MARIONETTE_DICE_4             = 1417,
    MARIONETTE_DICE_5             = 1418,
    MARIONETTE_DICE_6             = 1419,
    MARIONETTE_DICE_7             = 1420,
    MARIONETTE_DICE_8             = 1421,
    MARIONETTE_DICE_9             = 1422,
    MARIONETTE_DICE_10            = 1423,
    MARIONETTE_DICE_11            = 1424,
    MARIONETTE_DICE_12            = 1425,

    MARIONETTE_DICE_14            = 1427,
    WARCRY                        = 1428,
    COUNTERSTANCE_4               = 1429,
    STEAL                         = 1430,
    SHIELD_BASH_1                 = 1431,
    WEAPON_BASH                   = 1432,

    SIC                           = 1433,
    BARRAGE                       = 1434,

    MEDITATE                      = 1436,
    BLOOD_PACT                    = 1438,

    ACTINIC_BURST                 = 1441,

    HEXIDISCS                     = 1443,
    VORPAL_BLADE_GHRAH            = 1444,
    DAMNATION_DIVE_GHRAH          = 1445,
    SICKLE_SLASH                  = 1446,

    MARIONETTE_DICE_15            = 1457,

    REACTOR_COOL                  = 1463,
    OPTIC_INDURATION_CHARGE       = 1464,
    OPTIC_INDURATION              = 1465,
    STATIC_FILAMENT               = 1466,
    DECAYED_FILAMENT              = 1467,
    REACTOR_OVERHEAT              = 1468,
    REACTOR_OVERLOAD              = 1469,
    SELF_DESTRUCT_CLUSTER_RAZON   = 1470,

    HUNDRED_FISTS_PRISHE          = 1485,
    BENEDICTION_PRISHE            = 1486,
    ITEM_1_PRISHE                 = 1487,
    ITEM_2_PRISHE                 = 1488,
    NULLIFYING_DROPKICK_1         = 1489,
    AURORAL_UPPERCUT_1            = 1490,
    CHAINS_OF_APATHY              = 1491,
    CHAINS_OF_ARROGANCE           = 1492,
    CHAINS_OF_COWARDICE           = 1493,
    CHAINS_OF_RAGE                = 1494,
    CHAINS_OF_ENVY                = 1495,
    MALEVOLENT_BLESSING_1         = 1496,
    PESTILENT_PENANCE_1           = 1497,
    EMPTY_SALVATION_1             = 1498,
    INFERNAL_DELIVERANCE_1        = 1499,
    MALEVOLENT_BLESSING_2         = 1500,
    PESTILENT_PENANCE_2           = 1501,
    EMPTY_SALVATION_2             = 1502,
    INFERNAL_DELIVERANCE_2        = 1503,
    WHEEL_OF_IMPREGNABILITY       = 1504,
    BASTION_OF_TWILIGHT           = 1505,
    WINDS_OF_OBLIVION             = 1506,
    SEAL_OF_QUIESCENCE            = 1507,
    LUMINOUS_LANCE_1              = 1508,
    REJUVENATION_1                = 1509,
    REVELATION_1                  = 1510,

    HOWLING_MOON_3                = 1520, -- Unknown usage.
    ARMOR_BUSTER                  = 1521,
    ENERGY_SCREEN                 = 1522,
    MANA_SCREEN                   = 1523,
    DISSIPATION                   = 1524,

    CITADEL_BUSTER                = 1540,

    TRAMPLE_BAHAMUT               = 1542,
    TEMPEST_WING                  = 1543,
    TOUCHDOWN_BAHAMUT             = 1544,
    SWEEPING_FLAIL                = 1545,
    PRODIGIOUS_SPIKE              = 1546,
    IMPULSION                     = 1547,
    ABSOLUTE_TERROR_BAHAMUT       = 1548,
    HORRIBLE_ROAR_BAHAMUT         = 1549,
    CALL_OF_THE_WYRMKING          = 1550,
    MEGAFLARE                     = 1551,
    GIGAFLARE                     = 1552,
    TERAFLARE                     = 1553,

    CAMISADO_2                    = 1554,

    -- EES_?                         = 1557,

    FOOT_KICK_2                   = 1567,
    DUST_CLOUD_2                  = 1568,
    WHIRL_CLAWS_2                 = 1569,

    MIASMIC_BREATH_1              = 1604, -- Cirrate Christelle - Mobskill Version
    MIASMIC_BREATH_2              = 1605, -- Cirrate Christelle - Skill Attack version

    PUTRID_BREATH_1               = 1608, -- Cirrate Christelle - Mobskill Version
    PUTRID_BREATH_2               = 1609, -- Cirrate Christelle - Skill Attack version

    FROGKICK_2                    = 1621,

    SHEEP_BLEAT_2                 = 1633,
    SHEEP_SONG_2                  = 1634,
    SHEEP_CHARGE_3                = 1635,

    -- EES_?                         = 1641,

    ROAR_2                        = 1677,
    RAZOR_FANG_2                  = 1678,
    CLAW_CYCLONE_2                = 1679,

    HYPNIC_LAMP                   = 1695, -- Unique entry.

    PROBOSCIS_SHOWER              = 1708,

    FORCEFUL_BLOW                 = 1731, -- Used with Mamool's weapons break.

    FIRESPIT                      = 1733,

    LAVA_SPIT                     = 1785,

    GATES_OF_HADES                = 1790,

    VAMPIRIC_ROOT                 = 1793,

    BOILING_POINT                 = 1822,
    XENOGLOSSIA                   = 1823,
    AMORPHIC_SPIKES               = 1824,
    AMORPHIC_SCYTHE               = 1825,

    PYRIC_BLAST                   = 1828,
    PYRIC_BULWARK                 = 1829,
    POLAR_BLAST                   = 1830,
    POLAR_BULWARK                 = 1831,
    BAROFIELD                     = 1832,

    NERVE_GAS                     = 1836,

    SANDBLAST_2                   = 1841,
    SANDPIT_2                     = 1842,
    VENOM_SPRAY_2                 = 1843,
    PIT_AMBUSH_2                  = 1844,
    MANDIBULAR_BITE_2             = 1845,

    -- SPIRIT_SURGE                  = 1893,

    FIRESPIT_BLUE_MAMOOLJA        = 1923, -- Ignores shadows

    EES_LAMIA                     = 1931,
    EES_MERROW                    = 1932,
    AZURE_LORE                    = 1933,
    WILD_CARD                     = 1934,
    OVERDRIVE                     = 1935,

    WARP_OUT_GESSHO               = 1938,
    WARP_IN_GESSHO                = 1939,

    CHIMERA_RIPPER                = 1940,
    STRING_CLIPPER                = 1941,
    ARCUBALLISTA                  = 1942,
    SLAPSTICK                     = 1943,
    SHIELD_BASH_AUTOMATON         = 1944, -- Used by the trust Mnejing but may also be used by mobs.
    PROVOKE_AUTOMATON             = 1945, -- Used by the trust Mnejing but may also be used by mobs.
    FLASHBULB_AUTOMATON           = 1947, -- Used by the trust Mnejing but may also be used by mobs.
    DISRUPTOR_AUTOMATON           = 2747, -- Used by the trust Mnejing but may also be used by mobs.

    RANGED_ATTACK_15              = 1949,

    WATER_BOMB                    = 1959,

    IMMORTAL_SHIELD               = 1965,

    ECLOSION                      = 1970, -- Unique entry.

    DEATHGNASH                    = 1977, -- Unique entry.

    BOREAS_MANTLE                 = 1980, -- Unique entry.

    FIRE_MANEUVER                 = 1992,
    ICE_MANEUVER                  = 1993,
    WIND_MANEUVER                 = 1994,
    EARTH_MANEUVER                = 1995,
    THUNDER_MANEUVER              = 1996,
    WATER_MANEUVER                = 1997,
    HANE_FUBUKI                   = 1998,
    HIDEN_SOKYAKU                 = 1999,
    SHIKO_NO_MITATE               = 2000,
    HAPPOBARAI                    = 2001,
    RINPYOTOSHA                   = 2002,

    REWARD                        = 2005,
    AZURE_LORE_RAUBAHN            = 2006,
    WILD_CARD_QULTADA             = 2007,
    OVERDRIVE_SHAMARHAAN          = 2008,
    FIRE_SHOT                     = 2009,
    ICE_SHOT                      = 2010,
    WIND_SHOT                     = 2011,
    EARTH_SHOT                    = 2012,
    THUNDER_SHOT                  = 2013,
    WATER_SHOT                    = 2014,
    LIGHT_SHOT                    = 2015,
    DARK_SHOT                     = 2016,

    -- HUNDRED_FISTS                 = 2020,

    DAZE                          = 2066,
    KNOCKOUT                      = 2067,

    -- MIJIN_GAKURE                  = 2105,

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
    -- EES_?                         = 2148,

    GRIM_GLOWER                   = 2156,

    PEDAL_PIROUETTE               = 2210,

    HELL_SCISSORS                 = 2221,

    QUEASYSHROOM_2                = 2232,

    -- MIGHTY_STRIKES                = 2242,
    -- HUNDRED_FISTS                 = 2243,
    -- BENEDICTION                   = 2244,
    -- MANAFONT                      = 2245,
    -- CHAINSPELL                    = 2246,
    -- PERFECT_DODGE                 = 2247,
    -- INVINCIBLE                    = 2248,
    BLOOD_WEAPON_IXDRK            = 2249,
    -- FAMILIAR                      = 2250,
    -- SOUL_VOICE                    = 2251,
    EES_TROLL                     = 2252,
    -- MEIKYO_SHISUI                 = 2253,
    -- MIJIN_GAKURE                  = 2254,
    -- SPIRIT_SURGE                  = 2255,
    -- ASTRAL_FLOW                   = 2256,
    -- AZURE_LORE                    = 2257,
    -- WILD_CARD                     = 2258,
    -- OVERDRIVE                     = 2259,
    TRANCE                        = 2260,
    TABULA_RASA                   = 2261,

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

    -- TABULA_RASA                   = 2358,

    -- INVINCIBLE                    = 2379,

    -- MIJIN_GAKURE                  = 2382,

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

    CYTOKINESIS                   = 2514,

    DISSOLVE                      = 2550,

    -- TRANCE                        = 2710,

    BOOMING_BOMBINATION           = 2770,

    -- BENEDICTION                   = 2777,

    -- MIGHTY_STRIKES                = 2939,
    -- INVINCIBLE                    = 2940,
    -- EES_?                         = 2941,
    -- CHAINSPELL                    = 2942,
    -- BENEDICTION                   = 2943,
    -- MANAFONT                      = 2944,

    -- MEIKYO_SHISUI                 = 3175,

    CROSS_REAVER_2                = 3174,

    ARROGANCE_INCARNATE_1         = 3178,

    ROYAL_BASH_TRUST              = 3193, -- Trion Trust
    ROYAL_SAVIOR_TRUST            = 3194, -- Trion Trust

    LIGHT_BLADE_2                 = 3214,

    VICTORY_BEACON_TRUST          = 3237, -- Rughadjeen Trust

    SHIBARAKU_TRUST               = 3257, -- Gessho Trust
    SHIKO_NO_MITATE_TRUST         = 3258, -- Gessho Trust
    RINPYOTOSHA_TRUST             = 3260, -- Gessho Trust

    -- ELEMENTAL_SFORZO              = 3265,

    INFERNO_5                     = 3325, -- Unknown usage.

    AERIAL_BLAST_5                = 3327, -- Unknown usage.

    DIAMOND_DUST_5                = 3329, -- Unknown usage.

    JUDGMENT_BOLT_5               = 3331, -- Unknown usage.

    EARTHEN_FURY_5                = 3333, -- Unknown usage.

    TIDAL_WAVE_5                  = 3335, -- Unknown usage.

    HOWLING_MOON_4                = 3336, -- Unknown usage.

    SHEEP_SONG_3                  = 3433,

    DRAGON_BREATH_3               = 3438, -- Areuhat Trust

    TWIRLING_DERVISH              = 3469, -- Adelheid Trust

    LIGHT_BLADE_3                 = 3471,

    -- ELEMENTAL_SFORZO              = 3479,

    -- AZURE_LORE                    = 3481,
    BOLSTER                       = 3482,

    DAYBREAK_TRUST                = 3652, -- August Trust
    TARTARIC_SIGIL_TRUST          = 3653, -- August Trust
    NULL_FIELD_TRUST              = 3654, -- August Trust
    ALABASTER_BURST_TRUST         = 3655, -- August Trust
    NOBLE_FRENZY_TRUST            = 3656, -- August Trust
    FULMINOUS_FURY_TRUST          = 3657, -- August Trust
    NO_QUARTER_TRUST              = 3658, -- August Trust

    CROSS_REAVER_3                = 3706, -- Ark Angel HM Trust

    ARROGANCE_INCARNATE_2         = 3710, -- Ark Angel EV Trust

    DOMINION_SLASH_2              = 3712, -- Ark Angel EV Trust

    ARROGANCE_INCARNATE_3         = 3728,

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

    MIX_FINAL_ELIXIR              = 4231, -- Monbereaux Trust
}
