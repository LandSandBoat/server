-----------------------------------
-- ID: 5649
-- Item: Handful of Roasted Almonds
-- Food Effect: 5Min, All Races
-----------------------------------
-- HP 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5649)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
end

return itemObject
