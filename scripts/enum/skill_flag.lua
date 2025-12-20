xi = xi or {}

---@enum xi.skillFlag
xi.skillFlag =
{
    NONE           = 0x000,
    ASTRAL_FLOW    = 0x002, -- Player's Avatar Astral Flow blood pacts
    NO_TP_COST     = 0x004, -- Don't auto deduct TP
    NO_START_MSG   = 0x010, -- Doesn't emit "<mob> readies <skill>"
    NO_FINISH_MSG  = 0x020, -- Doesn't emit finish message when mobskill state completes
    BLOODPACT_RAGE = 0x040,
    BLOODPACT_WARD = 0x080,
    ALWAYS_ANIMATE = 0x100, -- Animation completes even if no targets in range
}
