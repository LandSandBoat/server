-----------------------------------
-- ID: 4375
-- Item: danceshroom
-- Food Effect: 5Min, All Races
-----------------------------------
-- Strength -5
-- Mind 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4375)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -5)
    target:addMod(xi.mod.MND, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -5)
    target:delMod(xi.mod.MND, 3)
end

return itemObject
