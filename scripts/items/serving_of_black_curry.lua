-----------------------------------
-- ID: 4297
-- Item: serving_of_black_curry
-- Food Effect: 180Min, All Races
-- https://wiki.ffo.jp/html/5680.html
-----------------------------------
-- Dexterity 2
-- Vitality 4
-- Intelligence 1
-- Health Regen While Healing 2
-- Magic Regen While Healing 1
-- defense % 15 (cap 180)
-- Accuracy 5
-- Evasion 5
-- Ranged ACC 5
-- Sleep Resist 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

local dataTable =
{
    [ 1] = { xi.mod.DEX,            4,   2 },
    [ 2] = { xi.mod.VIT,            6,   4 },
    [ 3] = { xi.mod.INT,            3,   1 },
    [ 4] = { xi.mod.HPHEAL,         6,   2 },
    [ 5] = { xi.mod.MPHEAL,         3,   1 },
    [ 6] = { xi.mod.FOOD_DEFP,     25,  15 },
    [ 7] = { xi.mod.FOOD_DEF_CAP, 200, 180 },
    [ 8] = { xi.mod.ACC,            5,   5 },
    [ 9] = { xi.mod.RACC,           5,   5 },
    [10] = { xi.mod.EVA,            5,   5 },
    [11] = { xi.mod.SLEEPRES,       3,   3 }
}

itemObject.onEffectGain = function(target, effect)
    for i = 1, #dataTable do
        -- Get party factor.
        local partySize = target:getPartySize()
        local column = 3
        if partySize >= 4 then
            column = 2
        end

        effect:addMod(dataTable[i][1], dataTable[i][column])
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
