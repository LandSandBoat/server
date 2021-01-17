-----------------------------------------
-- ID: 5186
-- Item: plate_of_yahata-style_carp_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 2
-- Accuracy % 11 (cap 56)
-- HP Recovered While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5186)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 56)
    target:addMod(tpz.mod.HPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 56)
    target:delMod(tpz.mod.HPHEAL, 2)
end

return item_object
