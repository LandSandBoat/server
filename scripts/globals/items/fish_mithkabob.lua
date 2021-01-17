-----------------------------------------
-- ID: 4398
-- Item: fish_mithkabob
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 1
-- Vitality 2
-- Mind -1
-- Defense % 25
-- Defense Cap 90
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4398)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 90)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 90)
end

return item_object
