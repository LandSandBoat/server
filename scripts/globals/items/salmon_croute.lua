-----------------------------------
-- ID: 4551
-- Item: salmon_croute
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP +3% (cap 130)
-- Dexterity 2
-- MND -2
-- Ranged Accuracy +6% (cap 15)
-- HP recovered while healing 2
-- MP recovered while healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4551)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 3)
    target:addMod(xi.mod.FOOD_MP_CAP, 130)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.FOOD_RACCP, 6)
    target:addMod(xi.mod.FOOD_RACC_CAP, 15)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 3)
    target:delMod(xi.mod.FOOD_MP_CAP, 130)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.FOOD_RACCP, 6)
    target:delMod(xi.mod.FOOD_RACC_CAP, 15)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
