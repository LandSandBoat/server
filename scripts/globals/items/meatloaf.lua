-----------------------------------------
-- ID: 5689
-- Item: Meatloaf
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- Strength 6
-- Agility 2
-- Intelligence -3
-- Attack 18% Cap 90
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5689)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 90)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 90)
end

return item_object
