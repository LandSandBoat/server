-----------------------------------
-- ID: 5159
-- Item: plate_of_friture_de_la_misareaux
-- Food Effect: 240Min, All Races
-----------------------------------
-- Dexterity 3
-- Vitality 3
-- Mind -3
-- Defense 5
-- Ranged ATT % 7
-- Ranged ATT Cap 15
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5159)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.DEF, 5)
    target:addMod(xi.mod.FOOD_RATTP, 7)
    target:addMod(xi.mod.FOOD_RATT_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.DEF, 5)
    target:delMod(xi.mod.FOOD_RATTP, 7)
    target:delMod(xi.mod.FOOD_RATT_CAP, 15)
end

return itemObject
