-----------------------------------
-- Moblin Maze Mongers
-- TODO: Unimplemented content.
-- Treat as documentation and rework as needed.
-----------------------------------
xi = xi or {}
xi.data = xi.data or {}
xi.data.maze = xi.data.maze or {}

-- Tabula base board layouts (5x5 grid).
-- false = blocked, 0 = open, xi.element.X = element cell.
xi.data.maze.tabulaGrid =
{
    [xi.item.MAZE_TABULA_M01] =
    {
        { 0,     0,     0,     0,     0 },
        { 0,     false, 0,     0,     0 },
        { 0,     0,     0,     0,     0 },
        { 0,     0,     0,     false, 0 },
        { 0,     0,     0,     0,     0 },
    },

    [xi.item.MAZE_TABULA_M02] =
    {
        { 0,     0,               0,     0,                  false },
        { 0,     xi.element.FIRE, 0,     xi.element.THUNDER, 0     },
        { 0,     0,               false, 0,                  0     },
        { 0,     xi.element.WIND, 0,     xi.element.LIGHT,   0     },
        { false, 0,               0,     0,                  0     },
    },

    [xi.item.MAZE_TABULA_M03] =
    {
        { 0,     0,                0,     xi.element.ICE,   0      },
        { 0,     xi.element.DARK,  0,     0,                0      },
        { false, 0,                false, 0,                false  },
        { 0,     0,                0,     xi.element.WATER, 0      },
        { 0,     xi.element.EARTH, 0,     0,                0      },
    },

    [xi.item.MAZE_TABULA_R01] =
    {
        { 0,     0,     0,     0,     0 },
        { 0,     false, 0,     0,     0 },
        { 0,     0,     0,     0,     0 },
        { 0,     0,     0,     false, 0 },
        { 0,     0,     0,     0,     0 },
    },

    [xi.item.MAZE_TABULA_R02] =
    {
        { 0,     0,               0,     0,                  false },
        { 0,     xi.element.FIRE, 0,     xi.element.THUNDER, 0     },
        { 0,     0,               false, 0,                  0     },
        { 0,     xi.element.WIND, 0,     xi.element.LIGHT,   0     },
        { false, 0,               0,     0,                  0     },
    },

    [xi.item.MAZE_TABULA_R03] =
    {
        { 0,     0,                0,     xi.element.ICE,   0      },
        { 0,     xi.element.DARK,  0,     0,                0      },
        { false, 0,                false, 0,                false  },
        { 0,     0,                0,     xi.element.WATER, 0      },
        { 0,     xi.element.EARTH, 0,     0,                0      },
    },
}

-- 4x4 grid bitmasks per rotation.
-- Index by [xi.maze.runeShape][rotation + 1], rotation 0-3.
-- Source: FFXiMain.dll embedded table. Signature: 01 02 00 88 00 C0 00 88 00 C0 02 02 00 8C 00 C8 00 C4 00 4C
---@type table<xi.maze.runeShape, integer[]>
xi.data.maze.runeShapeData =
{
    [xi.maze.runeShape.DOMINO] = { 0x8800, 0xC000, 0x8800, 0xC000 },
    [xi.maze.runeShape.CORNER] = { 0x8C00, 0xC800, 0xC400, 0x4C00 },
    [xi.maze.runeShape.LINE_3] = { 0x8880, 0xE000, 0x8880, 0xE000 },
    [xi.maze.runeShape.T]      = { 0x8C80, 0xE400, 0x4C40, 0x4E00 },
    [xi.maze.runeShape.SQUARE] = { 0xCC00, 0xCC00, 0xCC00, 0xCC00 },
    [xi.maze.runeShape.L]      = { 0x88C0, 0xE800, 0xC440, 0x2E00 },
    [xi.maze.runeShape.J]      = { 0x44C0, 0x8E00, 0xC880, 0xE200 },
    [xi.maze.runeShape.S]      = { 0x8C40, 0x6C00, 0x8C40, 0x6C00 },
    [xi.maze.runeShape.Z]      = { 0x4C80, 0xC600, 0x4C80, 0xC600 },
    [xi.maze.runeShape.LINE_4] = { 0x8888, 0xF000, 0x8888, 0xF000 },
    [xi.maze.runeShape.PLUS]   = { 0x4E40, 0x4E40, 0x4E40, 0x4E40 },
}

-- Rune item → shape and element mapping.
-- Source: Item DAT offset 0x14-0x15
--   byte[0x15] & 0xF = shape index, byte[0x14] & 0xF = element (0-7 → xi.element + 1, 0xF → NONE).
---@type table<xi.maze.rune, { shape: xi.maze.runeShape, element: xi.element }>
xi.data.maze.runeInfo =
{
    [xi.maze.rune.AQUAN]                  = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.AMORPH]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.BIRD]                   = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.BEAST]                  = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.LIZARD]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.VERMIN]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.PLANTOID]               = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.UNDEAD]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.ARCANA]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.DEMON]                  = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.DRAGON]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.ELEMENTAL]              = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.GREAT_WARRIOR]          = { shape = xi.maze.runeShape.DOMINO, element = xi.element.EARTH   },
    [xi.maze.rune.TINY_WARRIOR]           = { shape = xi.maze.runeShape.DOMINO, element = xi.element.WIND    },
    [xi.maze.rune.MOTION]                 = { shape = xi.maze.runeShape.DOMINO, element = xi.element.FIRE    },
    [xi.maze.rune.STILLNESS]              = { shape = xi.maze.runeShape.DOMINO, element = xi.element.WATER   },
    [xi.maze.rune.SUPREME_MIGHT]          = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.MIGHT]                  = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.WEAKNESS]               = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.PEON]                   = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.FIRE]                   = { shape = xi.maze.runeShape.CORNER, element = xi.element.FIRE    },
    [xi.maze.rune.ICE]                    = { shape = xi.maze.runeShape.CORNER, element = xi.element.ICE     },
    [xi.maze.rune.WIND]                   = { shape = xi.maze.runeShape.CORNER, element = xi.element.WIND    },
    [xi.maze.rune.EARTH]                  = { shape = xi.maze.runeShape.CORNER, element = xi.element.EARTH   },
    [xi.maze.rune.THUNDER]                = { shape = xi.maze.runeShape.CORNER, element = xi.element.THUNDER },
    [xi.maze.rune.WATER]                  = { shape = xi.maze.runeShape.CORNER, element = xi.element.WATER   },
    [xi.maze.rune.LIGHT]                  = { shape = xi.maze.runeShape.CORNER, element = xi.element.LIGHT   },
    [xi.maze.rune.DARKNESS]               = { shape = xi.maze.runeShape.CORNER, element = xi.element.DARK    },
    [xi.maze.rune.STRENGTH]               = { shape = xi.maze.runeShape.LINE_3, element = xi.element.FIRE    },
    [xi.maze.rune.DEXTERITY]              = { shape = xi.maze.runeShape.LINE_3, element = xi.element.THUNDER },
    [xi.maze.rune.AGILITY]                = { shape = xi.maze.runeShape.LINE_3, element = xi.element.WIND    },
    [xi.maze.rune.VITALITY]               = { shape = xi.maze.runeShape.LINE_3, element = xi.element.EARTH   },
    [xi.maze.rune.INTELLECT]              = { shape = xi.maze.runeShape.LINE_3, element = xi.element.ICE     },
    [xi.maze.rune.MIND]                   = { shape = xi.maze.runeShape.LINE_3, element = xi.element.WATER   },
    [xi.maze.rune.CHARISMA]               = { shape = xi.maze.runeShape.LINE_3, element = xi.element.LIGHT   },
    [xi.maze.rune.HARDINESS]              = { shape = xi.maze.runeShape.LINE_3, element = xi.element.LIGHT   },
    [xi.maze.rune.MYSTICISM]              = { shape = xi.maze.runeShape.LINE_3, element = xi.element.DARK    },
    [xi.maze.rune.CONSPICUOUS_BEHAVIOR]   = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.ALTERED_AGGRESSION]     = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.ALTERED_DEFENSE]        = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.DIVINE_MAGIC]           = { shape = xi.maze.runeShape.LINE_3, element = xi.element.LIGHT   },
    [xi.maze.rune.HEALING_MAGIC]          = { shape = xi.maze.runeShape.LINE_3, element = xi.element.LIGHT   },
    [xi.maze.rune.ENHANCING_MAGIC]        = { shape = xi.maze.runeShape.LINE_3, element = xi.element.LIGHT   },
    [xi.maze.rune.ENFEEBLING_MAGIC]       = { shape = xi.maze.runeShape.LINE_3, element = xi.element.DARK    },
    [xi.maze.rune.ELEMENTAL_MAGIC]        = { shape = xi.maze.runeShape.LINE_3, element = xi.element.DARK    },
    [xi.maze.rune.DARK_MAGIC]             = { shape = xi.maze.runeShape.LINE_3, element = xi.element.DARK    },
    [xi.maze.rune.WARRIOR]                = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.MONK]                   = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.WHITE_MAGE]             = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.BLACK_MAGE]             = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.RED_MAGE]               = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.THIEF]                  = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.ONSLAUGHT]              = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.PROTECTION]             = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.ACCURACY]               = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.EVASION]                = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.FORCE_OF_WILL]          = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.STEADY_MIND]            = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.FLURRY_OF_BLOWS]        = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.CRITICAL]               = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.RAPID_STRIKE]           = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.VOLUBILITY]             = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.FLEETFOOT]              = { shape = xi.maze.runeShape.CORNER, element = xi.element.WIND    },
    [xi.maze.rune.PROSPECTOR]             = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.WOODSMAN]               = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.HARVESTER]              = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.FISHERMAN]              = { shape = xi.maze.runeShape.LINE_4, element = xi.element.NONE    },
    [xi.maze.rune.CARPENTER]              = { shape = xi.maze.runeShape.SQUARE, element = xi.element.NONE    },
    [xi.maze.rune.SMITH]                  = { shape = xi.maze.runeShape.SQUARE, element = xi.element.NONE    },
    [xi.maze.rune.GOLDSMITH]              = { shape = xi.maze.runeShape.L,      element = xi.element.NONE    },
    [xi.maze.rune.LEATHERCRAFTER]         = { shape = xi.maze.runeShape.J,      element = xi.element.NONE    },
    [xi.maze.rune.BONECRAFTER]            = { shape = xi.maze.runeShape.S,      element = xi.element.NONE    },
    [xi.maze.rune.CLOTHIER]               = { shape = xi.maze.runeShape.Z,      element = xi.element.NONE    },
    [xi.maze.rune.ALCHEMIST]              = { shape = xi.maze.runeShape.SQUARE, element = xi.element.NONE    },
    [xi.maze.rune.MASTER_CHEF]            = { shape = xi.maze.runeShape.LINE_4, element = xi.element.NONE    },
    [xi.maze.rune.LOST_AND_FOUND]         = { shape = xi.maze.runeShape.PLUS,   element = xi.element.NONE    },
    [xi.maze.rune.SWIFT_SYNTHESIS]        = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.SURE_SYNTHESIS]         = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.SUPERIOR_SYNTHESIS]     = { shape = xi.maze.runeShape.LINE_4, element = xi.element.NONE    },
    [xi.maze.rune.INSURANCE_CONTRACT]     = { shape = xi.maze.runeShape.DOMINO, element = xi.element.NONE    },
    [xi.maze.rune.REPLENISHMENT_CONTRACT] = { shape = xi.maze.runeShape.SQUARE, element = xi.element.NONE    },
    [xi.maze.rune.TRIAL_BY_VELOCITY]      = { shape = xi.maze.runeShape.L,      element = xi.element.NONE    },
    [xi.maze.rune.TRIAL_BY_BUDGET]        = { shape = xi.maze.runeShape.LINE_4, element = xi.element.NONE    },
    [xi.maze.rune.TRIAL_BY_NUMBERS]       = { shape = xi.maze.runeShape.Z,      element = xi.element.NONE    },
    [xi.maze.rune.AMNESIACS_TRIAL]        = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.TRIAL_BY_SILENCE]       = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.GUIDANCE_CONTRACT]      = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.REINFORCEMENT_CONTRACT] = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.CONDITIONING_CONTRACT]  = { shape = xi.maze.runeShape.PLUS,   element = xi.element.NONE    },
    [xi.maze.rune.SUSTENANCE_CONTRACT]    = { shape = xi.maze.runeShape.S,      element = xi.element.NONE    },
    [xi.maze.rune.CAMARADERIE_CONTRACT]   = { shape = xi.maze.runeShape.PLUS,   element = xi.element.NONE    },
    [xi.maze.rune.GOLDAGRIKS_GENEROSITY]  = { shape = xi.maze.runeShape.T,      element = xi.element.NONE    },
    [xi.maze.rune.OBSCURED_ENTRANCE]      = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.SHORTCUT]               = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
    [xi.maze.rune.WALLOPER]               = { shape = xi.maze.runeShape.SQUARE, element = xi.element.NONE    },
    [xi.maze.rune.BARRAGER]               = { shape = xi.maze.runeShape.L,      element = xi.element.NONE    },
    [xi.maze.rune.SPELLSLINGER]           = { shape = xi.maze.runeShape.J,      element = xi.element.NONE    },
    [xi.maze.rune.SALINITY_SHIFT]         = { shape = xi.maze.runeShape.DOMINO, element = xi.element.WATER   },
    [xi.maze.rune.SKILLCHAIN]             = { shape = xi.maze.runeShape.CORNER, element = xi.element.NONE    },
    [xi.maze.rune.MAGIC_BURST]            = { shape = xi.maze.runeShape.LINE_3, element = xi.element.NONE    },
}
