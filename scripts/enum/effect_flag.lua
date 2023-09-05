-----------------------------------
-- Effect Flags
-----------------------------------
xi = xi or {}

xi.effectFlag =
{
    NONE            = 0x00000000,
    DISPELABLE      = 0x00000001,
    ERASABLE        = 0x00000002,
    ATTACK          = 0x00000004,
    EMPATHY         = 0x00000008,
    DAMAGE          = 0x00000010,
    DEATH           = 0x00000020,
    MAGIC_BEGIN     = 0x00000040,
    MAGIC_END       = 0x00000080,
    ON_ZONE         = 0x00000100,
    NO_LOSS_MESSAGE = 0x00000200,
    INVISIBLE       = 0x00000400,
    DETECTABLE      = 0x00000800,
    NO_REST         = 0x00001000,
    PREVENT_ACTION  = 0x00002000,
    WALTZABLE       = 0x00004000,
    FOOD            = 0x00008000,
    SONG            = 0x00010000,
    ROLL            = 0x00020000,
    SYNTH_SUPPORT   = 0x00040000,
    CONFRONTATION   = 0x00080000,
    LOGOUT          = 0x00100000,
    BLOODPACT       = 0x00200000,
    ON_JOBCHANGE    = 0x00400000,
    NO_CANCEL       = 0x00800000,
    INFLUENCE       = 0x01000000,
    OFFLINE_TICK    = 0x02000000,
    AURA            = 0x04000000,
    HIDE_TIMER      = 0x08000000,
    ON_ZONE_PATHOS  = 0x10000000,
}
