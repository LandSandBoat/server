-----------------------------------
-- ID: 5773
-- Item: mushroom_crepe
-- Food Effect: 30Min, All Races
-----------------------------------
-- Mind 2
-- MP % 10 (cap 30)
-- Magic Accuracy +10
-- Magic Def. Bonus +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5773)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 2)
    target:addMod(xi.mod.FOOD_MPP, 10)
    target:addMod(xi.mod.FOOD_MP_CAP, 30)
    target:addMod(xi.mod.MACC, 10)
    target:addMod(xi.mod.MDEF, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 2)
    target:delMod(xi.mod.FOOD_MPP, 10)
    target:delMod(xi.mod.FOOD_MP_CAP, 30)
    target:delMod(xi.mod.MACC, 10)
    target:delMod(xi.mod.MDEF, 5)
end

return itemObject
