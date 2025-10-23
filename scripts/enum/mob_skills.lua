xi = xi or {}

---@enum xi.mobSkill
xi.mobSkill =
{
    FOOT_KICK_1              =  257,
    DUST_CLOUD_1             =  258,
    WHIRL_CLAWS_1            =  259,
    LAMB_CHOP_1              =  260,
    RAGE_1                   =  261,
    SHEEP_CHARGE_1           =  262,
    SHEEP_BLEAT_1            =  263,
    SHEEP_SONG_1             =  264,
    RAGE_2                   =  265,
    RAM_CHARGE               =  266, -- Unique entry.
    RUMBLE                   =  267, -- Unique entry.
    GREAT_BLEAT              =  268, -- Unique entry.
    PETRIBREATH              =  269, -- Unique entry.
    ROAR_1                   =  270,
    RAZOR_FANG_1             =  271,
    RANGED_ATTACK_1          =  272,
    CLAW_CYCLONE_1           =  273,
    SHEEP_CHARGE_2           =  274,
    SANDBLAST_1              =  275,
    SANDPIT_1                =  276,
    VENOM_SPRAY_1            =  277,
    PIT_AMBUSH_1             =  278,
    MANDIBULAR_BITE_1        =  279,
    SUBSTITUTE               =  307,
    FROGKICK_1               =  308,
    SPORE_1                  =  309,
    QUEASYSHROOM_1           =  310,
    NUMBSHROOM_1             =  311,
    SHAKESHROOM_1            =  312,

    SILENCE_GAS_1            =  314,
    DARK_SPORE_1             =  315,

    DRILL_BRANCH             =  328,
    PINECONE_BOMB            =  329,

    LEAFSTORM                =  331,
    ENTANGLE                 =  332,

    VELOCIOUS_BLADE          =  347, -- Mammet-800

    HEAVY_BLOW               =  357,
    HEAVY_WHISK              =  358,
    BIONIC_BOOST             =  359,
    FLYING_HIP_PRESS         =  360,
    EARTH_SHOCK              =  361,

    SMITE_OF_FURY            =  396,
    FLURRY_OF_RAGE           =  397,
    WHISPERS_OF_IRE          =  398,

    RANGED_ATTACK_2          =  412,

    SCISSION_THRUST          =  419, -- Mammet-800

    SONIC_BLADE              =  422, -- Mammet-800

    SANDSPIN                 =  426,

    MICROQUAKE               =  441, -- Mammet-800

    PERCUSSIVE_FOIN          =  447, -- Mammet-800

    GRAVITY_WHEEL            =  457, -- Mammet-800

    PSYCHOMANCY              =  464, -- Mammet-800

    MIND_WALL                =  471, -- Mammet-800

    TRANSMOGRIFICATION       =  487, -- Mammet-800

    SELF_DESTRUCT            =  511,
    SMITE_OF_RAGE            =  513,
    WHIRL_OF_RAGE            =  514,

    DANSE_MACABRE            =  533,

    PANZERFAUST              =  536,
    TYPHOON                  =  539,

    TREMOROUS_TREAD          =  540, -- Mammet-800

    BLOW                     =  581,
    BLANK_GAZE              =   586,

    VULTURE_3                =  626,

    FINAL_METEOR             =  634, -- Final Meteor Chlevnik

    CRYSTAL_RAIN             =  678,
    CRYSTAL_WEAPON_FIRE      =  679, -- Zipacna Weapon Start
    CRYSTAL_WEAPON_WATER     =  682, -- Zipacna Weapon End

    MIGHTY_STRIKES_1         =  688,
    BENEDICTION_1            =  689, -- Season's Greetings KSNM 30 (Gilagoge Tlugvi)
    HUNDRED_FISTS_1          =  690, -- Season's Greetings KSNM 30 (Goga Tlugvi)

    BLOOD_WEAPON_1           =  695,
    SOUL_VOICE_1             =  696,

    CHARM                    =  710,

    MEIKYO_SHISUI_1          =  730, -- Tenzen, etc...
    MIJIN_GAKURE_1           =  731, -- Season's Greetings KSNM 30 (Ulagohvsdi Tlugvi)

    CALL_WYVERN              =  732,

    FAMILIAR_1               =  740, -- "Tango with a Tracker" Shikaree X

    GREAT_WHIRLWIND_1        =  803,

    DISPELLING_WIND          =  813,
    DEADLY_DRIVE             =  814,
    WIND_WALL                =  815,
    FANG_RUSH                =  816,
    DREAD_SHRIEK             =  817,
    TAIL_CRUSH               =  818,
    BLIZZARD_BREATH          =  819,
    THUNDER_BREATH           =  820,
    RADIANT_BREATH           =  821,
    CHAOS_BREATH             =  822,

    LIGHT_BLADE_1            =  830,

    HOWLING_MOON_1           =  838, -- Unknown usage.
    HOWLING_MOON_2           =  839, -- Confirmed usage: "The Moonlit Path" bcnm (Fenrir).

    INFERNO_1                =  848, -- Confirmed usage: "Trial by Fire" bcnm. Regular avatar-type mobs (Ifrit).

    EARTHEN_FURY_1           =  857, -- Confirmed usage: "Trial by Earth" bcnm. Regular avatar-type mobs (Titan).

    TIDAL_WAVE_1             =  866, -- Confirmed usage: "Trial by Water" bcnm. Regular avatar-type mobs (Leviathan).

    AERIAL_BLAST_1           =  875, -- Confirmed usage: "Trial by Wind" bcnm. Regular avatar-type mobs (Garuda).

    DIAMOND_DUST_1           =  884, -- Confirmed usage: "Trial by Ice" bcnm. Regular avatar-type mobs (Shiva).

    JUDGMENT_BOLT_1          =  893, -- Confirmed usage: "Trial by Lightning" bcnm. Regular avatar-type mobs (Ramuh).

    PET_FLAME_BREATH         =  900,
    PET_FROST_BREATH         =  901,
    PET_GUST_BREATH          =  902,
    PET_SAND_BREATH          =  903,
    PET_LIGHTNING_BREATH     =  904,
    PET_HYDRO_BREATH         =  905,

    SEARING_LIGHT_1          =  912, -- Confirmed usage: Regular avatar-type mobs (Carbuncle).
    INFERNO_2                =  913, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ifrit model avatar)
    EARTHEN_FURY_2           =  914, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Titan model avatar)
    TIDAL_WAVE_2             =  915, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Leviathan model avatar)
    AERIAL_BLAST_2           =  916, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Garuda model avatar)
    DIAMOND_DUST_2           =  917, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Shiva model avatar)
    JUDGMENT_BOLT_2          =  918, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ramuh model avatar)
    SEARING_LIGHT_2          =  919, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin, Crimson-toothed Pawberry) (Carbuncle model avatar)

    TRION_RED_LOTUS_BLADE    =  968, -- Trion Red Lotus Blade
    TRION_FLAT_BLADE         =  969, -- Trion Flat Blade
    TRION_SAVAGE_BLADE       =  970, -- Trion Savage Blade

    VOLKER_RED_LOTUS_BLADE   =  973, -- Volker Red Lotus Blade
    VOLKER_SPIRITS_WITHIN    =  974, -- Volker Spirits Within
    VOLKER_VORPAL_BLADE      =  975, -- Volker Vorpal Blade

    AJIDO_WARP_OUT           =  977, -- Windurst 9-2 Ajido teleport
    AJIDO_WARP_IN            =  978, -- Windurst 9-2 Ajido teleport

    PHASE_SHIFT_1_EXOPLATES  =  993,

    PHASE_SHIFT_2_EXOPLATES  =  997,

    PHASE_SHIFT_3_EXOPLATES  = 1001,

    ZEID_SUMMON_SHADOWS_1    = 1002, -- TODO: Investigate why was this in sql, where it came from and why wasnt it actually used in an scripted way.

    ZEID_SUMMON_SHADOWS_2    = 1007, -- Captured. Bastok mission 9-2 BCNM, phase 2. No actual name in log.

    CALL_BEAST               = 1017, -- "Tango with a Tracker" Shikaree X

    RANGED_ATTACK_3          = 1154,

    INFERNO_3                = 1162, -- Confirmed usage: "Trial-Size Trial by Fire" bcnm. (Ifrit)
    EARTHEN_FURY_3           = 1163, -- Confirmed usage: "Trial-Size Trial by Earth" bcnm. (Titan)
    TIDAL_WAVE_3             = 1164, -- Confirmed usage: "Trial-Size Trial by Water" bcnm. (Leviathan)
    AERIAL_BLAST_3           = 1165, -- Confirmed usage: "Trial-Size Trial by Wind" bcnm. (Garuda)
    DIAMOND_DUST_3           = 1166, -- Confirmed usage: "Trial-Size Trial by Ice" bcnm. (Shiva)
    JUDGMENT_BOLT_3          = 1167, -- Confirmed usage: "Trial-Size Trial by Lightning" bcnm. (Ramuh)

    RANGED_ATTACK_4          = 1202,
    RANGED_ATTACK_5          = 1203,
    RANGED_ATTACK_6          = 1204,
    RANGED_ATTACK_7          = 1205,
    RANGED_ATTACK_8          = 1206,

    RANGED_ATTACK_9          = 1209,
    RANGED_ATTACK_10         = 1210,
    RANGED_ATTACK_11         = 1211,
    RANGED_ATTACK_12         = 1212,
    RANGED_ATTACK_13         = 1213,
    RANGED_ATTACK_14         = 1214,

    COUNTERSTANCE            = 1331, -- The Waughroon Kid

    MANTLE_PIERCE            = 1349,

    AERIAL_COLLISION         = 1353,
    SPINE_LASH               = 1355,
    TIDAL_DIVE               = 1357,
    PLASMA_CHARGE            = 1358,

    SINUATE_RUSH             = 1367,

    WING_THRUST              = 1378,
    AURORAL_WIND             = 1379,
    IMPACT_STREAM            = 1380,
    DEPURATION               = 1381,
    CRYSTALINE_COCOON        = 1382,
    MEDUSA_JAVELIN           = 1386,

    AMATSU_TORIMAI           = 1390,
    AMATSU_KAZAKIRI          = 1391,

    AMATSU_HANAIKUSA         = 1394,
    AMATSU_TSUKIKAGE         = 1395,
    COSMIC_ELUCIDATION       = 1396,

    RANGED_ATTACK_TENZEN_1   = 1398, -- Tenzen Bow High
    RICEBALL_TENZEN          = 1399,
    RANGED_ATTACK_TENZEN_2   = 1400, -- Tenzen Bow Low

    HOWLING_MOON_3           = 1520, -- Unknown usage.

    FOOT_KICK_2              = 1567,
    DUST_CLOUD_2             = 1568,
    WHIRL_CLAWS_2            = 1569,

    FROGKICK_2               = 1621,

    SHEEP_BLEAT_2            = 1633,
    SHEEP_SONG_2             = 1634,
    SHEEP_CHARGE_3           = 1635,

    ROAR_2                   = 1677,
    RAZOR_FANG_2             = 1678,
    CLAW_CYCLONE_2           = 1679,

    HYPNIC_LAMP              = 1695, -- Unique entry.

    PROBOSCIS_SHOWER         = 1708,

    FORCEFUL_BLOW            = 1731, -- Used with Mamool's weapons break.

    LAVA_SPIT                = 1785,
    GATES_OF_HADES           = 1790,

    VAMPIRIC_ROOT            = 1793,

    XENOGLOSSIA              = 1823, -- Unique entry.

    SANDBLAST_2              = 1841,
    SANDPIT_2                = 1842,
    VENOM_SPRAY_2            = 1843,
    PIT_AMBUSH_2             = 1844,
    MANDIBULAR_BITE_2        = 1845,

    RANGED_ATTACK_15         = 1949,

    WATER_BOMB               = 1959,

    IMMORTAL_SHIELD          = 1965,

    ECLOSION                 = 1970, -- Unique entry.

    DEATHGNASH               = 1977, -- Unique entry.

    BOREAS_MANTLE            = 1980, -- Unique entry.

    NOCTURNAL_SERVITUDE      = 2112,

    HELLSNAP                 = 2113,
    HELLCLAP                 = 2114,
    CACKLE                   = 2115,
    NECROBANE                = 2116,
    NECROPURGE               = 2117,
    BILGESTORM               = 2118,
    THUNDRIS_SHRIEK          = 2119,

    RADIANT_SACRAMENT        = 2141,
    MEGA_HOLY                = 2142,
    PERFECT_DEFENSE          = 2143,
    DIVINE_SPEAR             = 2144,
    GOSPEL_OF_THE_LOST       = 2145,
    VOID_OF_REPENTANCE       = 2146,
    DIVINE_JUDGMENT          = 2147,

    GRIM_GLOWER              = 2156,

    PEDAL_PIROUETTE          = 2210,

    HELL_SCISSORS            = 2221,

    QUEASYSHROOM_2           = 2232,

    DI_HORN_ATTACK           = 2329,
    DI_BITE_ATTACK           = 2330,
    DI_KICK_ATTACK           = 2331,
    DI_TRAMPLE               = 2332,
    DI_GLOW                  = 2333,
    WRATH_OF_ZEUS            = 2334,
    LIGHTNING_SPEAR          = 2335,
    ACHERON_KICK             = 2336,
    DAMSEL_MEMENTO           = 2337,
    RAMPANT_STANCE           = 2338,

    OPPRESSIVE_GLARE         = 2392,

    ROAR_3                   = 2406,

    INFERNO_4                = 2480, -- Unknown usage.
    TIDAL_WAVE_4             = 2481, -- Unknown usage.
    EARTHEN_FURY_4           = 2482, -- Unknown usage.
    DIAMOND_DUST_4           = 2483, -- Unknown usage.
    JUDGMENT_BOLT_4          = 2484, -- Unknown usage.
    AERIAL_BLAST_4           = 2485, -- Unknown usage.

    BOOMING_BOMBINATION      = 2770,

    LIGHT_BLADE_2            = 3214,

    INFERNO_5                = 3325, -- Unknown usage.

    AERIAL_BLAST_5           = 3327, -- Unknown usage.

    DIAMOND_DUST_5           = 3329, -- Unknown usage.

    JUDGMENT_BOLT_5          = 3331, -- Unknown usage.

    EARTHEN_FURY_5           = 3333, -- Unknown usage.

    TIDAL_WAVE_5             = 3335, -- Unknown usage.

    HOWLING_MOON_4           = 3336, -- Unknown usage.

    SHEEP_SONG_3             = 3433,

    LIGHT_BLADE_3            = 3471,

    FOOT_KICK_3              = 3840,
    DUST_CLOUD_3             = 3841,
    WHIRL_CLAWS_3            = 3842,

    ROAR_4                   = 3848,
    RAZOR_FANG_3             = 3849,
    CLAW_CYCLONE_3           = 3850,

    LAMB_CHOP_2              = 3857,
    RAGE_3                   = 3858,
    SHEEP_CHARGE_4           = 3859,
    SHEEP_SONG_4             = 3860,

    FROGKICK_3               = 3868,
    SPORE_2                  = 3869,
    QUEASYSHROOM_3           = 3870,
    NUMBSHROOM_2             = 3871,
    SHAKESHROOM_2            = 3872,
    SILENCE_GAS_2            = 3873,
    DARK_SPORE_2             = 3874,

    SANDBLAST_3              = 3882,
    SANDPIT_3                = 3883,
    VENOM_SPRAY_3            = 3884,
    MANDIBULAR_BITE_3        = 3885,
}
