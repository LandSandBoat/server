-----------------------------------
-- ID: 5662
-- Item: Dragon Fruit
-- Food Effect: 5 Mins, All Races
-----------------------------------
-- Intelligence 4
-- Agility -6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5662)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.AGI, -6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.AGI, -6)
end

return itemObject
