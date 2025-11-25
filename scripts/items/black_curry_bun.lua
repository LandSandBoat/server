-----------------------------------
-- ID: 5758
-- Item: black_curry_bun
-- Food Effect: 30minutes, All Races
-- https://wiki.ffo.jp/html/17769.html
-----------------------------------
-- DEX +2
-- VIT +4
-- INT +1
-- Accuracy +5
-- Ranged Accuracy +5
-- Evasion +5
-- DEF +15% (cap 180)
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
    [ 1] = { xi.mod.DEX,            4,   3,   2 },
    [ 2] = { xi.mod.VIT,            6,   5,   4 },
    [ 3] = { xi.mod.INT,            3,   2,   1 },
    [ 4] = { xi.mod.AGI,            2,   0,   0 },
    [ 5] = { xi.mod.MND,            1,   0,   0 },
    [ 6] = { xi.mod.HPHEAL,         6,   4,   2 },
    [ 7] = { xi.mod.MPHEAL,         3,   2,   1 },
    [ 8] = { xi.mod.FOOD_DEFP,     25,  20,  15 },
    [ 9] = { xi.mod.FOOD_DEF_CAP, 200, 180, 180 },
    [10] = { xi.mod.ACC,            7,   5,   5 },
    [11] = { xi.mod.RACC,           7,   5,   5 },
    [12] = { xi.mod.EVA,            7,   5,   5 },
    [13] = { xi.mod.SLEEPRES,       5,   3,   3 }
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
