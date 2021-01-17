-----------------------------------------
-- ID: 4267
-- Item: Buttered Nebimonite
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Dexterity 1
-- Vitality 2
-- defense % 25
-- defense Cap 75
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4267)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 75)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 75)
end

return item_object
