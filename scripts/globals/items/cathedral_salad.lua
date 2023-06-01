-----------------------------------
-- ID: 5679
-- Item: cathedral_salad
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- MP 15% Cap 90
-- Agility 7
-- Mind 7
-- Strength -5
-- Vitality -5
-- Ranged Accuracy +17
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5679)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 15)
    target:addMod(xi.mod.FOOD_MP_CAP, 90)
    target:addMod(xi.mod.AGI, 7)
    target:addMod(xi.mod.MND, 7)
    target:addMod(xi.mod.STR, -5)
    target:addMod(xi.mod.VIT, -5)
    target:addMod(xi.mod.RACC, 17)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 15)
    target:delMod(xi.mod.FOOD_MP_CAP, 90)
    target:delMod(xi.mod.AGI, 7)
    target:delMod(xi.mod.MND, 7)
    target:delMod(xi.mod.STR, -5)
    target:delMod(xi.mod.VIT, -5)
    target:delMod(xi.mod.RACC, 17)
end

return itemObject
