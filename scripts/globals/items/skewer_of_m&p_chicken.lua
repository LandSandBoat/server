-----------------------------------
-- ID: 5639
-- Item: Skewer of M&P Chicken
-- Food Effect: 3Min, All Races
-----------------------------------
-- Strength 5
-- Intelligence -5
-- Attack % 25
-- Attack Cap 154
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5639)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.INT, -5)
    target:addMod(xi.mod.FOOD_ATTP, 25)
    target:addMod(xi.mod.FOOD_ATT_CAP, 154)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.INT, -5)
    target:delMod(xi.mod.FOOD_ATTP, 25)
    target:delMod(xi.mod.FOOD_ATT_CAP, 154)
end

return itemObject
