-----------------------------------
-- ID: 5756
-- Item: green_curry_bun
-- Food Effect: 30 min, All Races
-- https://wiki.ffo.jp/html/17768.html
-----------------------------------
-- VIT +1
-- AGI +2
-- Ranged Accuracy +5% (cap 25)
-- DEF +9% (cap 160)
-- Resist Sleep +3
-- hHP +2
-- hMP +1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

local dataTable =
{
    [1] = { xi.mod.VIT,            3,   2,   1 },
    [2] = { xi.mod.AGI,            4,   3,   2 },
    [3] = { xi.mod.HPHEAL,         6,   4,   2 },
    [4] = { xi.mod.MPHEAL,         3,   2,   1 },
    [5] = { xi.mod.FOOD_RACCP,    10,   8,   5 },
    [6] = { xi.mod.FOOD_RACC_CAP, 25,  25,  25 },
    [7] = { xi.mod.FOOD_DEFP,     13,  11,   9 },
    [8] = { xi.mod.FOOD_DEF_CAP, 180, 170, 160 },
    [9] = { xi.mod.SLEEPRES,       5,   4,   3 }
}

itemObject.onEffectGain = function(target, effect)
    for i = 1, #dataTable do
        -- Get party factor.
        local partySize = target:getPartySize()
        local column = 4
        if partySize >= 4 then
            column = 2
        elseif partySize >= 2 then
            column = 3
        end

        effect:addMod(dataTable[i][1], dataTable[i][column])
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
