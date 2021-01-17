-----------------------------------------
-- ID: 5983
-- Item: Piscator's Skewer
-- Food Effect: 60 Mins, All Races
-----------------------------------------
-- Dexterity 3
-- Vitality 4
-- Defense % 26 Cap 155
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5983)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FOOD_DEFP, 26)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 155)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FOOD_DEFP, 26)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 155)
end

return item_object
