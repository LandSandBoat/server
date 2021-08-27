-----------------------------------
-- ID: 4363
-- Item: faerie_apple
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -4
-- Intelligence 2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4363)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -4)
    target:addMod(xi.mod.INT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -4)
    target:delMod(xi.mod.INT, 2)
end

return item_object
