-----------------------------------
-- Nyzul Isle Global
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/items")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/appraisal")
require("scripts/globals/zone")
require("scripts/settings/main")
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}

xi.nyzul.baseWeapons =
{
    [xi.job.WAR] = xi.items.STURDY_AXE,
    [xi.job.MNK] = xi.items.BURNING_FISTS,
    [xi.job.WHM] = xi.items.WEREBUSTER,
    [xi.job.BLM] = xi.items.MAGES_STAFF,
    [xi.job.RDM] = xi.items.VORPAL_SWORD,
    [xi.job.THF] = xi.items.SWORDBREAKER,
    [xi.job.PLD] = xi.items.BRAVE_BLADE,
    [xi.job.DRK] = xi.items.DEATH_SICKLE,
    [xi.job.BST] = xi.items.DOUBLE_AXE,
    [xi.job.BRD] = xi.items.DANCING_DAGGER,
    [xi.job.RNG] = xi.items.KILLER_BOW,
    [xi.job.SAM] = xi.items.WINDSLICER,
    [xi.job.NIN] = xi.items.SASUKE_KATANA,
    [xi.job.DRG] = xi.items.RADIANT_LANCE,
    [xi.job.SMN] = xi.items.SCEPTER_STAFF,
    [xi.job.BLU] = xi.items.WIGHTSLAYER,
    [xi.job.COR] = xi.items.QUICKSILVER,
    [xi.job.PUP] = xi.items.INFERNO_CLAWS,
    [xi.job.DNC] = xi.items.MAIN_GAUCHE,
    [xi.job.SCH] = xi.items.ELDER_STAFF,
}

xi.nyzul.objective =
{
    ELIMINATE_ENEMY_LEADER      = 0,
    ELIMINATE_SPECIFIED_ENEMIES = 1,
    ACTIVATE_ALL_LAMPS          = 2,
    ELIMINATE_SPECIFIED_ENEMY   = 3,
    ELIMINATE_ALL_ENEMIES       = 4,
    FREE_FLOOR                  = 5,
}

xi.nyzul.lampsObjective =
{
    REGISTER     = 1,
    ACTIVATE_ALL = 2,
    ORDER        = 3,
}

xi.nyzul.gearObjective =
{
    AVOID_AGRO     = 1,
    DO_NOT_DESTROY = 2,
}

xi.nyzul.penalty =
{
    TIME   = 1,
    TOKENS = 2,
    PATHOS = 3,
}

xi.nyzul.pathos =
{
    -- Found info: if gaining pathos from failed gear objectives will pick 3 different ways,
    -- 1. token reward reduction, 2. time reduction, 3. random any other effect. Once picked which of
    -- the 3 chioces for the floor, it will always be that for each occurance.

    -- Neg Effects
    [1]  = { effect = xi.effect.IMPAIRMENT,    power = 0x01,  ID = 7372 }, -- Job Abilities
    [2]  = { effect = xi.effect.IMPAIRMENT,    power = 0x02,  ID = 7374 }, -- Weapon Skills
    [3]  = { effect = xi.effect.OMERTA,        power = 0x01,  ID = 7380 }, -- Songs
    [4]  = { effect = xi.effect.OMERTA,        power = 0x02,  ID = 7378 }, -- Black Magic
    [5]  = { effect = xi.effect.OMERTA,        power = 0x04,  ID = 7386 }, -- Blue Magic
    [6]  = { effect = xi.effect.OMERTA,        power = 0x08,  ID = 7382 }, -- Ninjutsu
    [7]  = { effect = xi.effect.OMERTA,        power = 0x10,  ID = 7384 }, -- Summoning Magic
    [8]  = { effect = xi.effect.OMERTA,        power = 0x20,  ID = 7376 }, -- White Magic
    [9]  = { effect = xi.effect.SLOW,          power = 2000,  ID = 7388 }, -- Attack speed reduced, needs retail data
    [10] = { effect = xi.effect.FAST_CAST,     power = -30,   ID = 7390 }, -- Casting speed reduced
    [11] = { effect = xi.effect.DEBILITATION,  power = 0x001, ID = 7392 }, -- STR
    [12] = { effect = xi.effect.DEBILITATION,  power = 0x002, ID = 7394 }, -- DEX
    [13] = { effect = xi.effect.DEBILITATION,  power = 0x004, ID = 7396 }, -- VIT
    [14] = { effect = xi.effect.DEBILITATION,  power = 0x008, ID = 7398 }, -- AGI
    [15] = { effect = xi.effect.DEBILITATION,  power = 0x010, ID = 7400 }, -- INT
    [16] = { effect = xi.effect.DEBILITATION,  power = 0x020, ID = 7402 }, -- MND
    [17] = { effect = xi.effect.DEBILITATION,  power = 0x040, ID = 7404 }, -- CHR
    -- Positive Effects
    [18] = { effect = xi.effect.REGAIN,        power = 5,     ID = 7406 }, -- confirmed 50
    [19] = { effect = xi.effect.REGEN,         power = 15,    ID = 7408 }, -- confirmed 15
    [20] = { effect = xi.effect.REFRESH,       power = 1,     ID = 7410 },
    [21] = { effect = xi.effect.FLURRY,        power = 15,    ID = 7412 },
    [22] = { effect = xi.effect.CONCENTRATION, power = 30,    ID = 7414 },
    [23] = { effect = xi.effect.STR_BOOST_II,  power = 30,    ID = 7416 }, -- confirmed 30
    [24] = { effect = xi.effect.DEX_BOOST_II,  power = 30,    ID = 7418 },
    [25] = { effect = xi.effect.VIT_BOOST_II,  power = 30,    ID = 7420 },
    [26] = { effect = xi.effect.AGI_BOOST_II,  power = 30,    ID = 7422 },
    [27] = { effect = xi.effect.INT_BOOST_II,  power = 30,    ID = 7424 },
    [28] = { effect = xi.effect.MND_BOOST_II,  power = 30,    ID = 7426 },
    [29] = { effect = xi.effect.CHR_BOOST_II,  power = 30,    ID = 7428 },
}

xi.nyzul.FloorLayout =
{
    [0]  = {   -20, -0.5, -380 }, -- boss floors 20, 40, 60, 80
 -- [?]  = {  -491, -4.0, -500 }, -- boss floor 20 confirmed
    [1]  = {   380, -0.5, -500 },
    [2]  = {   500, -0.5,  -20 },
    [3]  = {   500, -0.5,   60 },
    [4]  = {   500, -0.5, -100 },
    [5]  = {   540, -0.5, -140 },
    [6]  = {   460, -0.5, -219 },
    [7]  = {   420, -0.5,  500 },
    [8]  = {    60, -0.5, -335 },
    [9]  = {    20, -0.5, -500 },
    [10] = {   -95, -0.5,   60 },
    [11] = {   100, -0.5,  100 },
    [12] = {  -460, -4.0, -180 },
    [13] = {  -304, -0.5, -380 },
    [14] = {  -380, -0.5, -500 },
    [15] = {  -459, -4.0, -540 },
    [16] = {  -465, -4.0, -340 },
    [17] = { 504.5,  0.0,  -60 },
 -- [18] = {   580,  0.0,  340 },
 -- [19] = {   455,  0.0, -140 },
 -- [20] = {   500,  0.0,   20 },
 -- [21] = {   500,    0,  380 },
 -- [22] = {   460,    0,  100 },
 -- [23] = {   100,    0, -380 },
 -- [24] = { -64.5,    0,   60 },
}

xi.nyzul.floorCost =
{
    [1]  = { level =  1, cost =    0 },
    [2]  = { level =  6, cost =  500 },
    [3]  = { level = 11, cost =  550 },
    [4]  = { level = 16, cost =  600 },
    [5]  = { level = 21, cost =  650 },
    [6]  = { level = 26, cost =  700 },
    [7]  = { level = 31, cost =  750 },
    [8]  = { level = 36, cost =  800 },
    [9]  = { level = 41, cost =  850 },
    [10] = { level = 46, cost =  900 },
    [11] = { level = 51, cost = 1000 },
    [12] = { level = 56, cost = 1100 },
    [13] = { level = 61, cost = 1200 },
    [14] = { level = 66, cost = 1300 },
    [15] = { level = 71, cost = 1400 },
    [16] = { level = 76, cost = 1500 },
    [17] = { level = 81, cost = 1600 },
    [18] = { level = 86, cost = 1700 },
    [19] = { level = 91, cost = 1800 },
    [20] = { level = 96, cost = 1900 },
}

xi.nyzul.pickMobs =
{
    [0] = -- 20th Floor bosses
    {
        [40] = -- 20 and 40 floor Bosses
        {
            ADAMANTOISE = 17092999,
            FAFNIR      = 17093001,
        },
        [100] = -- floors 60, 80 and 100 floor bosses
        {
            KHIMAIRA = 17093002,
            CERBERUS = 17093004,
        },
    },

    [1] = -- Enemy Leaders, can appear on all floors but %20 that are on objective
    {
        MOKKE               = 17092944,
        LONG_HORNED_CHARIOT = 17092968,
    },

    [2] = -- Specified Enemies
    {
        [0] = -- Heraldic Imp x5
        {
            17092969, 17092970, 17092971, 17092972, 17092973
        },
        [1] = -- Psycheflayer x5
        {
            17092974, 17092975, 17092976, 17092977, 17092978
        },
        [2] = -- Poroggo Gent x5
        {
            17092979, 17092980, 17092981, 17092982, 17092983
        },
        [3] = -- Ebony Pudding x5
        {
            17092984, 17092985, 17092986, 17092987, 17092988
        },
        [4] = -- Qiqirn_Treasure_Hunter x2
        {
            17092989, 17092990
        },
        [5] = -- Qiqirn_Archaeologist x3
        {
            17092991, 17092992, 17092993
        },
        [6] = -- Racing_Chariot x5
        {
            17092994, 17092995, 17092996, 17092997, 17092998
        },
    },
}

 xi.nyzul.evenFloorNMs =
{
    [1] = -- floor 1 to 19 NM's
    {
        17092824, 17092825, 17092826, 17092827, 17092828, 17092829, 17092830, 17092831, 17092832,
    },

    [2] = -- floor 21 to 39 NM's
    {
        17092842, 17092843, 17092844, 17092845, 17092846, 17092847, 17092848, 17092849, 17092850,
    },

    [3] = -- floor 41 to 59 NM's
    {
        17092860, 17092861, 17092862, 17092863, 17092864, 17092865, 17092866, 17092867, 17092868,
    },

    [4] = -- floor 61 to 79 NM's
    {
        17092878, 17092879, 17092880, 17092881, 17092882, 17092883, 17092884, 17092885, 17092886,
    },

    [5] = -- floor 81 to 99 NM's
    {
        17092896, 17092897, 17092898, 17092899, 17092900, 17092901, 17092902, 17092903, 17092904,
    },
}

xi.nyzul.oddFloorNMs =
{
    [1] = -- floor 1 to 19 NM's
    {
        17092833, 17092834, 17092835, 17092836, 17092837, 17092838, 17092839, 17092840, 17092841,
    },

    [2] = -- floor 21 to 39 NM's
    {
        17092851, 17092852, 17092853, 17092854, 17092855, 17092856, 17092857, 17092858, 17092859,
    },

    [3] = -- floor 41 to 59 NM's
    {
        17092869, 17092870, 17092871, 17092872, 17092873, 17092874, 17092875, 17092876, 17092877,
    },

    [4] = -- floor 61 to 79 NM's
    {
        17092887, 17092888, 17092889, 17092890, 17092891, 17092892, 17092893, 17092894, 17092895,
    },

    [5] = -- floor 81 to 99 NM's
    {
        17092905, 17092906, 17092907, 17092908, 17092909, 17092910, 17092911, 17092912, 17092913,
    },
}


xi.nyzul.FloorEntities = -- regular mobs by layout
{
    [1] = -- Aquans
    {
        17092631, 17092632, 17092633, 17092634, 17092635, 17092636,
        17092637, 17092638, 17092639, 17092640, 17092641, 17092642
    },

    [2] = -- Amorphs
    {
        17092643, 17092644, 17092645, 17092646, 17092647, 17092648,
        17092649, 17092650, 17092651, 17092652, 17092653, 17092654
    },

    [3] = -- Arcana
    {
        17092655, 17092656, 17092657, 17092658, 17092659, 17092660,
        17092661, 17092662, 17092663, 17092664, 17092665, 17092666
    },

    [4] = -- Undead
    {
        17092667, 17092668, 17092669, 17092670, 17092671, 17092672,
        17092673, 17092674, 17092675, 17092676, 17092677, 17092678
    },

    [5] = -- Vermin
    {
        17092679, 17092680, 17092681, 17092682, 17092683, 17092684,
        17092685, 17092686, 17092687, 17092688, 17092689, 17092690
    },

    [6] = -- Demons
    {
        17092691, 17092692, 17092693, 17092694, 17092695, 17092696,
        17092697, 17092698, 17092699, 17092700, 17092701, 17092702
    },

    [7] = -- Dragons
    {
        17092703, 17092704, 17092705, 17092706, 17092707, 17092708,
        17092709, 17092710, 17092711, 17092712, 17092713, 17092714
    },

    [8] = -- Birds
    {
        17092715, 17092716, 17092717, 17092718, 17092719, 17092720,
        17092721, 17092722, 17092723, 17092724, 17092725, 17092726
    },

    [9] = -- Beasts
    {
        17092727, 17092728, 17092729, 17092730, 17092731, 17092732,
        17092733, 17092734, 17092735, 17092736, 17092737, 17092738
    },

    [10] = -- Plantoids
    {
        17092739, 17092740, 17092741, 17092742, 17092743, 17092744,
        17092745, 17092746, 17092747, 17092748, 17092749, 17092750
    },

    [11] =  -- Lizards
    {
        17092751, 17092752, 17092753, 17092754, 17092755, 17092756,
        17092757, 17092758, 17092759, 17092760, 17092761, 17092762
    },

    [12] = -- Amorphs
    {
        17092763, 17092764, 17092765, 17092766, 17092767, 17092768,
        17092769, 17092770, 17092771, 17092772, 17092773, 17092774
    },

    [13] = -- Mixed
    {
        17092775, 17092776, 17092777, 17092778, 17092779, 17092780,
        17092781, 17092782, 17092783, 17092784, 17092785, 17092786
    },

    [14] = -- Mixed
    {
        17092787, 17092788, 17092789, 17092790, 17092791, 17092792,
        17092793, 17092794, 17092795, 17092796, 17092797, 17092798
    },

    [15] = -- Amorphs
    {
        17092799, 17092800, 17092801, 17092802, 17092803, 17092804,
        17092805, 17092806, 17092807, 17092808, 17092809, 17092810
    },

    [16] = -- Arcana
    {
        17092811, 17092812, 17092813, 17092814, 17092815, 17092816,
        17092817, 17092818, 17092819, 17092820, 17092821, 17092822
    },

    [17] = -- Gears
    {
        start = 17092916,
        stop  = 17092921,
    },
}

xi.nyzul.appraisalItems =
{
    [xi.appraisalUtil.Origin.NYZUL_BAT_EYE              ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_SHADOW_EYE           ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_BOMB_KING            ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_JUGGLER_HECATOMB     ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_SMOTHERING_SCHMIDT   ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_HELLION              ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_LEAPING_LIZZY        ] = xi.items.APPRAISAL_FOOTWEAR,
    [xi.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT          ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_JAGGEDY_EARED_JACK   ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_CACTUAR_CANTAUTOR    ] = xi.items.APPRAISAL_FOOTWEAR,
    [xi.appraisalUtil.Origin.NYZUL_GARGANTUA            ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_GYRE_CARLIN          ] = xi.items.APPRAISAL_BOW,
    [xi.appraisalUtil.Origin.NYZUL_ASPHYXIATED_AMSEL    ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_FROSTMANE            ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_PEALLAIDH            ] = xi.items.APPRAISAL_GLOVES,
    [xi.appraisalUtil.Origin.NYZUL_CARNERO              ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_FALCATUS_ARANEI      ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_EMERGENT_ELM         ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_OLD_TWO_WINGS        ] = xi.items.APPRAISAL_CAPE,
    [xi.appraisalUtil.Origin.NYZUL_AIATAR               ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_INTULO               ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_ORCTRAP              ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_VALKURM_EMPEROR      ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_CRUSHED_KRAUSE       ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_STINGING_SOPHIE      ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_SERPOPARD_ISHTAR     ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_WESTERN_SHADOW       ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_BLOODTEAR_BALDURF    ] = xi.items.APPRAISAL_SHIELD,
    [xi.appraisalUtil.Origin.NYZUL_ZIZZY_ZILLAH         ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_ELLYLLON             ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_MISCHIEVOUS_MICHOLAS ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_LEECH_KING           ] = xi.items.APPRAISAL_EARRING,
    [xi.appraisalUtil.Origin.NYZUL_EASTERN_SHADOW       ] = xi.items.APPRAISAL_BOW,
    [xi.appraisalUtil.Origin.NYZUL_NUNYENUNC            ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_HELLDIVER            ] = xi.items.APPRAISAL_BOW,
    [xi.appraisalUtil.Origin.NYZUL_TAISAIJIN            ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_FUNGUS_BEETLE        ] = xi.items.APPRAISAL_SHIELD,
    [xi.appraisalUtil.Origin.NYZUL_FRIAR_RUSH           ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_PULVERIZED_PFEFFER   ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_ARGUS                ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_BLOODPOOL_VORAX      ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_NIGHTMARE_VASE       ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_DAGGERCLAW_DRACOS    ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_NORTHERN_SHADOW      ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_FRAELISSA            ] = { xi.items.APPRAISAL_CAPE, xi.items.APPRAISAL_BOW },
    [xi.appraisalUtil.Origin.NYZUL_ROC                  ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_SABOTENDER_BAILARIN  ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_AQUARIUS             ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_ENERGETIC_ERUCA      ] = xi.items.APPRAISAL_GLOVES,
    [xi.appraisalUtil.Origin.NYZUL_SPINY_SPIPI          ] = xi.items.APPRAISAL_CAPE,
    [xi.appraisalUtil.Origin.NYZUL_TRICKSTER_KINETIX    ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_DROOLING_DAISY       ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_BONNACON             ] = xi.items.APPRAISAL_FOOTWEAR,
    [xi.appraisalUtil.Origin.NYZUL_GOLDEN_BAT           ] = xi.items.APPRAISAL_CAPE,
    [xi.appraisalUtil.Origin.NYZUL_STEELFLEECE_BALDARICH] = xi.items.APPRAISAL_SHIELD,
    [xi.appraisalUtil.Origin.NYZUL_SABOTENDER_MARIACHI  ] = xi.items.APPRAISAL_DAGGER,
    [xi.appraisalUtil.Origin.NYZUL_UNGUR                ] = xi.items.APPRAISAL_BOW,
    [xi.appraisalUtil.Origin.NYZUL_SWAMFISK             ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_BUBURIMBOO           ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_KEEPER_OF_HALIDOM    ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_SERKET               ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_DUNE_WIDOW           ] = xi.items.APPRAISAL_NECKLACE,
    [xi.appraisalUtil.Origin.NYZUL_ODQAN                ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_BURNED_BERGMANN      ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_TYRANNIC_TUNNOK      ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_BLOODSUCKER          ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_TOTTERING_TOBY       ] = xi.items.APPRAISAL_FOOTWEAR,
    [xi.appraisalUtil.Origin.NYZUL_SOUTHERN_SHADOW      ] = xi.items.APPRAISAL_SHIELD,
    [xi.appraisalUtil.Origin.NYZUL_SHARP_EARED_ROPIPI   ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_PANZER_PERCIVAL      ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_VOUIVRE              ] = xi.items.APPRAISAL_POLEARM,
    [xi.appraisalUtil.Origin.NYZUL_JOLLY_GREEN          ] = xi.items.APPRAISAL_SASH,
    [xi.appraisalUtil.Origin.NYZUL_TUMBLING_TRUFFLE     ] = xi.items.APPRAISAL_HEADPIECE,
    [xi.appraisalUtil.Origin.NYZUL_CAPRICIOUS_CASSIE    ] = xi.items.APPRAISAL_EARRING,
    [xi.appraisalUtil.Origin.NYZUL_AMIKIRI              ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_STRAY_MARY           ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_SEWER_SYRUP          ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_UNUT                 ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_SIMURGH              ] = xi.items.APPRAISAL_FOOTWEAR,
    [xi.appraisalUtil.Origin.NYZUL_PELICAN              ] = xi.items.APPRAISAL_SHIELD,
    [xi.appraisalUtil.Origin.NYZUL_CARGO_CRAB_COLIN     ] = xi.items.APPRAISAL_SWORD,
    [xi.appraisalUtil.Origin.NYZUL_WOUNDED_WURFEL       ] = xi.items.APPRAISAL_RING,
    [xi.appraisalUtil.Origin.NYZUL_PEG_POWLER           ] = xi.items.APPRAISAL_AXE,
    [xi.appraisalUtil.Origin.NYZUL_JADED_JODY           ] = xi.items.APPRAISAL_BOX,
    [xi.appraisalUtil.Origin.NYZUL_MAIGHDEAN_UAINE      ] = xi.items.APPRAISAL_EARRING,
}

-- Local functions
local function get_token_rate(instance)
    local party_size = instance:getLocalVar("partySize")
    local rate       = 1

    if party_size > 3 then
        rate = rate - ((party_size - 3 ) * .1)
    end

    return rate
end

local function calculate_tokens(instance)
    local relative_floor   = xi.nyzul.get_relative_floor(instance)
    local rate             = get_token_rate(instance)
    local potential_tokens = instance:getLocalVar("potential_tokens")
    local floor_bonus      = 0

    if relative_floor > 1 then
        floor_bonus = (10 * math.floor((relative_floor - 1) / 5))
    end

    potential_tokens = math.floor(potential_tokens + (200 + floor_bonus) * rate)

    return potential_tokens
end

-- Global functions
xi.nyzul.get_relative_floor = function(instance)
    local current_floor  = instance:getLocalVar("Nyzul_Current_Floor")
    local starting_floor = instance:getLocalVar("Nyzul_Isle_StartingFloor")

    if current_floor < starting_floor then
        return current_floor + 100
    end

    return current_floor
end

xi.nyzul.handleAppraisalItem = function(player, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()

    for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
        if npc:getID() == cofferID and npc:getLocalVar("opened") == 0 then
            -- Appraisal Items
            local mobOffset = npc:getLocalVar("appraisalItem") - 17092723

            if mobOffset == 166 or mobOffset == 187 then
                mobOffset = 108
            elseif mobOffset == 154 or mobOffset == 172 or mobOffset == 190 then
                mobOffset = 136
            end

            local itemID = xi.nyzul.appraisalItems[mobOffset]

            if type(itemID) == "table" then
                local pick = math.random(1, #itemID)
                itemID     = itemID[pick]
            end

            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemID)

                return
            end

            player:addItem({id = itemID, appraisal = mobOffset})

            for _, players in pairs(chars) do
                players:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, itemID)
            end

            npc:entityAnimationPacket("open")
            npc:setLocalVar("opened", 1)
            npc:untargetable(true)
            npc:queue(10000, function(npcvar) npcvar:entityAnimationPacket("kesu") end)
            npc:queue(12000, function(npcvar) npcvar:setStatus(xi.status.DISAPPEAR) npcvar:resetLocalVars() npcvar:setAnimationSub(0) end)

            break
        end
    end
end

xi.nyzul.tempBoxTrigger = function(player, npc)
    if npc:getLocalVar("itemsPicked") == 0 then
        npc:setLocalVar("itemsPicked", 1)
        npc:entityAnimationPacket("open")
        npc:setAnimationSub(13)
        xi.nyzul.tempBoxPickItems(npc)
    end

    player:startEvent(2, {
        [0] = (npc:getLocalVar("itemID_1") + (npc:getLocalVar("itemAmount_1") * 65536)),
        [1] = (npc:getLocalVar("itemID_2") + (npc:getLocalVar("itemAmount_2") * 65536)),
        [2] = (npc:getLocalVar("itemID_3") + (npc:getLocalVar("itemAmount_3") * 65536))
    })
end

xi.nyzul.tempBoxPickItems = function(npc)
    local tempBoxItems =
    {
        [1]  = { itemID = xi.items.BOTTLE_OF_BARBARIANS_DRINK, amount = math.random(1, 3) },
        [2]  = { itemID = xi.items.BOTTLE_OF_FIGHTERS_DRINK,   amount = math.random(1, 3) },
        [3]  = { itemID = xi.items.BOTTLE_OF_ORACLES_DRINK,    amount = math.random(1, 3) },
        [4]  = { itemID = xi.items.BOTTLE_OF_ASSASSINS_DRINK,  amount = math.random(1, 3) },
        [5]  = { itemID = xi.items.BOTTLE_OF_SPYS_DRINK,       amount = math.random(1, 3) },
        [6]  = { itemID = xi.items.BOTTLE_OF_BRAVERS_DRINK,    amount = math.random(1, 3) },
        [7]  = { itemID = xi.items.BOTTLE_OF_SOLDIERS_DRINK,   amount = math.random(1, 3) },
        [8]  = { itemID = xi.items.BOTTLE_OF_CHAMPIONS_DRINK,  amount = math.random(1, 3) },
        [9]  = { itemID = xi.items.BOTTLE_OF_MONARCHS_DRINK,   amount = math.random(1, 3) },
        [10] = { itemID = xi.items.BOTTLE_OF_GNOSTICS_DRINK,   amount = math.random(1, 3) },
        [11] = { itemID = xi.items.BOTTLE_OF_CLERICS_DRINK,    amount = math.random(1, 3) },
        [12] = { itemID = xi.items.BOTTLE_OF_SHEPHERDS_DRINK,  amount = math.random(1, 3) },
        [13] = { itemID = xi.items.BOTTLE_OF_SPRINTERS_DRINK,  amount = math.random(1, 3) },
        [14] = { itemID = xi.items.FLASK_OF_STRANGE_MILK,      amount = math.random(1, 5) },
        [15] = { itemID = xi.items.BOTTLE_OF_STRANGE_JUICE,    amount = math.random(1, 5) },
        [16] = { itemID = xi.items.BOTTLE_OF_FANATICS_DRINK,   amount = 1                 },
        [17] = { itemID = xi.items.BOTTLE_OF_FOOLS_DRINK,      amount = 1                 },
        [18] = { itemID = xi.items.DUSTY_WING,                 amount = 1                 },
        [19] = { itemID = xi.items.BOTTLE_OF_VICARS_DRINK,     amount = math.random(1, 3) },
        [20] = { itemID = xi.items.DUSTY_POTION,               amount = math.random(1, 3) },
        [21] = { itemID = xi.items.DUSTY_ETHER,                amount = math.random(1, 3) },
        [22] = { itemID = xi.items.DUSTY_ELIXIR,               amount = 1                 }
    }

    local random       = math.random(1, #tempBoxItems)
    local item         = tempBoxItems[random]
    local item2_random = math.random(1, 10)
    local item3_random = math.random(1, 10)

    if npc:getLocalVar("itemID_1") == 0 then
        npc:setLocalVar("itemID_1", item.itemID)
        npc:setLocalVar("itemAmount_1", item.amount)
        table.remove(tempBoxItems, random)
    end

    if item2_random > 4 then
        random = math.random(1, #tempBoxItems)
        item   = tempBoxItems[random]

        npc:setLocalVar("itemID_2", item.itemID)
        npc:setLocalVar("itemAmount_2", item.amount)
        table.remove(tempBoxItems, random)
    end

    if item2_random > 4 and item3_random > 8 then
        random = math.random(1,#tempBoxItems)
        item   = tempBoxItems[random]

        npc:setLocalVar("itemID_3", item.itemID)
        npc:setLocalVar("itemAmount_3", item.amount)
        table.remove(tempBoxItems, random)
    end
end

xi.nyzul.tempBoxFinish = function(player, csid, option, npc)
    local ID = require("scripts/zones/"..player:getZoneName().."/IDs")

    if csid == 2 then
        local item_1 = npc:getLocalVar("itemID_1")
        local item_2 = npc:getLocalVar("itemID_2")
        local item_3 = npc:getLocalVar("itemID_3")

        if option == 1 and item_1 > 0 and npc:getLocalVar("itemAmount_1") > 0 then
            if not player:hasItem(item_1, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item_1)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item_1)
                npc:setLocalVar("itemAmount_1", npc:getLocalVar("itemAmount_1") - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end
        elseif option == 2 and item_2 > 0 and npc:getLocalVar("itemAmount_2") > 0 then
            if not player:hasItem(item_2, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item_2)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item_2)
                npc:setLocalVar("itemAmount_2", npc:getLocalVar("itemAmount_2") - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end
        elseif option == 3 and item_3 > 0 and npc:getLocalVar("itemAmount_3") > 0 then
            if not player:hasItem(item_3, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item_3)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item_3)
                npc:setLocalVar("itemAmount_3", npc:getLocalVar("itemAmount_3") - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end
        end

        if npc:getLocalVar("itemAmount_1") == 0 and npc:getLocalVar("itemAmount_2") == 0 and npc:getLocalVar("itemAmount_3") == 0 then
            npc:queue(10000, function(npcvar) npcvar:entityAnimationPacket("kesu") end)
            npc:queue(12000, function(npcvar) npcvar:setStatus(xi.status.DISAPPEAR) npcvar:setAnimationSub(0) npcvar:resetLocalVars() end)
        end
    end
end

xi.nyzul.clearChests = function(instance)
    for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
        local coffer = GetNPCByID(cofferID, instance)

        if coffer:getStatus() ~= xi.status.DISAPPEAR then
            coffer:setStatus(xi.status.DISAPPEAR)
            coffer:setAnimationSub(0)
            coffer:resetLocalVars()
        end
    end

    if xi.settings.ENABLE_NYZUL_CASKETS == 1 then
        for _, casketID in ipairs(ID.npc.TREASURE_CASKET) do
            local casket = GetNPCByID(casketID, instance)

            if casket:getStatus() ~= xi.status.DISAPPEAR then
                casket:setStatus(xi.status.DISAPPEAR)
                casket:setAnimationSub(0)
                casket:resetLocalVars()
            end
        end
    end
end

xi.nyzul.handleRunicKey = function(mob)
    local instance = mob:getInstance()

    if instance:getLocalVar("Nyzul_Current_Floor") == 100 then
        local chars      = instance:getChars()
        local startFloor = instance:getLocalVar("Nyzul_Isle_StartingFloor")

        for _, entity in pairs(chars) do
            -- Does players Runic Disk have data saved to a floor of entering or higher
            if entity:getVar("NyzulFloorProgress") + 1 >= startFloor and not entity:hasKeyItem(xi.ki.RUNIC_KEY) then
                if xi.settings.RUNIC_DISK_SAVE == 0 then -- On early version only initiator of floor got progress saves and key credit
                    if entity:getID() == instance:getLocalVar("diskHolder") then
                        if npcUtil.giveKeyItem(entity, xi.ki.RUNIC_KEY) then
                            entity:setVar("NyzulFloorProgress", 0)
                        end
                    end
                else -- Anyone can get a key on 100 win if disk passed check
                    npcUtil.giveKeyItem(entity, xi.ki.RUNIC_KEY)
                end
            end
        end
    end
end

xi.nyzul.handleProgress = function(instance, progress)
    local chars        = instance:getChars()
    local stage        = instance:getStage()
    local currectFloor = instance:getLocalVar("Nyzul_Current_Floor")
    local complete     = false

    if
        ((stage == xi.nyzul.objective.FREE_FLOOR or
        stage == xi.nyzul.objective.ELIMINATE_ENEMY_LEADER or
        stage == xi.nyzul.objective.ACTIVATE_ALL_LAMPS or
        stage == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY) and
        progress == 15)
        or
        ((stage == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES or stage == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMIES) and
        progress >= instance:getLocalVar("Eliminate"))
    then
        instance:setProgress(0)
        instance:setLocalVar("Eliminate", 0)
        instance:setLocalVar("potential_tokens", calculate_tokens(instance))

        for _, players in ipairs(chars) do
            players:messageSpecial(ID.text.OBJECTIVE_COMPLETE, currectFloor)
        end

        complete = true
    end

    return complete
end

xi.nyzul.enemyLeaderKill = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(15)
end

xi.nyzul.specifiedGroupKill = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end

xi.nyzul.specifiedEnemySet = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY then
        if instance:getLocalVar("Nyzul_Specified_Enemy") == mob:getID() then
            mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
        end
    end
end

xi.nyzul.specifiedEnemyKill = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY then
        if instance:getLocalVar("Nyzul_Specified_Enemy") == mob:getID() then
            instance:setProgress(15)
            instance:setLocalVar("Nyzul_Specified_Enemy", 0)
        end
    elseif instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end

xi.nyzul.eliminateAllKill = function(mob)
    local instance = mob:getInstance()

    if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
        instance:setProgress(instance:getProgress() + 1)
    end
end

xi.nyzul.activateRuneOfTransfer = function(instance)
    for _, runeID in pairs(ID.npc.RUNE_OF_TRANSFER) do
        if GetNPCByID(runeID, instance):getStatus() == xi.status.NORMAL then
            GetNPCByID(runeID, instance):setAnimationSub(1)

            break
        end
    end
end

xi.nyzul.vigilWeaponDrop = function(player, mob)
    local instance = mob:getInstance()

    -- Only floor 100 Bosses to drop 1 random weapon guarenteed and 1 of the disk holders job
    -- will not drop diskholder's weapon if anyone already has it.
    if instance:getLocalVar("Nyzul_Current_Floor") == 100 then
        local diskHolder = GetPlayerByID(instance:getLocalVar("diskHolder"), instance)
        local chars      = instance:getChars()

        if diskHolder ~= nil then
            for _, entity in pairs(chars) do
                if not entity:hasItem(xi.nyzul.baseWeapons[diskHolder:getMainJob()]) then
                    player:addTreasure(xi.nyzul.baseWeapons[diskHolder:getMainJob()], mob)

                    break
                end
            end
        end

        player:addTreasure(xi.nyzul.baseWeapons[math.random(1, #xi.nyzul.baseWeapons)], mob)

    -- Every NM can randomly drop a vigil weapon
    elseif math.random(100) <= 20 and xi.settings.ENABLE_VIGIL_DROPS == 1 then
        player:addTreasure(xi.nyzul.baseWeapons[math.random(1, #xi.nyzul.baseWeapons)], mob)
    end
end

xi.nyzul.spawnChest = function(mob, player)
    local instance = mob:getInstance()
    local mobID    = mob:getID()

    if
        mobID >= ID.mob[xi.assaultUtil.assaultArea.NYZUL_ISLE].BAT_EYE and
        mobID <= ID.mob[xi.assaultUtil.assaultArea.NYZUL_ISLE].TAISAIJIN
    then
        xi.nyzul.vigilWeaponDrop(player, mob)

        for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
            local coffer = GetNPCByID(cofferID, instance)

            if coffer:getStatus() == xi.status.DISAPPEAR then
                local pos = mob:getPos()
                coffer:untargetable(false)
                coffer:setPos(pos.x, pos.y, pos.z, pos.rot)
                coffer:setLocalVar("appraisalItem", mobID)
                coffer:setStatus(xi.status.NORMAL)

                break
            end
        end
    elseif mobID < ID.mob[xi.assaultUtil.assaultArea.NYZUL_ISLE].ADAMANTOISE and xi.settings.ENABLE_NYZUL_CASKETS == 1 then
        if math.random(100) <= 6 then
            for _, casketID in ipairs(ID.npc.TREASURE_CASKET) do
                local casket = GetNPCByID(casketID, instance)

                if casket:getStatus() == xi.status.DISAPPEAR then
                    local pos = mob:getPos()
                    casket:setPos(pos.x, pos.y, pos.z, pos.rot)
                    casket:setStatus(xi.status.NORMAL)

                    break
                end
            end
        end
    end
end

xi.nyzul.removePathos = function(instance)
    if instance:getLocalVar("floorPathos") > 0 then
        for i = 1, 29 do
            if utils.isBitSet(instance:getLocalVar("floorPathos"), i) then
                local removeMessage = xi.nyzul.pathos[i].ID
                local chars         = instance:getChars()

                for _, players in pairs(chars) do
                    players:delStatusEffectSilent(xi.nyzul.pathos[i].effect)
                    players:messageSpecial(removeMessage - 1)

                    if players:hasPet() then
                        local pet = players:getPet()
                        pet:delStatusEffectSilent(xi.nyzul.pathos[i].effect)
                    end
                end

                instance:setLocalVar("floorPathos",utils.setBit(instance:getLocalVar("floorPathos"), i, 0))
            end
        end
    end
end

xi.nyzul.addFloorPathos = function(instance)
    local randomPathos = instance:getLocalVar("randomPathos")

    if randomPathos > 0 then
        instance:setLocalVar("floorPathos", utils.setBit(instance:getLocalVar("floorPathos"), randomPathos, 1))

        local pathos = xi.nyzul.pathos[randomPathos]
        local chars  = instance:getChars()

        for _, players in pairs(chars) do
            players:addStatusEffect(pathos.effect, pathos.power, 0, 0)
            players:getStatusEffect(pathos.effect):unsetFlag(3) -- dispelable + eraseable
            players:getStatusEffect(pathos.effect):setFlag(8388864) -- on zone + no cancel
            players:messageSpecial(pathos.ID)

            if players:hasPet() then
                local pet = players:getPet()
                pet:addStatusEffectEx(pathos.effect, pathos.effect, pathos.power, 0, 0)
                pet:getStatusEffect(pathos.effect):unsetFlag(3) -- dispelable + eraseable
                pet:getStatusEffect(pathos.effect):setFlag(8388864) -- on zone + no cancel
            end
        end

        instance:setLocalVar("randomPathos", 0)
    end
end

xi.nyzul.addPenalty = function(mob)
    local instance = mob:getInstance()
    local pathos   = instance:getLocalVar("floorPathos")
    local penalty  = instance:getLocalVar("gearPenalty")
    local chars    = instance:getChars()

    if penalty == xi.nyzul.penalty.TIME then
        local timeLimit = instance:getTimeLimit() * 60

        instance:setTimeLimit(timeLimit - 60)

        for _, players in pairs(chars) do
            players:messageSpecial(ID.text.MALFUNCTION)
            players:messageSpecial(ID.text.TIME_LOSS, 1)
        end
    elseif penalty == xi.nyzul.penalty.TOKENS then
        local tokenPenalty = instance:getLocalVar("tokenPenalty")

        tokenPenalty = tokenPenalty + 1
        instance:setLocalVar("tokenPenalty", tokenPenalty)

        for _, players in pairs(chars) do
            players:messageSpecial(ID.text.MALFUNCTION)
            players:messageSpecial(ID.text.TOKEN_LOSS)
        end
    else
        for i = 1, 17 do
            local randomEffect = math.random(1, 17)

            if not utils.isBitSet(pathos, randomEffect) then
                instance:setLocalVar("floorPathos", utils.setBit(pathos, randomEffect, 1))
                pathos = xi.nyzul.pathos[randomEffect]
                local effect = pathos.effect
                local power  = pathos.power

                for _, players in pairs(chars) do
                    if effect == xi.effect.IMPAIRMENT or effect == xi.effect.OMERTA or effect == xi.effect.DEBILITATION then
                        if players:hasStatusEffect(effect) then
                            local statusEffect = players:getStatusEffect(effect)
                            local effectPower = statusEffect:getPower()
                            power = bit.bor(effectPower, power)
                        end
                    end

                    players:addStatusEffect(effect, power, 0, 0)
                    players:getStatusEffect(effect):unsetFlag(3) -- dispelable + eraseable
                    players:getStatusEffect(effect):setFlag(8388864) -- on zone + no cancel
                    players:messageSpecial(ID.text.MALFUNCTION)
                    players:messageSpecial(pathos.ID)

                    if players:hasPet() then
                        local pet = players:getPet()
                        pet:addStatusEffectEx(effect, effect, power, 0, 0)
                        pet:getStatusEffect(effect):unsetFlag(3) -- dispelable + eraseable
                        pet:getStatusEffect(effect):setFlag(8388864) -- on zone + no cancel
                    end
                end

                break
            end
        end
    end
end

xi.nyzul.get_token_penalty = function(instance)
    local floor_penalities = instance:getLocalVar("tokenPenalty")
    local rate             = get_token_rate(instance)

    return math.floor(117 * rate) * floor_penalities
end
