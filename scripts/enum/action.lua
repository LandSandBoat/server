-----------------------------------
-- ACTION IDs
-----------------------------------
xi = xi or {}

xi.action =
{
    NONE                  = 0,
    ATTACK                = 1,
    RANGED_FINISH         = 2,
    WEAPONSKILL_FINISH    = 3,
    MAGIC_FINISH          = 4,
    ITEM_FINISH           = 5,
    JOBABILITY_FINISH     = 6,
    WEAPONSKILL_START     = 7,
    MAGIC_START           = 8,
    ITEM_START            = 9,
    JOBABILITY_START      = 10,
    MOBABILITY_FINISH     = 11,
    RANGED_START          = 12,
    PET_MOBABILITY_FINISH = 13,
    DANCE                 = 14,
    RUN_WARD_EFFUSION     = 15,
    ROAMING               = 16,
    ENGAGE                = 17,
    DISENGAGE             = 18,
    CHANGE_TARGET         = 19,
    FALL                  = 20,
    DROPITEMS             = 21,
    DEATH                 = 22,
    FADE_OUT              = 23,
    DESPAWN               = 24,
    SPAWN                 = 25,
    STUN                  = 26,
    SLEEP                 = 27,
    ITEM_USING            = 28,
    ITEM_INTERRUPT        = 29,
    MAGIC_CASTING         = 30,
    MAGIC_INTERRUPT       = 31,
    RANGED_INTERRUPT      = 32,
    MOBABILITY_START      = 33,
    MOBABILITY_USING      = 34,
    MOBABILITY_INTERRUPT  = 35,
    LEAVE                 = 36,
    RAISE_MENU_SELECTION  = 37,
}

xi.act = xi.action
