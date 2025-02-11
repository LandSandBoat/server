xi = xi or {}

---@enum xi.mobSkill
xi.mobSkill =
{
    FOOT_KICK_1       =  257,
    DUST_CLOUD_1      =  258,
    WHIRL_CLAWS_1     =  259,
    LAMB_CHOP_1       =  260,
    RAGE_1            =  261,
    SHEEP_CHARGE_1    =  262,
    SHEEP_BLEAT_1     =  263,
    SHEEP_SONG_1      =  264,
    RAGE_2            =  265,
    RAM_CHARGE        =  266, -- Unique entry.
    RUMBLE            =  267, -- Unique entry.
    GREAT_BLEAT       =  268, -- Unique entry.
    PETRIBREATH       =  269, -- Unique entry.
    ROAR_1            =  270,
    RAZOR_FANG_1      =  271,
    RANGED_ATTACK_1   =  272,
    CLAW_CYCLONE_1    =  273,
    SHEEP_CHARGE_2    =  274,
    SANDBLAST_1       =  275,
    SANDPIT_1         =  276,
    VENOM_SPRAY_1     =  277,
    PIT_AMBUSH_1      =  278,
    MANDIBULAR_BITE_1 =  279,

    FROGKICK_1        =  308,
    SPORE_1           =  309,
    QUEASYSHROOM_1    =  310,
    NUMBSHROOM_1      =  311,
    SHAKESHROOM_1     =  312,

    SILENCE_GAS_1     =  314,
    DARK_SPORE_1      =  315,

    RANGED_ATTACK_2   =  412,

    DISPELLING_WIND   =  813,
    DEADLY_DRIVE      =  814,
    WIND_WALL         =  815,
    FANG_RUSH         =  816,
    DREAD_SHRIEK      =  817,
    TAIL_CRUSH        =  818,
    BLIZZARD_BREATH   =  819,
    THUNDER_BREATH    =  820,
    RADIANT_BREATH    =  821,
    CHAOS_BREATH      =  822,

    LIGHT_BLADE_1     =  830,

    HOWLING_MOON_1    =  838, -- Unknown usage.
    HOWLING_MOON_2    =  839, -- Confirmed usage: "The Moonlit Path" bcnm (Fenrir).

    INFERNO_1         =  848, -- Confirmed usage: "Trial by Fire" bcnm. Regular avatar-type mobs (Ifrit).

    EARTHEN_FURY_1    =  857, -- Confirmed usage: "Trial by Earth" bcnm. Regular avatar-type mobs (Titan).

    TIDAL_WAVE_1      =  866, -- Confirmed usage: "Trial by Water" bcnm. Regular avatar-type mobs (Leviathan).

    AERIAL_BLAST_1    =  875, -- Confirmed usage: "Trial by Wind" bcnm. Regular avatar-type mobs (Garuda).

    DIAMOND_DUST_1    =  884, -- Confirmed usage: "Trial by Ice" bcnm. Regular avatar-type mobs (Shiva).

    JUDGMENT_BOLT_1   =  893, -- Confirmed usage: "Trial by Lightning" bcnm. Regular avatar-type mobs (Ramuh).

    SEARING_LIGHT_1   =  912, -- Confirmed usage: Regular avatar-type mobs (Carbuncle).
    INFERNO_2         =  913, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ifrit model avatar)
    EARTHEN_FURY_2    =  914, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Titan model avatar)
    TIDAL_WAVE_2      =  915, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Leviathan model avatar)
    AERIAL_BLAST_2    =  916, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Garuda model avatar)
    DIAMOND_DUST_2    =  917, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Shiva model avatar)
    JUDGMENT_BOLT_2   =  918, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin) (Ramuh model avatar)
    SEARING_LIGHT_2   =  919, -- Confirmed usage: Untargetable avatar astral flow. (Ex. Kirin, Crimson-toothed Pawberry) (Carbuncle model avatar)

    RANGED_ATTACK_3   = 1154,

    INFERNO_3         = 1162, -- Confirmed usage: "Trial-Size Trial by Fire" bcnm. (Ifrit)
    EARTHEN_FURY_3    = 1163, -- Confirmed usage: "Trial-Size Trial by Earth" bcnm. (Titan)
    TIDAL_WAVE_3      = 1164, -- Confirmed usage: "Trial-Size Trial by Water" bcnm. (Leviathan)
    AERIAL_BLAST_3    = 1165, -- Confirmed usage: "Trial-Size Trial by Wind" bcnm. (Garuda)
    DIAMOND_DUST_3    = 1166, -- Confirmed usage: "Trial-Size Trial by Ice" bcnm. (Shiva)
    JUDGMENT_BOLT_3   = 1167, -- Confirmed usage: "Trial-Size Trial by Lightning" bcnm. (Ramuh)

    RANGED_ATTACK_4   = 1202,
    RANGED_ATTACK_5   = 1203,
    RANGED_ATTACK_6   = 1204,
    RANGED_ATTACK_7   = 1205,
    RANGED_ATTACK_8   = 1206,

    RANGED_ATTACK_9   = 1209,
    RANGED_ATTACK_10  = 1210,
    RANGED_ATTACK_11  = 1211,
    RANGED_ATTACK_12  = 1212,
    RANGED_ATTACK_13  = 1213,
    RANGED_ATTACK_14  = 1214,

    HOWLING_MOON_3    = 1520, -- Unknown usage.

    FOOT_KICK_2       = 1567,
    DUST_CLOUD_2      = 1568,
    WHIRL_CLAWS_2     = 1569,

    FROGKICK_2        = 1621,

    SHEEP_BLEAT_2     = 1633,
    SHEEP_SONG_2      = 1634,
    SHEEP_CHARGE_3    = 1635,

    ROAR_2            = 1677,
    RAZOR_FANG_2      = 1678,
    CLAW_CYCLONE_2    = 1679,

    HYPNIC_LAMP       = 1695, -- Unique entry.

    XENOGLOSSIA       = 1823, -- Unique entry.

    SANDBLAST_2       = 1841,
    SANDPIT_2         = 1842,
    VENOM_SPRAY_2     = 1843,
    PIT_AMBUSH_2      = 1844,
    MANDIBULAR_BITE_2 = 1845,

    RANGED_ATTACK_15  = 1949,

    ECLOSION          = 1970, -- Unique entry.

    DEATHGNASH        = 1977, -- Unique entry.

    BOREAS_MANTLE     = 1980, -- Unique entry.

    HELL_SCISSORS     = 2221,

    QUEASYSHROOM_2    = 2232,

    ROAR_3            = 2406,

    INFERNO_4         = 2480, -- Unknown usage.
    TIDAL_WAVE_4      = 2481, -- Unknown usage.
    EARTHEN_FURY_4    = 2482, -- Unknown usage.
    DIAMOND_DUST_4    = 2483, -- Unknown usage.
    JUDGMENT_BOLT_4   = 2484, -- Unknown usage.
    AERIAL_BLAST_4    = 2485, -- Unknown usage.

    LIGHT_BLADE_2     = 3214,

    INFERNO_5         = 3325, -- Unknown usage.

    AERIAL_BLAST_5    = 3327, -- Unknown usage.

    DIAMOND_DUST_5    = 3329, -- Unknown usage.

    JUDGMENT_BOLT_5   = 3331, -- Unknown usage.

    EARTHEN_FURY_5    = 3333, -- Unknown usage.

    TIDAL_WAVE_5      = 3335, -- Unknown usage.

    HOWLING_MOON_4    = 3336, -- Unknown usage.

    SHEEP_SONG_3      = 3433,

    LIGHT_BLADE_3     = 3471,

    FOOT_KICK_3       = 3840,
    DUST_CLOUD_3      = 3841,
    WHIRL_CLAWS_3     = 3842,

    ROAR_4            = 3848,
    RAZOR_FANG_3      = 3849,
    CLAW_CYCLONE_3    = 3850,

    LAMB_CHOP_2       = 3857,
    RAGE_3            = 3858,
    SHEEP_CHARGE_4    = 3859,
    SHEEP_SONG_4      = 3860,

    FROGKICK_3        = 3868,
    SPORE_2           = 3869,
    QUEASYSHROOM_3    = 3870,
    NUMBSHROOM_2      = 3871,
    SHAKESHROOM_2     = 3872,
    SILENCE_GAS_2     = 3873,
    DARK_SPORE_2      = 3874,

    SANDBLAST_3       = 3882,
    SANDPIT_3         = 3883,
    VENOM_SPRAY_3     = 3884,
    MANDIBULAR_BITE_3 = 3885,
}
