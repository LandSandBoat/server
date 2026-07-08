-----------------------------------
-- Augments
-----------------------------------
xi = xi or {}
xi.augment = xi.augment or {}

-- Stored in equipment exdata to denote the way the augments should be processed
---@enum xi.augment.kind
xi.augment.kind =
{
    HAS_AUGMENTS = 0x02, -- Standard, Trial, Serialized, Crafting Shield etc
    BUNDLED      = 0x03, -- Bundled augments: Odyssey, Dyna-D JSE necks
}

-- Stored in equipment exdata to further refine the type of augments stored on the item
-- Several flags can be present on a single item (i.e. STANDARD + TRIAL).
---@enum xi.augment.subKind
xi.augment.subKind =
{
    STANDARD        = 0x03, -- Base flags for standard augments
    CRAFTING_SHIELD = 0x08, -- Crafting shields
    SERIALIZED      = 0x10, -- Serialized number + server name (Lu Shang +1, Ebisu +1)
    MEZZOTINT       = 0x20, -- Mezzotinting (Geas Fete, Delve)
    TRIAL           = 0x40, -- Magian trial present
    EVOLITH         = 0x80,
}

-- RP curve used to calculate reinforcement points needed per rank.
-- Bundled augments select A or B via RPCurve field in exdata.
-- Mezzotint always uses MEZZOTINT.
---@enum xi.augment.rpCurve
xi.augment.rpCurve =
{
    A         = 0, -- Bundled: cumulative, up to 4750 RP total
    B         = 1, -- Bundled: cumulative, up to 55800 RP total
    MEZZOTINT = 2, -- Mezzotint: per-rank (resets), up to 5980 RP total
}

-- Used with bundled augments
---@enum xi.augment.parametric
xi.augment.parametric =
{
    -- Bitmask effects: parameter selects stats from the group (bits in documented order)
    BASE_STATS   = 2049, -- HP (0), MP, STR, DEX, VIT, AGI, INT, MND, CHR (8)
    STAT_COMBO   = 2050, -- STR (0), DEX, VIT, AGI, INT, MND, CHR (6) -- All bits set == ALL STATS
    ELEMENTS     = 2051, -- Fire (0), Ice, Wind, Earth, Lightning, Water, Light, Dark (7)
    ACCURACY     = 2052, -- Accuracy (0), Rng. Acc., Mag. Acc. (2)
    ATTACK       = 2053, -- Attack (0), Rng. Atk., Mag. Atk. Bns., Magic Damage (3)
    DEFENSE      = 2054, -- DEF (0), Mag. Def. Bns., Evasion, Mag. Evasion (3)
    ACC_ATK_DEF  = 2055, -- Accuracy (0), Rng. Acc., Attack, Mag. Atk. Bns., DEF (4)
    MAGIC        = 2056, -- Mag. Acc. (0), Mag. Atk. Bns., Magic Damage, Mag. Def. Bns., Mag. Evasion (4)

    -- Prefix effects: scope the effect provided as second parameter to given entity
    PET          = 2064,
    WYVERN       = 2065,
    AVATAR       = 2066,
    AUTOMATON    = 2067,
    LUOPAN       = 2068,
    ALTER_EGO    = 2069,

    -- Special
    WEAPON_SKILL = 2076, -- WS name from second element, always DMG:+#%
    ALL_ATTR     = 4096, -- All Attr.+#
}
