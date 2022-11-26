-----------------------------------
-- ID: 6276
-- Item: deep-fried_shrimp
-- Food Effect: 30Min, All Races
-----------------------------------
-- VIT +3
-- Fire resistance +20
-- Accuracy +20% (cap 70)
-- Ranged Accuracy +20% (cap 70)
-- Subtle Blow +8
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6276)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FIRE_MEVA, 20)
    target:addMod(xi.mod.FOOD_ACCP, 20)
    target:addMod(xi.mod.FOOD_ACC_CAP, 70)
    target:addMod(xi.mod.FOOD_RACCP, 20)
    target:addMod(xi.mod.FOOD_RACC_CAP, 70)
    target:addMod(xi.mod.SUBTLE_BLOW, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FIRE_MEVA, 20)
    target:delMod(xi.mod.FOOD_ACCP, 20)
    target:delMod(xi.mod.FOOD_ACC_CAP, 70)
    target:delMod(xi.mod.FOOD_RACCP, 20)
    target:delMod(xi.mod.FOOD_RACC_CAP, 70)
    target:delMod(xi.mod.SUBTLE_BLOW, 8)
end

return itemObject
