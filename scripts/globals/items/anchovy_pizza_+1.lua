-----------------------------------
-- ID: 5700
-- Item: anchovy_pizza_+1
-- Food Effect: 4 hours, all Races
-----------------------------------
-- HP +35
-- DEX +2
-- Accuracy +9% (Cap 16)
-- Attack +10% (Cap 21)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5700)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 35)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.FOOD_ACCP, 9)
    target:addMod(xi.mod.FOOD_ACC_CAP, 16)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 21)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 35)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.FOOD_ACCP, 9)
    target:delMod(xi.mod.FOOD_ACC_CAP, 16)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 21)
end

return itemObject
