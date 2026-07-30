-----------------------------------
-- Rank thresholds for fame calculations
-- Fame is stored at 10x the retail 0-250 scale to account for decimal precision (2500 cap)
-- https://wiki.ffo.jp/html/2683.html
-----------------------------------
xi = xi or {}
xi.data = xi.data or {}
xi.data.fame = xi.data.fame or {}
-----------------------------------

-- Points required for each fame rank
-- These are the retail values after the February 18th 2014 "relaxation" as called by JP wiki (see link above)
xi.data.fame.rankPoints =
{
    [1] = 0,
    [2] = 50,
    [3] = 125,
    [4] = 225,
    [5] = 325,
    [6] = 425,
    [7] = 488,
    [8] = 550,
    [9] = 613,
}

-- Fame rank (1-9) for a raw fame point value
-- Called by CLuaBaseEntity::getFameLevel
xi.data.fame.getRankFromPoints = function(famePoints)
    local rank = 1

    for level, points in ipairs(xi.data.fame.rankPoints) do
        if famePoints >= points then
            rank = level
        end
    end

    return rank
end
