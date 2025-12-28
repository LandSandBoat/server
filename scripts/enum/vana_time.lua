xi = xi or {}

-- Number of earth seconds for each Vana'diel time interval.
-- See: https://www.bg-wiki.com/ffxi/Vana%27diel_Time

---@enum xi.vanaTime
xi.vanaTime =
{
    YEAR   = 360 * (24 * 60 * 2.4), -- 1244160 Earth seconds
    MONTH  =  30 * (24 * 60 * 2.4), -- 103680 Earth seconds
    WEEK   =   8 * (24 * 60 * 2.4), -- 27648 Earth seconds
    DAY    =  24 * (60 * 2.4),      -- 3456 Earth seconds
    HOUR   =  60 * (2.4),           -- 144 Earth seconds
    MINUTE = 2.4,                   -- 2.4 Earth seconds
}
