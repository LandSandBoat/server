-----------------------------------
-- Moblin Maze Mongers
-----------------------------------
xi = xi or {}
xi.maze = xi.maze or {}

---@enum xi.maze.runeShape
xi.maze.runeShape =
{
    -- #
    -- #
    DOMINO  = 0,

    -- #.
    -- ##
    CORNER  = 1,

    -- #
    -- #
    -- #
    LINE_3  = 2,

    -- #.
    -- ##
    -- #.
    T       = 3,

    -- ##
    -- ##
    SQUARE  = 4,

    -- #.
    -- #.
    -- ##
    L       = 5,

    -- .#
    -- .#
    -- ##
    J       = 6,

    -- #.
    -- ##
    -- .#
    S       = 7,

    -- .#
    -- ##
    -- #.
    Z       = 8,

    -- #
    -- #
    -- #
    -- #
    LINE_4  = 9,

    -- .#.
    -- ###
    -- .#.
    PLUS    = 10,
}

-- MMM Voucher names extracted from item descriptions
-- Stored in Tabula exdata
---@enum xi.maze.voucher
xi.maze.voucher =
{
    SANITIZATION_TEAM_ALPHA     = 1, -- Voucher 01
    SANITIZATION_TEAM_BETA      = 2, -- Voucher 02
    SANITIZATION_TEAM_GAMMA     = 3, -- Voucher 03
    MATERIALIZATION_TEAM        = 4, -- Voucher 04
    ACTUALIZATION_TEAM          = 5, -- Voucher 05
    APPROPRIATION_TEAM          = 6, -- Voucher 06
    LIQUIDATION_TEAM            = 7, -- Voucher 07
    AQUATIC_DEPOPULATION_TEAM   = 8, -- Voucher 08
    REVITALIZATION_TEAM         = 9, -- Voucher 09
}

-- MMM Rune names extracted from item descriptions
-- Stored in Tabula exdata
---@enum xi.maze.rune
xi.maze.rune =
{
    AQUAN                  =   1, -- Rune 001
    AMORPH                 =   2, -- Rune 002
    BIRD                   =   3, -- Rune 003
    BEAST                  =   4, -- Rune 004
    LIZARD                 =   5, -- Rune 005
    VERMIN                 =   6, -- Rune 006
    PLANTOID               =   7, -- Rune 007
    UNDEAD                 =   8, -- Rune 008
    ARCANA                 =   9, -- Rune 009
    DEMON                  =  10, -- Rune 010
    DRAGON                 =  11, -- Rune 011
    ELEMENTAL              =  12, -- Rune 012
    GREAT_WARRIOR          =  13, -- Rune 013
    TINY_WARRIOR           =  14, -- Rune 014
    MOTION                 =  15, -- Rune 015
    STILLNESS              =  16, -- Rune 016
    SUPREME_MIGHT          =  17, -- Rune 017
    MIGHT                  =  18, -- Rune 018
    WEAKNESS               =  19, -- Rune 019
    PEON                   =  20, -- Rune 020
    FIRE                   =  21, -- Rune 021
    ICE                    =  22, -- Rune 022
    WIND                   =  23, -- Rune 023
    EARTH                  =  24, -- Rune 024
    THUNDER                =  25, -- Rune 025
    WATER                  =  26, -- Rune 026
    LIGHT                  =  27, -- Rune 027
    DARKNESS               =  28, -- Rune 028
    STRENGTH               =  29, -- Rune 029
    DEXTERITY              =  30, -- Rune 030
    AGILITY                =  31, -- Rune 031
    VITALITY               =  32, -- Rune 032
    INTELLECT              =  33, -- Rune 033
    MIND                   =  34, -- Rune 034
    CHARISMA               =  35, -- Rune 035
    HARDINESS              =  36, -- Rune 036
    MYSTICISM              =  37, -- Rune 037
    CONSPICUOUS_BEHAVIOR   =  38, -- Rune 038
    ALTERED_AGGRESSION     =  39, -- Rune 039
    ALTERED_DEFENSE        =  40, -- Rune 040
    DIVINE_MAGIC           =  41, -- Rune 041
    HEALING_MAGIC          =  42, -- Rune 042
    ENHANCING_MAGIC        =  43, -- Rune 043
    ENFEEBLING_MAGIC       =  44, -- Rune 044
    ELEMENTAL_MAGIC        =  45, -- Rune 045
    DARK_MAGIC             =  46, -- Rune 046
    WARRIOR                =  51, -- Rune 051
    MONK                   =  52, -- Rune 052
    WHITE_MAGE             =  53, -- Rune 053
    BLACK_MAGE             =  54, -- Rune 054
    RED_MAGE               =  55, -- Rune 055
    THIEF                  =  56, -- Rune 056
    ONSLAUGHT              =  71, -- Rune 071
    PROTECTION             =  72, -- Rune 072
    ACCURACY               =  73, -- Rune 073
    EVASION                =  74, -- Rune 074
    FORCE_OF_WILL          =  75, -- Rune 075
    STEADY_MIND            =  76, -- Rune 076
    FLURRY_OF_BLOWS        =  77, -- Rune 077
    CRITICAL               =  78, -- Rune 078
    RAPID_STRIKE           =  79, -- Rune 079
    VOLUBILITY             =  80, -- Rune 080
    FLEETFOOT              =  81, -- Rune 081
    PROSPECTOR             =  82, -- Rune 082
    WOODSMAN               =  83, -- Rune 083
    HARVESTER              =  84, -- Rune 084
    FISHERMAN              =  85, -- Rune 085
    CARPENTER              =  86, -- Rune 086
    SMITH                  =  87, -- Rune 087
    GOLDSMITH              =  88, -- Rune 088
    LEATHERCRAFTER         =  89, -- Rune 089
    BONECRAFTER            =  90, -- Rune 090
    CLOTHIER               =  91, -- Rune 091
    ALCHEMIST              =  92, -- Rune 092
    MASTER_CHEF            =  93, -- Rune 093
    LOST_AND_FOUND         =  94, -- Rune 094
    SWIFT_SYNTHESIS        =  95, -- Rune 095
    SURE_SYNTHESIS         =  96, -- Rune 096
    SUPERIOR_SYNTHESIS     =  97, -- Rune 097
    INSURANCE_CONTRACT     =  98, -- Rune 098
    REPLENISHMENT_CONTRACT =  99, -- Rune 099
    TRIAL_BY_VELOCITY      = 100, -- Rune 100
    TRIAL_BY_BUDGET        = 101, -- Rune 101
    TRIAL_BY_NUMBERS       = 102, -- Rune 102
    AMNESIACS_TRIAL        = 103, -- Rune 103
    TRIAL_BY_SILENCE       = 104, -- Rune 104
    GUIDANCE_CONTRACT      = 106, -- Rune 106
    REINFORCEMENT_CONTRACT = 107, -- Rune 107
    CONDITIONING_CONTRACT  = 108, -- Rune 108
    SUSTENANCE_CONTRACT    = 109, -- Rune 109
    CAMARADERIE_CONTRACT   = 110, -- Rune 110
    GOLDAGRIKS_GENEROSITY  = 111, -- Rune 111
    OBSCURED_ENTRANCE      = 112, -- Rune 112
    SHORTCUT               = 113, -- Rune 113
    WALLOPER               = 114, -- Rune 114
    BARRAGER               = 115, -- Rune 115
    SPELLSLINGER           = 116, -- Rune 116
    SALINITY_SHIFT         = 117, -- Rune 117
    SKILLCHAIN             = 118, -- Rune 118
    MAGIC_BURST            = 119, -- Rune 119
}
