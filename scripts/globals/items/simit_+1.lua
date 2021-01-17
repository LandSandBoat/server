-----------------------------------------
-- ID: 5597
-- Item: simit_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 18
-- Vitality 4
-- Defense 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5597)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 18)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.DEF, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 18)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.DEF, 2)
end

return item_object
