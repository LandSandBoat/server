-----------------------------------
-- ID: 5601
-- Item: Balik Sis +1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 5
-- Mind -2
-- Attack % 15
-- Attack Cap 70
-- Ranged ACC 2
-- Ranged ATT % 15
-- Ranged ATT Cap 70
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5601)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.FOOD_ATTP, 15)
    target:addMod(xi.mod.FOOD_ATT_CAP, 70)
    target:addMod(xi.mod.RACC, 2)
    target:addMod(xi.mod.FOOD_RATTP, 15)
    target:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.FOOD_ATTP, 15)
    target:delMod(xi.mod.FOOD_ATT_CAP, 70)
    target:delMod(xi.mod.RACC, 2)
    target:delMod(xi.mod.FOOD_RATTP, 15)
    target:delMod(xi.mod.FOOD_RATT_CAP, 70)
end

return itemObject
