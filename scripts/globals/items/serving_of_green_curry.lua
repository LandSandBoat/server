-----------------------------------
-- ID: 4296
-- Item: serving_of_green_curry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility 2
-- Vitality 1
-- Health Regen While Healing 2
-- Magic Regen While Healing 1
-- Defense +9% (cap 160)
-- Ranged ACC +5% (cap 25)
-- Sleep Resist +3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4296)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 1)
    target:addMod(xi.mod.FOOD_DEFP, 9)
    target:addMod(xi.mod.FOOD_DEF_CAP, 160)
    target:addMod(xi.mod.FOOD_RACCP, 5)
    target:addMod(xi.mod.FOOD_RACC_CAP, 25)
    target:addMod(xi.mod.SLEEPRES, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 1)
    target:delMod(xi.mod.FOOD_DEFP, 9)
    target:delMod(xi.mod.FOOD_DEF_CAP, 160)
    target:delMod(xi.mod.FOOD_RACCP, 5)
    target:delMod(xi.mod.FOOD_RACC_CAP, 25)
    target:delMod(xi.mod.SLEEPRES, 3)
end

return itemObject
