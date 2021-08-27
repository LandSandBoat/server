-----------------------------------
-- ID: 5859
-- Item: galkan_sausage_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 4
-- Intelligence -5
-- Attack 10
-- Ranged Attack 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5859)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.INT, -5)
    target:addMod(xi.mod.ATT, 10)
    target:addMod(xi.mod.RATT, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.INT, -5)
    target:delMod(xi.mod.ATT, 10)
    target:delMod(xi.mod.RATT, 10)
end

return item_object
