xi = xi or {}

-- Number of earth seconds for each Vana'diel time interval.
-- See: https://www.bg-wiki.com/ffxi/Vana%27diel_Time
local secondsPerTick = 2.4

xi.vanaTime =
{
    YEAR  = 518400 * secondsPerTick,
    MONTH = 43200 * secondsPerTick,
    WEEK  = 11520 * secondsPerTick,
    DAY   = 1440 * secondsPerTick,
    HOUR  = 60 * secondsPerTick,
}
