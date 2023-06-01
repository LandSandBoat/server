-----------------------------------
-- ID: 5696
-- Item: margherita_pizza_+1
-- Food Effect: 4 hours, all Races
-----------------------------------
-- HP +35
-- Accuracy +10% (cap 9)
-- Attack +10% (cap 11)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5696)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 9)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 11)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 9)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 11)
end

return itemObject
