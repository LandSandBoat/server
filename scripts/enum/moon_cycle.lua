-----------------------------------
-- Moon Cycle
-----------------------------------
xi = xi or {}

---@enum xi.moonCycle
xi.moonCycle =
{
    NEW_MOON                = 0,
    LESSER_WAXING_CRESCENT  = 1,
    GREATER_WAXING_CRESCENT = 2,
    FIRST_QUARTER           = 3,
    LESSER_WAXING_GIBBOUS   = 4,
    GREATER_WAXING_GIBBOUS  = 5,
    FULL_MOON               = 6,
    GREATER_WANING_GIBBOUS  = 7,
    LESSER_WANING_GIBBOUS   = 8,
    THIRD_QUARTER           = 9,
    GREATER_WANING_CRESCENT = 10,
    LESSER_WANING_CRESCENT  = 11,
}
