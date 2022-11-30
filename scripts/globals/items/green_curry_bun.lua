-----------------------------------
-- ID: 5756
-- Item: green_curry_bun
-- Food Effect: 30 min, All Races
-----------------------------------
-- TODO: Group effects
-- VIT +1
-- AGI +2
-- Ranged Accuracy +5% (cap 25)
-- DEF +9% (cap 160)
-- Resist Sleep +3
-- hHP +2
-- hMP +1
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5756)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.FOOD_RACCP, 5)
    target:addMod(xi.mod.FOOD_RACC_CAP, 25)
    target:addMod(xi.mod.FOOD_DEFP, 9)
    target:addMod(xi.mod.FOOD_DEF_CAP, 160)
    target:addMod(xi.mod.SLEEPRES, 3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.FOOD_RACCP, 5)
    target:delMod(xi.mod.FOOD_RACC_CAP, 25)
    target:delMod(xi.mod.FOOD_DEFP, 9)
    target:delMod(xi.mod.FOOD_DEF_CAP, 160)
    target:delMod(xi.mod.SLEEPRES, 3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
