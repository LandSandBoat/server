-----------------------------------
-- ID: 4345
-- Item: serving_of_flounder_meuniere_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity 6
-- Vitality 1
-- Mind -1
-- Ranged ACC 15
-- Ranged ATT % 14
-- Ranged ATT Cap 30
-- Enmity -4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4345)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.RACC, 15)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 30)
    target:addMod(xi.mod.ENMITY, -4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.RACC, 15)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 30)
    target:delMod(xi.mod.ENMITY, -4)
end

return itemObject
