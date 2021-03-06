-----------------------------------
-- ID: 4292
-- Item: loaf_of_pain_de_neige
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 18
-- Vitality 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4292)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.VIT, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.VIT, 4)
end

return item_object
