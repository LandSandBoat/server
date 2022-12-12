-----------------------------------
-- ID: 4365
-- Item: rolanberry
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -4
-- Intelligence 2
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4365)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -4)
    target:addMod(xi.mod.INT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -4)
    target:delMod(xi.mod.INT, 2)
end

return itemObject
