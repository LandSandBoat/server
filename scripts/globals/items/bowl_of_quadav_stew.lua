-----------------------------------
-- ID: 4569
-- Item: Bowl of Quadav Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility -4
-- Vitality 2
-- Defense % 17
-- Defense Cap 60
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4569)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, -4)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.FOOD_DEFP, 17)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 60)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, -4)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.FOOD_DEFP, 17)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 60)
end

return item_object
