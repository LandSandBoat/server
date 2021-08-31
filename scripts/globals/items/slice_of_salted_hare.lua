-----------------------------------
-- ID: 5737
-- Item: slice_of_salted_hare
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 10
-- Strength 1
-- hHP +1
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5737)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.HPHEAL, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.HPHEAL, 1)
end

return item_object
