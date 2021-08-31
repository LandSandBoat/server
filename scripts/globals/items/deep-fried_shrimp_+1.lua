-----------------------------------
-- ID: 6277
-- Item: deep-fried_shrimp
-- Food Effect: 60Min, All Races
-----------------------------------
-- VIT +4
-- Fire resistance +21
-- Accuracy +21% (cap 75)
-- Ranged Accuracy +21% (cap 75)
-- Subtle Blow +9
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6277)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FIRE_RES, 21)
    target:addMod(xi.mod.FOOD_ACCP, 21)
    target:addMod(xi.mod.FOOD_ACC_CAP, 75)
    target:addMod(xi.mod.FOOD_RACCP, 21)
    target:addMod(xi.mod.FOOD_RACC_CAP, 75)
    target:addMod(xi.mod.SUBTLE_BLOW, 9)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FIRE_RES, 21)
    target:delMod(xi.mod.FOOD_ACCP, 21)
    target:delMod(xi.mod.FOOD_ACC_CAP, 75)
    target:delMod(xi.mod.FOOD_RACCP, 21)
    target:delMod(xi.mod.FOOD_RACC_CAP, 75)
    target:delMod(xi.mod.SUBTLE_BLOW, 9)
end

return item_object
