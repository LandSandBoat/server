-----------------------------------
-- ID: 4453
-- Item: Bowl of Eyeball Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- HP +6% (cap 70)
-- Charisma -10
-- Health Regen While Healing 4
-- Accuracy 12
-- Ranged ACC 12
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4453)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 6)
    target:addMod(xi.mod.FOOD_HP_CAP, 70)
    target:addMod(xi.mod.CHR, -10)
    target:addMod(xi.mod.HPHEAL, 4)
    target:addMod(xi.mod.ACC, 12)
    target:addMod(xi.mod.RACC, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 6)
    target:delMod(xi.mod.FOOD_HP_CAP, 70)
    target:delMod(xi.mod.CHR, -10)
    target:delMod(xi.mod.HPHEAL, 4)
    target:delMod(xi.mod.ACC, 12)
    target:delMod(xi.mod.RACC, 12)
end

return itemObject
