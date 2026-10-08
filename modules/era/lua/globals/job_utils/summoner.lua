-----------------------------------
-- Module: Summoner spirit perpetuation cost helpers
-- The override target does not exist in the base scripts; declaring it here
-- creates it for the other era modules that call it.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_summoner')

-- Perpetuation cost breakpoints for elemental spirits, in ascending level order.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
local spiritPerpThresholds =
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

local carbunclePerpThresholds =
{
    { level = 10, cost =  1 },
    { level = 18, cost =  2 },
    { level = 27, cost =  3 },
    { level = 36, cost =  4 },
    { level = 45, cost =  5 },
    { level = 54, cost =  6 },
    { level = 63, cost =  7 },
    { level = 72, cost =  8 },
    { level = 81, cost =  9 },
    { level = 91, cost = 10 },
    { level = 92, cost = 11 },
}

local fenrirPerpThresholds =
{
    { level =  8, cost =  1 },
    { level = 15, cost =  2 },
    { level = 22, cost =  3 },
    { level = 30, cost =  4 },
    { level = 37, cost =  5 },
    { level = 45, cost =  6 },
    { level = 51, cost =  7 },
    { level = 59, cost =  8 },
    { level = 66, cost =  9 },
    { level = 73, cost = 10 },
    { level = 81, cost = 11 },
    { level = 91, cost = 12 },
    { level = 92, cost = 13 },
}

local avatarPerpThresholds =
{
    { level = 10, cost =  3 },
    { level = 19, cost =  4 },
    { level = 28, cost =  5 },
    { level = 38, cost =  6 },
    { level = 47, cost =  7 },
    { level = 56, cost =  8 },
    { level = 65, cost =  9 },
    { level = 68, cost = 10 },
    { level = 71, cost = 11 },
    { level = 74, cost = 12 },
    { level = 81, cost = 13 },
    { level = 91, cost = 14 },
    { level = 92, cost = 15 },
}

m:addOverrideByEra('xi.job_utils.summoner.getPerpetuationCost', {
    [xi.expansion.ABYSSEA] = function(pet)
        local thresholds = {}

        local petId    = pet:getPetID()
        local petLevel = pet:getMainLvl()

        if petId <= xi.petId.DARK_SPIRIT then
            thresholds = spiritPerpThresholds
        elseif
            petId == xi.petId.CARBUNCLE or
            petId == xi.petId.CAIT_SITH
        then
            thresholds = carbunclePerpThresholds
        elseif petId == xi.petId.FENRIR then
            thresholds = fenrirPerpThresholds
        elseif
            (petId >= xi.petId.IFRIT and petId <= xi.petId.DIABOLOS) or
            petId == xi.petId.SIREN
        then
            thresholds = avatarPerpThresholds
        else
            return 0
        end

        for _, threshold in ipairs(thresholds) do
            if petLevel < threshold.level then
                return threshold.cost
            end
        end

        return thresholds[#thresholds].cost
    end,
})

m:addOverrideByEra('xi.job_utils.summoner.applyPerpetuationCost', {
    [xi.expansion.ABYSSEA] = function(caster, pet)
        local meritReduction = 0
        local baseCost       = 0

        if pet then
            local petId = pet:getPetID()

            baseCost = xi.job_utils.summoner.getPerpetuationCost(pet)

            if
                petId >= xi.petId.FIRE_SPIRIT and
                petId <= xi.petId.DARK_SPIRIT
            then
                -- SUMMONING_MAGIC_CAST_TIME used to be Elemental MP Cost catagory which reduced spirit perpetuation.
                -- Elemental MP Cost was removed in March 2012 and replaced with SUMMONING_MAGIC_CAST_TIME.
                meritReduction = caster:getMerit(xi.merit.SUMMONING_MAGIC_CAST_TIME)
            end

            caster:setMod(xi.mod.AVATAR_PERPETUATION, math.max(0, baseCost - meritReduction))
        end
    end,
})
