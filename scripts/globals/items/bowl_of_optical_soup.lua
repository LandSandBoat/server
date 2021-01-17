-----------------------------------------
-- ID: 4340
-- Item: bowl_of_optical_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP % 6 (cap 75)
-- Charisma -15
-- HP Recovered While Healing 5
-- Accuracy 15
-- Ranged Accuracy 15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4340)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 75)
    target:addMod(tpz.mod.CHR, -15)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.ACC, 15)
    target:addMod(tpz.mod.RACC, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 75)
    target:delMod(tpz.mod.CHR, -15)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.ACC, 15)
    target:delMod(tpz.mod.RACC, 15)
end

return item_object
