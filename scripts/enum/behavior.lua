-----------------------------------
-- Behavior bits
-----------------------------------
xi = xi or {}

xi.behavior =
{
    NONE         = 0x000,
    NO_DESPAWN   = 0x001, -- mob does not despawn on death
    STANDBACK    = 0x002, -- mob will standback forever
    RAISABLE     = 0x004, -- mob can be raised via Raise spells
    AGGRO_AMBUSH = 0x200, -- mob aggroes by ambush
    NO_TURN      = 0x400, -- mob does not turn to face target
}
