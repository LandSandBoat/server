-----------------------------------
-- ID: 5698
-- Item: pepperoni_pizza_+1
-- Food Effect: 4 hours, all Races
-----------------------------------
-- HP +35
-- Strength 2
-- Accuracy 9% (caps @ 11)
-- Attack 10% (caps @ 16)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5698)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 16)
    target:addMod(xi.mod.FOOD_ACCP, 9)
    target:addMod(xi.mod.FOOD_ACC_CAP, 11)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 16)
    target:delMod(xi.mod.FOOD_ACCP, 9)
    target:delMod(xi.mod.FOOD_ACC_CAP, 11)
end

return itemObject
