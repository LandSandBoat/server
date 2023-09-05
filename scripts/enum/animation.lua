-----------------------------------
-- Animations
-----------------------------------
xi = xi or {}

xi.animation =
{
    NONE                    = 0,
    ATTACK                  = 1,
    DESPAWN                 = 2,
    DEATH                   = 3,
    CHOCOBO                 = 5,
    FISHING                 = 6,
    -- NOTE: Commented out in core
    -- HEALING                 = 7,
    OPEN_DOOR               = 8,
    CLOSE_DOOR              = 9,
    ELEVATOR_UP             = 10,
    ELEVATOR_DOWN           = 11,
    -- seems to be WALLHACK = 28,
    -- seems to be WALLHACK = 31,
    FISHING_NPC             = 32,
    HEALING                 = 33,
    FISHING_FISH            = 38,
    FISHING_CAUGHT          = 39,
    FISHING_ROD_BREAK       = 40,
    FISHING_LINE_BREAK      = 41,
    FISHING_MONSTER         = 42,
    FISHING_STOP            = 43,
    SYNTH                   = 44,
    SIT                     = 47,
    RANGED                  = 48,
    FISHING_START           = 50,
    NEW_FISHING_START       = 56,
    NEW_FISHING_FISH        = 57,
    NEW_FISHING_CAUGHT      = 58,
    NEW_FISHING_ROD_BREAK   = 59,
    NEW_FISHING_LINE_BREAK  = 60,
    NEW_FISHING_MONSTER     = 61,
    NEW_FISHING_STOP        = 62,
    -- 63 through 72 are used with /sitchair
    -- 73 through 83 sitting on air (guessing future use for more chairs..)
    MOUNT                   = 85,
    -- TRUST                = 90, -- This is the animation for a trust NPC spawning in.
}

xi.anim = xi.animation
