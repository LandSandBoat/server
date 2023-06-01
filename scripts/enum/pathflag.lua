xi = xi or {}

xi.pathflag =
{
    NONE     = 0x00,
    RUN      = 0x01, -- run twice the speed
    WALLHACK = 0x02, -- run through walls if path is too long
    REVERSE  = 0x04, -- reverse the path
    SCRIPT   = 0x08, -- don't overwrite this path before completion (except via another script)
    SLIDE    = 0x10, -- Slide to end point if close enough (so no over shoot)
}
