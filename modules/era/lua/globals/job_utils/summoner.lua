-----------------------------------
-- Module: Summoner spirit perpetuation cost helpers
-----------------------------------
local moduleName = 'era_job_utils_summoner'

xi.job_utils.summoner = xi.job_utils.summoner or {}

-- Perpetuation cost breakpoints for elemental spirits, in ascending level order.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
local spiritPerpTresholds =
{
    { level =  5, cost =  2 },
    { level =  9, cost =  3 },
    { level = 14, cost =  4 },
    { level = 18, cost =  5 },
    { level = 23, cost =  6 },
    { level = 25, cost =  7 },
    { level = 27, cost =  8 },
    { level = 32, cost =  9 },
    { level = 36, cost = 10 },
    { level = 40, cost = 11 },
    { level = 45, cost = 12 },
    { level = 49, cost = 13 },
    { level = 54, cost = 14 },
    { level = 58, cost = 15 },
    { level = 63, cost = 16 },
    { level = 67, cost = 17 },
    { level = 72, cost = 18 },
}

local function getSpiritPerpetuationCost(level)
    for _, threshold in ipairs(spiritPerpTresholds) do
        if level < threshold.level then
            return threshold.cost
        end
    end

    return spiritPerpTresholds[#spiritPerpTresholds].cost
end

xi.job_utils.summoner.applySpiritPerpetuationCost = function(caster)
    local pet = caster:getPet()
    if
        pet and
        pet:getPetID() >= xi.petId.FIRE_SPIRIT and
        pet:getPetID() <= xi.petId.DARK_SPIRIT
    then
        local baseCost       = getSpiritPerpetuationCost(pet:getMainLvl())
        local meritReduction = caster:getMerit(xi.merit.SUMMONING_MAGIC_CAST_TIME)

        caster:setMod(xi.mod.AVATAR_PERPETUATION, math.max(0, baseCost - meritReduction))
    end
end

return { name = moduleName }
