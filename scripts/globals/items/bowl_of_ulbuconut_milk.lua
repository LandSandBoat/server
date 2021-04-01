-----------------------------------
-- ID: 5976
-- Item: Bowl of Ulbuconut Milk
-- Food Effect: 3Min, All Races
-----------------------------------
-- Charisma +3
-- Vitality -2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5976)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, 3)
    target:addMod(xi.mod.VIT, -2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 3)
    target:delMod(xi.mod.VIT, -2)
end

return item_object
