-----------------------------------------
-- ID: 4499
-- Item: loaf_of_iron_bread
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 4
-- Vitality 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4499)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 4)
    target:addMod(tpz.mod.VIT, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 4)
    target:delMod(tpz.mod.VIT, 1)
end

return item_object
